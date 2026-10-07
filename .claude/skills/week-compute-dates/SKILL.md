---
name: week-compute-dates
description: Computes the Plan's dates - next Shopping day, planned Week, current Week, purchase date, Week file name - from the Shopping day in ROUTINES. Use whenever a skill needs to know which Week it is working on.
user-invocable: false
---

# Week dates

Read the **Shopping day** from ROUTINES in the state (e.g. "saturday"). Never assume it is Saturday or that the Week runs Monday to Sunday (see `docs/adr/0002-week-starts-after-shopping-day.md`).

- The **next Shopping day** is the next occurrence of the Shopping day from today, including today (the Plan may run the evening before or on the day itself).
- The **planned Week** is the 7 days after the next Shopping day. Example: Shopping day Saturday → Week Sunday to Saturday; Shopping day Wednesday → Week Thursday to Wednesday.
- The **Week file** is `data/weeks/<first day of the Week>.md`.
- The **current Week** is the one that ends on the Shopping day itself. Its file has the Menu still to be eaten until then.
- The **purchase date** is the next Shopping day, unless the Lead reported a one-off exception for this Week (e.g. "this week I'll shop on Sunday", recorded under PENDING or said in conversation). The exception does not change the Week, only the purchase date: the Projected stock gains or loses days of consumption, and Spend counts in that date's month (by Receipt date).

Output: next Shopping day, planned Week (first and last day), current Week file, planned Week file, purchase date (and whether it is an exception).
