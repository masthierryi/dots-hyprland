# Dynamic Hyprland Configuration

This feature allows you to dynamically configure Hyprland settings (gaps, borders, window opacity, terminal opacity) through the illogical-impulse settings GUI.

## Features

- **GUI Configuration**: Configure Hyprland settings through the settings app
- **Opacity Variables**: Set global opacity values that can be used in any window rule
- **Automatic Application**: Click a button to apply settings immediately
- **Per-Window Control**: Use opacity variables in your custom window rules

## Configuration

### Accessing Settings

1. Open the illogical-impulse settings app
2. Navigate to the "Hyprland" tab (window icon)
3. Adjust the settings as desired
4. Click "Apply Hyprland Settings Now" button

### Available Settings

#### General Settings
- **Inner Gaps**: Spacing between windows
- **Outer Gaps**: Spacing from screen edges
- **Workspace Gaps**: Spacing between workspaces
- **Border Size**: Window border thickness

#### Decoration
- **Corner Rounding**: Window corner radius
- **Blur Settings**: Enable/disable blur, blur size, passes, and vibrancy

#### Window Opacity Rules
- **Active Opacity**: Opacity for focused windows
- **Inactive Opacity**: Opacity for unfocused windows
- **Hover Opacity**: Opacity when hovering over windows

#### Terminal Settings
- **Kitty Background Opacity**: Set terminal background transparency

## How It Works

### Configuration Storage

All settings are stored in `~/.config/illogical-impulse/config.json` under the `hyprland` object:

```json
{
  "hyprland": {
    "general": {
      "gaps": { "gapsIn": 3, "gapsOut": 4, "gapsWorkspaces": 50 },
      "border": { "borderSize": 2, "colActiveBorder": "rgba(0DB7D4FF)", ... }
    },
    "decoration": {
      "rounding": 4,
      "blur": { "enabled": true, "size": 3, ... }
    },
    "windowRules": {
      "opacityActive": 0.89,
      "opacityInactive": 0.8,
      "opacityHover": 0.95
    },
    "terminal": {
      "kittyBackgroundOpacity": 0.8
    }
  }
}
```

### Opacity Variables System

The script creates/updates opacity variables at the top of your `~/.config/hypr/custom/rules.conf`:

```bash
# Opacity Variables - Managed by illogical-impulse
# Use these variables in your window rules:
# windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(yourapp)$
$OPACITY_ACTIVE = 0.89
$OPACITY_INACTIVE = 0.8
$OPACITY_HOVER = 0.95
# End Opacity Variables
```

You can then use these variables in your custom window rules:

```bash
windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(dolphin)$
windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(kate)$
windowrulev2 = opacity $OPACITY_HOVER override $OPACITY_INACTIVE override, class:^(firefox)$
```

### Application

The apply script (`scripts/hyprland/apply-hyprland-config.sh`) is called when:
1. You click "Apply Hyprland Settings Now" button in the settings
2. You toggle between light and dark modes (automatic integration)

The script:
1. Reads settings from the config file
2. Updates the following files:
   - `~/.config/hypr/hyprland/general.conf` (gaps, borders, decoration)
   - `~/.config/hypr/custom/rules.conf` (opacity variables only)
   - `~/.config/kitty/kitty.conf` (terminal opacity)
3. Reloads Hyprland configuration

### Integration with Theme Toggle

The feature integrates with the existing dark mode toggle. When you toggle themes, the script applies your configured settings.

## Manual Application

You can manually apply settings at any time:

```bash
~/.config/quickshell/ii/scripts/hyprland/apply-hyprland-config.sh
```

Or use the "Apply Hyprland Settings Now" button in the settings GUI.

## Troubleshooting

### Settings Not Applying

1. Check that the config file exists: `~/.config/illogical-impulse/config.json`
2. Ensure `jq` is installed: `sudo pacman -S jq`
3. Check script permissions: `ls -l ~/.config/quickshell/ii/scripts/hyprland/apply-hyprland-config.sh`
4. Run the script manually to see error messages

### Configuration Files Not Found

The script will create missing directories automatically. If files don't exist, they need to be created manually with the base configuration.

### Theme Mode Not Detected

The script uses `gsettings get org.gnome.desktop.interface color-scheme` to detect the theme mode. Make sure this is set correctly.

## Technical Details

- **Script**: `~/.config/quickshell/ii/scripts/hyprland/apply-hyprland-config.sh`
- **Settings Page**: `~/.config/quickshell/ii/modules/settings/HyprlandConfig.qml`
- **Config Module**: `~/.config/quickshell/ii/modules/Config.qml`
- **Theme Integration**: Modified `switchwall.sh` to call apply script in `post_process()`

## Contributing

Feel free to extend this feature by:
- Adding more window rules for other applications
- Adding more Hyprland settings (animations, input, etc.)
- Improving the UI with better controls
- Adding validation for color codes and other inputs
