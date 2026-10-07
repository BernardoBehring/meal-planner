---
name: price-select-stores
description: Decides which supermarkets to research for each product, from the Search level with the item's impact on the total. Use before researching prices.
user-invocable: false
---

# Which stores to research

Read in `data/state.md`: the **usual** and **nearby** supermarkets (SHOPPING / SUPERMARKETS) and the **Search level** (ROUTINES). Research the usual and nearby stores first; others only if they are accessible to the Family.

## Search level

Researching every item in every store is expensive and slow (it is the most expensive part of each Plan). At **every** level, each price presented as current is researched in this session; the level only decides **how many supermarkets** are included.

| Level | What to do |
| --- | --- |
| **Full** | Compare the high-impact items across all usual and nearby supermarkets, every time. |
| **When tight** (default) | Research **only the usual store** first. Compare with other supermarkets only when the caller asks (the Plan asks if the total comes out 🟡 or 🔴 against the Week budget). |
| **Usual store only** | Research only the usual store, never compare. |

One-off questions from the Lead ("where is olive oil cheapest?") ask for a comparison by nature: compare, whatever the level.

## Effort by impact (when comparing)

- **High-impact items** (meat, fish, dairy, olive oil, coffee, anything above ~3 units of the local currency in the cart, or the local equivalent): **all** usual and nearby supermarkets.
- **Cheap or price-stable items** (rice, pasta, onions, flour): **one** supermarket, the likely place of purchase.
- **Fruit and vegetables**: one supermarket plus the week's leaflets, because prices vary a lot with the season and promotions.

Output: product → stores to research; and whether a comparison is expected.
