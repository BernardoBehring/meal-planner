---
name: list-check-sufficiency
description: Proves that the Week's Menu covers every Member's daily references through the Daily references table. Use in a Plan after the Shopping list, before any price.
user-invocable: false
---

# Sufficiency check

Do it **before** looking at prices, and do not redo it afterwards to make the cost fit.

1. **Every ingredient named on the Menu** is in the Week quantities table and covered by Projected stock + List. An ingredient on the Menu but missing from the table is an error, not a saving.
2. **Daily references** for every Member present: **fruit 2 to 3 portions per day**, **dairy (or alternative) every day for Children** (calcium), **vegetables at lunch and dinner**.
3. Prove it with the **Daily references table** in the Week file: one row per Member, one column per day, each cell with the number of fruit portions / dairy portions / meals with vegetables that the Menu actually gives that Member that day (counting only meals they are present for, including lunchboxes and canteen meals only if their content is known). Fill it from the Menu, not from the budget. Mark any cell below the reference with ❌.
4. Any ❌ means the Menu must be fixed (add fruit to breakfast or snacks, milk to porridge, a vegetable side) and consumption recounted (`list-count-consumption`) before moving on. A sentence such as "the daily reference is met" is not a substitute for the table.
5. After pricing, if the Estimated cost is far below the Week budget (under 60%), treat it as a warning, not a win: redo the count. A low cost is only legitimate when it comes from Stock being used, and the Week file must show where each meal comes from.

Output: the Daily references table, with no ❌.
