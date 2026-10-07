---
name: month-select-close
description: Picks which month to close, deciding between a full close or a partial summary. Use at the start of a month close.
user-invocable: false
---

# Which month

- Called by the Plan (the purchase date is already in the next month): the month recorded as "Current month" in BUDGET. **Full close.** Receipts dated in that month that arrive later are added to `data/months/YYYY-MM.md` as a correction.
- Asked by the user ("how did September go?"): the month asked. If it is the current month, not yet over: **partial summary** — show the numbers but do not write to `data/months/` or turn the month in the state.

Output: month, full / partial.
