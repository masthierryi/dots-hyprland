#!/bin/bash
set -euo pipefail

SPECIAL_NAME="special:special"

# Offsets dos monitores (ajuste conforme seu setup)
MON1_X=0;    MON1_Y=0       # workspace 1
MON11_X=768; MON11_Y=0      # workspace 11 (HDMI-A-1)
MON12_X=768; MON12_Y=0      # workspace 12 (assumindo mesmo monitor do 11; ajuste se outro)

# Helpers
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

launch_browser() { # WS CLASS URLS...
  local ws="$1"; shift
  local cls="$1"; shift
  local urls=("$@")
  hyprctl dispatch exec "[workspace ${ws}] chromium --new-window --class=${cls} ${urls[*]}"
}

# Fecha tudo exceto scratchpad
hyprctl -j clients \
  | jq -r --arg s "$SPECIAL_NAME" '.[] | select(.workspace.name != $s and .workspace.id != -99) | .address' \
  | while read -r addr; do hyprctl dispatch closewindow "address:${addr}"; done
sleep 1.0  # garante fechamento

######## Workspace 11 ########
hyprctl dispatch workspace 11

# 1) Chromium (x.com + pixiv) à esquerda (perfil padrão)
move_mouse $((MON11_X+50)) $((MON11_Y+200))
launch_browser 11 "chromium-ws11" "https://x.com/masthierryi" "https://www.pixiv.net/en/"
sleep 0.50
chromium11_addr="$(wait_for 'Chromium' 11 10 || true)"
[ -n "$chromium11_addr" ] && { move_exact "$chromium11_addr" $MON11_X $MON11_Y; focus_addr "$chromium11_addr"; }

# 2) Dolphin à direita (/mnt/ssd2/)
sleep 0.15
move_mouse $((MON11_X+1400)) $((MON11_Y+200))
hyprctl dispatch exec "[workspace 11] dolphin /mnt/ssd2/"
sleep 0.15
dolphin_addr="$(wait_for 'dolphin' 11 7 || true)"
[ -n "$dolphin_addr" ] && { move_exact "$dolphin_addr" $((MON11_X+1000)) $MON11_Y; focus_addr "$dolphin_addr"; }

sleep 1.0

######## Workspace 1 (antes do Krita) ########
hyprctl dispatch workspace 1
move_mouse 0 0
launch_browser 1 "chromium-ws1" "https://web.whatsapp.com/" "https://gemini.google.com/"
sleep 0.3
chromium1_addr="$(wait_for 'Chromium' 1 5 || true)"
[ -n "$chromium1_addr" ] && { move_exact "$chromium1_addr" $MON1_X $MON1_Y; focus_addr "$chromium1_addr"; }

sleep 0.7

######## Workspace 12 ########
hyprctl dispatch workspace 12
move_mouse $((MON12_X+900)) $((MON12_Y+500))
hyprctl dispatch exec "[workspace 12] krita"
sleep 4
krita_addr="$(wait_for 'krita' 12 30 || true)"
[ -n "$krita_addr" ] && { move_exact "$krita_addr" $((MON12_X+200)) $((MON12_Y+100)); focus_addr "$krita_addr"; }

# Foco final
hyprctl dispatch workspace 11
