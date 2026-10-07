---
name: price-research
description: Researches current online food prices at the Family's local supermarkets, in any country and currency, with per-unit prices, store comparison, the one-shop vs. split decision, all recorded in data/prices.md. Use whenever a current price must be stated, compared or added up - inside the weekly Plan, when changing a Plan, or in one-off questions such as "how much is chicken at Lidl?", "where is olive oil cheapest?" or "is it worth going to Aldi this week?".
---

# Price research (orchestrator)

Chains skills only; every rule lives in the skill named at each step (`docs/adr/0004-atomic-skills.md`).

Input: products with the quantity needed (the whole Shopping list or one product), and whether the caller asks for a comparison.

1. `price-select-stores`.
2. For each product × store: `price-find-current` → `price-compute-unit` → `price-label`. Items already priced in this session can reuse that price.
3. More than one store researched → `price-compare-stores`.
4. `price-summarise-total`.
5. `price-record` (researched prices).

Output: labelled prices per item, the total make-up and, when compared, the comparison table and purchase decision.
