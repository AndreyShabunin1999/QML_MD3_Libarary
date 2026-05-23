import QtQuick 2.15
import QtQuick.Window 2.15

import "QML/Controls"
import App.Theme 1.0

Window {
    id: window
    width: 1000
    height: 1000
    visible: true
    title: qsTr("Hello World")

    IndexBackground {
        anchors.fill: parent
    }

    SideSheet {
        id: sideSheet
    }

    NavigationDrawer {
        id: drawer

        title: "Menu"
        drawerWidth: 320
        modal: true

        model: [
            { text: "Home", icon: "home" },
            { text: "Profile", icon: "person" },
            { type: "divider" },
            { text: "Settings", icon: "settings" }
        ]

        onItemClicked: function(item) {
            console.log("clicked:", item.text)
        }
    }
    //NavigationRail {
    //    id: rail

    //    z:999

    //    extended: false
    //    currentIndex: 0

    //    model: [
    //        { icon: "home", text: "Home" },
    //        { icon: "search", text: "Search" },
    //        { icon: "settings", text: "Settings" }
    //    ]
    //}

    //NavigationBar {
    //    id: nav

    //    z:999

    //    model: [
    //        { text: "Home", icon: "home" },
    //        { text: "Search", icon: "search" },
    //        { text: "Profile", icon: "person" }
    //    ]

    //    // 3 страницы внутри StackLayout
    //    Item { Rectangle { anchors.fill: parent; color: "red" } }
    //    Item { Rectangle { anchors.fill: parent; color: "green" } }
    //    Item { Rectangle { anchors.fill: parent; color: "blue" } }
    //}

    FabMenu {
        id: fabMenu

        model: [
            { text: "Edit", icon: "edit", color: Theme.color.secondaryContainer },
            { text: "Delete", icon: "delete", color: Theme.color.errorContainer },
            { text: "Share", icon: "share", color: Theme.color.primaryContainer }
        ]

        onItemClicked: function(index, itemData) {
            console.log("Clicked:", index, itemData.text)
        }
    }

    Dialog {
        id: dialog

        title: "Delete item"
        text: "This action cannot be undone."

        acceptText: "Delete"
        rejectText: "Cancel"

        onAccepted: {
            console.log("Accepted")
        }

        onRejected: {
            console.log("Rejected")
        }

        onClosed: {
            console.log("Closed")
        }
    }

    SnackBar {
        id: snack
    }

    ToolTip {
        id: tip
        text: "Hello tooltip"
    }

    Item {
        anchors.fill: parent

        TopAppBar {
            id: topAppBar
            title: "Dashboard"

            IconButton {
                icon: "search"
                type: "standard"
                onClicked: console.log("search")
            }

            IconButton {
                icon: "more_vert"
                type: "standard"
                onClicked: sideSheet.open()
            }

            IconButton {
                icon: "menu"
                type: "standard"
                onClicked: drawer.open()
            }
        }

        BreadCrumb {
            id: breadcrumb
            anchors {
                top: topAppBar.bottom
                topMargin: 70   // под TopAppBar
                left: parent.left
                right: parent.right
            }
            model: ["Главная"]
        }

        Flickable {
            id: flick
            anchors {
                top:  breadcrumb.bottom
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            contentHeight: column.implicitHeight
            contentWidth: width

            clip: true

            Column {
                id: column
                width: flick.width

                spacing: 4

                Row {
                    spacing: 8

                    Button {
                        text: "Continue"
                        type: "filled"

                        onClicked: {
                            snack.text = "Filled button pressed"
                            snack.actionText = "OK"
                            snack.open()
                        }
                    }

                    Button {
                        text: "Cancel"
                        type: "text"

                        onClicked: {
                            snack.text = "Text button pressed"
                            snack.actionText = ""
                            snack.open()
                        }
                    }

                    Button {
                        text: "Delete"
                        type: "outlined"

                        onClicked: {
                            snack.text = "Delete action triggered"
                            snack.actionText = "UNDO"
                            snack.open()
                        }
                    }

                    Button {
                        text: "Save"
                        type: "elevated"

                        onClicked: {
                            snack.text = "Saved successfully"
                            snack.actionText = "VIEW"
                            snack.open()
                        }
                    }

                    Button {
                        text: "Option"
                        type: "filledTonal"

                        onClicked: {
                            snack.text = "Tonal option selected"
                            snack.actionText = "DETAILS"
                            snack.open()
                        }
                    }

                    Button {
                        text: "ToolTip"
                        type: "filledTonal"

                        onClicked: {
                            tip.open()
                        }
                    }

                    Button {
                        text: "Open Time Picker"

                        onClicked: {
                            timePicker.open()
                        }
                    }

                    Button {
                        text: "Open dialog"

                        onClicked: {
                            dialog.open()
                        }
                    }

                    Button {
                        text: "Добавить уровень"
                        onClicked: {
                            breadcrumb.model = [
                                { text: "Главная", action: function() { console.log("На главную") } },
                                { text: "Каталог", action: function() { console.log("В каталог") } },
                                { text: "Товар" }
                            ]
                        }
                    }
                }

                Row {
                    spacing: 4

                    CheckBox {
                        text: "Accept terms"
                        checked: true

                        onClicked: {
                            console.log("checked:", checked)
                        }
                    }

                    CheckBox {
                        text: "Subscribe to newsletter"
                        checked: false
                    }

                    CheckBox {
                        text: "Indeterminate state"
                        indeterminate: true
                    }
                }

                Row {
                    spacing: 4

                    Switch {
                        text: "Wi-Fi"
                        checked: true
                        enabled: true

                        onClicked: {
                            console.log("Wi-Fi:", checked)
                        }
                    }

                    Switch {
                        text: "Bluetooth"
                        checked: false
                    }

                    Switch {
                        text: "Airplane mode"
                        checked: false
                        enabled: false
                    }
                }

                Row {
                    spacing: 12

                    IconButton {
                        icon: "add"
                        type: "standard"
                        onClicked: console.log("standard")
                    }

                    IconButton {
                        icon: "edit"
                        type: "outlined"
                        onClicked: console.log("outlined")
                    }

                    IconButton {
                        icon: "favorite"
                        type: "filled"
                        onClicked: console.log("filled")
                    }

                    IconButton {
                        icon: "share"
                        type: "filledTonal"
                        onClicked: console.log("filledTonal")
                    }
                }

                Row {
                    spacing: 4

                    // 1. Selected
                    RadioButton {
                        text: "Option A"
                        checked: true

                        onClicked: console.log("A selected")
                    }

                    // 2. Unselected
                    RadioButton {
                        text: "Option B"
                        checked: false

                        onClicked: console.log("B selected")
                    }

                    // 3. Disabled selected
                    RadioButton {
                        text: "Option C (disabled selected)"
                        checked: true
                        enabled: false
                    }

                    // 4. Disabled unselected
                    RadioButton {
                        text: "Option D (disabled)"
                        checked: false
                        enabled: false
                    }
                }

                Row {
                    spacing: 4

                    TextField {
                        label: "Filled"
                        type: "filled"
                        text: ""
                    }

                    TextField {
                        label: "Outlined"
                        type: "outlined"
                        text: ""
                    }
                }

                Row {
                    SegmentedButton {
                        id: seg

                        enabled: true
                        multiSelect: false

                        buttons: [
                            { text: "Day", icon: "today", selected: false, enabled: true },
                            { text: "Week", icon: "view_week", selected: true, enabled: true },
                            { text: "Month", icon: "calendar_month", selected: false, enabled: true },
                            { text: "Year", icon: "event", selected: false, enabled: false }
                        ]

                        onClicked: function(index) {
                            console.log("Selected index:", index)
                            console.log("State:", JSON.stringify(seg.buttons))
                        }
                    }
                }

                Row {
                    TimePicker {
                        id: timePicker

                        onAccepted: (h, m) => {
                                        console.log("Selected time:", h, m)
                                    }

                        onRejected: {
                            console.log("Cancelled")
                        }

                        onClosed: {
                            console.log("Picker closed")
                        }
                    }
                }

                Row {
                    spacing: 4

                    Chip {
                        text: "Assist"
                        type: "assist"
                        icon: "star"
                        onClicked: console.log("assist clicked")
                    }

                    Chip {
                        text: "Filter"
                        type: "filter"
                        selected: true
                        icon: "music_note"
                        onClicked: console.log("filter clicked")
                    }

                    Chip {
                        text: "Input chip"
                        type: "input"
                        showCloseIcon: true
                        onClicked: console.log("clicked")
                        onCloseClicked: console.log("close clicked")
                    }
                }

                Row {
                    CircularProgress {
                        value: 0.65   // 65%
                    }

                    CircularProgress {
                        indeterminate: true
                    }

                    CircularProgress {
                        indeterminate: true
                        wavy: true
                    }

                    CircularProgress {
                        value: 0.4
                        showTrack: true
                    }
                }

                // Row {
                //     ColorPicker {
                //         width: 200
                //         height: 400
                //     }
                // }

                Row {
                    FAB {
                        icon: "add"
                        type: "standard"

                        onClicked: {
                            console.log("FAB clicked")
                        }
                    }
                }

                Row {
                    spacing: 16

                    Card {
                        width: 300
                        height: 200
                        type: "elevated"

                        Column {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 8

                            Text {
                                text: "Title"
                                font.pixelSize: 18
                                color: Theme.color.onSurfaceColor
                            }

                            Text {
                                text: "Some description text inside the card."
                                wrapMode: Text.Wrap
                                color: Theme.color.onSurfaceVariantColor
                            }

                            Button {
                                text: "Action"
                            }
                        }
                    }
                }

                Row {
                    spacing: 16

                    // 1. multi-browse (дефолт)
                    Carousel {
                        width: 400
                        height: 200
                        type: "multi-browse"

                        model: [
                            "https://i.ytimg.com/vi/ocO5JQownZE/maxresdefault.jpg",
                            "https://i.ytimg.com/vi/DwCca2beFmM/maxresdefault.jpg",
                            "https://i.ytimg.com/vi/JCNY1-CFQ-E/maxresdefault.jpg"
                        ]
                    }
                }

                Row {
                    spacing: 20

                    // 1. Determinate (обычный прогресс)
                    LinearProgress {
                        width: 250
                        value: 0.25
                        indeterminate: false
                        wavy: false
                    }

                    // 2. Determinate (полный прогресс)
                    LinearProgress {
                        width: 250
                        value: 0.75
                        indeterminate: false
                        wavy: false
                    }

                    // 3. Indeterminate (анимация загрузки)
                    LinearProgress {
                        width: 250
                        indeterminate: true
                        wavy: false
                    }

                    // 4. Wavy + determinate
                    LinearProgress {
                        width: 250
                        value: 0.5
                        indeterminate: false
                        wavy: true
                    }

                    // 5. Wavy + indeterminate (самый “loading-like” режим)
                    LinearProgress {
                        width: 250
                        indeterminate: true
                        wavy: true
                    }
                }

                Row {
                    spacing: 16

                    ComboBox {
                        width: 260
                        label: "Country"

                        model: [
                            { text: "Finland", value: "FI", icon: "flag" },
                            { text: "Germany", value: "DE", icon: "flag" },
                            { text: "Japan", value: "JP", icon: "flag" }
                        ]

                        onActivated: function(index) {
                            console.log("Value:", currentValue)
                        }
                    }

                    ComboBox {
                        width: 260
                        label: "Currency"

                        model: [
                            { text: "EUR", value: "€" },
                            { text: "USD", value: "$" },
                            { text: "JPY", value: "¥" }
                        ]
                    }
                }

                Row {
                    Tabs {
                        width: 400
                        height: 300

                        model: [
                            { text: "Home", icon: "home" },
                            { text: "Search", icon: "search" },
                            { text: "Settings", icon: "settings" }
                        ]

                        // вкладка 0
                        Rectangle {
                            color: "red"
                            anchors.fill: parent

                            Text {
                                anchors.centerIn: parent
                                text: "Home page"
                            }
                        }

                        // вкладка 1
                        Rectangle {
                            color: "green"
                            anchors.fill: parent

                            Text {
                                anchors.centerIn: parent
                                text: "Search page"
                            }
                        }

                        // вкладка 2
                        Rectangle {
                            color: "blue"
                            anchors.fill: parent

                            Text {
                                anchors.centerIn: parent
                                text: "Settings page"
                            }
                        }
                    }
                }

                Row {
                    DataTable {
                        width: 600
                        height: 400

                        columns: [
                            { label: "Name", role: "name", width: 200 },
                            { label: "Age", role: "age", width: 80 },
                            { label: "City", role: "city", width: 150 }
                        ]

                        rowData: [
                            { name: "Alice", age: 24, city: "Helsinki" },
                            { name: "Bob", age: 31, city: "Espoo" },
                            { name: "Charlie", age: 19, city: "Vantaa" }
                        ]
                    }
                }

                //Row {
                //    CanvasBarChart {

                //        values: [10, 20, 15, 30, 25]

                //        barColors: ["red", "green", "blue", "orange", "purple"]
                //    }
                //}

                //Row {
                //    CanvasPieChart {
                //        width: 300
                //        height: 400

                //        values: [40, 25, 20, 15]
                //        labels: ["A", "B", "C", "D"]
                //    }
                //}

                Row {
                    Rectangle {
                        width: 420
                        height: 260
                        color: "#1e1e1e"

                        CanvasLineChart {
                            anchors.fill: parent

                            values: [4, 8, 6, 10, 12, 9, 14]
                            labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

                            seriesName: "Sales"

                            showArea: true
                            showPoints: true
                        }
                    }
                }
            }
        }

        ScrollBar {
            target: flick
            orientation: Qt.Vertical
        }
    }
}
