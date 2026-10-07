---
name: email-set-recipients
description: Writes the E-MAIL section of the state with each recipient's type. Use in onboarding or when the Lead asks to add, remove or change an address.
user-invocable: false
---

# Set the e-mail recipients

1. If the E-MAIL section already has an address, use `lead-confirm-change` first; stop if not confirmed.
2. Ask the **Lead's e-mail**, where the Plan, the Review request and updated lists arrive. Ask whether anyone else should get a copy (e.g. another Adult who does the shopping) and each copy's type: **list only** (default: short e-mail with the Shopping list and the Menu) or **all**. The Lead always gets "all" (types are explained in `email-resolve-recipients`).
3. Explain that only the Lead changes the budget and recipients, and that other Adults can drop Receipts and Reviews in the inbox.
4. Confirm each address by repeating it back, because a typo makes e-mails get lost silently. Also say that e-mails need the Gmail connector on their claude.ai account; without it, everything still works through files and chat.
5. Write one line per recipient: `- <address> (<Lead | name> — <all | list only>)`.
6. If the section was not empty before, use `email-send-change-notice` (recipients).
