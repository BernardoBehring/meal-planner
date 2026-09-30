---
name: price-research
description: Researches current online food prices at the Family's local supermarkets, in any country and currency, calculates price per kg/l/unit and per portion, compares stores, decides between one shop or a split purchase, and records everything in data/prices.md. Use whenever a current price must be stated, compared or added up - inside the weekly Plan, when changing a Plan, or in one-off questions such as "how much is chicken at Lidl?", "where is olive oil cheapest?" or "is it worth going to Aldi this week?".
---

# Price research

A price may be presented as **current** only if it was researched online **in this session**. What the model "knows" about prices is out of date, and a budget built on invented prices is worse than no budget, because it gives false confidence. This skill exists so that every price has a source, a date and a label.

## Input

A list of products with the quantity needed (e.g. "chicken breast — 1.5 kg"). It may be the whole Shopping list or a single product from a one-off question.

## Where to research

1. Read in `data/state.md`: **country / region** and **currency** (ROUTINES), and the **usual** and **nearby** supermarkets and whether the Family accepts store brands, frozen and seasonal produce (SHOPPING / SUPERMARKETS). Research the usual and nearby stores first; others only if they are accessible to the Family.
2. Sources, in order of preference:
   - The supermarket's **online shop** in that country: shelf price and price per kg/l. Find it with WebSearch (e.g. "<supermarket> <country> online shop <product>"); most chains have a national site per country (e.g. tesco.com in the UK, continente.pt in Portugal, rewe.de in Germany, carrefour.fr in France).
   - **Weekly leaflets and promotions** (common for discounters such as Lidl and Aldi, which often have no full online shop): valid only for the stated period.
   - Price comparison sites for groceries, if they exist in that country, as a pointer to the store page; confirm on the store page when possible.
   - WebSearch to find the right page; WebFetch to read the price on the page.
3. Search in the **local language of the shops**, with product names as they appear on local shelves.
4. Check `data/prices.md` for history (brands the Family buys, prices paid), but never use that history as a current price.
5. **Countries or chains without online prices**: some supermarkets publish no prices online. Then say so once, use the most recent VERIFIED PRICE from receipts as an ESTIMATE (with its date), and label the rest UNVERIFIED PRICE. Over the weeks the receipts will fill the gap.

## Search level

Researching every item in every store is expensive and slow (it is the most expensive part of each Plan). The Family chooses, in ROUTINES in the state, how much to compare. At **every** level, each price presented as current is researched in this session (Rule 11); the level only decides **how many supermarkets** are included.

| Level | What to do |
| --- | --- |
| **Full** | Compare the high-impact items across all usual and nearby supermarkets, every time. |
| **When tight** (default) | Research **only the usual store** first and return the total. Compare with other supermarkets only when the caller asks (the Plan asks if the total comes out 🟡 or 🔴 against the Week budget). |
| **Usual store only** | Research only the usual store, never compare. Leave out the comparison table and the split-purchase decision. |

One-off questions from the Lead ("where is olive oil cheapest?") ask for a comparison by nature: compare, whatever the level.

## Effort: where research pays off

When comparing supermarkets, spread the effort by impact on the total:

- **High-impact items** (meat, fish, dairy, olive oil, coffee, anything above ~3 units of the local currency in the cart, or the local equivalent): compare across **all** usual and nearby supermarkets.
- **Cheap or price-stable items** (rice, pasta, onions, flour): research at **one** supermarket, the likely place of purchase.
- **Fruit and vegetables**: one supermarket plus the week's leaflets, because prices vary a lot with the season and promotions.

## For each product, record

| Field | Example |
| --- | --- |
| Product | Chicken breast |
| Brand | Store brand |
| Pack | 1 kg |
| Price | 5.99 (in the Family's currency) |
| Price per kg/l/unit | 5.99/kg |
| Supermarket | <store> |
| Promotion | No / "-30% until 2026-10-06" (only if the page confirms the validity) |
| Date | 2026-10-03 |
| Source | URL |
| Label | CURRENT PRICE (researched 2026-10-03) |

Always calculate the **price per kg/l/unit** (that is how different packs are compared) and, when it makes sense, the **cost per portion**. A bigger pack only pays off if the price per kg is lower **and** the quantity will be eaten without waste (consider Stock and expiry dates).

## Labels

- **CURRENT PRICE (researched YYYY-MM-DD)**: found in this session, with URL.
- **VERIFIED PRICE (receipt, YYYY-MM-DD)**: paid on a Receipt (recorded by the `intake` skill).
- **HISTORICAL PRICE (YYYY-MM-DD)**: from `data/prices.md` or earlier sessions.
- **UNVERIFIED PRICE**: research failed, the page did not show the price or the product was not found. Do not fill the gap with a number presented as fact.
- **ESTIMATE**: a value used only to complete a total. Say where it came from (e.g. "last price paid, 2026-09-12").

Write the labels in the conversation language when showing them to the Family; keep the English labels in `data/prices.md`.

## Comparison and purchase decision

Show the comparison table (only the stores researched; cells without data = "—"), with amounts in the Family's currency:

| Product | Store A | Store B | Store C | Best price |
| --- | ---: | ---: | ---: | --- |
| Chicken breast (per kg) | 5.99 | 6.49 | 5.79 | Store C |

Then calculate:

```text
ONE SUPERMARKET
- Store A: XX.XX (N items at current price, M estimated)

SPLIT PURCHASE
- Store C: XX.XX
- Store A: XX.XX
Total: XX.XX | Saving: X.XX
```

Recommend splitting only if the saving is worth the time and travel (Rule 8): small savings rarely justify a second trip, unless the stores are next to each other or on the usual route. State the recommendation and why.

## Total summary

Every cost total shows its make-up:

```text
Estimated cost: XX.XX
- Current prices (researched today): XX.XX (N items)
- Estimates: X.XX (M items)
- Unverified: K items (no amount included)
```

## Recording in `data/prices.md`

Append (never delete) the researched rows to a table with the columns: `Date | Product | Brand | Pack | Price | Price/kg-l-unit | Supermarket | Promotion | Label | Source`. Prices are in the Family's currency (write the currency in the file header). If the file does not exist, create it with that table. Do not record unverified prices.
