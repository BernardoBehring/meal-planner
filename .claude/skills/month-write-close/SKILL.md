---
name: month-write-close
description: Produces the month summary from the month's Receipts, Plans, Meals out, Waste - written to data/months/YYYY-MM.md in a full close, only shown in a partial one. Use in a month close.
user-invocable: false
---

# Month file

Write in the **conversation language** (the English below is the reference), amounts in the Family's currency.

Gather:

- **Spend** from every Receipt dated in the month, from the files in `data/weeks/` (`🧾 Receipts` sections) and from BUDGET in the state.
- **Unconfirmed** purchases of the month: as `budget-estimate-unconfirmed` says.
- Estimated cost of each Plan of the month, Top-up purchases, cost attributed to Guests, Meals out, Waste.
- For each Adult with a Weight log: the month's trend from `weight-assess-trend` (window = the month); put it under "Lessons for next month".

````markdown
# 📅 Month close YYYY-MM

```text
Monthly budget:        XXX.XX
Total spend:           XXX.XX  (XXX.XX from Receipts + XX.XX estimated without Receipt)
Difference:            XX.XX   (saving | overspend)
Average per purchase:  XX.XX   (N Shopping days)
Estimated vs. Spend:   estimates X.XX above/below reality (N Weeks)
```

## By Week
| Week | Estimated cost | List spend | Top-up | Total spend |

## Main expenses
Top 5 products or categories by amount in the month (from Receipt items).

## Guests
Weeks with Guests and the estimated cost attributed to them (explains part of any above-usual Spend).

## Meals out
Total XX.XX in N meals (not in the budget; shows the impact).

## Waste
Items and approximate value.

## Lessons for next month
3 to 5 concrete actions (e.g. "fruit estimates were 20% below reality: raise the margin", "the store-brand yoghurt was approved: keep it").
````

Output: the summary `text` block (the Plan e-mail shows it under "Previous week").
