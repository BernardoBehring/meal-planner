---
name: presence-compute
description: Computes who eats at home at each meal of each day of a Week, classifying each Member as Adult or Child by age. Use before building a Menu or recounting portions.
user-invocable: false
---

# Presence

1. **Ages**: the state keeps each Member's **birth month and year**, not their age, because ages go stale. Calculate each Member's age at the date of the Plan. Adult = 18 or over; Child = under 18. When a Member turns 18 they become an Adult from that Plan on: update their block and note under PENDING that the Adult profile (goal, activity) can be completed.
2. **Composition**: read the Members from the state. Never assume how many people there are, their ages or relationships. If there are no Members, stop: onboarding is pending.
3. **Who eats where**: from the PROFILE routine (meals per day and who eats at home at each), each Member's usual presence (shared custody, shift work, student away) and the changes recorded in the Review and PENDING:
   - **Guests** (people who are not Members and eat a planned meal) count in portions and in the Week's Spend, with no profile or preferences. Record how many, adult or child, and at which meals.
   - **School and routine work canteens** are not Meals out: they only change Presence (that Member does not eat that meal at home); their fixed costs stay outside the system.
   - Meals prepared at home and eaten out (Adults' lunchboxes, Children's school snacks, packed snacks for activities) **are** at-home meals for quantities: they use Stock.
   - A Member away (trip, holiday at the other parent's) is out of every meal of those days.

Output: a Presence table (day × meal → Members and Guests present, plus packed meals), and "Week with Guests: yes/no". Every quantity in the Plan depends on it.
