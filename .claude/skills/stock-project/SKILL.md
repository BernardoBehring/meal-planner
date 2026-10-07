---
name: stock-project
description: Computes the Projected stock for the first day of the planned Week. Use in a Plan before the Shopping list, or when a Plan change moves the purchase date.
user-invocable: false
---

# Projected stock

**Projected stock for the first day of the Week** = current Stock − what the current Week's Menu will still consume up to and including the purchase date (from `week-compute-dates`).

- If the purchase is exceptionally later than usual, also count the planned Week's days before the purchase, which are still served by the current Stock.
- If it is exceptionally earlier, the current Week's remaining days after the purchase are still served by the current Stock: count them too.

Output: item → quantity expected at home on the first day of the Week.
