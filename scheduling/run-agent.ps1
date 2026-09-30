# Windows: runs the meal-planner agent headless for a scheduled job, with the family state
# prepended to the prompt. Called by the scheduled tasks that apply-schedule.ps1 registers.
# Usage: run-agent.ps1 -Kind plan|review
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
$log = Join-Path $logDir ("{0:yyyy-MM-dd_HHmm}_{1}.log" -f (Get-Date), $Kind)

$prompt = Get-Content -Raw -Encoding UTF8 (Join-Path $PSScriptRoot "prompt-$Kind.txt")
$statePath = Join-Path $project 'data\state.md'
if (Test-Path $statePath) {
    $state = Get-Content -Raw -Encoding UTF8 $statePath
    $prompt = $state + "`n`n=============================`n`n" + $prompt
}

$claude = (Get-Command claude -ErrorAction SilentlyContinue).Source
if (-not $claude) { $claude = Join-Path $env:USERPROFILE '.local\bin\claude.exe' }

# Windows PowerShell 5.1 turns any native stderr line into an error; with 'Stop' a mere warning would abort the run.
$ErrorActionPreference = 'Continue'

$prompt | & $claude -p --agent meal-planner `
    --permission-mode acceptEdits `
    --allowedTools Read Write Edit Glob Grep Skill WebSearch WebFetch `
        mcp__claude_ai_Gmail__send_message mcp__claude_ai_Gmail__search_threads mcp__claude_ai_Gmail__get_thread `
        mcp__claude_ai_Gmail__list_labels mcp__claude_ai_Gmail__create_label mcp__claude_ai_Gmail__label_message `
        'Bash(mkdir -p archive/:*)' 'Bash(mv inbox/:*)' `
    2>&1 | Out-File -FilePath $log -Encoding utf8

"Exit code: $LASTEXITCODE" | Out-File -FilePath $log -Encoding utf8 -Append
