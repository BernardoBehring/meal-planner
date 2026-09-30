# Week file template

Use exactly this structure in `data/weeks/<first day of the Week>.md` (the day after the Shopping day). Write the **titles and text in the conversation language** from ROUTINES (the English below is the reference), with amounts in the Family's currency, except the `🧾 Receipts` and `📝 Review` headings, which stay in English because other skills look for them. Sections with no content show "—" instead of disappearing, so all Weeks are comparable. The `🧾 Receipts` and `📝 Review` sections are appended later by the `intake` skill: keep them if they already exist.

````markdown
# 🗓️ Week of YYYY-MM-DD to YYYY-MM-DD

Planned on: YYYY-MM-DD (automatic | interactive) | Week with Guests: yes/no

## 🎯 Goal

2 to 4 sentences: the Week's focus (e.g. use up the chicken in the freezer, more legumes, busy week → bigger meal prep) and what changed after the previous Week's Review.

## 📊 Budget

```text
Week budget:       XX.XX  (lower of weekly XX and month remainder XX ÷ N Shopping days)
Estimated cost:    XX.XX  🟢/🟡/🔴
Difference:        X.XX
  Current prices:  XX.XX (N items)
  Estimates:       X.XX (M items)
  Unverified:      K items
```

## 🥗 Menu

One column per meal in the PROFILE routine (e.g. include "School snack" if a Child takes a snack from home, and "Late snack" if there is one).

| Day | Breakfast | School snack | Lunch | Snack | Dinner |
| --- | --- | --- | --- | --- | --- |
| Sun 10-04 | ... | — | ... | ... | ... |
| Mon 10-05 | ... | ... | ... | ... | ... |
| ... | | | | | |
(7 rows, first to last day of the Week, with weekday and date)

(Mark ♻️ for meals reusing meal prep or Leftovers, and 🏫/💼 for meals eaten out of home.)

## 🧮 Week quantities

Summary of total consumption per ingredient (from the meal-by-meal count), with where it comes from: how much from the Projected stock and how much from the Shopping list. This is what proves the food lasts the Week.

| Ingredient | Used this Week | From Stock | From List |
| --- | --- | --- | --- |
| Bananas | 14 (≈1.7 kg) | 2 | 12 |

## ✅ Daily references

Filled from the Menu **before** prices (see the weekly-plan skill, Phase 4). Each cell: fruit portions / dairy portions / meals with vegetables that the Member gets that day. Reference: fruit 2–3, dairy every day for Children, vegetables at lunch and dinner. Mark any cell below the reference with ❌ — a Week with ❌ is not ready to be priced.

| Member | Day 1 | Day 2 | Day 3 | Day 4 | Day 5 | Day 6 | Day 7 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| <Name> | 2 / 2 / 2 | ... | | | | | |

## 👥 Presence

Who eats at home at each meal, only when different from the routine (e.g. "Thu dinner: Ana at grandma's"; "Sat lunch: +2 adult Guests"). If there are Guests, mark the Week **with Guests** in the Goal and show the estimated cost attributed to them (e.g. "Guests: ≈6.40 of the List").

## 👧 Children's adaptations

Per Child, by name: portions and adaptations per meal, when different from the base meal. No calorie targets. (Leave the section out if the Family has no Children.)

## 👨 Adults

Per Adult, by name: portions per meal and daily estimate (kcal, protein, carbohydrates, fat, fibre), labelled **PLANNING ESTIMATE**.

## 👨‍🍳 Meal prep (days from ROUTINES, e.g. YYYY-MM-DD)

(Leave the table out and write "The Family does not do meal prep" if that is the case in ROUTINES.)

| Dish | Quantity | Storage | Eat by | Used in |
| --- | --- | --- | --- | --- |

## 📖 Recipes

One subsection per more complex dish:

### Recipe name
- **Ingredients:** quantity of each
- **Method:** numbered steps
- **Time:** XX min | **Serves:** N | **Approx. cost:** X.XX (X.XX/portion)

## 📦 Stock used

Stock items used this Week, highlighting ⚠️ ones.

## 🛒 Shopping list

Grouped by supermarket (per the purchase recommendation), then by category, with product names as on the local shelves:

### <Supermarket>
**Protein**
- ☐ <product> — 1.5 kg — 8.99 (CURRENT PRICE)

**Fruit** / **Vegetables** / **Dairy** / **Pantry** / **Frozen** ...

## 💰 Price comparison

Comparison table and decision (one supermarket or split purchase, with saving and reason).

## 💡 How we saved

- Item → alternative: −X.XX
- (Scenarios, only if the Estimated cost did not fit the Week budget)

## ❓ Pending

- Missing Receipts, "to confirm" items, Review, Stock count, doubts from the automatic run.
````
