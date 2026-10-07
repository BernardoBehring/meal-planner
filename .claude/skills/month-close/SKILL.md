---
name: month-close
description: Closes the Family's food month - monthly Budget vs. real Spend from Receipts, main expenses, Meals out, Waste, lessons - in data/months/YYYY-MM.md, then opens the new month. Use on the first Plan of a new month (the weekly-plan skill calls it) and whenever the user asks how the month went, how much they spent this month, whether they stayed within the monthly budget, or for a monthly summary.
---

# Month close (orchestrator)

Chains skills only; every rule lives in the skill named at each step (`docs/adr/0004-atomic-skills.md`). Must happen **before** the new month's Week budget is calculated.

1. `month-select-close`.
2. `intake` (so the month's last Receipts are included).
3. For each Adult with a Weight log: `weight-read-log` → `weight-assess-trend` (the month).
4. `month-write-close` (partial: show only, write nothing).
5. Full close only: `budget-turn-month`.
6. Return the summary block (the Plan e-mail shows it under "Previous week").
