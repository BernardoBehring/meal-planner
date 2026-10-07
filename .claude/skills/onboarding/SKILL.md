---
name: onboarding
description: Runs the Family onboarding interview in short steps, starting with the conversation language, country and currency and the Family's composition (how many people, names, birth months), then each Member's profile, routine, current eating habits, preferences, restrictions, kitchen, budget and supermarkets, routines (shopping day, schedule, meal prep, stock count, price search level) and current stock; applies the schedule to the operating system; fills data/state.md and resumes where it stopped if interrupted. Use on first use of the meal-planner agent, when the state says "Onboarding: PENDING" or has an empty PROFILE or Members, and when the user wants to redo or update the family profile, says someone moved in or out or a baby was born, or wants to change the budget, supermarkets, country, shopping day, schedule, meal prep, stock count frequency, price search level or language.
---

# Onboarding

Without a real profile the system can only produce generic menus, and the rule is never to invent Family data, **including how many people there are, where they live or what they speak**. Everything else (portions, List quantities, a realistic budget, Children's rules, which shops to research) depends on these answers. Onboarding fills `data/state.md` (copy it from `templates/state.md` first if it does not exist) so the first Plan is already useful. It only happens in conversation: in an automatic run there is nobody to answer.

## How to run it

- **One step at a time**, 4 to 6 questions per message at most, so it is not overwhelming. Use `AskUserQuestion` when there are clear options (e.g. equipment, accepts store brands); ask in text for free data (names, birth months, times).
- **Save to the state at the end of each step**, not only at the end. If the conversation is interrupted, nothing is lost.
- **Resume where it stopped**: before starting, see which state sections are already filled and ask only what is missing. If the user asks to update just one part (e.g. the budget, or "my mother moved in with us"), do only that step.
- Accept "don't know" and "prefer not to say": record "—" and move on. Health data is optional.
- Talk about Children with care. Onboarding asks what they eat and like, not their weight for diet purposes. If the Lead raises a concern about a Child's weight, growth or health, record it and recommend a paediatrician or paediatric dietitian.
- Write everything in the state in English (headings, labels, weekdays), except free-text answers such as dish names, which stay as the Family says them.

## Steps

0. **Language and place** (before anything else, in one short message, in the language the user wrote in):
   - **Conversation language** for chats and e-mails (any language; for Portuguese, ask Brazil or Portugal, for Spanish ask the country, etc., so the vocabulary is natural). From here on, talk in that language.
   - **Country and city/region** where they shop, and the **currency** (suggest the obvious one for the country and confirm).
   - Say that product names will stay as they appear in their local supermarkets.
   → ROUTINES / Conversation language, Country / region, Currency
1. **Family composition**: who lives at home and eats the planned meals.
   - How many people and, for each: name or nickname (how the Lead wants the system to call them), **birth month and year** (not age, which goes stale; for babies the month matters) and relationship to the Lead.
   - Who is the **Lead**: who will use the system, answer the Reviews and get the e-mails. Usually the person answering.
   - **Lead's e-mail**, where the Plan, the Review request and updated lists arrive. Ask whether anyone else should get a copy (e.g. another Adult who does the shopping) and each copy's type: **list only** (default: short e-mail with the Shopping list and the Menu) or **all**. The Lead always gets "all". Explain that only the Lead changes the budget and recipients, and that other Adults can drop Receipts and Reviews in the inbox. Confirm each address by repeating it back, because a typo makes e-mails get lost silently. Also say that e-mails need the Gmail connector on their claude.ai account; without it, everything still works through files and chat. → E-MAIL
   - Does anyone eat at home only part of the week (e.g. shared custody, shift work, student away during the week)? Record as usual presence (e.g. "Ana: at home Friday to Sunday").
   - Cases that need a professional (baby under 2, pregnancy, breastfeeding, chronic condition, prescribed diet): record them and explain the system plans for the Family in general, while that Member's needs come from a health professional.
   → PROFILE / Members (one block per Member, with birth month, marked Adult or Child by age today)
2. **Each Adult's profile**: sex, height, weight, goal (maintain, lose, gain, general health), physical activity and frequency, where they have lunch on work days (home, lunchbox, work canteen), relevant health conditions and medication (optional); whether they already log their weight in a Google Drive file and its exact title (optional — the agent then reads it in Reviews instead of asking). One Adult at a time. → Member block
3. **Each Child's profile**: school and hours, where they have lunch on school days (canteen or lunchbox; the canteen only changes Presence and its cost stays outside the system), whether they take a snack from home, appetite, sport, allergies and intolerances. No weight-for-diet questions. → Member block
4. **Household routine**: work and sleep hours, how many meals a day, **who eats at home at each meal** (Presence for each weekday), cooking time on each kind of day (work days and days off). → PROFILE / Routine
5. **Current eating habits**: what they usually have for breakfast, lunch, dinner and snacks; drinks; sweets; typical local dishes they cook; how often they eat out or order food (restaurant, takeaway; the canteen does not count). → PROFILE (summary) and MEALS OUT (habit)
6. **Preferences and restrictions**, per Member: favourite, accepted and rejected foods; allergies, intolerances, restrictions (religious, vegetarian...). → PREFERENCES, Member block
7. **Kitchen**: hob, oven, air fryer, microwave, pressure cooker, blender, other; freezer space. → PROFILE / Kitchen
8. **Budget and shopping**: how much they want to spend per week (in their currency), knowing that Guests' meals count in the Budget; whether there is a monthly limit; usual and nearby supermarkets (with approximate distance); whether they accept store brands, frozen and seasonal produce; whether they usually take advantage of promotions. → BUDGET, SHOPPING / SUPERMARKETS
9. **Shopping and cooking routines** → ROUTINES:
   - Usual **Shopping day** and **what time** they usually shop. Explain that the Week becomes the 7 days after the Shopping day, and that a one-off purchase on another day is handled in conversation without changing anything.
   - **Automatic schedule**, calculated from that and shown for the Lead to adjust:
     - morning shopping (before 12:00): Plan **the evening before at 20:00** and Review request **two days before at 19:00**;
     - afternoon or evening shopping: Plan **the same day at 08:00** and Review request **the day before at 19:00**.
     Save as `- Plan: <weekday in English> HH:MM` and `- Review: <weekday in English> HH:MM` (e.g. `- Plan: friday 20:00`); the scheduling scripts read this format.
   - **Meal prep**: do they do it? Which days (suggest the day after shopping) and how much time on each? If not, record "no".
   - **Stock count**: monthly (default), fortnightly, every two months or never. If they choose "never", warn that Stock will depend only on the Reviews and will drift from reality.
   - **Search level** for prices: explain each option in one sentence and the cost (comparing supermarkets makes the Plan slower and more expensive): **full**, **when tight** (default: compares only if the usual store does not fit the budget) or **usual store only**. If their supermarkets publish no prices online, say that prices will come mostly from receipts.
10. **Current stock**: ask for photos of the fridge, freezer and pantry in `inbox/` with "count" in the file name (and process them with the `intake` skill), or a quick list of what is at home. → STOCK

## At the end

1. If there is no monthly budget, use weekly × 4.33 as a reference, labelled "estimated from weekly". Check the weekly budget is realistic **for the number of Members, their ages and the local cost of food** (e.g. two teenagers eat more than two small children). If it looks insufficient for adequate food, say so with numbers, without hiding it.
2. At the top of the state: `Onboarding: DONE (YYYY-MM-DD)`. Remove onboarding from PENDING and set "Current month" in BUDGET.
3. Show a short profile summary (Members, routine, budget) and ask for confirmation.
4. **Apply the schedule** to the operating system with the authorised command for this platform (see "Family routines" in the agent): Windows `powershell.exe -NoProfile -ExecutionPolicy Bypass -File scheduling/apply-schedule.ps1`; macOS/Linux `bash scheduling/apply-schedule.sh`. Show the output (day, time and next run of each job). If it fails, show the error and point to the README's section for their OS.
5. Explain the weekly routine in 4 lines, with the real days and times from ROUTINES: receipts in `inbox/`; Review e-mail (when), answered by replying to it or in `inbox/review.txt`; Plan (when); changes in conversation.
6. Offer to do the first Plan now (`weekly-plan` skill, interactive mode).

## Changes after onboarding

If the Lead says someone moved in or out, a baby was born or a Child turned 18, do only step 1 (and step 2 or 3 for the new Member), update Presence in the routine and say that portions and the Shopping list change from the next Plan. If the change affects an already planned Week, offer the `change-plan` skill. If they change the Shopping day or the schedule, update ROUTINES and apply the schedule again (step 4 of "At the end").
