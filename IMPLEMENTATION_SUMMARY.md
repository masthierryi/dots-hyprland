- Can now change Hypr basic settings from GUI settings app.
- **Dark mode**: Settings saved to `~/.config/illogical-impulse/config.json`
- **Light mode**: Settings saved to `~/.config/illogical-impulse/config-light.json`
- Each mode has its own independent configuration for Hypr and Quickshell.

### How to implement (if not merged)

- Duplicate `config.json` to `config-light.json` to have separate light mode settings
- Add the new files and modifications
- Verify the paths and apps in `apply-hyprland-config.sh`
- Enjoy ;)

### Opacity Variables System

The script creates global opacity variables at the top of `~/.config/hypr/custom/rules.conf`:

```bash
# Opacity Variables - Managed by illogical-impulse
$OPACITY_ACTIVE = 0.89
$OPACITY_INACTIVE = 0.8
# End Opacity Variables
```

**Adding Apps to Use Opacity Variables**

*You must manually add window rules* to `~/.config/hypr/custom/rules.conf` for each app:

```bash
# Example: Apply opacity to Dolphin file manager
windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(dolphin)$

# Example: Apply opacity to Kate editor
windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(kate)$

...
```

Now when you change opacity values in the GUI and click "Apply", all windows using these variables will update automatically.

### Terminal Configuration

**Kitty Terminal**

The script automatically updates `~/.config/kitty/kitty.conf` with the background opacity you set in the GUI.
```
windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(kate)$
```
```
background_opacity 0.9
```
Note that kitty opacity on kitty.conf is someway stronger than the windowrule. If the kitty `background_opacity` is less than the `$OPACITY_ACTIVE`, `background_opacity` will be the one used. 

**Other Terminals**

If you use a different terminal (alacritty, wezterm, etc.), you need to:
1. Manually edit your terminal's config file
2. Or modify the apply script at `~/.config/quickshell/ii/scripts/hyprland/apply-hyprland-config.sh` to support your terminal

### What Gets Updated by the  script

When you click "Apply Hyprland Settings Now":
- `~/.config/hypr/hyprland/general.conf` - gaps, borders, decoration
- `~/.config/hypr/custom/rules.conf` - opacity variables (your rules stay untouched)
- `~/.config/kitty/kitty.conf` - terminal background opacity
