#!/bin/bash

hyprctl dispatch workspace 11
# Inicia o VLC: -Z (Aleatório), -L (Loop), e desassocia do shell
vlc -Z -L --no-playlist-autostart  /mnt/ssd2/music & disown
sleep 0.6
hyprctl dispatch togglespecialworkspace

exit
