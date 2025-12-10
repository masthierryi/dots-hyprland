# Hyprland Dynamic Configuration - Quick Setup

## How It Works

This system manages Hyprland settings (gaps, borders, blur, opacity) through the illogical-impulse GUI.

### Light/Dark Mode Independence

- **Dark mode**: Settings saved to `~/.config/illogical-impulse/config.json`
- **Light mode**: Settings saved to `~/.config/illogical-impulse/config-light.json`
- Each mode has its own independent configuration
- When you switch themes, the appropriate config file is loaded automatically
- **First time setup**: Duplicate `config.json` to `config-light.json` to have separate light mode settings

### Opacity Variables System

The script creates global opacity variables at the top of `~/.config/hypr/custom/rules.conf`:

```bash
# Opacity Variables - Managed by illogical-impulse
$OPACITY_ACTIVE = 0.89
$OPACITY_INACTIVE = 0.8
$OPACITY_HOVER = 0.95
# End Opacity Variables
```

### Adding Apps to Use Opacity Variables

**You must manually add window rules** to `~/.config/hypr/custom/rules.conf` for each app:

```bash
# Example: Apply opacity to Dolphin file manager
windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(dolphin)$

# Example: Apply opacity to Kate editor
windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(kate)$

# Example: Use hover opacity for Firefox
windowrulev2 = opacity $OPACITY_HOVER override $OPACITY_INACTIVE override, class:^(firefox)$
```

Now when you change opacity values in the GUI and click "Apply", all windows using these variables will update automatically.

## Terminal Configuration

### Kitty Terminal

The script automatically updates `~/.config/kitty/kitty.conf` with the background opacity you set in the GUI.

### Other Terminals

If you use a different terminal (alacritty, wezterm, etc.), you need to:
1. Manually edit your terminal's config file
2. Or modify the apply script at `~/.config/quickshell/ii/scripts/hyprland/apply-hyprland-config.sh` to support your terminal

## Quick Start

1. **Create light mode config**: `cp ~/.config/illogical-impulse/config.json ~/.config/illogical-impulse/config-light.json`
2. Open illogical-impulse settings → Hyprland tab
3. Adjust your settings (gaps, blur, opacity values)
4. Click "Apply Hyprland Settings Now"
5. Add window rules to `~/.config/hypr/custom/rules.conf` using the opacity variables
6. Toggle between light/dark mode - each has independent settings!

## What Gets Updated

When you click "Apply Hyprland Settings Now":
- `~/.config/hypr/hyprland/general.conf` - gaps, borders, decoration
- `~/.config/hypr/custom/rules.conf` - opacity variables (your rules stay untouched)
- `~/.config/kitty/kitty.conf` - terminal background opacity
