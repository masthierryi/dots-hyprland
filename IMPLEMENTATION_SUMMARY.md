# Implementation Summary - Dynamic Hyprland Configuration (Simplified)

## What Was Implemented

A simplified, user-friendly dynamic configuration system for Hyprland that addresses user feedback for a cleaner, more flexible approach.

### Key Changes Based on User Feedback

1. **Apply Button Instead of Switch**: Changed from ConfigSwitch to RippleButton - now works properly as a clickable button
2. **Opacity Variables System**: Instead of managing individual app rules, the system creates global opacity variables
3. **No More Duplication**: Script only manages the variables section, user's existing rules remain untouched
4. **Removed Light/Dark Mode Overrides**: Simplified to single set of settings
5. **Removed Border Colors Display**: Users can edit these directly in config file if needed
6. **Added Hover Opacity**: New $OPACITY_HOVER variable for hover states

## How It Works

### Opacity Variables Approach

The script creates/updates a variables section at the top of `~/.config/hypr/custom/rules.conf`:

```bash
# Opacity Variables - Managed by illogical-impulse
$OPACITY_ACTIVE = 0.89
$OPACITY_INACTIVE = 0.8
$OPACITY_HOVER = 0.95
# End Opacity Variables
```

Users then reference these variables in their own custom rules:

```bash
windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(dolphin)$
windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(kate)$
windowrulev2 = opacity $OPACITY_HOVER override $OPACITY_INACTIVE override, class:^(firefox)$
```

**Benefits:**
- No duplication - change opacity once, affects all windows using that variable
- Flexible - users control which apps use which opacity values
- Clean - script doesn't touch user's custom rules

### GUI Settings Page

Simplified settings with:
- **General Settings**: Gaps (inner, outer, workspace), Border size
- **Decoration**: Corner rounding, Blur settings (enabled, size, passes, vibrancy)
- **Window Opacity**: Global opacity variables (active, inactive, hover)
- **Terminal**: Kitty background opacity
- **Apply Button**: RippleButton to apply changes immediately

### Configuration Storage

Settings stored in `~/.config/illogical-impulse/config.json`:

```json
{
  "hyprland": {
    "general": {
      "gaps": { "gapsIn": 3, "gapsOut": 4, "gapsWorkspaces": 50 },
      "border": { "borderSize": 2, "colActiveBorder": "rgba(0DB7D4FF)", ... }
    },
    "decoration": {
      "rounding": 4,
      "blur": { "enabled": true, "size": 3, "passes": 0, "vibrancy": 0.5, ... }
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

## Files Modified/Created

### Modified Files
1. `dots/.config/quickshell/ii/modules/Config.qml` - Simplified config structure
2. `dots/.config/quickshell/ii/modules/settings/HyprlandConfig.qml` - New cleaner UI with button
3. `dots/.config/quickshell/ii/scripts/hyprland/apply-hyprland-config.sh` - Simplified script using variables

### Integration
- `dots/.config/quickshell/ii/scripts/colors/switchwall.sh` - Still calls apply script on theme toggle

## Usage

### Quick Start

1. Open illogical-impulse settings → Hyprland tab
2. Set your preferred opacity values
3. Click "Apply Hyprland Settings Now"
4. Add window rules using the variables:
   ```bash
   windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(yourapp)$
   ```

### Example Use Cases

**Case 1: Same opacity for multiple apps**
```bash
# Set opacity to 89% in GUI, then use in multiple rules:
windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(dolphin)$
windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(kate)$
windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(code)$
```

**Case 2: Hover opacity for specific app**
```bash
windowrulev2 = opacity $OPACITY_HOVER override $OPACITY_INACTIVE override, class:^(firefox)$
```

**Case 3: Quick global changes**
- Adjust opacity sliders in GUI
- Click "Apply Hyprland Settings Now"
- All windows using those variables update immediately!

## Technical Details

### Script Behavior

The apply script:
1. Reads values from config.json
2. Updates opacity variables section (removes old, adds new)
3. Updates general.conf (gaps, borders, decoration)
4. Updates kitty.conf (terminal opacity)
5. Reloads Hyprland

**Safe Operations:**
- Creates backups (.bak files)
- Uses context-aware sed patterns
- Only manages the variables section in rules.conf
- Creates directories if missing

### No Theme Mode Detection

The simplified version doesn't detect light/dark mode. Settings are applied as-is when:
- User clicks Apply button
- Theme toggle triggers the script (via switchwall.sh integration)

## Troubleshooting

### Variables Not Working

Make sure your window rules reference the variables correctly:
```bash
# ✓ Correct
windowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(app)$

# ✗ Incorrect (missing $)
windowrulev2 = opacity OPACITY_ACTIVE override OPACITY_INACTIVE override, class:^(app)$
```

### Apply Button Doesn't Work

1. Check script permissions: `ls -l ~/.config/quickshell/ii/scripts/hyprland/apply-hyprland-config.sh`
2. Make executable if needed: `chmod +x ~/.config/quickshell/ii/scripts/hyprland/apply-hyprland-config.sh`
3. Run manually to see errors: `~/.config/quickshell/ii/scripts/hyprland/apply-hyprland-config.sh`

### Settings Not Persisting

Settings are saved to config.json automatically when you change them in the GUI. The Apply button only applies them to the actual config files.

## Complete Documentation

For detailed documentation, see: `docs/HYPRLAND_DYNAMIC_CONFIG.md`

## Summary of Improvements

✅ Simpler configuration structure
✅ No more duplicate rules
✅ User has full control over which apps use which opacity
✅ Proper button instead of buggy switch
✅ Removed unnecessary theme mode complexity
✅ Added hover opacity variable
✅ Cleaner, more maintainable code

This implementation is more flexible, easier to understand, and doesn't interfere with user's custom window rules!
