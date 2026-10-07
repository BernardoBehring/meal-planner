# 🥗 Meal Planner — a family food assistant for Claude Code

A [Claude Code](https://claude.com/claude-code) agent that plans your family's weekly meals, keeps track of what you have at home, researches current supermarket prices and keeps your grocery budget under control. It works in **any language, country and currency**, on **Windows, macOS and Linux**.

Every week it:

1. **Asks how the week went** (by e-mail — you just reply on your phone).
2. **Plans the next week**: menu, recipes, meal prep, a shopping list based on what you already have, current prices from your supermarkets, and the cost against your budget.
3. **Learns** from your receipts, what you liked, what was left over and what went off.

It adapts to each family member (adults can have goals such as losing weight; children never get diets or calorie targets), never invents prices, and never cuts necessary food to fit a budget.

## What you need

- **Claude Code** installed and logged in with a Claude account ([install guide](https://docs.claude.com/en/docs/claude-code/setup)). Each person uses their own account and pays for their own usage (a weekly Plan with price comparison costs roughly US$1–3 of usage; see "Costs" below).
- **Git**, to download and update the project.
- **Optional — e-mail:** connect **Gmail** to your claude.ai account (claude.ai → Settings → Connectors → Gmail). Without it everything still works; plans stay in files and in the chat instead of arriving by e-mail.
- **Optional — weight log:** if an Adult already logs their weight daily in a Google Drive file (e.g. a spreadsheet with date and weight), connect **Google Drive** the same way and give the file's title in onboarding. The agent reads only that file, by its exact title, and never writes to Drive.

## Install

```bash
git clone https://github.com/BernardoBehring/meal-planner.git
cd meal-planner
claude --agent meal-planner
```

Then say hello in your own language. The agent runs a short **onboarding interview**: language, country and currency, who is in the family, routines, budget, supermarkets, shopping day. At the end it schedules the weekly jobs on your computer.

Your answers are stored in `data/state.md`. Everything under `data/`, `inbox/` and `archive/` is private: it is ignored by Git and never leaves your computer (except what the agent e-mails to you).

### Scheduling, per operating system

The agent schedules two weekly jobs itself at the end of onboarding: the **Review request** and the **Plan**. If that step fails, run the command for your system from the project folder:

| System | Command | What it uses |
| --- | --- | --- |
| Windows | `powershell -NoProfile -ExecutionPolicy Bypass -File scheduling/apply-schedule.ps1` | Task Scheduler (tasks "Meal planner - Plan" / "Meal planner - Review") |
| macOS | `bash scheduling/apply-schedule.sh` | `launchd` agents in `~/Library/LaunchAgents/com.mealplanner.*.plist` |
| Linux | `bash scheduling/apply-schedule.sh` | your user `crontab` (lines tagged `# meal-planner`) |

Add `--dry-run` (or `-DryRun` on Windows) to see what would be scheduled without changing anything.

Notes:

- **The computer must be on** (and, on macOS/Windows, your user logged in) at the scheduled times. Windows and macOS run a missed job when the computer wakes up; Linux `cron` does not, so pick times when the machine is usually on (or use `anacron`).
- **macOS:** the first run may ask for permission (e.g. to access files or the keychain where Claude Code keeps your login). If a job fails, check the log in `scheduling/logs/` and run `bash scheduling/run-agent.sh plan` once in Terminal to grant access.
- **Linux:** `cron` must be installed and running (`systemctl status cron` or `crond`).
- **Windows:** Claude Code needs Git for Windows (Git Bash), which the Claude Code installer asks for anyway.
- To remove the jobs: Windows — delete the two tasks in Task Scheduler; macOS — `launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.mealplanner.*.plist` and delete the files; Linux — `crontab -e` and delete the `# meal-planner` lines.

## Your weekly routine

| When | What happens | What you do |
| --- | --- | --- |
| Any time | — | Drop receipt photos/PDFs in `inbox/` (or tell the agent in a chat). |
| Before the Plan | You get the **Review** e-mail (`[Meal plan review]`) | Reply on your phone: what changed, what you liked, what was left over. Blank = as planned. |
| Plan time | The agent plans the next week | Read the e-mail: shopping list first, then menu and recipes. |
| Shopping day | — | Shop, then drop the receipt in `inbox/`. |
| Once a month (configurable) | The agent asks for a **stock count** | Put photos of the fridge, freezer and pantry in `inbox/` with `count` in the file name. |

Want to change something? Open `claude --agent meal-planner` and ask: "swap Wednesday's fish for chicken", "we have two guests on Saturday", "change my budget", "how did this month go?".

## Updating

```bash
git pull
```

Your data (`data/`, `inbox/`, `archive/`) is untouched by updates. If the schedule scripts changed, the agent re-applies them the next time you change your routines, or run the command in the table above.

## Costs

Claude Code usage is billed to each person's own Claude account. Price research is the expensive part; in onboarding you choose the **search level**:

- **when tight** (default): researches only your usual store, and compares other supermarkets only when the plan does not fit the budget;
- **usual store only**: cheapest;
- **full**: compares all your nearby supermarkets every week.

## Limitations

- **Prices online:** some supermarkets (in some countries) do not publish prices online. Then prices come mostly from your receipts, and items without a price are clearly marked as unverified. The agent never invents prices.
- **E-mail attachments** are not read: send receipt photos to `inbox/`, not as e-mail replies.
- **Not medical advice.** Nutrition figures are planning estimates. Babies under 2, pregnancy, breastfeeding, chronic conditions and prescribed diets need a health professional; the agent will say so.

## How it is built (for the curious)

- `.claude/agents/meal-planner.md` — the agent: rules, principles, when to use each skill.
- `.claude/skills/` — atomic skills, one per business rule or effect (e.g. `budget-compute-week`, `receipt-read`, `email-send-list`), hidden from the `/` menu; and seven orchestrators you can call by name, one per routine: `onboarding`, `intake`, `weekly-plan`, `price-research`, `review-request`, `change-plan`, `month-close`. Why: `docs/adr/0004-atomic-skills.md`.
- `CONTEXT.md` — the glossary (Family, Member, Lead, Week, Stock, Spend, Receipt...). Terms are used with exactly these meanings everywhere.
- `docs/adr/` — design decisions and why.
- `templates/state.md` — the empty family state copied on first run.
- `scheduling/` — per-OS scripts and the prompts used by the automatic runs.

Contributions and fixes welcome — especially from macOS and Linux users, since the scheduling scripts there were validated only in dry-run mode.
