---
name: budget-record-spend
description: Records the Spend of one food Receipt in BUDGET, in the month of the Receipt date. Use for each List purchase or Top-up purchase Receipt.
user-invocable: false
---

# Record Spend

The Receipt is the source of truth for Spend (`docs/adr/0001-receipt-is-source-of-truth.md`).

- **Spend** = receipt total **minus** cleaning, hygiene, pet and other non-food items. Show the calculation (total − non-food = Spend). Bottled water and drinks for home are food.
- Spend counts in the **month of the Receipt date**, in the Family's currency — even if the Week it serves starts in another month.
- A **Top-up purchase** counts in the Spend of the Week in which it was paid, recorded separately from the List purchase.
- Meals out and canteen receipts are never Spend (see `meal-out-record`).
- In BUDGET in the state: add it to the Week line and to the month total; update the month remainder.
