---
name: review-request
description: Sends the Lead, by e-mail, the Review questions for the Week that is ending, personalised from the planned Menu, with a template ready to fill in by replying to the e-mail (or, alternatively, in inbox/review.txt) before the next Plan. Use for the automatic Review request run and when the user asks for the review questions, the weekly questionnaire or the review.txt template.
---

# Review request

The Review is what makes the system learn: without it the calculated Stock drifts from reality (swapped meals, leftovers, things that went off) and this Week's "we didn't like it" would only take effect two Weeks later. So it is requested before the Plan, at the times in ROUTINES in the state ("Review" and "Plan" lines), to be answered before the Plan runs. The request must be **quick to answer on a phone**: concrete questions about this Week, not a generic questionnaire.

Write the e-mail and questions in the **conversation language** from ROUTINES, with natural local vocabulary.

This skill does **not** make the Plan.

## Steps

1. Read `data/state.md`. If "Onboarding: PENDING", there is no Week to review: stop without sending anything.
2. Use the `intake` skill for Receipts and Stock counts, **except** Reviews (`review.txt` and e-mail replies): those are read by the Plan. If an old `review.txt` is already in the inbox, mention in the e-mail's pending items that it will be read by the Plan.
3. Read the current Week file in `data/weeks/` (the file named after the first day of the Week that is ending). If it does not exist, ask only the general questions.
4. Build the questions (see "Questions") and the template.
5. Send the e-mail (see "E-mail"). In interactive mode you may also show the template in the conversation and offer to take the answers right there, writing `inbox/review.txt` yourself.
6. Finish with: files processed and whether the e-mail was sent.

## Questions

Personalise them with this Week's Menu. Yes/no or quick-choice questions get answered; long open questions do not.

1. **Meals**: for each day, "was it made as planned?", with the Menu's meals already written, so the Lead only marks what was swapped or skipped.
2. **Children and Members with difficult tastes**: for each, by name, what they ate well and what they refused (mention 3 to 5 new or risky dishes). If the Family has only Adults, ask in general.
3. **Left over / ran out**: mention the main Shopping list items and the ⚠️ Stock items.
4. **Went off**: what was thrown away.
5. **Liked / disliked**: dishes to repeat or drop.
6. **Money**: any Top-up purchases or Meals out (restaurant, takeaway; the canteen does not count) without a receipt in the inbox?
7. **Next Week**: any change in routine (travel, Guests, a Member away, a busy week)?

## Template

Include in the e-mail a block with the questions already filled in and space for answers, designed to be **answered in the e-mail itself**: the Lead taps Reply, fills in the lines and sends. Blank answers mean "all as planned". The same block works for anyone who prefers to save it as `inbox/review.txt`. Example structure (translate the labels into the conversation language):

```text
REVIEW — Week of YYYY-MM-DD

MEALS (write only what changed)
Mon: lunch Chicken with rice / dinner Omelette →
Tue: ...

<NAME> — ate well:
<NAME> — refused:
(one pair of lines per Child or Member with difficult tastes, by name)

LEFT OVER:
RAN OUT:
WENT OFF:

LIKED (repeat):
DISLIKED (avoid):

PURCHASES/MEALS OUT WITHOUT RECEIPT:

NEXT WEEK — routine changes:
```

## E-mail

- **to**: only recipients of type **all** in the E-MAIL section of `data/state.md` (never "list only" recipients or anyone else; if there are none, do not send and record the pending item). If the Gmail tools are unavailable, write the request to the conversation/log instead and note it under PENDING.
- **subject**: must always **start with the tag `[Meal plan review]`** in English, whatever the conversation language (it is how replies are found), followed by a short phrase in the conversation language with the deadline, e.g. `[Meal plan review] 📝 Revisão da semana — responda até sexta às 20:00`.
- **htmlBody** (simple HTML, readable on a phone) and **body** in plain text, in this order:
  1. One sentence: **reply to this e-mail** filling in the template below before the Plan (day and time from ROUTINES); no need to answer everything, as blanks mean "as planned". Alternatively, save the answers as `inbox/review.txt`. Receipt photos still go into the `inbox/` folder: attachments to this e-mail are not read.
  2. **Pending**: Unconfirmed purchases (Receipt missing), "to confirm" items and, if the next Shopping day is a Stock count day per ROUTINES, the Stock count request.
  3. The template, in a `<pre>` block that is easy to fill in when replying.
- If sending fails, record the error under PENDING in the state.
