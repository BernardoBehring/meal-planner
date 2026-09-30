# Plan e-mail template

Send with `mcp__claude_ai_Gmail__send_message`. If the Gmail tools are not available, skip the e-mail and note it in the Week file.

- **to**: recipients of type **all** in the E-MAIL section of `data/state.md` (never anyone else; if empty, do not send and record the pending item). Recipients of type **list only** get the short e-mail (see below).
- **subject**: `🥗 <"Meal plan" in the conversation language> — <"Week of" in the conversation language> YYYY-MM-DD` (the first day of the Week)
- **Language**: the conversation language from ROUTINES, with natural local vocabulary; amounts in the Family's currency.
- **htmlBody**: simple HTML, readable on a phone: `<h2>`, `<h3>`, `<p>`, `<ul>`, `<table>` with thin inline borders (`style="border-collapse:collapse"` and `border:1px solid #ddd; padding:4px` on cells). No external CSS, images or scripts.
- **body**: the same information as plain text, no Markdown (no `#`, `**`, `|`).

The e-mail is read on a phone, often inside the supermarket. So whatever needs action comes first and the Shopping list comes before the recipes.

## Section order

1. **Summary** (3 lines): Week budget, Estimated cost with 🟢/🟡/🔴 and the difference; how much is current price vs. estimate.
2. **Previous week**: real Spend from Receipts (or "Receipt pending — estimated XX"), Top-up purchases and Meals out.
3. **❓ Pending**: what the Lead needs to do (send Receipt X, confirm items, Review, Stock count), as a short list.
4. **🛒 Shopping list**: grouped by supermarket and category, with ☐, quantity and price of each item.
5. **🥗 Menu**: table of the 7 days of the Week.
6. **👨‍🍳 Meal prep** (if the Family does it).
7. **💰 Price comparison**: table, purchase decision and source links.
8. **💡 How we saved** and Scenarios (if any).
9. **📖 Recipes**.
10. Footer: "Full file: data/weeks/YYYY-MM-DD.md".

## Short e-mail (recipients "list only")

A separate e-mail, sent after the full one, to each **list only** recipient. It is for whoever goes to the supermarket: the List and, to decide substitutions, the Menu.

- **subject**: `🛒 <"Shopping list" in the conversation language> — YYYY-MM-DD`
- Content, in this order: estimated total (one line); **Shopping list** grouped by supermarket and category, with ☐ and quantity (no per-item prices); **Menu** for the 7 days. No pending items, price comparison, recipes, month budget data or Members' personal information.

## Notice e-mail (onboarding pending)

Send only if the E-MAIL section already has an address (onboarding interrupted after step 1). Without an address, the notice stays only in the Week file and the run log.

- **subject**: `🥗 <"Meal plan" in the conversation language> — onboarding missing`
- Short body: the Plan was not made because there is no Family profile yet; to start, open a terminal in the project folder and run `claude --agent meal-planner`. Include what intake processed, if anything.
