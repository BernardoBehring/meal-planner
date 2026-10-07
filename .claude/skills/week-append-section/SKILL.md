---
name: week-append-section
description: Appends a 🧾 Receipts, 📝 Review or ✏️ Changes block to a Week file without touching its planning sections. Use after a Receipt, a Review or a Plan change is recorded.
user-invocable: false
---

# Append to the Week file

Find the Week file the event belongs to (`data/weeks/YYYY-MM-DD.md`, the Week whose dates contain the Receipt date, the reviewed Week, or the changed Week). Append, never rewrite, under the matching English heading (create it at the end if missing):

- `## 🧾 Receipts`: one entry per Receipt — supermarket, date, purchase type, total, non-food and Spend.
- `## 📝 Review`: the Review, summarised, with its origin (file or e-mail of <date>); also the Stock count differences from the calculated Stock, when there was one.
- `## ✏️ Changes`: one line per change (date: what changed, effect on cost).

Headings stay in English; the text inside is in the conversation language.
