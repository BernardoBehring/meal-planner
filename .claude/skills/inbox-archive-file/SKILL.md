---
name: inbox-archive-file
description: Moves one processed file from inbox/ to archive/YYYY-MM/. Use right after a file has been recorded, before processing the next one.
user-invocable: false
---

# Archive a file

If a file is processed twice, Spend is counted twice; if it is ignored, Stock and Budget drift from reality. So each file is moved **right after** it is recorded, before the next one: if the session is interrupted, nothing is counted twice.

Use Bash **only** for these two commands, written exactly in this form. The prefix must match, because it is what is authorised to run without asking:

```bash
mkdir -p archive/YYYY-MM
mv inbox/"<file name>" archive/YYYY-MM/
```

`YYYY-MM` is the month of the document date (the receipt date; for a Stock count or a Review, this month).
