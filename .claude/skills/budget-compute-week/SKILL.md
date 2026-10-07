---
name: budget-compute-week
description: Computes the Week budget from the weekly Budget, the month remainder, the Shopping days left in the purchase month. Use in a Plan before classifying the Estimated cost.
user-invocable: false
---

# Week budget

**Week budget** = min(weekly budget; remainder of the month ÷ Shopping days left in the month). Show the calculation.

- **The monthly Budget prevails over the weekly one.**
- The month is the **purchase date's** month (from `week-compute-dates`), not the month the Week starts. Example: with Shopping day Saturday, the Week starting Sunday 1 November, bought on Saturday 31 October, comes out of October's budget.
- **Remainder of the month** = monthly Budget − Spend already recorded in that month (BUDGET in the state).
- **Shopping days left in the month** = number of occurrences of the Shopping day from the purchase date to the end of that month, including the purchase date. Always at least 1.

Output: `Week budget: XX.XX (lower of weekly XX and month remainder XX ÷ N Shopping days)`.
