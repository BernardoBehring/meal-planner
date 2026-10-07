---
name: onboarding-ask-composition
description: Asks who lives at home eating the planned meals, creating one Member block each, naming the Lead. Use in onboarding, or when someone moves in or out, a baby is born, a Child turns 18.
user-invocable: false
---

# Family composition

Never invent the Family's composition.

- How many people and, for each: name or nickname (how the Lead wants the system to call them), **birth month and year** (not age, which goes stale; for babies the month matters) and relationship to the Lead.
- Who is the **Lead**: who will use the system, answer the Reviews and get the e-mails. Usually the person answering.
- Then the e-mail recipients: `email-set-recipients`.
- Does anyone eat at home only part of the week (e.g. shared custody, shift work, student away during the week)? Record as usual presence (e.g. "Ana: at home Friday to Sunday").
- Cases that need a professional: record them (rules in `menu-check-children`).

→ PROFILE / Members: one block per Member (template in `templates/state.md`), with birth month, marked Adult or Child by age today (`presence-compute`).

**After onboarding**, when the composition changes: update the Members and their usual presence, then do `onboarding-ask-adult-profile` or `onboarding-ask-child-profile` for a new Member. Say that portions and the Shopping list change from the next Plan; if an already planned Week is affected, offer the `change-plan` skill.
