=============================
FAMILY STATE
=============================

Last updated: —
Onboarding: PENDING

## E-MAIL

(Set by the `email-set-recipients` skill; types explained in `email-resolve-recipients`. One line per recipient: "- <address> (<Lead | name> — <all | list only>)".)

- — (Lead — all)

## ROUTINES

(Filled in onboarding. The "Plan" and "Review" lines are read by the scheduling scripts: keep the format "<weekday in English> HH:MM", e.g. "saturday 08:00".)

- Conversation language: —
- Country / region: —
- Currency: —
- Shopping day: —
- Usual shopping time: —
- Plan: saturday 08:00
- Review: friday 19:00
- Meal prep: — (days and time on each; "no" if they don't)
- Stock count: monthly (monthly | fortnightly | every two months | never)
- Search level: when tight (full | when tight | usual store only)

## PROFILE

### Members

(One block per Member, filled in onboarding. Adult or Child is decided by age at each Plan — see the `presence-compute` skill.)

- —

Block template — Adult:
- Name (Adult, born YYYY-MM) — Lead? yes/no
  - Sex / height / weight: —
  - Goal: —
  - Physical activity: —
  - Work / hours / weekday lunch (home, lunchbox, work canteen): —
  - Allergies / intolerances / restrictions: —
  - Health / relevant medication: —
  - Weight log (Google Drive file title, optional): —
  - Usual presence: every day

Block template — Child:
- Name (Child, born YYYY-MM)
  - School / hours: —
  - Weekday lunch: school canteen (Presence only, outside the Budget) / lunchbox
  - School snack taken from home: yes / no
  - Appetite / sport / notes: —
  - Allergies / intolerances: —
  - Usual presence: every day

### Routine

- Meals per day: —
- Who eats at home at each meal (by weekday): —
- Sleep: —

### Kitchen

- Equipment: —
- Cooking time (work days / days off): —
- Freezer space: —

## BUDGET

Weekly (base): —
Monthly: — (prevails over the weekly)

Current month (YYYY-MM) — Spend by Receipt date:
- Week of YYYY-MM-DD (purchase YYYY-MM-DD): Estimated cost — | Spend — (list — + top-up —)
- Total spent this month: —
- Remaining this month: —
- Shopping days left this month: —
- Next Week budget: —

## SHOPPING / SUPERMARKETS

- Usual: —
- Nearby: —
- Accepts store brands: —
- Accepts frozen: —
- Accepts seasonal produce: —
- Buys on promotion: —

## STOCK

Last Stock count: — (when the next one is due: `stock-check-count-due` skill)

(Line format and statuses: see the `stock-classify` skill.)

- —

## PREFERENCES

(Per Member, by name.)

- —: likes — / dislikes —

## LAST WEEK

- Week of: —
- Estimated cost: —
- Spend (Receipts): —
- Top-up purchases: —
- Review received: —
- Liked: —
- Disliked: —
- Leftovers: —
- Ran out of: —
- Menu swaps: —

## MEALS OUT (current month — not counted in the Budget)

- —

## WASTE

- —

## FAVOURITE RECIPES

- —

## REJECTED RECIPES

- —

## PRODUCTS

- Favourites: —
- Good value: —
- Cause waste: —

## PENDING

- Do the onboarding interview (claude --agent meal-planner)
