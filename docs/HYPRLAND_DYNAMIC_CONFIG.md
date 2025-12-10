# Dynamic Hyprland Configuration

This feature allows you to dynamically configure Hyprland settings (gaps, borders, window opacity, terminal opacity) through the illogical-impulse settings GUI, with automatic theme-aware adjustments for light and dark modes.

## Features

- **GUI Configuration**: Configure Hyprland settings through the settings app
- **Theme-Aware Settings**: Different settings for light and dark modes
- **Automatic Application**: Settings are automatically applied when toggling between light and dark modes
- **Per-Application Opacity**: Configure opacity for specific applications (Dolphin, Kate, Kitty)

## Configuration

### Accessing Settings

1. Open the illogical-impulse settings app
2. Navigate to the "Hyprland" tab (window icon)
3. Adjust the settings as desired

### Available Settings

#### General Settings
- **Inner Gaps**: Spacing between windows
- **Outer Gaps**: Spacing from screen edges
- **Workspace Gaps**: Spacing between workspaces
- **Border Size**: Window border thickness
- **Border Colors**: Active and inactive border colors (currently view-only, edit in config file)

#### Decoration
- **Corner Rounding**: Window corner radius
- **Blur Settings**: Enable/disable blur, blur size, passes, and vibrancy

#### Window Opacity Rules
- **Dolphin File Manager**: Enable opacity rule and set active/inactive opacity
- **Kate Text Editor**: Enable opacity rule and set active/inactive opacity

#### Terminal Settings
- **Kitty Background Opacity**: Set terminal background transparency

#### Theme Mode Overrides
- **Light Mode**: Specify different opacity values for light mode
- **Dark Mode**: Specify different opacity values for dark mode

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
      "dolphin": { "enabled": true, "opacity": 0.89, "opacityInactive": 0.8 },
      "kate": { "enabled": true, "opacity": 0.89, "opacityInactive": 0.8 }
    },
    "terminal": {
      "kittyBackgroundOpacity": 0.8
    },
    "themeModes": {
      "light": { /* light mode overrides */ },
      "dark": { /* dark mode overrides */ }
    }
  }
}
```

### Automatic Application

The apply script (`scripts/hyprland/apply-hyprland-config.sh`) is automatically called when:
1. You toggle between light and dark modes
2. You manually click "Apply Hyprland Settings Now" in the settings

The script:
1. Detects the current theme mode (light/dark)
2. Reads settings from the config file, using theme-specific overrides when available
3. Updates the following files:
   - `~/.config/hypr/hyprland/general.conf` (gaps, borders, decoration)
   - `~/.config/hypr/custom/rules.conf` (window opacity rules)
   - `~/.config/kitty/kitty.conf` (terminal opacity)
4. Reloads Hyprland configuration

### Integration with Theme Toggle

The feature is integrated with the existing dark mode toggle. When you toggle between light and dark modes:
1. The theme switch script (`switchwall.sh`) runs
2. It calls the Hyprland configuration apply script
3. Settings are applied based on the new theme mode

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
