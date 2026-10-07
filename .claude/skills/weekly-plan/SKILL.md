---
name: weekly-plan
description: Produces the Family's full Plan for the next Week (the 7 days after the Shopping day) - Menu, recipes, meal prep, Shopping list, current prices, Week budget - saved in the Week file, the state, the e-mail. Use for the automatic Plan run and whenever the user asks to plan the week, build the menu, make next week's shopping list or "run the plan", even if they only ask for part of it.
---

# Weekly plan (orchestrator)

Chains skills only; every rule lives in the skill named at each step (`docs/adr/0004-atomic-skills.md`). The order matters: each step depends on the previous one — never start from the price.

**Modes** — automatic (the request says "automatic run": ask nothing, record doubts under PENDING) or interactive (ask freely, especially in the Review and before closing the Menu).

1. `state-init` if `data/state.md` is missing.
2. `state-check-onboarding`. If pending:
   - interactive → `onboarding`, then continue;
   - automatic → `intake`, `week-compute-dates`, `week-write-onboarding-notice`, `email-send-onboarding-pending`, then stop.
3. `intake`.
4. `week-compute-dates`. Read `data/prices.md`, the current Week file and the previous one, if they exist.
5. `month-check-close-due` → if due, `month-close` (keep its summary block for the e-mail).
6. **Review of the current Week**: use the Review already processed (LAST WEEK). None → interactive: `review-build-questions`, ask them in the conversation, then apply as `intake` does for a Review; automatic: mark "Review pending". Unconfirmed purchases → `budget-estimate-unconfirmed`. For each Adult with a Weight log → `weight-read-log`, `weight-assess-trend`.
7. `presence-compute`.
8. `menu-build` → `menu-plan-prep` → `menu-check-children` (if there are Children) → `nutrition-estimate-adults` (Adults with enough data).
9. `stock-project` → `list-count-consumption` → `list-build` → `list-check-sufficiency` (fix the Menu and loop back to `list-count-consumption` while any ❌).
10. `price-research` with the Shopping list (comparison only if its Search level says so).
11. `budget-compute-week` → `budget-classify-status`. If 🟡/🔴 and the Search level is "when tight": `price-research` again with a comparison, then `budget-classify-status` again. Still 🟡/🔴 → `budget-apply-economy`. Then the under-60% check in `list-check-sufficiency`.
12. Save: `week-write-file` → `stock-record-plan` → `budget-record-plan` → `week-summarise-last` → `stock-check-count-due` (purchase date; if due, add the request to PENDING) → PENDING (missing Receipts, "to confirm" items, Review) → "Last updated".
13. `email-send-plan` → `email-send-list`.
14. Final summary, in the conversation language:

```text
✅ PLAN — Week of YYYY-MM-DD
Intake: N receipts, Stock count yes/no, Review yes/no
File: data/weeks/YYYY-MM-DD.md
Week budget: XX.XX | Estimated cost: XX.XX (🟢/🟡/🔴) | XX.XX verified + X.XX estimated
E-mail: sent / failed (reason) / Gmail not connected
Pending: ...
```
