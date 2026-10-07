---
name: onboarding-ask-budget
description: Asks the weekly Budget, the monthly limit, the supermarkets, what kinds of products the Family accepts. Use in onboarding, or when the Lead changes the Budget or the supermarkets.
user-invocable: false
---

# Budget and shopping

1. If BUDGET already has values (a change, not the first setup), use `lead-confirm-change` first; stop if not confirmed.
2. Ask: how much they want to spend per week (in their currency), knowing that Guests' meals count in the Budget; whether there is a monthly limit; usual and nearby supermarkets (with approximate distance and how they get there); whether they accept store brands, frozen and seasonal produce; whether they usually take advantage of promotions.
3. `budget-default-monthly`.
4. If it was a change, `email-send-change-notice` (budget).

→ BUDGET, SHOPPING / SUPERMARKETS
