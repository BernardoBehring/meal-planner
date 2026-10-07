---
name: list-count-consumption
description: Counts, meal by meal, how much of each ingredient the Menu uses in the Week. Use in a Plan after the Menu, before the Shopping list.
user-invocable: false
---

# Count consumption meal by meal

Build a consumption table (ingredient × portions × people present, at every meal of the 7 days, from the Presence table) and add up per ingredient. Do not estimate "roughly": this is where a plan that is too cheap hides insufficient food.

- **Every ingredient named on the Menu** (including salad items, bread for toast and sandwiches, sauces and sides) appears in the table.
- **Count slices and pieces, not packs**: e.g. bread = slices per toast/sandwich × people × occasions; an 800 g loaf has about 20 slices.
- Pay special attention to items eaten every day, which almost never last a whole Week from Stock: **fruit** (every appearance: breakfast, snacks, lunchbox, dessert), **milk, yoghurt and cheese** (every appearance), **bread, oats and breakfast cereals**, and **vegetables** at lunch and dinner.

Output: the Week quantities table (Ingredient | Used this Week | From Stock | From List), with "From Stock" taken from the Projected stock.
