---
name: menu-build
description: Builds the 7-day Menu of a Week from the Presence table, the Stock, the Family's preferences. Use in a Plan, before any quantity or price.
user-invocable: false
---

# Build the Menu

**Never start from the price.** First decide what the Family needs to eat; price only optimises how to buy it later. Do not choose a dish because a food is cheap.

Build the Menu for the 7 days of the planned Week:

- **Every** meal in the Presence table, for each person present, including those prepared at home and eaten out (lunchboxes, school snacks, packed snacks). If a meal leaves home in a lunchbox, it uses Stock and must be on the Menu.
- **A base meal for the Family** whenever possible, with per-Member adaptations (Adult portions, adaptations for each Child).
- Every Menu considers protein, carbohydrates, fat, fibre, fruit, vegetables, legumes, dairy (or suitable alternatives) and hydration.
- Build from the Family's own food culture and what their local shops sell; respect cultural and religious practices recorded in the profile.
- **Use Stock first**, starting with ⚠️ (use first) items and Leftovers. Do not waste food available at home.
- Respect PREFERENCES and REJECTED RECIPES; repeat FAVOURITE RECIPES in moderation; avoid what caused Waste; apply the profile's notes (cooking time per day, kitchen equipment, variety wishes, weekly goals, recipe format).
- Vary proteins (chicken, eggs, legumes, fish, meat), vegetable colours and fruit across the Week.
- Give approximate portions (e.g. per Adult: cooked rice 150 g, chicken 150 g, beans 100 g, vegetables 150 g), in the units the profile asks for.
- Write a recipe for each more complex dish, as the profile asks (detail level, measures).

Output: the Menu table (one column per meal in the routine; ♻️ for reuse of meal prep or Leftovers, 🏫/💼 for meals eaten out of home), Children's adaptations, Adult portions, recipes. Then the Menu must pass `menu-check-children` (when there are Children).
