import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions

ScrollView {
    id: root
    contentWidth: width
    clip: true

    ColumnLayout {
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: 20
        }
        spacing: 10

        StyledText {
            text: Translation.tr("Hyprland Settings")
            Layout.fillWidth: true
            color: Appearance.colors.colOnLayer0
            font {
                family: Appearance.font.family.title
                pixelSize: Appearance.font.pixelSize.title * 1.3
                variableAxes: Appearance.font.variableAxes.title
            }
        }

        StyledText {
            text: Translation.tr("Configure Hyprland window manager settings. Changes will be applied based on the current theme mode (light/dark).")
            Layout.fillWidth: true
            color: Appearance.colors.colSecondary
            wrapMode: Text.Wrap
            font.pixelSize: Appearance.font.pixelSize.smaller
        }

        SettingsSectionSeparator {
            text: Translation.tr("General Settings")
        }

        // Gaps Settings
        SettingsBox {
            Layout.fillWidth: true
            ConfigSpinBox {
                bindTarget: "hyprland.general.gaps.gapsIn"
                label: Translation.tr("Inner Gaps")
                sublabel: Translation.tr("Spacing between windows")
                minValue: 0
                maxValue: 50
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSpinBox {
                bindTarget: "hyprland.general.gaps.gapsOut"
                label: Translation.tr("Outer Gaps")
                sublabel: Translation.tr("Spacing from screen edges")
                minValue: 0
                maxValue: 50
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSpinBox {
                bindTarget: "hyprland.general.gaps.gapsWorkspaces"
                label: Translation.tr("Workspace Gaps")
                sublabel: Translation.tr("Spacing between workspaces")
                minValue: 0
                maxValue: 100
            }
        }

        // Border Settings
        SettingsBox {
            Layout.fillWidth: true
            ConfigSpinBox {
                bindTarget: "hyprland.general.border.borderSize"
                label: Translation.tr("Border Size")
                sublabel: Translation.tr("Window border thickness")
                minValue: 0
                maxValue: 10
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigTextField {
                bindTarget: "hyprland.general.border.colActiveBorder"
                label: Translation.tr("Active Border Color")
                sublabel: Translation.tr("Color for active window border (e.g., rgba(0DB7D4FF))")
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigTextField {
                bindTarget: "hyprland.general.border.colInactiveBorder"
                label: Translation.tr("Inactive Border Color")
                sublabel: Translation.tr("Color for inactive window border")
            }
        }

        SettingsSectionSeparator {
            text: Translation.tr("Decoration Settings")
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSpinBox {
                bindTarget: "hyprland.decoration.rounding"
                label: Translation.tr("Corner Rounding")
                sublabel: Translation.tr("Window corner radius")
                minValue: 0
                maxValue: 20
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSwitch {
                bindTarget: "hyprland.decoration.blur.enabled"
                label: Translation.tr("Enable Blur")
                sublabel: Translation.tr("Enable window blur effects")
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSpinBox {
                bindTarget: "hyprland.decoration.blur.size"
                label: Translation.tr("Blur Size")
                sublabel: Translation.tr("Blur radius")
                minValue: 1
                maxValue: 20
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSpinBox {
                bindTarget: "hyprland.decoration.blur.passes"
                label: Translation.tr("Blur Passes")
                sublabel: Translation.tr("Number of blur passes")
                minValue: 0
                maxValue: 10
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSlider {
                bindTarget: "hyprland.decoration.blur.vibrancy"
                label: Translation.tr("Blur Vibrancy")
                sublabel: Translation.tr("Vibrancy strength")
                minValue: 0.0
                maxValue: 1.0
                stepSize: 0.05
            }
        }

        SettingsSectionSeparator {
            text: Translation.tr("Window Opacity Rules")
        }

        StyledText {
            text: Translation.tr("Dolphin File Manager")
            Layout.fillWidth: true
            color: Appearance.colors.colOnLayer0
            font.pixelSize: Appearance.font.pixelSize.larger
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSwitch {
                bindTarget: "hyprland.windowRules.dolphin.enabled"
                label: Translation.tr("Enable Opacity Rule")
                sublabel: Translation.tr("Apply custom opacity to Dolphin")
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSlider {
                bindTarget: "hyprland.windowRules.dolphin.opacity"
                label: Translation.tr("Active Opacity")
                sublabel: Translation.tr("Opacity when window is focused")
                minValue: 0.1
                maxValue: 1.0
                stepSize: 0.01
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSlider {
                bindTarget: "hyprland.windowRules.dolphin.opacityInactive"
                label: Translation.tr("Inactive Opacity")
                sublabel: Translation.tr("Opacity when window is not focused")
                minValue: 0.1
                maxValue: 1.0
                stepSize: 0.01
            }
        }

        StyledText {
            text: Translation.tr("Kate Text Editor")
            Layout.fillWidth: true
            color: Appearance.colors.colOnLayer0
            font.pixelSize: Appearance.font.pixelSize.larger
            Layout.topMargin: 10
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSwitch {
                bindTarget: "hyprland.windowRules.kate.enabled"
                label: Translation.tr("Enable Opacity Rule")
                sublabel: Translation.tr("Apply custom opacity to Kate")
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSlider {
                bindTarget: "hyprland.windowRules.kate.opacity"
                label: Translation.tr("Active Opacity")
                sublabel: Translation.tr("Opacity when window is focused")
                minValue: 0.1
                maxValue: 1.0
                stepSize: 0.01
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSlider {
                bindTarget: "hyprland.windowRules.kate.opacityInactive"
                label: Translation.tr("Inactive Opacity")
                sublabel: Translation.tr("Opacity when window is not focused")
                minValue: 0.1
                maxValue: 1.0
                stepSize: 0.01
            }
        }

        SettingsSectionSeparator {
            text: Translation.tr("Terminal Settings")
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSlider {
                bindTarget: "hyprland.terminal.kittyBackgroundOpacity"
                label: Translation.tr("Kitty Background Opacity")
                sublabel: Translation.tr("Background transparency for Kitty terminal")
                minValue: 0.1
                maxValue: 1.0
                stepSize: 0.01
            }
        }

        SettingsSectionSeparator {
            text: Translation.tr("Theme Mode Settings")
        }

        StyledText {
            text: Translation.tr("Light Mode Overrides")
            Layout.fillWidth: true
            color: Appearance.colors.colOnLayer0
            font.pixelSize: Appearance.font.pixelSize.larger
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSlider {
                bindTarget: "hyprland.themeModes.light.windowRules.dolphin.opacity"
                label: Translation.tr("Dolphin Opacity (Light)")
                sublabel: Translation.tr("Opacity for Dolphin in light mode")
                minValue: 0.1
                maxValue: 1.0
                stepSize: 0.01
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSlider {
                bindTarget: "hyprland.themeModes.light.windowRules.kate.opacity"
                label: Translation.tr("Kate Opacity (Light)")
                sublabel: Translation.tr("Opacity for Kate in light mode")
                minValue: 0.1
                maxValue: 1.0
                stepSize: 0.01
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSlider {
                bindTarget: "hyprland.themeModes.light.terminal.kittyBackgroundOpacity"
                label: Translation.tr("Kitty Opacity (Light)")
                sublabel: Translation.tr("Kitty background opacity in light mode")
                minValue: 0.1
                maxValue: 1.0
                stepSize: 0.01
            }
        }

        StyledText {
            text: Translation.tr("Dark Mode Overrides")
            Layout.fillWidth: true
            color: Appearance.colors.colOnLayer0
            font.pixelSize: Appearance.font.pixelSize.larger
            Layout.topMargin: 10
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSlider {
                bindTarget: "hyprland.themeModes.dark.windowRules.dolphin.opacity"
                label: Translation.tr("Dolphin Opacity (Dark)")
                sublabel: Translation.tr("Opacity for Dolphin in dark mode")
                minValue: 0.1
                maxValue: 1.0
                stepSize: 0.01
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSlider {
                bindTarget: "hyprland.themeModes.dark.windowRules.kate.opacity"
                label: Translation.tr("Kate Opacity (Dark)")
                sublabel: Translation.tr("Opacity for Kate in dark mode")
                minValue: 0.1
                maxValue: 1.0
                stepSize: 0.01
            }
        }

        SettingsBox {
            Layout.fillWidth: true
            ConfigSlider {
                bindTarget: "hyprland.themeModes.dark.terminal.kittyBackgroundOpacity"
                label: Translation.tr("Kitty Opacity (Dark)")
                sublabel: Translation.tr("Kitty background opacity in dark mode")
                minValue: 0.1
                maxValue: 1.0
                stepSize: 0.01
            }
        }

        SettingsSectionSeparator {
            text: Translation.tr("Apply Settings")
        }

        SettingsBox {
            Layout.fillWidth: true
            RowLayout {
                anchors {
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                spacing: 10

                StyledText {
                    Layout.fillWidth: true
                    text: Translation.tr("Apply Current Settings")
                    color: Appearance.colors.colOnLayer0
                    font.pixelSize: Appearance.font.pixelSize.larger
                }

                Button {
                    text: Translation.tr("Apply Now")
                    onClicked: {
                        Quickshell.execDetached([Directories.scriptPath + "/hyprland/apply-hyprland-config.sh"]);
                    }
                }
            }
        }

        StyledText {
            text: Translation.tr("Note: Settings will be automatically applied when you toggle light/dark mode")
            Layout.fillWidth: true
            color: Appearance.colors.colSecondary
            wrapMode: Text.Wrap
            font.pixelSize: Appearance.font.pixelSize.smaller
            Layout.topMargin: 5
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
