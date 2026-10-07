---
name: stock-apply-review
description: Corrects STOCK from a Review's answers about meals cooked, Leftovers, shortages, food that went off. Use when a Review is processed.
user-invocable: false
---

# Stock from a Review

Input: the Review answers (from `review-read`). Blank answers mean "no change".

- Meals cooked, swapped or skipped → correct the Stock (what was not cooked is still at home).
- Leftovers and shortages → STOCK.
- What went off → remove it from Stock (the Waste itself is recorded by `waste-record`).

Write each line in the `stock-classify` format.
