---
name: email-send-review-request
description: Sends the Review request e-mail containing the personalised template. Use in the Review request run.
user-invocable: false
---

# Send the Review request

Get the addresses for the **review-request** e-mail with `email-resolve-recipients` ("all" only). If the Gmail tools are unavailable, write the request to the conversation/log instead and note it under PENDING.

- **subject**: must always **start with the tag `[Meal plan review]`** in English, whatever the conversation language (it is how `review-fetch-email` finds replies), followed by a short phrase in the conversation language with the deadline, e.g. `[Meal plan review] 📝 Revisão da semana — responda até sexta às 20:00`.
- **htmlBody** (simple HTML, readable on a phone) and **body** in plain text, in this order:
  1. One sentence: **reply to this e-mail** filling in the template below before the Plan (day and time from ROUTINES); no need to answer everything, as blanks mean "as planned". Alternatively, save the answers as `inbox/review.txt`. Receipt photos still go into the `inbox/` folder: attachments to this e-mail are not read.
  2. **Pending**: Unconfirmed purchases (Receipt missing), "to confirm" items and, if `stock-check-count-due` says the next Shopping day is a Stock count day, the Stock count request. If an old `review.txt` is already in the inbox, say it will be read by the Plan.
  3. The template from `review-build-questions`, in a `<pre>` block that is easy to fill in when replying.
- If sending fails, record the error under PENDING in the state.
