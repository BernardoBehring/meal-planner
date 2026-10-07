---
name: onboarding-ask-shopping-routines
description: Asks the Shopping day, shopping time, meal prep, Stock count frequency, price Search level. Use in onboarding, or when any of these routines changes.
user-invocable: false
---

# Shopping and cooking routines

- Usual **Shopping day** and **what time** they usually shop. Explain that the Week becomes the 7 days after the Shopping day, and that a one-off purchase on another day is handled in conversation without changing anything. Then `schedule-derive`.
- **Meal prep**: do they do it? Which days (suggest the day after shopping) and how much time on each? If not, record "no".
- **Stock count**: monthly (default), fortnightly, every two months or never. If they choose "never", warn that Stock will depend only on the Reviews and will drift from reality.
- **Search level** for prices: explain each option in one sentence and the cost (comparing supermarkets makes the Plan slower and more expensive): **full**, **when tight** (default: compares only if the usual store does not fit the budget) or **usual store only**. If their supermarkets publish no prices online, say that prices will come mostly from receipts.

→ ROUTINES. If the Plan or Review line changed, `schedule-apply`.
