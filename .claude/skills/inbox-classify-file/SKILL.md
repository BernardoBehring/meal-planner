---
name: inbox-classify-file
description: Classifies each file in inbox/ as Receipt, Stock count, Review or Unidentified, in processing order. Use at the start of intake.
user-invocable: false
---

# Classify inbox files

List the files directly in `inbox/` and classify each:

- **Receipt**: photo, scan or PDF of a purchase, supermarket invoice, restaurant bill.
- **Stock count**: photos with "count" in the file name.
- **Review**: `review.txt`.
- **Unidentified**: anything else, or unreadable. Leave it in `inbox/` and record its name and the reason under PENDING.

Return them in the order **Receipts (by date) → Stock count → Review**. The Stock count is the latest picture of the Stock, so it comes after purchases; the Review corrects the Week's consumption.
