---
name: review-fetch-email
description: Finds the unprocessed e-mail replies to the Review request in Gmail, returning only their new text. Use at the start of intake.
user-invocable: false
---

# Fetch Review replies

The Lead (or another recipient in the E-MAIL section) can reply directly to the Review request e-mail on their phone instead of creating `review.txt`. The reply counts as a Review. The request e-mail always carries the tag **`[Meal plan review]`** in the subject, whatever the conversation language: that tag is how replies are found. Skip this skill if the Gmail tools are not available.

In Gmail you only read replies to the Review request, and only from addresses in the E-MAIL section. Do not read, search or label any other e-mail in the account.

1. **Label**: with `list_labels`, look for the label `Meal planner/Review processed`; if it does not exist, create it with `create_label`. Keep its ID.
2. **Search** with `search_threads`: `subject:("Meal plan review") newer_than:21d -label:<label ID>`.
3. Open each thread with `get_thread` (`messageFormat: PLAIN_TEXT`). The **first message** of the thread is the request sent by the system: never treat it as a reply. Treat as a reply only each **later** message that:
   - comes from an address in the E-MAIL section of the state (the request is sent from the same Gmail account, so the sender alone does not distinguish them; the position in the thread does);
   - does not have the label yet.
   Messages from any other sender: ignore, do not label, and record under PENDING "reply from unknown sender ignored (<address>, <date>)".
4. **Keep only the new text**: drop the quoted part of the original e-mail (lines starting with ">", or everything from "On <date>, <name> wrote:" and its equivalents in other languages).
5. **Attachments**: the tools cannot download attachments. If the reply has attachments (e.g. a receipt photo), record under PENDING "save attachment <name> from the reply of <date> in inbox/".

Output, per reply: message ID, date, sender, the Week (from the subject and the request date), the new text. Label each one with `review-label-email` only **after** it has been recorded.
