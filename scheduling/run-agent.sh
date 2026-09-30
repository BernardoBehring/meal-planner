#!/usr/bin/env bash
# macOS / Linux: runs the meal-planner agent headless for a scheduled job, with the family
# state prepended to the prompt. Called by the cron / launchd jobs that apply-schedule.sh installs.
# Usage: run-agent.sh plan|review
set -uo pipefail

kind="${1:-}"
case "$kind" in
  plan|review) ;;
  *) echo "usage: $0 plan|review" >&2; exit 2 ;;
esac

project="$(cd "$(dirname "$0")/.." && pwd)"
cd "$project" || exit 1

mkdir -p scheduling/logs
log="scheduling/logs/$(date +%Y-%m-%d_%H%M)_${kind}.log"

# cron and launchd start with a minimal PATH: apply-schedule.sh passes the absolute path in CLAUDE_BIN.
claude_bin="${CLAUDE_BIN:-$(command -v claude || echo "$HOME/.local/bin/claude")}"

{
  if [ -f data/state.md ]; then
    cat data/state.md
    printf '\n\n=============================\n\n'
  fi
  cat "scheduling/prompt-${kind}.txt"
} | "$claude_bin" -p --agent meal-planner \
    --permission-mode acceptEdits \
    --allowedTools Read Write Edit Glob Grep Skill WebSearch WebFetch \
      mcp__claude_ai_Gmail__send_message mcp__claude_ai_Gmail__search_threads mcp__claude_ai_Gmail__get_thread \
      mcp__claude_ai_Gmail__list_labels mcp__claude_ai_Gmail__create_label mcp__claude_ai_Gmail__label_message \
      'Bash(mkdir -p archive/:*)' 'Bash(mv inbox/:*)' \
    > "$log" 2>&1
status=$?
echo "Exit code: $status" >> "$log"
exit "$status"
