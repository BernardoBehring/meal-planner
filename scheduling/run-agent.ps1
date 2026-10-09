# Windows: runs the meal-planner agent headless for a scheduled job, with the family state
# prepended to the prompt. Called by the scheduled tasks that apply-schedule.ps1 registers.
# Usage: run-agent.ps1 -Kind plan|review
# Logs (scheduling/logs/):
#   runs.log                      one "start" and one "end" line per run; a start with no end = run killed or crashed
#   YYYY-MM-DD_HHMM_<kind>.log    the run's output, with header and footer
# Each run gets its own session id: "claude --resume <id>" reopens it to see every step it took.
# The script exits with the agent's exit code, so Task Scheduler's "Last Run Result" shows failures.
# Kept ASCII-only on purpose: Windows PowerShell 5.1 misreads non-ASCII in BOM-less scripts.
param(
    [Parameter(Mandatory = $true)][ValidateSet('plan', 'review')][string]$Kind
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
$session = [guid]::NewGuid().ToString()

function Write-Log([string]$text) { $text | Out-File -FilePath $log -Encoding utf8 -Append }
function Write-Run([string]$text) { ("{0:yyyy-MM-dd HH:mm:ss}  {1,-6}  {2}" -f (Get-Date), $Kind, $text) | Out-File -FilePath $runs -Encoding utf8 -Append }

Write-Run "start  session $session  log $logName"
Write-Log ("Run: {0}  started {1:yyyy-MM-dd HH:mm:ss}" -f $Kind, $started)
Write-Log "Session: $session  (see every step: claude --resume $session)"

$code = 1
try {
    $prompt = Get-Content -Raw -Encoding UTF8 (Join-Path $PSScriptRoot "prompt-$Kind.txt")
    $statePath = Join-Path $project 'data\state.md'
    if (Test-Path $statePath) {
        $state = Get-Content -Raw -Encoding UTF8 $statePath
        $prompt = $state + "`n`n=============================`n`n" + $prompt
    } else {
        Write-Log 'Warning: data\state.md not found; running without the family state.'
    }

    $claude = (Get-Command claude -ErrorAction SilentlyContinue).Source
    if (-not $claude) { $claude = Join-Path $env:USERPROFILE '.local\bin\claude.exe' }
    if (-not (Test-Path $claude)) { throw "claude not found (looked in PATH and $claude)." }
    Write-Log "Claude: $claude"
    Write-Log '-----------------------------'

    # Windows PowerShell 5.1 turns any native stderr line into an error; with 'Stop' a mere warning would abort the run.
    # ForEach-Object "$_" writes those lines as plain text instead of PowerShell error records.
    $ErrorActionPreference = 'Continue'

    $prompt | & $claude -p --agent meal-planner --session-id $session `
        --permission-mode acceptEdits `
        --allowedTools Read Write Edit Glob Grep Skill WebSearch WebFetch `
            mcp__claude_ai_Gmail__send_message mcp__claude_ai_Gmail__search_threads mcp__claude_ai_Gmail__get_thread `
            mcp__claude_ai_Gmail__list_labels mcp__claude_ai_Gmail__create_label mcp__claude_ai_Gmail__label_message `
            mcp__claude_ai_Google_Drive__search_files mcp__claude_ai_Google_Drive__read_file_content `
            'Bash(mkdir -p archive/:*)' 'Bash(mv inbox/:*)' `
        2>&1 | ForEach-Object { "$_" } | Out-File -FilePath $log -Encoding utf8 -Append
    $code = $LASTEXITCODE
} catch {
    Write-Log "ERROR: $($_.Exception.Message)"
} finally {
    $minutes = [math]::Round(((Get-Date) - $started).TotalMinutes, 1)
    $result = if ($code -eq 0) { 'OK' } else { "FAILED (exit $code)" }
    Write-Log '-----------------------------'
    Write-Log ("Finished {0:yyyy-MM-dd HH:mm:ss} after {1} min - {2}" -f (Get-Date), $minutes, $result)
    Write-Log "Exit code: $code"
    Write-Run "end    $result after $minutes min  session $session"
}
exit $code
