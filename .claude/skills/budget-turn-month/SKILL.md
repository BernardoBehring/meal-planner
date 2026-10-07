---
name: budget-turn-month
description: Opens the new month in the state's monthly tracking (BUDGET, MEALS OUT). Use after a full month close.
user-invocable: false
---

# Turn the month

In `data/state.md`:

- BUDGET: "Current month" becomes the new month, with empty Week lines and the remainder equal to the monthly Budget.
- MEALS OUT starts empty (keep the habit line).
- Unconfirmed purchases stay pending, because their Receipt still belongs to the old month when it arrives: note that under PENDING.
