---
name: budget-classify-status
description: Classifies an Estimated cost against the Week budget as 🟢 within, 🟡 near the limit or 🔴 over. Use whenever an Estimated cost is compared with the Week budget.
user-invocable: false
---

# Budget status

| Status | Estimated cost vs. Week budget | What follows |
| --- | --- | --- |
| 🟢 **within** | below 95% | nothing |
| 🟡 **near the limit** | from 95% up to 100% | look for easy savings (`budget-apply-economy`, first steps only) |
| 🔴 **over** | above 100% | Economy mode (`budget-apply-economy`) |

Output: status and the difference (Week budget − Estimated cost).
