import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 640
    title: qsTr("Cencipheror")


    Column {
        anchors.fill: parent
        spacing: 10

        Rectangle {
            id: inputRec
            width: parent.width
            height: (parent.height - parent.spacing - buttonField.height) / 2
            color: "transparent"
            border.width: 10
            border.color: "lightgray"

            TextEdit {
                id: input
                anchors.fill: parent
                anchors.margins: 15
                text: qsTr("Enter some text...")
            }
         }

        Rectangle {
            width: parent.width
            height: inputRec.height
            color: "transparent"
            border.width: 10
            border.color: "lightgray"

            TextEdit {
                id: output
                anchors.fill: parent
                anchors.margins: 15
                text: qsTr("Enter some text...")
            }
         }

        Row {
            id: buttonField
            width: parent.width
            height: 30
        }

    }
}
