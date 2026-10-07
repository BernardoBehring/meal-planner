---
name: receipt-classify-purchase
description: Classifies a Receipt as List purchase, Top-up purchase, Meal out or canteen, from its date with its content. Use for each Receipt after reading it.
user-invocable: false
---

# Purchase type

- **List purchase**: made on the purchase date of a Week (the Shopping day, or the one-off exception the Lead reported) with Shopping list items.
- **Top-up purchase**: any other food purchase during the Week.
- **Meal out**: restaurant, fast food, takeaway, ready food eaten out.
- **Canteen**: school or routine work canteen.

Output: the type, plus the Week it belongs to (the Week whose purchase date or days contain the Receipt date).
