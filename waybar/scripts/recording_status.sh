#!/usr/bin/env bash
STATE="$XDG_RUNTIME_DIR/wf_recording.state"

# Hide if no state
[[ -f $STATE ]] || exit 0
# Load PID / FILE
# shellcheck disable=SC1090
source "$STATE" || exit 0

# Stale? (PID recorded but process gone)
if [[ -n ${PID:-} ]] && ! kill -0 "$PID" 2>/dev/null; then
  rm -f "$STATE"
  exit 0
fi

# Optional filename in tooltip
base=""
[[ -n ${FILE:-} ]] && base=$(basename -- "$FILE")

printf '{"text":"● rec","tooltip":"Recording: %s","class":["recording"]}\n' "$base"
