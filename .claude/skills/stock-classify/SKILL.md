---
name: stock-classify
description: Sets the status of each STOCK line in the state (available, running low, critical, use first, Unconfirmed). Use whenever a skill writes STOCK lines.
user-invocable: false
---

# Stock line format

Each line in STOCK: `item — quantity — status — expiry (when relevant) — Unconfirmed?`

| Status | Meaning |
| --- | --- |
| 🟢 available | enough for the coming Week's use |
| 🟡 running low | will run out during the Week |
| 🔴 critical | finished or nearly; must be bought |
| ⚠️ use first | close to expiry or opened; the Menu uses it first |

- **Unconfirmed**: came from a Shopping list without a Receipt yet; the Receipt confirms it (`stock-apply-purchase`).
- The calculated Stock assumes the Menu was followed. The Review corrects it (`stock-apply-review`) and the Stock count replaces it with the real Stock (`stock-apply-count`).
- Whatever a Stock count could not see stays as it was, marked "not checked in the Stock count".
