# Windows: runs the meal-planner agent headless for a scheduled job, with the family state
# prepended to the prompt. Called by the scheduled tasks that apply-schedule.ps1 registers.
# Usage: run-agent.ps1 -Kind plan|review [-MaxAttempts 6] [-RetryMinutes 60]
# Retries: when an attempt fails because of a Claude usage limit, overload or network error, it waits
#   RetryMinutes and tries again, up to MaxAttempts. Other failures are not retried (a half-done run
#   could e-mail twice).
# When the run finally fails: a Windows notification, plus an e-mail to the Lead (prompt-failure.txt) -
#   that e-mail also needs Claude, so after a usage limit it usually cannot go out; the notification can.
# Logs (scheduling/logs/):
#   runs.log                      "start", "retry" and "end" lines per run; a start with no end = run killed or crashed
#   YYYY-MM-DD_HHMM_<kind>.log    the run's output, every attempt, with header and footer
# Each attempt gets its own session id: "claude --resume <id>" reopens it to see every step it took.
# The script exits with the agent's exit code, so Task Scheduler's "Last Run Result" shows failures.
# Kept ASCII-only on purpose: Windows PowerShell 5.1 misreads non-ASCII in BOM-less scripts.
param(
    [Parameter(Mandatory = $true)][ValidateSet('plan', 'review')][string]$Kind,
    [int]$MaxAttempts = 6,
    [double]$RetryMinutes = 60
)

$ErrorActionPreference = 'Stop'
$project = Split-Path -Parent $PSScriptRoot
Set-Location $project

$utf8 = New-Object System.Text.UTF8Encoding $false
$OutputEncoding = $utf8
[Console]::OutputEncoding = $utf8

$logDir = Join-Path $project 'scheduling\logs'
New-Item -ItemType Directory -Force $logDir | Out-Null
$started = Get-Date
$logName = "{0:yyyy-MM-dd_HHmm}_{1}.log" -f $started, $Kind
$log = Join-Path $logDir $logName
$runs = Join-Path $logDir 'runs.log'
# Failures worth waiting for: they go away on their own.
$retryable = "(?i)you've hit your .*limit|usage limit|rate.?limit|overloaded|API Error: ?(429|500|502|503|529)|ECONNRESET|ETIMEDOUT|ENOTFOUND"

function Write-Log([string]$text) { $text | Out-File -FilePath $log -Encoding utf8 -Append }
function Write-Run([string]$text) { ("{0:yyyy-MM-dd HH:mm:ss}  {1,-6}  {2}" -f (Get-Date), $Kind, $text) | Out-File -FilePath $runs -Encoding utf8 -Append }

function Invoke-Claude([string]$prompt, [string]$session, [string[]]$tools) {
    # Windows PowerShell 5.1 turns any native stderr line into an error; with 'Stop' a mere warning would abort the run.
    # ForEach-Object "$_" writes those lines as plain text instead of PowerShell error records.
    $ErrorActionPreference = 'Continue'
    $out = $prompt | & $claude -p --agent meal-planner --session-id $session `
        --permission-mode acceptEdits --allowedTools $tools 2>&1 | ForEach-Object { "$_" }
    $code = $LASTEXITCODE
    $out | Out-File -FilePath $log -Encoding utf8 -Append
    [pscustomobject]@{ Code = $code; Text = ($out -join "`n") }
}

function Show-Notification([string]$title, [string]$text) {
    try {
        [void][Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
        [void][Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]
        $xml = New-Object Windows.Data.Xml.Dom.XmlDocument
        $esc = { param($s) [System.Security.SecurityElement]::Escape($s) }
        $xml.LoadXml("<toast duration=`"long`"><visual><binding template=`"ToastGeneric`"><text>$(& $esc $title)</text><text>$(& $esc $text)</text></binding></visual></toast>")
        $app = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
        [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($app).Show([Windows.UI.Notifications.ToastNotification]::new($xml))
        Write-Log 'Failure notification shown on the desktop.'
    } catch {
        Write-Log "Could not show the desktop notification: $($_.Exception.Message)"
    }
}

$agentTools = @('Read', 'Write', 'Edit', 'Glob', 'Grep', 'Skill', 'WebSearch', 'WebFetch',
    'mcp__claude_ai_Gmail__send_message', 'mcp__claude_ai_Gmail__search_threads', 'mcp__claude_ai_Gmail__get_thread',
    'mcp__claude_ai_Gmail__list_labels', 'mcp__claude_ai_Gmail__create_label', 'mcp__claude_ai_Gmail__label_message',
    'mcp__claude_ai_Google_Drive__search_files', 'mcp__claude_ai_Google_Drive__read_file_content', 'Artifact', 'ArtifactData',
    'Bash(mkdir -p archive/:*)', 'Bash(mv inbox/:*)')

Write-Log ("Run: {0}  started {1:yyyy-MM-dd HH:mm:ss}  (up to {2} attempts, {3} min apart)" -f $Kind, $started, $MaxAttempts, $RetryMinutes)

$code = 1
$attempt = 0
$session = ''
$lastText = ''
try {
    $claude = (Get-Command claude -ErrorAction SilentlyContinue).Source
    if (-not $claude) { $claude = Join-Path $env:USERPROFILE '.local\bin\claude.exe' }
    if (-not (Test-Path $claude)) { throw "claude not found (looked in PATH and $claude)." }
    Write-Log "Claude: $claude"

    while ($true) {
        $attempt++
        $session = [guid]::NewGuid().ToString()
        Write-Run "start  attempt $attempt/$MaxAttempts  session $session  log $logName"
        Write-Log '-----------------------------'
        Write-Log ("Attempt {0}/{1}  {2:yyyy-MM-dd HH:mm:ss}" -f $attempt, $MaxAttempts, (Get-Date))
        Write-Log "Session: $session  (see every step: claude --resume $session)"

        # Read the state on every attempt: the Family may have changed it while we waited.
        $prompt = Get-Content -Raw -Encoding UTF8 (Join-Path $PSScriptRoot "prompt-$Kind.txt")
        $statePath = Join-Path $project 'data\state.md'
        if (Test-Path $statePath) {
            $prompt = (Get-Content -Raw -Encoding UTF8 $statePath) + "`n`n=============================`n`n" + $prompt
        } else {
            Write-Log 'Warning: data\state.md not found; running without the family state.'
        }

        $r = Invoke-Claude $prompt $session $agentTools
        $code = $r.Code
        $lastText = $r.Text
        if ($code -eq 0) { break }
        if ($attempt -ge $MaxAttempts -or $lastText -notmatch $retryable) { break }
        Write-Log "Attempt $attempt failed (exit $code) with a temporary error; next try in $RetryMinutes min."
        Write-Run "retry  attempt $attempt failed (exit $code); next try in $RetryMinutes min"
        Start-Sleep -Seconds ([int]($RetryMinutes * 60))
    }
} catch {
    $lastText = "ERROR: $($_.Exception.Message)"
    Write-Log $lastText
} finally {
    $minutes = [math]::Round(((Get-Date) - $started).TotalMinutes, 1)
    $result = if ($code -eq 0) { 'OK' } else { "FAILED (exit $code)" }
    Write-Log '-----------------------------'
    Write-Log ("Finished {0:yyyy-MM-dd HH:mm:ss} after {1} min and {2} attempt(s) - {3}" -f (Get-Date), $minutes, $attempt, $result)
    Write-Log "Exit code: $code"
    Write-Run "end    $result after $minutes min, $attempt attempt(s)  session $session"
}

if ($code -ne 0) {
    $tail = (($lastText -split "`n") | Where-Object { $_.Trim() } | Select-Object -Last 5) -join "`n"
    Show-Notification "Meal planner: $Kind run failed" "$tail`nLog: scheduling\logs\$logName"
    if ($claude -and (Test-Path $claude)) {
        $details = "Run: $Kind`nStarted: {0:yyyy-MM-dd HH:mm}`nAttempts: $attempt`nExit code: $code`nLog: scheduling/logs/$logName`nSession: $session`nLast error lines:`n$tail" -f $started
        $notice = (Get-Content -Raw -Encoding UTF8 (Join-Path $PSScriptRoot 'prompt-failure.txt')) + $details
        Write-Log '----- failure e-mail -----'
        $n = Invoke-Claude $notice ([guid]::NewGuid().ToString()) @('Read', 'mcp__claude_ai_Gmail__send_message')
        $sent = if ($n.Code -eq 0) { 'sent' } else { "not sent (exit $($n.Code))" }
        Write-Log "Failure e-mail: $sent"
        Write-Run "notice failure e-mail $sent, desktop notification shown"
    }
}
exit $code
