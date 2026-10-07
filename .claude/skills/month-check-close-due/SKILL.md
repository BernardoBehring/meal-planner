---
name: month-check-close-due
description: Tells whether the month recorded in BUDGET must be closed before planning. Use in a Plan right after computing the purchase date.
user-invocable: false
---

# Is a month close due?

If the **purchase date** (from `week-compute-dates`) is in a different month from the "Current month" in BUDGET, the previous month is over for purchasing purposes, and the Week budget now comes from the new month: the month close is due **before** the Week budget is calculated.

Output: due (which month) / not due.
