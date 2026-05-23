import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

import App.Theme 1.0

Item {
    id: root
    anchors.fill: parent
    z: 100 // Above everything
    visible: false // Hidden by default

    // Public properties
    default property alias content: contentLayout.data
    property string title: "Right Drawer"
    property real drawerWidth: 320

    function open() {
        visible = true
        scrim.opacity = 1
        drawerPanel.x = parent.width - drawerPanel.width
    }

    function close() {
        scrim.opacity = 0
        drawerPanel.x = parent.width
        closeTimer.start()
    }

    Timer {
        id: closeTimer
        interval: 300
        onTriggered: root.visible = false
    }

    // Scrim
    Rectangle {
        id: scrim
        anchors.fill: parent
        color: "#52000000" // Scrim opacity 32%
        opacity: 0
        Behavior on opacity { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

        MouseArea {
            anchors.fill: parent
            onClicked: root.close()
        }
    }

    // Drawer Panel
    Rectangle {
        id: drawerPanel
        width: root.drawerWidth
        height: parent.height
        color: Theme.color.surfaceContainer
        x: parent.width // Start off-screen right

        Behavior on x { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

        // Shadow
        layer.enabled: true
        layer.effect: DropShadow {
            anchors.fill: drawerPanel
            source: drawerPanel

            horizontalOffset: -2
            verticalOffset: 0
            radius: 16
            samples: 17

            color: Qt.rgba(0, 0, 0, 0.25)
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            // Header
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 64

                Text {
                    anchors.centerIn: parent
                    text: root.title
                    font.pixelSize: Theme.typography.titleLarge.size
                    font.family: Theme.typography.titleLarge.family
                    color: Theme.color.onSurfaceColor
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: Theme.color.outlineVariant
            }

            // Content Container
            Item {
                id: contentLayout
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
            }
        }
    }
}
