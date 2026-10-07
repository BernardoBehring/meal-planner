---
name: email-send-list-update
description: Sends the corrected Shopping list after a Plan change, only while the List purchase has not happened yet. Use at the end of a Plan change.
user-invocable: false
---

# Send the updated List

Only if the Shopping list purchase has not happened yet (no List-purchase Receipt for this Week). If the shopping is already done, do not send: say the change applies to consumption and any missing items can become a Top-up purchase.

Get the addresses for the **list-update** e-mail with `email-resolve-recipients` (every recipient, "all" and "list only").

- **subject**: `🛒 <"Shopping list (updated)" in the conversation language> — YYYY-MM-DD`
- Body: what changed (2 or 3 lines), the full corrected Shopping list (grouped by supermarket and category, with ☐) and the new Estimated cost.
