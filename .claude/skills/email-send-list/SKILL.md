---
name: email-send-list
description: Sends the short Shopping list e-mail to "list only" recipients. Use at the end of a Plan, right after the full Plan e-mail.
user-invocable: false
---

# Send the short List e-mail

For whoever goes to the supermarket: the List and, to decide substitutions, the Menu. Get the addresses for the **list** e-mail with `email-resolve-recipients`; if there are none, skip it silently.

- **subject**: `🛒 <"Shopping list" in the conversation language> — YYYY-MM-DD`
- Language, `htmlBody` and `body` rules: as in `email-send-plan/references/email-template.md`.
- Content, in this order: estimated total (one line); **Shopping list** grouped by supermarket and category, with ☐ and quantity (no per-item prices); **Menu** for the 7 days. No pending items, price comparison, recipes, month budget data or Members' personal information.
