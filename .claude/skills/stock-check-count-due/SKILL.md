---
name: stock-check-count-due
description: Tells whether a Stock count is due on a given Shopping day, from the Stock count frequency in ROUTINES. Use when building the pending items of a Plan or a Review request.
user-invocable: false
---

# Is a Stock count due?

A Stock count is a real survey of the Stock by the Lead: photos of the fridge, freezer and pantry with "count" in the file name in `inbox/`, or a typed list in the Review reply.

It is **due** on the **first Shopping day of each period** set in ROUTINES (monthly, fortnightly or every two months), when no Stock count has been recorded for that period ("Last Stock count" in STOCK).

- **monthly**: first Shopping day of each month.
- **fortnightly**: first Shopping day of each month and the first Shopping day on or after the 15th.
- **every two months**: first Shopping day of January, March, May, July, September, November.
- **never**: not due; suggest one only if the Review shows big gaps between calculated and real Stock, and remind that Stock will drift from reality.

Input: the Shopping day to check. Output: due / not due; if due, the request text for PENDING.
