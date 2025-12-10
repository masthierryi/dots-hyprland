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

        StyledText {
            text: Translation.tr("Set global opacity values that can be used in your window rules.\nUse $OPACITY_ACTIVE, $OPACITY_INACTIVE, and $OPACITY_HOVER variables in custom/rules.conf")
            color: Appearance.colors.colSecondary
            wrapMode: Text.Wrap
            font.pixelSize: Appearance.font.pixelSize.smaller
            Layout.leftMargin: 48
            Layout.rightMargin: 48
        }

        ConfigRow {
            ConfigSpinBox {
                icon: "visibility"
                text: Translation.tr("Active Opacity (%)")
                value: Config.options.hyprland.windowRules.opacityActive * 100
                from: 10
                to: 100
                stepSize: 1
                onValueChanged: {
                    Config.options.hyprland.windowRules.opacityActive = value / 100;
                }
            }
            ConfigSpinBox {
                icon: "visibility_off"
                text: Translation.tr("Inactive Opacity (%)")
                value: Config.options.hyprland.windowRules.opacityInactive * 100
                from: 10
                to: 100
                stepSize: 1
                onValueChanged: {
                    Config.options.hyprland.windowRules.opacityInactive = value / 100;
                }
            }
        }

        ConfigSpinBox {
            icon: "mouse"
            text: Translation.tr("Hover Opacity (%)")
            value: Config.options.hyprland.windowRules.opacityHover * 100
            from: 10
            to: 100
            stepSize: 1
            onValueChanged: {
                Config.options.hyprland.windowRules.opacityHover = value / 100;
            }
        }

        ContentSubsection {
            title: Translation.tr("Example Usage")
            
            StyledText {
                text: Translation.tr("In your custom/rules.conf, use:\nwindowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(dolphin)$\nwindowrulev2 = opacity $OPACITY_ACTIVE override $OPACITY_INACTIVE override, class:^(kate)$")
                color: Appearance.colors.colSecondary
                wrapMode: Text.Wrap
                font.pixelSize: Appearance.font.pixelSize.smaller
                font.family: "monospace"
                Layout.leftMargin: 48
                Layout.rightMargin: 48
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
        icon: "settings"
        title: Translation.tr("Apply Settings")

        RippleButton {
            Layout.fillWidth: true
            buttonRadius: Appearance.rounding.button
            padding: 12
            onClicked: {
                Quickshell.execDetached([Directories.scriptPath + "/hyprland/apply-hyprland-config.sh"]);
            }
            contentItem: RowLayout {
                spacing: 10
                MaterialSymbol {
                    text: "check"
                    iconSize: 20
                    color: Appearance.colors.colOnPrimaryContainer
                }
                StyledText {
                    text: Translation.tr("Apply Hyprland Settings Now")
                    color: Appearance.colors.colOnPrimaryContainer
                    font.pixelSize: Appearance.font.pixelSize.larger
                }
            }
        }

        StyledText {
            text: Translation.tr("Note: Settings will be automatically applied when you toggle light/dark mode")
            color: Appearance.colors.colSecondary
            wrapMode: Text.Wrap
            font.pixelSize: Appearance.font.pixelSize.smaller
            Layout.leftMargin: 48
            Layout.topMargin: 10
        }
    }
}
