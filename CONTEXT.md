# Family Meal Planning

A system that plans, shops for and tracks a family's food, with the goal of eating well while spending as little as possible. Nothing about the family is fixed: who they are, the country, currency, supermarkets, shopping day, routines and language are all set in the onboarding interview.

## Language

The system's internal language is English: agent, skills, this glossary and the headings of every data file. The **conversation language** (chat and e-mails) is chosen by the family in onboarding and can be any language; use natural local vocabulary in it (e.g. a Portuguese family in Portugal reads "ementa", a Brazilian one "cardápio"), but keep the canonical English terms below inside data files, so the skills can find them. Product names always stay exactly as they appear in the family's local supermarkets, so the Shopping list matches the shelves.

## Terms

### Family

**Family**:
The set of Members whose food the system plans, defined in onboarding.
_Avoid_: household, users

**Member**:
Each person in the Family, identified by a name or nickname, with birth month and year (from which age is calculated) and their own profile.
_Avoid_: person, user

**Adult**:
A Member aged 18 or over, by age calculated at the date; may have individual nutrition goals (e.g. weight loss).
_Avoid_: parent (use the Member's name)

**Child**:
A Member under 18, by age calculated at the date (becomes an Adult at 18); eats to grow and never gets weight-loss goals or restrictions.
_Avoid_: minor, son/daughter (use the Member's name)

**Lead**:
The single Adult who decides the Family profile, the Budget and the e-mail recipients, and receives every e-mail; other Adults may drop Receipts and Reviews.
_Avoid_: admin, owner, user

**Presence**:
Who eats each meal of a Week; by default every Member in the routine, with exceptions (Guests, absences, school or work canteen).
_Avoid_: diners, headcount

**Guest**:
A person who is not a Member and eats a planned meal; counts in portions and in the Week's Spend, but has no profile or preferences.
_Avoid_: visitor, invitee

### Time

**Shopping day**:
The weekday on which the Family usually does the Shopping list purchase, set in onboarding; a one-off purchase on another day does not change the Week, only the purchase date (Budget month and Projected stock).
_Avoid_: grocery day, market day

**Week**:
The 7 days following the Shopping day, covered by one Menu; the Week file is named after its first day.
_Avoid_: shopping week, cycle, Monday to Sunday

**Plan**:
Producing, before the Shopping day, the Menu, the Shopping list and the Estimated cost of the following Week.
_Avoid_: weekly plan, report

**Review**:
The Lead's account of the Week that is ending, given by replying to the Review request e-mail or in a `review.txt` file: what was liked or rejected, Leftovers, shortages, Waste and Menu swaps; it corrects the calculated Stock and feeds the next Plan.
_Avoid_: feedback, evaluation

**Review request**:
The e-mail sent to the Lead before the Plan with the Review questions for the Week that is ending, personalised from its Menu.
_Avoid_: survey, questionnaire

**Purchase date**:
The day the Shopping list purchase is made: the Shopping day, unless the Lead reports a one-off exception for that Week; it decides the Budget month and the days the Projected stock must cover.
_Avoid_: shopping date, delivery date

**Month close**:
The summary of a finished month — monthly Budget against Spend, main expenses, Meals out, Waste and lessons — done before the first Week budget of the new month.
_Avoid_: monthly report, statement

### Food

**Menu**:
The meals planned for each day of a Week.
_Avoid_: meal plan, diet

**Shopping list**:
The products to buy on the Shopping day to cover the next Week's Menu, calculated from the Projected stock.
_Avoid_: cart, order

**Scenario**:
A cost variant of the Menu (Ideal, Economy, Minimum), shown only when the Estimated cost does not fit the Week budget even after optimisation.
_Avoid_: alternative plan, option

**Stock**:
The food the Family has at home at a given moment.
_Avoid_: pantry, inventory

**Projected stock**:
The Stock expected on the first day of the Week: current Stock minus what the current Week's Menu will still consume until it ends; the basis of the Shopping list.
_Avoid_: future stock, expected stock

**Stock count**:
A real survey of the Stock done by the Lead (photos of the fridge, freezer and pantry), at the frequency chosen in onboarding (monthly by default), on the first Shopping day of the period; it replaces the calculated Stock.
_Avoid_: inventory, audit

**Daily references**:
The minimum each Member present must get from the Menu each day — fruit, dairy (or an alternative) for Children, vegetables at the main meals — checked before any price.
_Avoid_: targets, quotas

**Weight log**:
An Adult's own daily weight record, kept outside the system (e.g. a Drive spreadsheet) and only read by it.
_Avoid_: weigh-in, scale data

**Waste**:
Food that went off or was thrown away without being eaten.
_Avoid_: losses, leftovers (a leftover can still be used)

**Leftover**:
Cooked food or an ingredient left over that can still be used.
_Avoid_: scraps, waste

**Meal prep**:
Dishes cooked in advance on the meal prep days chosen in onboarding (by default, the day after the Shopping day), to serve meals of the Week.
_Avoid_: batch cooking, lunchbox (a lunchbox is a meal taken out)

### Money

**Spend**:
The amount paid for food and drinks bought for home; excludes cleaning, hygiene and Meals out, even on the same Receipt.
_Avoid_: expense, cost (cost is an estimate; spend is real)

**Meal out**:
An occasional meal eaten or bought outside home (restaurant, fast food, takeaway); recorded separately and not counted in the Budget. School and routine work canteens are not Meals out: they only change Presence, and their fixed costs stay outside the system.
_Avoid_: restaurant, dining out

**Budget**:
The Spend limit, weekly and monthly, in the Family's currency, set by the Lead; the monthly one prevails. Spend counts in the month of the Receipt date.
_Avoid_: target, allowance

**Week budget**:
The effective limit of a Week: the lower of the weekly Budget and the remainder of the purchase month divided by the Shopping days still left in that month, counting the current one.
_Avoid_: weekly budget (that is the base value set by the Lead)

**Status**:
How an Estimated cost compares with the Week budget: 🟢 within, 🟡 near the limit, 🔴 over.
_Avoid_: health, traffic light

**Economy mode**:
The fixed sequence of savings applied when the Estimated cost is 🟡 or 🔴, cheapest-to-change first, never reducing adequate food.
_Avoid_: cutting, austerity

**List purchase**:
The purchase of the Shopping list on the Purchase date; its Receipt confirms the Unconfirmed Stock.
_Avoid_: main shop, weekly shop

**Top-up purchase**:
Any food purchase during the Week other than the Shopping list purchase; counts in the Spend of the Week in which it was paid.
_Avoid_: extra shop, quick shop

**Estimated cost**:
The forecast of a Plan's Spend, based on researched prices.
_Avoid_: planned spend, budget

**Receipt**:
Proof of a supermarket purchase (photo or invoice) dropped in the inbox folder; the source of truth for Spend, Stock additions and prices paid.
_Avoid_: invoice, bill, ticket

**Price label**:
How reliable a price is: current (researched online this session), verified (paid on a Receipt), historical, unverified, or estimate.
_Avoid_: price source, confidence

**Unconfirmed**:
The status of a Shopping list purchase whose Receipt has not arrived yet; the system assumes it was made and uses the Estimated cost instead of the Spend until the Receipt arrives.
_Avoid_: pending, expected

**Search level**:
How much the system compares prices across supermarkets: full, when tight (default: compares only if the usual store comes out 🟡 or 🔴) or usual store only. Current prices are always researched, at every level.
_Avoid_: price mode, effort
