#!/usr/bin/env bash
# macOS / Linux: reads the ROUTINES section of data/state.md and (re)installs the two weekly jobs.
#   Linux -> user crontab (lines tagged "# meal-planner <id>", replaced on every run)
#   macOS -> launchd agents in ~/Library/LaunchAgents (com.mealplanner.<id>.plan|review.plist)
# Expected lines in data/state.md (weekday in English):
#   - Plan: saturday 08:00
#   - Review: friday 19:00
# Usage: apply-schedule.sh [--dry-run] [--os linux|macos]
set -euo pipefail

dry_run=0
os=""
while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run) dry_run=1 ;;
    --os) shift; os="${1:-}" ;;
    *) echo "usage: $0 [--dry-run] [--os linux|macos]" >&2; exit 2 ;;
  esac
  shift
done

if [ -z "$os" ]; then
  case "$(uname -s)" in
    Linux) os=linux ;;
    Darwin) os=macos ;;
    *) echo "Unsupported system $(uname -s). On Windows use scheduling/apply-schedule.ps1." >&2; exit 1 ;;
  esac
fi

project="$(cd "$(dirname "$0")/.." && pwd)"
state="$project/data/state.md"
runner="$project/scheduling/run-agent.sh"
[ -f "$state" ] || { echo "data/state.md not found. Run onboarding first (claude --agent meal-planner)." >&2; exit 1; }

claude_bin="$(command -v claude || true)"
[ -n "$claude_bin" ] || claude_bin="$HOME/.local/bin/claude"
[ -x "$claude_bin" ] || [ "$dry_run" -eq 1 ] || { echo "claude not found (looked in PATH and $claude_bin)." >&2; exit 1; }

# One id per project folder, so two families (or two clones) on the same machine don't clash.
id="$(printf '%s' "$project" | cksum | cut -d' ' -f1)"

weekday_number() { # cron and launchd both use 0 = Sunday
  case "$1" in
    sunday) echo 0 ;; monday) echo 1 ;; tuesday) echo 2 ;; wednesday) echo 3 ;;
    thursday) echo 4 ;; friday) echo 5 ;; saturday) echo 6 ;;
    *) return 1 ;;
  esac
}

# Parses the "- <Label>: <weekday> HH:MM" line into slot_dow, slot_h, slot_m, slot_day.
# Runs in the current shell (not in $(...)), so a bad line really stops the script.
slot() {
  local label="$1" line
  line="$(tr '[:upper:]' '[:lower:]' < "$state" | grep -E "^[[:space:]]*-[[:space:]]*${label}[[:space:]]*:" | head -n1 || true)"
  if ! [[ "$line" =~ :[[:space:]]*([a-z]+)[[:space:]]+([0-9]{1,2}):([0-9]{2}) ]]; then
    echo "Line '- ${label}: <weekday> HH:MM' not found or malformed in the ROUTINES section of data/state.md" >&2
    exit 1
  fi
  slot_day="${BASH_REMATCH[1]}"
  slot_h=$((10#${BASH_REMATCH[2]}))
  slot_m=$((10#${BASH_REMATCH[3]}))
  if ! slot_dow="$(weekday_number "$slot_day")"; then
    echo "Invalid weekday for ${label}: '$slot_day' (use English: monday ... sunday)" >&2
    exit 1
  fi
  if [ "$slot_h" -gt 23 ] || [ "$slot_m" -gt 59 ]; then
    echo "Invalid time for ${label}: ${slot_h}:${slot_m}" >&2
    exit 1
  fi
}

slot plan;   plan_dow=$slot_dow; plan_h=$slot_h; plan_m=$slot_m; plan_day=$slot_day
slot review; rev_dow=$slot_dow;  rev_h=$slot_h;  rev_m=$slot_m;  rev_day=$slot_day

install_linux() {
  local tag="# meal-planner $id" q_runner q_claude lines current
  q_runner="$(printf '%q' "$runner")"
  q_claude="$(printf '%q' "$claude_bin")"
  lines="$plan_m $plan_h * * $plan_dow CLAUDE_BIN=$q_claude /bin/bash $q_runner plan $tag
$rev_m $rev_h * * $rev_dow CLAUDE_BIN=$q_claude /bin/bash $q_runner review $tag"
  if [ "$dry_run" -eq 1 ]; then
    echo "[dry run] crontab lines that would be installed (replacing any tagged '$tag'):"
    echo "$lines"
    return
  fi
  current="$(crontab -l 2>/dev/null | grep -vF "$tag" || true)"
  printf '%s\n%s\n' "$current" "$lines" | sed '/^$/d' | crontab -
  echo "Meal planner - Plan: every $plan_day at $(printf '%02d:%02d' "$plan_h" "$plan_m") (cron)"
  echo "Meal planner - Review: every $rev_day at $(printf '%02d:%02d' "$rev_h" "$rev_m") (cron)"
}

xml_escape() { printf '%s' "$1" | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g'; }

plist() { # $1 kind, $2 weekday, $3 hour, $4 minute
  cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>com.mealplanner.$id.$1</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>$(xml_escape "$runner")</string>
    <string>$1</string>
  </array>
  <key>EnvironmentVariables</key>
  <dict>
    <key>CLAUDE_BIN</key><string>$(xml_escape "$claude_bin")</string>
    <key>PATH</key><string>/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
  </dict>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Weekday</key><integer>$2</integer>
    <key>Hour</key><integer>$3</integer>
    <key>Minute</key><integer>$4</integer>
  </dict>
</dict>
</plist>
EOF
}

install_macos() {
  local dir="$HOME/Library/LaunchAgents" kind file dow h m day
  for kind in plan review; do
    if [ "$kind" = plan ]; then dow=$plan_dow; h=$plan_h; m=$plan_m; day=$plan_day
    else dow=$rev_dow; h=$rev_h; m=$rev_m; day=$rev_day; fi
    file="$dir/com.mealplanner.$id.$kind.plist"
    if [ "$dry_run" -eq 1 ]; then
      echo "[dry run] $file"
      plist "$kind" "$dow" "$h" "$m"
      continue
    fi
    mkdir -p "$dir"
    plist "$kind" "$dow" "$h" "$m" > "$file"
    launchctl bootout "gui/$(id -u)" "$file" 2>/dev/null || true
    launchctl bootstrap "gui/$(id -u)" "$file"
    echo "Meal planner - $kind: every $day at $(printf '%02d:%02d' "$h" "$m") (launchd, $file)"
  done
}

case "$os" in
  linux) install_linux ;;
  macos) install_macos ;;
  *) echo "Unknown --os '$os' (use linux or macos)" >&2; exit 2 ;;
esac
