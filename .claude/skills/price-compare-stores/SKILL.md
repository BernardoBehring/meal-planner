---
name: price-compare-stores
description: Decides between buying everything at one supermarket or splitting the purchase, from the researched prices. Use when prices were researched at more than one store.
user-invocable: false
---

# One shop or split purchase

Show the comparison table (only the stores researched; cells without data = "—"), with amounts in the Family's currency:

| Product | Store A | Store B | Store C | Best price |
| --- | ---: | ---: | ---: | --- |
| Chicken breast (per kg) | 5.99 | 6.49 | 5.79 | Store C |

Then calculate:

```text
ONE SUPERMARKET
- Store A: XX.XX (N items at current price, M estimated)

SPLIT PURCHASE
- Store C: XX.XX
- Store A: XX.XX
Total: XX.XX | Saving: X.XX
```

Recommend splitting only if the saving is worth the time and travel: never recommend visiting several supermarkets to save a trivial amount if it takes disproportionate time or travel (consider the Family's transport and distances in the profile). Small savings rarely justify a second trip, unless the stores are next to each other or on the usual route. State the recommendation and why.
