---
name: change-plan
description: Changes an existing weekly Plan - swap, add or remove meals, ingredients or quantities, change supermarket, adjust for Guests or absences, or a one-off change of shopping day - keeping Menu, Shopping list, Estimated cost, Stock, state consistent, re-sending the corrected List if the shopping has not been done yet. Use whenever the user asks for any change to a menu or list already produced, such as "swap Wednesday's fish for chicken", "take the salmon off the list", "we have guests on Saturday", "Ana is away on Thursday", "I'd rather buy everything at Lidl" or "this week I'll only shop on Sunday".
---

# Change a Plan (orchestrator)

Chains skills only; every rule lives in the skill named at each step (`docs/adr/0004-atomic-skills.md`). The Week file, Shopping list, Estimated cost and Stock were calculated together, so they change together.

1. **Identify the Week**: by default, the next Week already planned (the most recent `data/weeks/<first day of the Week>.md`); the Week in progress if the request is about it.
2. By kind of change:
   - meals, ingredients, quantities → `menu-apply-change`;
   - Guests or absences → `presence-compute`, then `menu-apply-change` for the affected meals;
   - one-off shopping day → `week-compute-dates` (new purchase date) → `stock-project`;
   - supermarket → `price-research` for the List at that store.
3. `list-count-consumption` → `list-build` → `list-check-sufficiency`.
4. `price-research` for new items → `budget-compute-week` (the purchase month may have changed) → `budget-classify-status`; 🔴 → warn and offer `budget-apply-economy` before confirming.
5. **Show before and after** (meal, items added or removed from the List, cost difference) and ask for confirmation. If the request is already unambiguous and small, apply it directly and show the result.
6. Save: `week-write-file` (planning sections) → `week-append-section` (✏️ Changes) → `stock-record-plan` → `budget-record-plan` → "Last updated".
7. `email-send-list-update`.
