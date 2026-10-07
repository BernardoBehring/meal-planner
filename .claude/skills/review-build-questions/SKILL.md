---
name: review-build-questions
description: Builds the Review questions for the Week that is ending, personalised from its Menu, as a template to fill in. Use for the Review request, or to ask the Review in conversation.
user-invocable: false
---

# Review questions

The Review is what makes the system learn: without it the calculated Stock drifts from reality (swapped meals, leftovers, things that went off) and this Week's "we didn't like it" would only take effect two Weeks later. It must be **quick to answer on a phone**: concrete questions about this Week, not a generic questionnaire. Yes/no or quick-choice questions get answered; long open questions do not.

Read the current Week file in `data/weeks/` (the Week that is ending). If it does not exist, ask only the general questions. Write in the conversation language.

1. **Meals**: for each day, "was it made as planned?", with the Menu's meals already written, so the Lead only marks what was swapped or skipped.
2. **Children and Members with difficult tastes**: for each, by name, what they ate well and what they refused (mention 3 to 5 new or risky dishes). If the Family has only Adults, ask in general.
3. **Left over / ran out**: mention the main Shopping list items and the ⚠️ Stock items.
4. **Went off**: what was thrown away.
5. **Liked / disliked**: dishes to repeat or drop.
6. **Money**: any Top-up purchases or Meals out (restaurant, takeaway; the canteen does not count) without a receipt in the inbox?
7. **Next Week**: any change in routine (travel, Guests, a Member away, a busy week)?
8. Any question the profile asks to repeat each Week (e.g. a weekly goal).

## Template

Designed to be **answered in the e-mail itself**: the Lead taps Reply, fills in the lines and sends. Blank answers mean "all as planned". The same block works as `inbox/review.txt`. Example structure (translate the labels into the conversation language):

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
