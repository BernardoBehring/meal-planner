---
name: week-write-file
description: Writes the planning sections of the Week file from references/week-template.md. Use when a Plan is saved or redone.
user-invocable: false
---

# Write the Week file

Write `data/weeks/<first day of the Week>.md` (from `week-compute-dates`) following **exactly** the template in `references/week-template.md`.

- Titles and text in the **conversation language** from ROUTINES, amounts in the Family's currency, except the `🧾 Receipts`, `📝 Review` and `✏️ Changes` headings, which stay in English because other skills look for them.
- Sections with no content show "—" instead of disappearing, so all Weeks are comparable.
- If the file already exists (Plan redone), overwrite the planning sections but **keep** the `🧾 Receipts`, `📝 Review` and `✏️ Changes` sections.
