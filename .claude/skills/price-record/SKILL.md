---
name: price-record
description: Appends researched or paid prices to data/prices.md. Use after prices are researched or a Receipt is read.
user-invocable: false
---

# Record prices

Append (never delete) rows to the table in `data/prices.md` with the columns: `Date | Product | Brand | Pack | Price | Price/kg-l-unit | Supermarket | Promotion | Label | Source`.

- Prices are in the Family's currency (write the currency in the file header). If the file does not exist, create it with that table.
- Researched prices: label CURRENT PRICE, source = URL.
- Paid prices: label **VERIFIED PRICE (receipt, YYYY-MM-DD)**, source = the Receipt.
- Do not record unverified prices.
