# Windows: reads the ROUTINES section of data/state.md and (re)registers the two scheduled tasks.
# Expected lines in data/state.md (weekday in English):
#   - Plan: saturday 08:00
#   - Review: friday 19:00
# Usage: apply-schedule.ps1 [-DryRun]
# Kept ASCII-only on purpose: Windows PowerShell 5.1 misreads non-ASCII in BOM-less scripts.
param([switch]$DryRun)

$ErrorActionPreference = 'Stop'
$project = Split-Path -Parent $PSScriptRoot
$runner = Join-Path $PSScriptRoot 'run-agent.ps1'
$statePath = Join-Path $project 'data\state.md'
if (-not (Test-Path $statePath)) { throw "data\state.md not found. Run onboarding first (claude --agent meal-planner)." }
$state = Get-Content -Raw -Encoding UTF8 $statePath

$weekdays = @{
    'monday' = 'Monday'; 'tuesday' = 'Tuesday'; 'wednesday' = 'Wednesday'; 'thursday' = 'Thursday'
    'friday' = 'Friday'; 'saturday' = 'Saturday'; 'sunday' = 'Sunday'
}

function Get-Slot([string]$label) {
    $m = [regex]::Match($state.ToLower(), "(?m)^\s*-\s*$label\s*:\s*([a-z]+)\s+(\d{1,2}):(\d{2})")
    if (-not $m.Success) { throw "Line '- ${label}: <weekday> HH:MM' not found in the ROUTINES section of data/state.md" }
    $day = $weekdays[$m.Groups[1].Value]
    if (-not $day) { throw "Invalid weekday for ${label}: '$($m.Groups[1].Value)' (use English: monday ... sunday)" }
    [pscustomobject]@{ Day = $day; Time = ('{0:D2}:{1}' -f [int]$m.Groups[2].Value, $m.Groups[3].Value) }
}

$jobs = @(
    @{ Name = 'Meal planner - Plan'; Label = 'plan'; Kind = 'plan'
       Description = 'Runs the meal-planner agent (Claude Code) to plan the next Week.' },
    @{ Name = 'Meal planner - Review'; Label = 'review'; Kind = 'review'
       Description = 'Runs the meal-planner agent (Claude Code) to e-mail the Review request.' }
)

$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -ExecutionTimeLimit (New-TimeSpan -Hours 1) `
    -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

foreach ($j in $jobs) {
    $slot = Get-Slot $j.Label
    if ($DryRun) {
        "[dry run] {0}: every {1} at {2} -> powershell -File `"{3}`" -Kind {4}" -f $j.Name, $slot.Day, $slot.Time, $runner, $j.Kind
        continue
    }
    $action = New-ScheduledTaskAction -Execute 'powershell.exe' `
        -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$runner`" -Kind $($j.Kind)"
    $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $slot.Day -At $slot.Time
    Register-ScheduledTask -TaskName $j.Name -Action $action -Trigger $trigger -Settings $settings `
        -Description $j.Description -Force | Out-Null
    $next = (Get-ScheduledTask -TaskName $j.Name | Get-ScheduledTaskInfo).NextRunTime
    "{0}: every {1} at {2} (next run: {3:yyyy-MM-dd HH:mm})" -f $j.Name, $slot.Day, $slot.Time, $next
}
