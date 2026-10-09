#!/usr/bin/env bash
# macOS / Linux: runs the meal-planner agent headless for a scheduled job, with the family
# state prepended to the prompt. Called by the cron / launchd jobs that apply-schedule.sh installs.
# Usage: run-agent.sh plan|review
# Logs (scheduling/logs/):
#   runs.log                      one "start" and one "end" line per run; a start with no end = run killed or crashed
#   YYYY-MM-DD_HHMM_<kind>.log    the run's output, with header and footer
# Each run gets its own session id: "claude --resume <id>" reopens it to see every step it took.
set -uo pipefail

kind="${1:-}"
case "$kind" in
  plan|review) ;;
  *) echo "usage: $0 plan|review" >&2; exit 2 ;;
esac

project="$(cd "$(dirname "$0")/.." && pwd)"
cd "$project" || exit 1

mkdir -p scheduling/logs
started=$(date +%s)
log_name="$(date +%Y-%m-%d_%H%M)_${kind}.log"
log="scheduling/logs/$log_name"
runs="scheduling/logs/runs.log"
session="$(uuidgen 2>/dev/null || cat /proc/sys/kernel/random/uuid 2>/dev/null \
  || od -An -N16 -tx1 /dev/urandom | tr -d ' \n' | sed -E 's/^(.{8})(.{4}).(.{3}).(.{3})(.{12})$/\1-\2-4\3-a\4-\5/')"
session="$(printf '%s' "$session" | tr '[:upper:]' '[:lower:]')"

run_line() { printf '%s  %-6s  %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$kind" "$1" >> "$runs"; }

run_line "start  session $session  log $log_name"
{
  echo "Run: $kind  started $(date '+%Y-%m-%d %H:%M:%S')"
  echo "Session: $session  (see every step: claude --resume $session)"
} > "$log"

# cron and launchd start with a minimal PATH: apply-schedule.sh passes the absolute path in CLAUDE_BIN.
claude_bin="${CLAUDE_BIN:-$(command -v claude || echo "$HOME/.local/bin/claude")}"

if [ ! -x "$claude_bin" ]; then
  echo "ERROR: claude not found (looked in CLAUDE_BIN, PATH and $HOME/.local/bin/claude)." >> "$log"
  status=127
else
  [ -f data/state.md ] || echo "Warning: data/state.md not found; running without the family state." >> "$log"
  { echo "Claude: $claude_bin"; echo "-----------------------------"; } >> "$log"
  {
    if [ -f data/state.md ]; then
      cat data/state.md
      printf '\n\n=============================\n\n'
    fi
    cat "scheduling/prompt-${kind}.txt"
  } | "$claude_bin" -p --agent meal-planner --session-id "$session" \
      --permission-mode acceptEdits \
      --allowedTools Read Write Edit Glob Grep Skill WebSearch WebFetch \
        mcp__claude_ai_Gmail__send_message mcp__claude_ai_Gmail__search_threads mcp__claude_ai_Gmail__get_thread \
        mcp__claude_ai_Gmail__list_labels mcp__claude_ai_Gmail__create_label mcp__claude_ai_Gmail__label_message \
        mcp__claude_ai_Google_Drive__search_files mcp__claude_ai_Google_Drive__read_file_content \
        'Bash(mkdir -p archive/:*)' 'Bash(mv inbox/:*)' \
      >> "$log" 2>&1
  status=$?
fi

minutes="$(awk -v s="$(( $(date +%s) - started ))" 'BEGIN { printf "%.1f", s / 60 }')"
if [ "$status" -eq 0 ]; then result="OK"; else result="FAILED (exit $status)"; fi
{
  echo "-----------------------------"
  echo "Finished $(date '+%Y-%m-%d %H:%M:%S') after $minutes min - $result"
  echo "Exit code: $status"
} >> "$log"
run_line "end    $result after $minutes min  session $session"
exit "$status"
