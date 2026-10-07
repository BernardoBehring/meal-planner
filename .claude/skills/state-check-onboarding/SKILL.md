---
name: state-check-onboarding
description: Tells whether onboarding is done, listing the missing parts of the Family profile. Use at the start of every Plan, Review request or onboarding.
user-invocable: false
---

# Is onboarding done?

Read `data/state.md`. Onboarding is **pending** if any of these is true:

- The top line says "Onboarding: PENDING".
- PROFILE / Members is empty ("—").
- ROUTINES has no Shopping day.

Never invent a profile to get past this check, **including how many people there are, where they live or what they speak**.

Output: `done` or `pending`, plus the list of empty state sections (so onboarding can resume where it stopped).
