---
name: email-send-onboarding-pending
description: Sends the short notice that the Plan was not made because onboarding is missing. Use in an automatic Plan run when onboarding is pending.
user-invocable: false
---

# Onboarding-missing e-mail

Get the addresses for the **onboarding-notice** e-mail with `email-resolve-recipients`. Send only if there is one (onboarding interrupted after the composition step); without an address, the notice stays only in the Week file and the run log.

- **subject**: `🥗 <"Meal plan" in the conversation language> — onboarding missing`
- Short body: the Plan was not made because there is no Family profile yet; to start, open a terminal in the project folder and run `claude --agent meal-planner`. Include what intake processed, if anything.
