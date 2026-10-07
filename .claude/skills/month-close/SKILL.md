---
name: month-close
description: Closes the Family's food month - monthly Budget vs. real Spend from Receipts, average per purchase, main expenses, Guests, Meals out, Waste and possible savings - writes data/months/YYYY-MM.md, opens the new month in the state and requests the Stock count. Use on the first Plan of a new month (the weekly-plan skill calls it) and whenever the user asks how the month went, how much they spent this month, whether they stayed within the monthly budget, or for a monthly summary.
---

# Month close

The month close turns four or five Weeks of Receipts into a month summary and a lesson for the next one. It also "turns the month" in the state, which is why it must happen **before** the new month's Week budget is calculated.

Write the month file and summary in the **conversation language** from ROUTINES (the English below is the reference), with amounts in the Family's currency.

## Which month to close

- Called by `weekly-plan` (the purchase date is already in the next month): the month recorded as "Current month" in BUDGET in the state. Receipts dated in that month that arrive later are added to `data/months/YYYY-MM.md` as a correction.
- Asked by the user ("how did September go?"): the month asked. If it is the current month, not yet over, do a **partial summary**: show the numbers but do not write to `data/months/` or turn the month in the state.

## Steps

1. Make sure intake has run (`intake` skill), so the month's last Receipts are included.
2. Gather the month's data:
   - **Spend** from every Receipt dated in the month, from the files in `data/weeks/` (`🧾 Receipts` sections) and from BUDGET in the state. Spend belongs to the month of the **Receipt date**.
   - **Unconfirmed** purchases of the month (no Receipt): use the Estimated cost, marked ESTIMATE.
   - Estimated cost of each Plan of the month, Top-up purchases, cost attributed to Guests, Meals out, Waste.
   - For each Adult with a "Weight log" line: the 7-day average at the start and end of the month and the change (agent's "Weight log" rules); put it under "Lessons for next month".
3. Calculate and write `data/months/YYYY-MM.md`:

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

4. **Turn the month** in the state (full close only): in BUDGET, "Current month" becomes the new month, with empty Week lines and the remainder equal to the monthly budget. MEALS OUT starts empty. Unconfirmed purchases stay pending, because their Receipt still belongs to the old month when it arrives: note that under PENDING.
5. If the Stock count in ROUTINES is monthly or every two months and this is a Stock count month with no Stock count recorded, add the Stock count request to PENDING (photos of the fridge, freezer and pantry, with "count" in the file name, in `inbox/`).
6. Return the summary block (the `text` block above). `weekly-plan` includes it in the Week e-mail, in the "Previous week" section.
