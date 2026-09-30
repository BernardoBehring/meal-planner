---
name: change-plan
description: Changes an existing weekly Plan - swap, add or remove meals, ingredients or quantities, change supermarket, adjust for Guests or absences, or a one-off change of shopping day - keeping Menu, Shopping list, Estimated cost, Stock and state consistent, and re-sending the corrected List by e-mail if the shopping has not been done yet. Use whenever the user asks for any change to a menu or list already produced, such as "swap Wednesday's fish for chicken", "take the salmon off the list", "we have guests on Saturday", "Ana is away on Thursday", "I'd rather buy everything at Lidl" or "this week I'll only shop on Sunday".
---

# Change a Plan

The Week file, the Shopping list, the Estimated cost and the Stock in the state were calculated together. Changing only one of them (e.g. swapping a meal and forgetting the List) produces a List that does not serve the Menu. This skill changes everything at once.

Talk and write in the **conversation language** from ROUTINES, with amounts in the Family's currency.

## Steps

1. **Identify the Week**: by default, the next Week already planned (the most recent `data/weeks/<first day of the Week>.md`). If the request is about the Week in progress, use its file.
2. **Understand the change** and, if it is ambiguous, ask (e.g. "grilled or roast chicken?", "are the Guests coming for dinner or only lunch?", "are the Guests adults or children?"). Guests count in portions and in the Week's Spend; mark the Week "with Guests" and show the cost attributed to them. A one-off change of shopping day ("this week I'll shop on Sunday") does not change the Week, only the purchase date: recalculate the Projected stock (more or fewer days of consumption before the purchase) and the Budget month if it changes. Check the change respects the agent's rules: Children, nutritional balance and ⚠️ Stock. If there is a conflict, explain and propose an alternative before applying.
3. **Recalculate what the change affects**:
   - Menu: the swapped meal and those that depend on it (meal prep, ♻️ reuse).
   - Ingredients: what comes in and what goes out.
   - Shopping list: based on the Projected stock. An ingredient that left the Menu may no longer need buying, or may stay at home.
   - Prices for new items with the `price-research` skill. Items already priced in this session can reuse that price.
   - Estimated cost and 🟢/🟡/🔴 status against the Week budget. If it becomes 🔴, warn and offer savings before confirming.
4. **Show before and after** (meal, items added or removed from the List, cost difference) and ask for confirmation. If the request is already unambiguous and small, apply it directly and show the result.
5. **Save**:
   - Week file: update Menu, Recipes, Meal prep, Shopping list, Budget and Comparison. Append at the end a `## ✏️ Changes` section with one line per change (date: what changed, effect on cost). Keep `🧾 Receipts` and `📝 Review`.
   - State: STOCK (Unconfirmed List items), BUDGET (the Week's Estimated cost), "Last updated".
6. **E-mail**: only if the Shopping list purchase has not happened yet (no List-purchase Receipt for this Week). Send to **every** recipient in the E-MAIL section of `data/state.md`, both "all" and "list only" (never anyone else):
   - **subject**: `🛒 <"Shopping list (updated)" in the conversation language> — YYYY-MM-DD`
   - Body: what changed (2 or 3 lines), the full corrected Shopping list (grouped by supermarket and category, with ☐) and the new Estimated cost.
   - If the shopping is already done, do not send: say the change applies to consumption and any missing items can become a Top-up purchase.
