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

move_exact() { hyprctl dispatch movewindowpixel "exact $2 $3,address:$1"; }
focus_addr() { hyprctl dispatch focuswindow "address:$1"; sleep 0.08; hyprctl dispatch focuswindow "address:$1"; }
has_ydotool() { command -v ydotool >/dev/null; }
move_mouse() { has_ydotool && ydotool mousemove -x "$1" -y "$2"; }

# Fecha tudo exceto scratchpad
hyprctl -j clients \
  | jq -r --arg s "$SPECIAL_NAME" '.[] | select(.workspace.name != $s and .workspace.id != -99) | .address' \
  | while read -r addr; do hyprctl dispatch closewindow "address:${addr}"; done

# Espera para garantir fechamento
sleep 1.0

# Workspace 11 (HDMI-A-1 offset 768,0)
hyprctl dispatch workspace 11

# 1) Librewolf (Notion + Proton) na esquerda
move_mouse 820 200
hyprctl dispatch exec "[workspace 11] librewolf https://www.notion.so/"
sleep 0.50
libre_addr="$(wait_for 'LibreWolf' 11 10 || true)"
[ -n "$libre_addr" ] && { move_exact "$libre_addr" 768 0; focus_addr "$libre_addr"; }

# 2) Dolphin na direita (dir /home/masthierryi/z-FAST/)
sleep 0.15
move_mouse 2100 200
hyprctl dispatch exec "[workspace 11] dolphin /home/masthierryi/z-FAST/"
sleep 0.15
dolphin_addr="$(wait_for 'dolphin' 11 4 || true)"
[ -n "$dolphin_addr" ] && { move_exact "$dolphin_addr" 1768 0; focus_addr "$dolphin_addr"; }

# 3) Kate abaixo do Dolphin
sleep 0.15
move_mouse 2100 900
hyprctl dispatch exec "[workspace 11] kate"
sleep 0.1
kate_addr="$(wait_for 'kate' 11 1 || true)"
[ -n "$kate_addr" ] && { move_exact "$kate_addr" 1768 600; focus_addr "$dolphin_addr"; }

# Workspace 1 (secundário) — Chromium com WhatsApp + Gemini
hyprctl dispatch workspace 1
move_mouse 900 800
hyprctl dispatch exec "[workspace 1] chromium https://web.whatsapp.com/ https://gemini.google.com/"
sleep 0.2
chromium_addr="$(wait_for 'Chromium' 1 2 || true)"
[ -n "$chromium_addr" ] && { move_exact "$chromium_addr" 0 0; focus_addr "$chromium_addr"; }

# Foco final de volta ao 11
hyprctl dispatch workspace 11
