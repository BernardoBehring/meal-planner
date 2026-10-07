---
name: week-write-onboarding-notice
description: Writes a short notice in the planned Week file saying the Plan was not made because onboarding is missing. Use in an automatic Plan run when onboarding is pending.
user-invocable: false
---

# Onboarding-missing notice

Write `data/weeks/<first day of the Week>.md` with only: the Plan was not made because there is no Family profile yet; to start, open a terminal in the project folder and run `claude --agent meal-planner`; plus what intake processed, if anything. Do not invent a Menu.
