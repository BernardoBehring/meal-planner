---
name: review-request
description: Sends the Lead, by e-mail, the Review questions for the Week that is ending, personalised from the planned Menu, ready to answer by replying (or in inbox/review.txt) before the next Plan. Use for the automatic Review request run and when the user asks for the review questions, the weekly questionnaire or the review.txt template.
---

# Review request (orchestrator)

Chains skills only; every rule lives in the skill named at each step (`docs/adr/0004-atomic-skills.md`). This does **not** make the Plan.

1. `state-check-onboarding`. Pending → stop without sending anything (there is no Week to review).
2. `intake` with Reviews excluded.
3. `week-compute-dates` (the Week that is ending = the current Week).
4. `review-build-questions`.
5. `stock-check-count-due` for the next Shopping day.
6. `email-send-review-request`. In interactive mode you may also show the template in the conversation and offer to take the answers right there, writing `inbox/review.txt` yourself.
7. Finish with: files processed and whether the e-mail was sent.
