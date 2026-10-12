#!/usr/bin/env bash
# macOS / Linux: runs the meal-planner agent headless for a scheduled job, with the family
# state prepended to the prompt. Called by the cron / launchd jobs that apply-schedule.sh installs.
# Usage: run-agent.sh plan|review
#   MAX_ATTEMPTS (default 6) and RETRY_MINUTES (default 60) can be set in the environment.
# Retries: when an attempt fails because of a Claude usage limit, overload or network error, it waits
#   RETRY_MINUTES and tries again, up to MAX_ATTEMPTS. Other failures are not retried (a half-done run
#   could e-mail twice).
# When the run finally fails: a desktop notification (macOS; Linux if notify-send can reach the desktop),
#   plus an e-mail to the Lead (prompt-failure.txt) - that e-mail also needs Claude, so after a usage
#   limit it usually cannot go out.
# Logs (scheduling/logs/):
#   runs.log                      "start", "retry" and "end" lines per run; a start with no end = run killed or crashed
#   YYYY-MM-DD_HHMM_<kind>.log    the run's output, every attempt, with header and footer
# Each attempt gets its own session id: "claude --resume <id>" reopens it to see every step it took.
set -uo pipefail

kind="${1:-}"
case "$kind" in
  plan|review) ;;
  *) echo "usage: $0 plan|review" >&2; exit 2 ;;
esac
max_attempts="${MAX_ATTEMPTS:-6}"
retry_minutes="${RETRY_MINUTES:-60}"

project="$(cd "$(dirname "$0")/.." && pwd)"
cd "$project" || exit 1

mkdir -p scheduling/logs
started=$(date +%s)
started_text="$(date '+%Y-%m-%d %H:%M')"
log_name="$(date +%Y-%m-%d_%H%M)_${kind}.log"
log="scheduling/logs/$log_name"
runs="scheduling/logs/runs.log"
prompt_file="$(mktemp)"
trap 'rm -f "$prompt_file"' EXIT
# Failures worth waiting for: they go away on their own.
retryable="you've hit your .*limit|usage limit|rate.?limit|overloaded|API Error: ?(429|500|502|503|529)|ECONNRESET|ETIMEDOUT|ENOTFOUND"

new_session() {
  local s
  s="$(uuidgen 2>/dev/null || cat /proc/sys/kernel/random/uuid 2>/dev/null \
    || od -An -N16 -tx1 /dev/urandom | tr -d ' \n' | sed -E 's/^(.{8})(.{4}).(.{3}).(.{3})(.{12})$/\1-\2-4\3-a\4-\5/')"
  printf '%s' "$s" | tr '[:upper:]' '[:lower:]'
}

run_line() { printf '%s  %-6s  %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$kind" "$1" >> "$runs"; }

# $1 session id, then the allowed tools; the prompt comes on stdin. Output is appended to the log
# and kept in $attempt_out for the retry check.
attempt_out=""
run_claude() {
  local session="$1" tmp status
  shift
  tmp="$(mktemp)"
  "$claude_bin" -p --agent meal-planner --session-id "$session" \
    --permission-mode acceptEdits --allowedTools "$@" > "$tmp" 2>&1
  status=$?
  cat "$tmp" >> "$log"
  attempt_out="$(cat "$tmp")"
  rm -f "$tmp"
  return "$status"
}

notify_desktop() { # $1 title, $2 text
  if command -v osascript >/dev/null 2>&1; then
    osascript -e 'on run argv' -e 'display notification (item 2 of argv) with title (item 1 of argv)' -e 'end run' \
      "$1" "$2" >/dev/null 2>&1 && { echo "Failure notification shown on the desktop." >> "$log"; return; }
  elif command -v notify-send >/dev/null 2>&1; then
    # cron has no desktop session: point notify-send at the user's session bus.
    DBUS_SESSION_BUS_ADDRESS="${DBUS_SESSION_BUS_ADDRESS:-unix:path=/run/user/$(id -u)/bus}" \
      notify-send -u critical "$1" "$2" >/dev/null 2>&1 && { echo "Failure notification shown on the desktop." >> "$log"; return; }
  fi
  echo "Could not show a desktop notification." >> "$log"
}

agent_tools=(Read Write Edit Glob Grep Skill WebSearch WebFetch
  mcp__claude_ai_Gmail__send_message mcp__claude_ai_Gmail__search_threads mcp__claude_ai_Gmail__get_thread
  mcp__claude_ai_Gmail__list_labels mcp__claude_ai_Gmail__create_label mcp__claude_ai_Gmail__label_message
  mcp__claude_ai_Google_Drive__search_files mcp__claude_ai_Google_Drive__read_file_content
  'Bash(mkdir -p archive/:*)' 'Bash(mv inbox/:*)')

echo "Run: $kind  started $(date '+%Y-%m-%d %H:%M:%S')  (up to $max_attempts attempts, $retry_minutes min apart)" > "$log"

# cron and launchd start with a minimal PATH: apply-schedule.sh passes the absolute path in CLAUDE_BIN.
claude_bin="${CLAUDE_BIN:-$(command -v claude || echo "$HOME/.local/bin/claude")}"

attempt=0
session=""
if [ ! -x "$claude_bin" ]; then
  attempt_out="ERROR: claude not found (looked in CLAUDE_BIN, PATH and $HOME/.local/bin/claude)."
  echo "$attempt_out" >> "$log"
  status=127
else
  echo "Claude: $claude_bin" >> "$log"
  while :; do
    attempt=$((attempt + 1))
    session="$(new_session)"
    run_line "start  attempt $attempt/$max_attempts  session $session  log $log_name"
    {
      echo "-----------------------------"
      echo "Attempt $attempt/$max_attempts  $(date '+%Y-%m-%d %H:%M:%S')"
      echo "Session: $session  (see every step: claude --resume $session)"
    } >> "$log"
    [ -f data/state.md ] || echo "Warning: data/state.md not found; running without the family state." >> "$log"
    # Read the state on every attempt: the Family may have changed it while we waited.
    # The prompt goes through a file, not a pipe: a pipe would run run_claude in a subshell and lose $attempt_out.
    {
      if [ -f data/state.md ]; then
        cat data/state.md
        printf '\n\n=============================\n\n'
      fi
      cat "scheduling/prompt-${kind}.txt"
    } > "$prompt_file"
    run_claude "$session" "${agent_tools[@]}" < "$prompt_file"
    status=$?
    [ "$status" -eq 0 ] && break
    [ "$attempt" -ge "$max_attempts" ] && break
    printf '%s' "$attempt_out" | grep -qiE "$retryable" || break
    echo "Attempt $attempt failed (exit $status) with a temporary error; next try in $retry_minutes min." >> "$log"
    run_line "retry  attempt $attempt failed (exit $status); next try in $retry_minutes min"
    sleep "$(awk -v m="$retry_minutes" 'BEGIN { printf "%d", m * 60 }')"
  done
fi

minutes="$(awk -v s="$(( $(date +%s) - started ))" 'BEGIN { printf "%.1f", s / 60 }')"
if [ "$status" -eq 0 ]; then result="OK"; else result="FAILED (exit $status)"; fi
{
  echo "-----------------------------"
  echo "Finished $(date '+%Y-%m-%d %H:%M:%S') after $minutes min and $attempt attempt(s) - $result"
  echo "Exit code: $status"
} >> "$log"
run_line "end    $result after $minutes min, $attempt attempt(s)  session $session"

if [ "$status" -ne 0 ]; then
  tail_lines="$(printf '%s\n' "$attempt_out" | grep -v '^[[:space:]]*$' | tail -n 5)"
  notify_desktop "Meal planner: $kind run failed" "$tail_lines
Log: scheduling/logs/$log_name"
  if [ -x "$claude_bin" ]; then
    echo "----- failure e-mail -----" >> "$log"
    {
      cat scheduling/prompt-failure.txt
      printf 'Run: %s\nStarted: %s\nAttempts: %s\nExit code: %s\nLog: scheduling/logs/%s\nSession: %s\nLast error lines:\n%s\n' \
        "$kind" "$started_text" "$attempt" "$status" "$log_name" "$session" "$tail_lines"
    } > "$prompt_file"
    if run_claude "$(new_session)" Read mcp__claude_ai_Gmail__send_message < "$prompt_file"; then sent="sent"; else sent="not sent"; fi
    echo "Failure e-mail: $sent" >> "$log"
    run_line "notice failure e-mail $sent"
  fi
fi
exit "$status"
