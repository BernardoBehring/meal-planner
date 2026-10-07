# Atomic skills: each skill does one thing

The agent is made of many small skills, each with a single responsibility (compute the Week budget, read a Receipt, record Spend, send the List e-mail…), instead of one large skill per routine. The routines people and the scheduler already call — `weekly-plan`, `intake`, `review-request`, `month-close`, `onboarding`, `change-plan`, `price-research` — are kept as **orchestrator** skills: they only chain other skills and contain no business rules. The agent file keeps only the role, conventions, routing and a single list of absolute prohibitions that apply everywhere. The number of skills is not a cost to minimise; reuse and clarity are the goal.

We had one skill per routine, and the same rules ended up written in several places (the e-mail recipient types in six, the Children's rules in five, the Week budget formula in four), with at least one inconsistency (the 🟡 threshold). Atomic skills are hidden from the `/` menu (`user-invocable: false`); the model still invokes them.

## Consequences

- A business rule (e.g. the Week budget, who receives which e-mail, when a Stock count is due) lives in exactly one skill; whoever needs it invokes that skill, never copies the rule.
- If a skill's description needs "and" to say what it does, it must be split. Orchestrators are exempt: their description names the routine.
- A Plan invokes many skills, so a run makes more tool calls than before; descriptions are kept to one sentence because all of them are loaded in every session.
