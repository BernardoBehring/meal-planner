---
name: onboarding
description: Runs the Family onboarding interview in short steps - language, country, currency, composition, each Member's profile, routine, habits, preferences, kitchen, budget, supermarkets, shopping routines, current stock - filling data/state.md, resuming where it stopped. Use on first use of the meal-planner agent, when the state says "Onboarding: PENDING" or has an empty PROFILE or Members, and when the user wants to redo or update the family profile, says someone moved in or out or a baby was born, or wants to change the budget, supermarkets, country, shopping day, schedule, meal prep, stock count frequency, price search level or language.
---

# Onboarding (orchestrator)

Chains skills only; every rule lives in the skill named at each step (`docs/adr/0004-atomic-skills.md`). Without a real profile the system can only produce generic menus. It only happens in conversation: in an automatic run there is nobody to answer.

## How to run it

- `state-init` if `data/state.md` is missing; then `state-check-onboarding` to see which steps are already filled. **Resume where it stopped**: run only the missing steps. If the user asks to update just one part (e.g. the budget, or "my mother moved in with us"), run only that step.
- **One step at a time**, 4 to 6 questions per message at most. Use `AskUserQuestion` when there are clear options; ask in text for free data (names, birth months, times).
- **Save to the state at the end of each step**, so nothing is lost if the conversation is interrupted.
- Accept "don't know" and "prefer not to say": record "—" and move on. Health data is optional.
- Write everything in the state in English (headings, labels, weekdays), except free-text answers such as dish names, which stay as the Family says them.

## Steps

0. `onboarding-ask-language`
1. `onboarding-ask-composition` (includes `email-set-recipients`)
2. `onboarding-ask-adult-profile` — once per Adult
3. `onboarding-ask-child-profile` — once per Child
4. `onboarding-ask-household-routine`
5. `onboarding-ask-habits`
6. `onboarding-ask-preferences`
7. `onboarding-ask-kitchen`
8. `onboarding-ask-budget`
9. `onboarding-ask-shopping-routines`
10. `onboarding-ask-stock`

## At the end

1. Show a short profile summary (Members, routine, budget) and ask for confirmation.
2. `state-mark-onboarding-done`.
3. `schedule-apply`.
4. Explain the weekly routine in 4 lines, with the real days and times from ROUTINES: receipts in `inbox/`; Review e-mail (when), answered by replying to it or in `inbox/review.txt`; Plan (when); changes in conversation.
5. Offer to do the first Plan now (`weekly-plan`, interactive mode).
