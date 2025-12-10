import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services
import qs.modules.common
import qs.modules.common.widgets

ContentPage {
    forceWidth: true

    ContentSection {
        icon: "window"
        title: Translation.tr("General Settings")

        ConfigRow {
            ConfigSpinBox {
                icon: "spaces"
                text: Translation.tr("Inner Gaps")
                value: Config.options.hyprland.general.gaps.gapsIn
                from: 0
                to: 50
                stepSize: 1
                onValueChanged: {
                    Config.options.hyprland.general.gaps.gapsIn = value;
                }
            }
            ConfigSpinBox {
                icon: "expand_content"
                text: Translation.tr("Outer Gaps")
                value: Config.options.hyprland.general.gaps.gapsOut
                from: 0
                to: 50
                stepSize: 1
                onValueChanged: {
                    Config.options.hyprland.general.gaps.gapsOut = value;
                }
            }
        }

        ConfigRow {
            ConfigSpinBox {
                icon: "grid_view"
                text: Translation.tr("Workspace Gaps")
                value: Config.options.hyprland.general.gaps.gapsWorkspaces
                from: 0
                to: 100
                stepSize: 5
                onValueChanged: {
                    Config.options.hyprland.general.gaps.gapsWorkspaces = value;
                }
            }
            ConfigSpinBox {
                icon: "border_outer"
                text: Translation.tr("Border Size")
                value: Config.options.hyprland.general.border.borderSize
                from: 0
                to: 10
                stepSize: 1
                onValueChanged: {
                    Config.options.hyprland.general.border.borderSize = value;
                }
            }
        }

        ContentSubsection {
            title: Translation.tr("Border Colors")
            
            StyledText {
                text: Translation.tr("Active: ") + Config.options.hyprland.general.border.colActiveBorder
                color: Appearance.colors.colSecondary
                font.pixelSize: Appearance.font.pixelSize.smaller
                Layout.leftMargin: 48
            }
            StyledText {
                text: Translation.tr("Inactive: ") + Config.options.hyprland.general.border.colInactiveBorder
                color: Appearance.colors.colSecondary
                font.pixelSize: Appearance.font.pixelSize.smaller
                Layout.leftMargin: 48
            }
            StyledText {
                text: Translation.tr("Edit in config file for custom colors")
                color: Appearance.colors.colSecondary
                font.pixelSize: Appearance.font.pixelSize.smaller
                wrapMode: Text.Wrap
                Layout.leftMargin: 48
            }
        }
    }

    ContentSection {
        icon: "texture"
        title: Translation.tr("Decoration")

        ConfigSpinBox {
            icon: "rounded_corner"
            text: Translation.tr("Corner Rounding")
            value: Config.options.hyprland.decoration.rounding
            from: 0
            to: 20
            stepSize: 1
            onValueChanged: {
                Config.options.hyprland.decoration.rounding = value;
            }
        }

        ConfigSwitch {
            buttonIcon: "blur_on"
            text: Translation.tr("Enable Blur")
            checked: Config.options.hyprland.decoration.blur.enabled
            onCheckedChanged: {
                Config.options.hyprland.decoration.blur.enabled = checked;
            }
        }

        ConfigRow {
            enabled: Config.options.hyprland.decoration.blur.enabled
            ConfigSpinBox {
                icon: "blur_medium"
                text: Translation.tr("Blur Size")
                value: Config.options.hyprland.decoration.blur.size
                from: 1
                to: 20
                stepSize: 1
                onValueChanged: {
                    Config.options.hyprland.decoration.blur.size = value;
                }
            }
            ConfigSpinBox {
                icon: "layers"
                text: Translation.tr("Blur Passes")
                value: Config.options.hyprland.decoration.blur.passes
                from: 0
                to: 10
                stepSize: 1
                onValueChanged: {
                    Config.options.hyprland.decoration.blur.passes = value;
                }
            }
        }

        ConfigSpinBox {
            enabled: Config.options.hyprland.decoration.blur.enabled
            icon: "palette"
            text: Translation.tr("Blur Vibrancy (%)")
            value: Config.options.hyprland.decoration.blur.vibrancy * 100
            from: 0
            to: 100
            stepSize: 5
            onValueChanged: {
                Config.options.hyprland.decoration.blur.vibrancy = value / 100;
            }
        }
    }

    ContentSection {
        icon: "opacity"
        title: Translation.tr("Window Opacity Rules")

        ContentSubsection {
            title: Translation.tr("Dolphin File Manager")

            ConfigSwitch {
                buttonIcon: "folder"
                text: Translation.tr("Enable Opacity Rule")
                checked: Config.options.hyprland.windowRules.dolphin.enabled
                onCheckedChanged: {
                    Config.options.hyprland.windowRules.dolphin.enabled = checked;
                }
            }

            ConfigRow {
                enabled: Config.options.hyprland.windowRules.dolphin.enabled
                ConfigSpinBox {
                    icon: "visibility"
                    text: Translation.tr("Active Opacity (%)")
                    value: Config.options.hyprland.windowRules.dolphin.opacity * 100
                    from: 10
                    to: 100
                    stepSize: 1
                    onValueChanged: {
                        Config.options.hyprland.windowRules.dolphin.opacity = value / 100;
                    }
                }
                ConfigSpinBox {
                    icon: "visibility_off"
                    text: Translation.tr("Inactive Opacity (%)")
                    value: Config.options.hyprland.windowRules.dolphin.opacityInactive * 100
                    from: 10
                    to: 100
                    stepSize: 1
                    onValueChanged: {
                        Config.options.hyprland.windowRules.dolphin.opacityInactive = value / 100;
                    }
                }
            }
        }

        ContentSubsection {
            title: Translation.tr("Kate Text Editor")

            ConfigSwitch {
                buttonIcon: "edit"
                text: Translation.tr("Enable Opacity Rule")
                checked: Config.options.hyprland.windowRules.kate.enabled
                onCheckedChanged: {
                    Config.options.hyprland.windowRules.kate.enabled = checked;
                }
            }

            ConfigRow {
                enabled: Config.options.hyprland.windowRules.kate.enabled
                ConfigSpinBox {
                    icon: "visibility"
                    text: Translation.tr("Active Opacity (%)")
                    value: Config.options.hyprland.windowRules.kate.opacity * 100
                    from: 10
                    to: 100
                    stepSize: 1
                    onValueChanged: {
                        Config.options.hyprland.windowRules.kate.opacity = value / 100;
                    }
                }
                ConfigSpinBox {
                    icon: "visibility_off"
                    text: Translation.tr("Inactive Opacity (%)")
                    value: Config.options.hyprland.windowRules.kate.opacityInactive * 100
                    from: 10
                    to: 100
                    stepSize: 1
                    onValueChanged: {
                        Config.options.hyprland.windowRules.kate.opacityInactive = value / 100;
                    }
                }
            }
        }
    }

    ContentSection {
        icon: "terminal"
        title: Translation.tr("Terminal Settings")

        ConfigSpinBox {
            icon: "contrast"
            text: Translation.tr("Kitty Background Opacity (%)")
            value: Config.options.hyprland.terminal.kittyBackgroundOpacity * 100
            from: 10
            to: 100
            stepSize: 1
            onValueChanged: {
                Config.options.hyprland.terminal.kittyBackgroundOpacity = value / 100;
            }
        }
    }

    ContentSection {
        icon: "light_mode"
        title: Translation.tr("Light Mode Overrides")

        ContentSubsection {
            title: Translation.tr("Window Opacity (Light Mode)")

            ConfigRow {
                ConfigSpinBox {
                    icon: "folder"
                    text: Translation.tr("Dolphin (%)")
                    value: Config.options.hyprland.themeModes.light.windowRules.dolphin.opacity * 100
                    from: 10
                    to: 100
                    stepSize: 1
                    onValueChanged: {
                        Config.options.hyprland.themeModes.light.windowRules.dolphin.opacity = value / 100;
                    }
                }
                ConfigSpinBox {
                    icon: "edit"
                    text: Translation.tr("Kate (%)")
                    value: Config.options.hyprland.themeModes.light.windowRules.kate.opacity * 100
                    from: 10
                    to: 100
                    stepSize: 1
                    onValueChanged: {
                        Config.options.hyprland.themeModes.light.windowRules.kate.opacity = value / 100;
                    }
                }
            }

            ConfigSpinBox {
                icon: "terminal"
                text: Translation.tr("Kitty Background (%)")
                value: Config.options.hyprland.themeModes.light.terminal.kittyBackgroundOpacity * 100
                from: 10
                to: 100
                stepSize: 1
                onValueChanged: {
                    Config.options.hyprland.themeModes.light.terminal.kittyBackgroundOpacity = value / 100;
                }
            }
        }
    }

    ContentSection {
        icon: "dark_mode"
        title: Translation.tr("Dark Mode Overrides")

        ContentSubsection {
            title: Translation.tr("Window Opacity (Dark Mode)")

            ConfigRow {
                ConfigSpinBox {
                    icon: "folder"
                    text: Translation.tr("Dolphin (%)")
                    value: Config.options.hyprland.themeModes.dark.windowRules.dolphin.opacity * 100
                    from: 10
                    to: 100
                    stepSize: 1
                    onValueChanged: {
                        Config.options.hyprland.themeModes.dark.windowRules.dolphin.opacity = value / 100;
                    }
                }
                ConfigSpinBox {
                    icon: "edit"
                    text: Translation.tr("Kate (%)")
                    value: Config.options.hyprland.themeModes.dark.windowRules.kate.opacity * 100
                    from: 10
                    to: 100
                    stepSize: 1
                    onValueChanged: {
                        Config.options.hyprland.themeModes.dark.windowRules.kate.opacity = value / 100;
                    }
                }
            }

            ConfigSpinBox {
                icon: "terminal"
                text: Translation.tr("Kitty Background (%)")
                value: Config.options.hyprland.themeModes.dark.terminal.kittyBackgroundOpacity * 100
                from: 10
                to: 100
                stepSize: 1
                onValueChanged: {
                    Config.options.hyprland.themeModes.dark.terminal.kittyBackgroundOpacity = value / 100;
                }
            }
        }
    }

    ContentSection {
        icon: "settings"
        title: Translation.tr("Apply Settings")

        ConfigSwitch {
            buttonIcon: "check"
            text: Translation.tr("Apply Hyprland Settings Now")
            checked: false
            onCheckedChanged: {
                if (checked) {
                    Quickshell.execDetached([Directories.scriptPath + "/hyprland/apply-hyprland-config.sh"]);
                    checked = false;
                }
            }
            StyledToolTip {
                text: Translation.tr("Apply current settings to Hyprland configuration files")
            }
        }

        StyledText {
            text: Translation.tr("Note: Settings will be automatically applied when you toggle light/dark mode")
            color: Appearance.colors.colSecondary
            wrapMode: Text.Wrap
            font.pixelSize: Appearance.font.pixelSize.smaller
            Layout.leftMargin: 48
        }
    }
}
