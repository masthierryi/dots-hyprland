#!/bin/bash
set -euo pipefail

SPECIAL_NAME="special:special"

wait_for() { # CLASS WS TIMEOUT
  local cls="$1" ws="$2" to="${3:-6}" addr=""
  for _ in $(seq 1 $to); do
    addr="$(hyprctl -j clients | jq -r --arg c "$cls" --argjson w "$ws" '.[] | select(.class==$c and .workspace.id==$w) | .address' | head -n1)"
    [ -n "$addr" ] && { echo "$addr"; return 0; }
    sleep 0.12
  done
  return 1
}

# Fecha tudo exceto scratchpad
hyprctl -j clients \
  | jq -r --arg s "$SPECIAL_NAME" '.[] | select(.workspace.name != $s and .workspace.id != -99) | .address' \
  | while read -r addr; do hyprctl dispatch closewindow "address:${addr}"; done
