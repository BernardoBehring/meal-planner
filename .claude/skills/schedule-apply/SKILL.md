---
name: schedule-apply
description: Registers the Plan with the Review request as scheduled jobs in the operating system. Use whenever the "Plan" or "Review" lines in ROUTINES change.
user-invocable: false
---

# Apply the schedule

Run with Bash **exactly** the command for the platform you are running on (these are the only ones authorised):

| Platform | Command |
| --- | --- |
| Windows | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File scheduling/apply-schedule.ps1` |
| macOS / Linux | `bash scheduling/apply-schedule.sh` |

Show the Lead the script output (day, time and next run of each job). If it fails, show the error and ask them to run the same command in a terminal (the README has per-OS help).
