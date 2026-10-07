---
name: weekly-plan
description: Produces the Family's full Plan for the next Week (the 7 days after the Shopping day) - review of the ending Week, Menu, recipes, meal prep, Projected stock, Shopping list, current price research, Week budget, Economy mode - writes the Week file, updates the state and sends the e-mail. Use for the automatic Plan run and whenever the user asks to plan the week, build the menu, make next week's shopping list or "run the plan", even if they only ask for part of it (e.g. "make next week's shopping list").
---

# Weekly plan

The Plan turns the Family state into three deliverables: what to eat (Menu), what to buy (Shopping list) and how much it will cost (Estimated cost vs. Week budget). It always follows the same order, because each phase depends on the previous one: **never start from the price**.

Everything the Family reads (the Week file and e-mails) is written in the **conversation language** from ROUTINES, with amounts in the Family's **currency**. Headings in data files that other skills look up (`🧾 Receipts`, `📝 Review`) stay in English.

## Modes

- **Automatic** (the request says "automatic run"): nobody answers. Ask nothing; decide from the state, record doubts under PENDING and send the e-mail.
- **Interactive**: ask freely, especially in the Review (Phase 2) and before closing the Menu. Send the e-mail at the end unless the Lead says not to.

## Dates

Read the **Shopping day** from ROUTINES in the state (e.g. "saturday"). Never assume it is Saturday or that the Week runs Monday to Sunday.

- The **next Shopping day** is the next occurrence of the Shopping day from today, including today (the Plan may run the evening before or on the day itself).
- The **planned Week** is the 7 days after the next Shopping day. Example: Shopping day Saturday → Week Sunday to Saturday; Shopping day Wednesday → Week Thursday to Wednesday.
- The file is `data/weeks/<first day of the Week>.md`. If it already exists (Plan redone), overwrite the planning sections but **keep** the `🧾 Receipts` and `📝 Review` sections.
- The **current Week** is the one that ends on the Shopping day itself. Its file has the Menu still to be eaten until then.
- The **purchase date** is the next Shopping day, unless the Lead reported a one-off exception for this Week (e.g. "this week I'll shop on Sunday"). The exception does not change the Week, only the purchase date: the Projected stock gains or loses days of consumption, and Spend counts in that date's month (by Receipt date).

## Phases

### Phase 0: Preconditions

1. Read `data/state.md` (if it does not exist, copy `templates/state.md` to it). If "Onboarding: PENDING" or the PROFILE is empty, **do not invent a profile**:
   - Interactive: use the `onboarding` skill.
   - Automatic: still run intake (Phase 1), write a short notice in `data/weeks/<first day of the Week>.md` that onboarding is missing (`claude --agent meal-planner`), send a short e-mail with that notice (only if E-MAIL has an address) and stop.
2. Read `data/prices.md`, the current Week file and the previous one, if they exist.

### Phase 1: Intake

Always use the `intake` skill: it checks `inbox/` and e-mail replies to the Review request (even with an empty inbox there may be a reply).

If the **purchase date** is in a different month from the "Current month" in BUDGET, use the `month-close` skill before continuing: the previous month is over for purchasing purposes, and the Week budget now comes from the new month.

### Phase 2: Review of the current Week

- Use the Review already processed (LAST WEEK → "Review received").
- No Review: in interactive mode, ask the questions (what was left over, ran out, went off, liked, disliked, what each Child ate well or refused, how much was spent, did the routine change?); in automatic mode, carry on and mark "Review pending".
- **Weight log**: for each Adult with a "Weight log" line, read it as the agent's "Weight log" rules say and record in the Week file's Review the 7-day average, its change from the previous 7 days and from the start of the log. If that Adult's goal is weight loss and the 7-day average has not dropped for 3 Weeks in a row, adjust their portions a little (less carbohydrate, same protein, fruit and vegetables) and say so; a faster loss than about 1% of body weight per week is worth mentioning too. Never for Children.
- Current Week purchases without a Receipt stay **Unconfirmed**: the Estimated cost stands in for the Spend, labelled as an estimate, and the Receipt goes under PENDING.

### Phase 3: Menu

Build the Menu for the 7 days of the planned Week following the agent's nutrition rules and each Member's rules (Adults and Children, by age):

- **Presence first**: calculate each Member's age today from their birth month (anyone who turned 18 becomes an Adult; note it under PENDING). Then, from the Members and the PROFILE routine, plus changes from the Review and PENDING (Guests, someone away, shared custody, canteen), decide who eats at home at each meal of each day. All quantities depend on this. If there are no Members in the state, do not assume the Family's composition: ask in interactive mode; in automatic mode, treat it as pending onboarding (Phase 0).
- **Every** meal the PROFILE routine lists, for each person, including those prepared at home and eaten out: Adults' lunchboxes, Children's school snacks, late snack if any. If a meal leaves home in a lunchbox, it uses Stock and must be on the Menu. Also consider who does not eat at home at each meal (canteen, Guests, a Member away). **Guests** count in portions and Spend; record how many and at which meals in the Presence table, and estimate how much of the Shopping list went to them.
- **A base meal for the Family**, with adaptations for each Child and portions for each Adult.
- Build from the Family's own food culture and what their local shops sell.
- **Use Stock first**, starting with ⚠️ (use first) items and Leftovers.
- Respect PREFERENCES and REJECTED RECIPES; repeat FAVOURITE RECIPES in moderation; avoid what caused Waste.
- Vary proteins (chicken, eggs, legumes, fish, meat), vegetable colours and fruit across the Week.
- **Meal prep** per ROUTINES: on the days and with the time the Family gave (by default, the day after the Shopping day, the first day of the Week). Each dish should serve meals on the following days; reuse (e.g. roast chicken on the prep day → next day's lunchbox → wrap filling later). If the Family does **not** do meal prep, plan meals that fit each day's cooking time (PROFILE / Kitchen), with quicker dishes on work days.
- Adults: when there is data, estimate kcal, protein, carbohydrates, fat and fibre per day, per Adult, as a **planning estimate**. Children: never calorie targets.

### Phase 4: Projected stock and Shopping list

1. **Projected stock for the first day of the Week** = current Stock − what the current Week's Menu will still consume up to and including the purchase date. If the purchase is exceptionally later than usual, also count the planned Week's days before the purchase, which are still served by the current Stock.
2. **Count quantities meal by meal.** Build a consumption table (ingredient × portions × Members present, at every meal of the 7 days) and add up per ingredient. Do not estimate "roughly": this is where a plan that is too cheap hides insufficient food. Pay special attention to items eaten every day, which almost never last a whole Week from Stock:
   - **Fruit**: count every appearance (breakfast, snacks, lunchbox, dessert). As a reference, 2 to 3 portions per Member present per day.
   - **Milk, yoghurt and cheese**: every appearance counts. Children need dairy (or an alternative) every day, for calcium.
   - **Bread, oats and breakfast cereals**, and **vegetables** at lunch and dinner.
3. **Shopping list** = total consumption − Projected stock, rounded up to real pack sizes, with a small margin for staples that are 🟡 or 🔴.
4. Do not buy what is already at home in sufficient quantity (Rule 7).
5. **Sufficiency check** — do it before looking at prices, and do not redo it afterwards to make the cost fit:
   - **Every ingredient named on the Menu** (including salad items, bread for toast and sandwiches, sauces and sides) appears in the Week quantities table and is covered by Projected stock + List. An ingredient on the Menu but missing from the table is an error, not a saving.
   - **Count slices and pieces, not packs**: e.g. bread = slices per toast/sandwich × people × occasions; an 800 g loaf has about 20 slices.
   - **Daily references** are met for every Member present: fruit 2 to 3 portions per day, dairy (or alternative) every day for Children, vegetables at lunch and dinner. Prove it with the **Daily references table** in the Week file: one row per Member, one column per day, each cell with the number of fruit portions / dairy portions / meals with vegetables that the Menu actually gives that Member that day (counting only meals they are present for, including lunchboxes and canteen meals only if their content is known). Fill it **before** price research, from the Menu, not from the budget. Any cell below the reference means the Menu must be fixed (add fruit to breakfast or snacks, milk to porridge, a vegetable side) — and the quantities in step 2 recounted — before moving on. A sentence such as "the daily reference is met" is not a substitute for the table.
   - If the Estimated cost is far below the Week budget (for example, under 60%), treat it as a warning, not a win: redo the count. A low cost is only legitimate when it comes from Stock being used, and the Week file must show where each meal comes from.

### Phase 5: Prices

Use the `price-research` skill with the Shopping list and the **Search level** from ROUTINES. It returns labelled prices and, depending on the level, the comparison across supermarkets and the one-shop vs. split-purchase recommendation. At the "when tight" level it researches only the usual store first: do Phase 6 with that total and, if it comes out 🟡 or 🔴, call the skill again to compare other supermarkets before Economy mode.

### Phase 6: Budget and optimisation

1. Calculate the **Week budget** = min(weekly budget; remainder of the month ÷ Shopping days left in the month). Show the calculation.
   - The month is the **purchase date's** month, not the month the Week starts. Example: with Shopping day Saturday, the Week starting Sunday 1 November, bought on Saturday 31 October, comes out of October's budget.
   - **Shopping days left in the month** = number of occurrences of the Shopping day from the purchase date to the end of that month, including the purchase date. Always at least 1.
2. Compare with the Estimated cost and classify: 🟢 within, 🟡 near the limit (margin below ~5%) or 🔴 over.
3. 🟡: look for easy savings. 🔴: apply **Economy mode** in the order of the agent's rules and, if it still does not fit, present the **Scenarios** (only as differences from the main Menu). Never cut necessary food or Children's essential foods.
   - **The cost is always the cost of the adequate Menu** from Phase 4. Never shrink quantities, drop ingredients or fall below the daily references to reach 🟢: that turns a budget problem into a hidden food problem. If the adequate Menu does not fit even after Economy mode, the Week is 🔴: say so plainly, show the gap, and let the Scenarios show what the Family could change (cheaper proteins, fewer premium items), each still meeting the daily references. The Lead decides; the Plan never decides silently.
   - A note like "fruit is tighter than usual this Week" means the check failed: go back to Phase 4 instead of writing it.
4. Record each saving applied (item → alternative: −amount).

### Phase 7: Save

1. Write `data/weeks/<first day of the Week>.md` following **exactly** the template in `references/week-template.md`.
2. Update `data/state.md`:
   - STOCK: Projected stock for the first day of the Week + Shopping list items as **Unconfirmed**.
   - BUDGET: the planned Week's line with its Estimated cost; next Week budget.
   - LAST WEEK: summary of the current Week (Estimated cost, Spend from Receipts, Review).
   - PENDING: missing Receipts, "to confirm" items, Review, Stock count (if the purchase date is the first Shopping day of a Stock count period per ROUTINES — monthly, fortnightly or every two months — and there is no Stock count for that period; with "never", suggest one only if the Review shows big gaps between calculated and real Stock).
   - "Last updated".
3. Record the researched prices in `data/prices.md` (the `price-research` skill does this).

### Phase 8: E-mail

Send the e-mail following `references/email-template.md`. If it fails, or the Gmail tools are unavailable, record it in the Week file.

### Phase 9: Final summary

Finish with (in the conversation language):

```text
✅ PLAN — Week of YYYY-MM-DD
Intake: N receipts, Stock count yes/no, Review yes/no
File: data/weeks/YYYY-MM-DD.md
Week budget: XX.XX | Estimated cost: XX.XX (🟢/🟡/🔴) | XX.XX verified + X.XX estimated
E-mail: sent / failed (reason) / Gmail not connected
Pending: ...
```
