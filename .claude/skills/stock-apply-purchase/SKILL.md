---
name: stock-apply-purchase
description: Updates STOCK from the items of one food Receipt. Use for each List purchase or Top-up purchase Receipt.
user-invocable: false
---

# Stock from a Receipt

Input: the Receipt items (from `receipt-read`) and its purchase type (from `receipt-classify-purchase`).

- **List purchase**: move the matching Stock items from **Unconfirmed** to confirmed, with the real quantities. List items missing from the Receipt: remove them from Stock and record them as "not bought".
- **Top-up purchase**: add its items to Stock.
- Meals out and canteen receipts do not touch Stock.

Write each line in the `stock-classify` format.
