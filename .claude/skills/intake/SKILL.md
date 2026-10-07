---
name: intake
description: Processes everything the Family dropped in inbox/ (receipts, Stock count photos, review.txt) plus e-mail replies to the Review request, archiving each file as soon as it is recorded. Use at the start of every meal-planner session, before a Plan or a Review request, whenever there are files in inbox/, and when the user says they dropped a receipt, invoice, pantry photo or review in the folder or replied to the Review e-mail.
---

# Intake (orchestrator)

Chains skills only; every rule lives in the skill named at each step (`docs/adr/0004-atomic-skills.md`). The caller may exclude Reviews (the Review request does: the Plan reads them).

1. Read `data/state.md` if not read yet this session.
2. `inbox-classify-file` → ordered list. `review-fetch-email` → replies (skip when Reviews are excluded). Nothing at all → finish saying so.
3. **Each Receipt**, one at a time: `receipt-read` → `receipt-classify-purchase` →
   - List or Top-up purchase: `budget-record-spend` → `stock-apply-purchase` → `price-record` (paid prices) → `week-append-section` (🧾 Receipts) → `week-summarise-last`;
   - Meal out or canteen: `meal-out-record`;
   → `inbox-archive-file`.
4. **Stock count**: `stock-apply-count` → `week-append-section` (📝 Review, differences) → `inbox-archive-file` for each photo.
5. **Each Review** (`review.txt` and e-mail replies of the same Week together): `review-read` → `stock-apply-review` → `waste-record` → `review-apply-preferences` → `budget-estimate-unconfirmed` (Spend reported without Receipt) → `review-record-requests` → `week-append-section` (📝 Review) → `week-summarise-last` (Review received) → `inbox-archive-file` for the file / `review-label-email` for each reply. A typed Stock list inside a Review → `stock-apply-count`.
6. Update "Last updated" and PENDING in the state.
7. Report, in the conversation language:

```text
📥 INTAKE DONE

Receipts: N
- Tesco, 2026-10-03, list purchase: total £61.20 − non-food £4.10 = Spend £57.10
- Aldi, 2026-10-07, top-up: Spend £3.45
Meals out: 1 (£12.50, not counted in the budget)
Stock count: yes/no
Review: yes/no (file | e-mail)
To confirm: 2 items (listed under PENDING)
Unidentified: none
```
