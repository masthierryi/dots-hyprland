#!/bin/bash

# Verifica se está no light mode
current_mode=$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null | tr -d "'")

if [[ "$current_mode" != "prefer-dark" ]]; then
    # Aplica fundo bege no light mode
    kwriteconfig6 --file kdeglobals --group "Colors: View" --key BackgroundNormal "#F5F0E6"
    kwriteconfig6 --file kdeglobals --group "Colors:View" --key BackgroundAlternate "#EFE9DD"
    kwriteconfig6 --file kdeglobals --group "Colors:Window" --key BackgroundNormal "#F5F0E6"
    kwriteconfig6 --file kdeglobals --group "Colors:Window" --key BackgroundAlternate "#EFE9DD"
    kwriteconfig6 --file kdeglobals --group "Colors: Button" --key BackgroundNormal "#EFE9DD"
    kwriteconfig6 --file kdeglobals --group "Colors: Button" --key BackgroundAlternate "#E9E3D7"
    kwriteconfig6 --file kdeglobals --group "Colors:Header" --key BackgroundNormal "#E5DFD3"
    kwriteconfig6 --file kdeglobals --group "Colors: Header" --key BackgroundAlternate "#E5DFD3"
    kwriteconfig6 --file kdeglobals --group "Colors:Complementary" --key BackgroundNormal "#EFE9DD"
    kwriteconfig6 --file kdeglobals --group "Colors: Tooltip" --key BackgroundNormal "#F5F0E6"

    # Força o KDE a recarregar as cores
    qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null || true
fi
