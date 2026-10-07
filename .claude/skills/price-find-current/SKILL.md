---
name: price-find-current
description: Researches online the current shelf price of one product at one supermarket, with source URL. Use for every price that will be presented as current.
user-invocable: false
---

# Find a current price

What the model "knows" about prices is out of date, and a budget built on invented prices is worse than no budget, because it gives false confidence. A price is current only if found online **in this session**.

1. Read **country / region** and **currency** (ROUTINES) in the state, and whether the Family accepts store brands, frozen and seasonal produce (SHOPPING / SUPERMARKETS).
2. Sources, in order of preference:
   - The supermarket's **online shop** in that country: shelf price and price per kg/l. Find it with WebSearch (e.g. "<supermarket> <country> online shop <product>"); most chains have a national site per country (e.g. tesco.com in the UK, continente.pt in Portugal, rewe.de in Germany, carrefour.fr in France).
   - **Weekly leaflets and promotions** (common for discounters such as Lidl and Aldi, which often have no full online shop): valid only for the stated period.
   - Price comparison sites for groceries, if they exist in that country, as a pointer to the store page; confirm on the store page when possible.
   - WebSearch to find the right page; WebFetch to read the price on the page.
3. Search in the **local language of the shops**, with product names as they appear on local shelves.
4. `data/prices.md` shows history (brands the Family buys, prices paid), but that history is never a current price.
5. A promotion counts only if the page confirms it and its validity.
6. **Countries or chains without online prices**: some supermarkets publish no prices online. Say so once, use the most recent VERIFIED PRICE from receipts as an ESTIMATE (with its date), and label the rest UNVERIFIED PRICE. Over the weeks the receipts will fill the gap.

Output, per product: Product | Brand | Pack | Price | Supermarket | Promotion (No / "-30% until 2026-10-06") | Date | Source URL. Then `price-compute-unit` and `price-label`.
