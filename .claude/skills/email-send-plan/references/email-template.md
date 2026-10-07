# Plan e-mail template

- **to**: the addresses `email-resolve-recipients` returns for the **plan** e-mail.
- **subject**: `🥗 <"Meal plan" in the conversation language> — <"Week of" in the conversation language> YYYY-MM-DD` (the first day of the Week)
- **Language**: the conversation language from ROUTINES, with natural local vocabulary; amounts in the Family's currency.
- **htmlBody**: simple HTML, readable on a phone: `<h2>`, `<h3>`, `<p>`, `<ul>`, `<table>` with thin inline borders (`style="border-collapse:collapse"` and `border:1px solid #ddd; padding:4px` on cells). No external CSS, images or scripts.
- **body**: the same information as plain text, no Markdown (no `#`, `**`, `|`).

The e-mail is read on a phone, often inside the supermarket. So whatever needs action comes first and the Shopping list comes before the recipes.

## Section order

1. **Summary** (3 lines): Week budget, Estimated cost with 🟢/🟡/🔴 and the difference; how much is current price vs. estimate.
2. **Previous week**: real Spend from Receipts (or "Receipt pending — estimated XX"), Top-up purchases and Meals out; the month close summary block, if a month was closed in this Plan.
3. **❓ Pending**: what the Lead needs to do (send Receipt X, confirm items, Review, Stock count, recent changes to the Budget or recipients), as a short list.
4. **🛒 Shopping list**: grouped by supermarket and category, with ☐, quantity and price of each item.
5. **🥗 Menu**: table of the 7 days of the Week.
6. **👨‍🍳 Meal prep** (if the Family does it).
7. **💰 Price comparison**: table, purchase decision and source links.
8. **💡 How we saved** and Scenarios (if any).
9. **📖 Recipes**.
10. Footer: "Full file: data/weeks/YYYY-MM-DD.md".
