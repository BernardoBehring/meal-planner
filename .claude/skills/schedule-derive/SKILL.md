---
name: schedule-derive
description: Derives the Plan time plus the Review request time from the Shopping day with the usual shopping time. Use when the Shopping day or shopping time is set or changed.
user-invocable: false
---

# Derive the schedule

From the **Shopping day** and the **usual shopping time** in ROUTINES:

- morning shopping (before 12:00): Plan **the evening before at 20:00** and Review request **two days before at 19:00**;
- afternoon or evening shopping: Plan **the same day at 08:00** and Review request **the day before at 19:00**.

Show the result for the Lead to adjust, then save it in ROUTINES exactly as `- Plan: <weekday in English> HH:MM` and `- Review: <weekday in English> HH:MM` (e.g. `- Plan: friday 20:00`). The scheduling scripts read this format: no other text on those two lines.

Output: the two ROUTINES lines. Applying them to the operating system is the `schedule-apply` skill.
