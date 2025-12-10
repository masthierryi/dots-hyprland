#!/usr/bin/env bash
# Script to apply Hyprland configuration from illogical-impulse config.json

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
SHELL_CONFIG_FILE="$XDG_CONFIG_HOME/illogical-impulse/config.json"
HYPR_CONFIG_DIR="$XDG_CONFIG_HOME/hypr"
HYPRLAND_GENERAL_CONF="$HYPR_CONFIG_DIR/hyprland/general.conf"
CUSTOM_RULES_CONF="$HYPR_CONFIG_DIR/custom/rules.conf"
KITTY_CONF="$XDG_CONFIG_HOME/kitty/kitty.conf"

# Check if config file exists
if [ ! -f "$SHELL_CONFIG_FILE" ]; then
    echo "Config file not found: $SHELL_CONFIG_FILE"
    exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "jq is required but not installed"
    exit 1
fi

# Determine current mode (dark or light)
get_current_mode() {
    current_mode=$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null | tr -d "'")
    if [[ "$current_mode" == "prefer-dark" ]]; then
        echo "dark"
    else
        echo "light"
    fi
}

# Get config value with mode override
get_config_value() {
    local base_path="$1"
    local mode="$2"
    
    # Try to get mode-specific value first
    if [ -n "$mode" ]; then
        local mode_path=".hyprland.themeModes.${mode}.${base_path#.hyprland.}"
        local mode_value=$(jq -r "$mode_path" "$SHELL_CONFIG_FILE" 2>/dev/null)
        if [ "$mode_value" != "null" ] && [ -n "$mode_value" ]; then
            echo "$mode_value"
            return
        fi
    fi
    
    # Fall back to base value
    local base_value=$(jq -r "$base_path" "$SHELL_CONFIG_FILE" 2>/dev/null)
    echo "$base_value"
}

# Apply general.conf settings
apply_general_conf() {
    local mode="$1"
    echo "Applying general.conf settings for mode: $mode"
    
    # Backup original file
    if [ -f "$HYPRLAND_GENERAL_CONF" ]; then
        cp "$HYPRLAND_GENERAL_CONF" "$HYPRLAND_GENERAL_CONF.bak"
    fi
    
    # Get values from config
    local gaps_in=$(get_config_value ".hyprland.general.gaps.gapsIn" "$mode")
    local gaps_out=$(get_config_value ".hyprland.general.gaps.gapsOut" "$mode")
    local gaps_workspaces=$(get_config_value ".hyprland.general.gaps.gapsWorkspaces" "$mode")
    local border_size=$(get_config_value ".hyprland.general.border.borderSize" "$mode")
    local col_active=$(get_config_value ".hyprland.general.border.colActiveBorder" "$mode")
    local col_inactive=$(get_config_value ".hyprland.general.border.colInactiveBorder" "$mode")
    local rounding=$(get_config_value ".hyprland.decoration.rounding" "$mode")
    local blur_enabled=$(get_config_value ".hyprland.decoration.blur.enabled" "$mode")
    local blur_size=$(get_config_value ".hyprland.decoration.blur.size" "$mode")
    local blur_passes=$(get_config_value ".hyprland.decoration.blur.passes" "$mode")
    local blur_vibrancy=$(get_config_value ".hyprland.decoration.blur.vibrancy" "$mode")
    
    # Read the file and update values
    if [ -f "$HYPRLAND_GENERAL_CONF" ]; then
        # Update gaps
        sed -i "s/^\(\s*gaps_in\s*=\s*\).*/\1$gaps_in/" "$HYPRLAND_GENERAL_CONF"
        sed -i "s/^\(\s*gaps_out\s*=\s*\).*/\1$gaps_out/" "$HYPRLAND_GENERAL_CONF"
        sed -i "s/^\(\s*gaps_workspaces\s*=\s*\).*/\1$gaps_workspaces/" "$HYPRLAND_GENERAL_CONF"
        
        # Update border
        sed -i "s/^\(\s*border_size\s*=\s*\).*/\1$border_size/" "$HYPRLAND_GENERAL_CONF"
        sed -i "s|^\(\s*col.active_border\s*=\s*\).*|\1$col_active|" "$HYPRLAND_GENERAL_CONF"
        sed -i "s|^\(\s*col.inactive_border\s*=\s*\).*|\1$col_inactive|" "$HYPRLAND_GENERAL_CONF"
        
        # Update decoration
        sed -i "s/^\(\s*rounding\s*=\s*\).*/\1$rounding/" "$HYPRLAND_GENERAL_CONF"
        sed -i "s/^\(\s*enabled\s*=\s*\).*/\1$blur_enabled/" "$HYPRLAND_GENERAL_CONF"
        sed -i "s/^\(\s*size\s*=\s*\).*/\1$blur_size/" "$HYPRLAND_GENERAL_CONF"
        sed -i "s/^\(\s*passes\s*=\s*\).*/\1$blur_passes/" "$HYPRLAND_GENERAL_CONF"
        sed -i "s/^\(\s*vibrancy\s*=\s*\).*/\1$blur_vibrancy/" "$HYPRLAND_GENERAL_CONF"
    fi
}

# Apply window rules
apply_window_rules() {
    local mode="$1"
    echo "Applying window rules for mode: $mode"
    
    # Backup original file
    if [ -f "$CUSTOM_RULES_CONF" ]; then
        cp "$CUSTOM_RULES_CONF" "$CUSTOM_RULES_CONF.bak"
    fi
    
    # Get values from config
    local dolphin_enabled=$(get_config_value ".hyprland.windowRules.dolphin.enabled" "$mode")
    local dolphin_opacity=$(get_config_value ".hyprland.windowRules.dolphin.opacity" "$mode")
    local dolphin_opacity_inactive=$(get_config_value ".hyprland.windowRules.dolphin.opacityInactive" "$mode")
    
    local kate_enabled=$(get_config_value ".hyprland.windowRules.kate.enabled" "$mode")
    local kate_opacity=$(get_config_value ".hyprland.windowRules.kate.opacity" "$mode")
    local kate_opacity_inactive=$(get_config_value ".hyprland.windowRules.kate.opacityInactive" "$mode")
    
    if [ -f "$CUSTOM_RULES_CONF" ]; then
        # Remove existing Dolphin opacity rules
        sed -i '/# Regra para transparência do Dolphin/,/windowrulev2.*dolphin/d' "$CUSTOM_RULES_CONF"
        
        # Remove existing Kate opacity rules
        sed -i '/# Regra para transparência do Kate/,/windowrulev2.*kate/d' "$CUSTOM_RULES_CONF"
        
        # Add new rules if enabled
        if [ "$dolphin_enabled" == "true" ]; then
            echo "" >> "$CUSTOM_RULES_CONF"
            echo "# Regra para transparência do Dolphin" >> "$CUSTOM_RULES_CONF"
            echo "windowrulev2 = opacity $dolphin_opacity override $dolphin_opacity_inactive override, class:^(org.kde.dolphin)$" >> "$CUSTOM_RULES_CONF"
            echo "windowrulev2 = opacity $dolphin_opacity override $dolphin_opacity_inactive override, class:^(dolphin)$" >> "$CUSTOM_RULES_CONF"
        fi
        
        if [ "$kate_enabled" == "true" ]; then
            echo "" >> "$CUSTOM_RULES_CONF"
            echo "# Regra para transparência do Kate" >> "$CUSTOM_RULES_CONF"
            echo "windowrulev2 = opacity $kate_opacity override $kate_opacity_inactive override, class:^(org.kde.kate)$" >> "$CUSTOM_RULES_CONF"
            echo "windowrulev2 = opacity $kate_opacity override $kate_opacity_inactive override, class:^(kate)$" >> "$CUSTOM_RULES_CONF"
        fi
    fi
}

# Apply kitty.conf settings
apply_kitty_conf() {
    local mode="$1"
    echo "Applying kitty.conf settings for mode: $mode"
    
    # Backup original file
    if [ -f "$KITTY_CONF" ]; then
        cp "$KITTY_CONF" "$KITTY_CONF.bak"
    fi
    
    # Get value from config
    local bg_opacity=$(get_config_value ".hyprland.terminal.kittyBackgroundOpacity" "$mode")
    
    if [ -f "$KITTY_CONF" ]; then
        # Update background_opacity
        sed -i "s/^\(\s*background_opacity\s*\).*/\1$bg_opacity/" "$KITTY_CONF"
    fi
}

# Reload Hyprland configuration
reload_hyprland() {
    echo "Reloading Hyprland configuration..."
    hyprctl reload 2>/dev/null || true
}

# Main execution
main() {
    local mode=$(get_current_mode)
    echo "Current theme mode: $mode"
    
    apply_general_conf "$mode"
    apply_window_rules "$mode"
    apply_kitty_conf "$mode"
    reload_hyprland
    
    echo "Hyprland configuration applied successfully!"
    
    # Send notification
    notify-send "Hyprland Settings" "Configuration applied successfully" -a "illogical-impulse" -i "preferences-system" 2>/dev/null || true
}

main "$@"
