---
name: price-label
description: Gives every price the label that says how reliable it is (current, verified, historical, unverified, estimate). Use whenever a price is shown, recorded or added to a total.
user-invocable: false
---

# Price labels

- **CURRENT PRICE (researched YYYY-MM-DD)**: found online in this session (`price-find-current`), with URL. The only label that may be presented as today's price.
- **VERIFIED PRICE (receipt, YYYY-MM-DD)**: paid on a Receipt. The most reliable, but still historical.
- **HISTORICAL PRICE (YYYY-MM-DD)**: from `data/prices.md`, previous conversations or the model's own knowledge.
- **UNVERIFIED PRICE**: research failed, the page did not show the price or the product was not found. Do not fill the gap with a number presented as fact.
- **ESTIMATE**: a value used only to complete a total. Say where it came from (e.g. "last price paid, 2026-09-12").

Write the labels in the conversation language when showing them to the Family; keep the English labels in `data/prices.md`. Always keep **VERIFIED FACT** and **ESTIMATE** apart.
