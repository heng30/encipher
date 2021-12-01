import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
  property real fontPixel: 20
  id: topLayout
  visible: true
  x: (Screen.desktopAvailableWidth - width) / 2
  y: (Screen.desktopAvailableHeight - height) / 2
  width: 800
  height: 600
  flags: Qt.Dialog
  title: qsTr("Cencipheror")

  Column {
    anchors.fill: parent
    spacing: 10

    Keys.onEscapePressed: Qt.quit()

    Rectangle {
      id: topField
      width: parent.width
      height: 40

      Row {
        anchors.fill: parent
        anchors {
          leftMargin: 5
          rightMargin: 5
          topMargin: 5
        }
        spacing: 5

        Rectangle {
          width: parent.width - encrypt.width - decrypt.width - 2 * parent.spacing
          height: parent.height
          color: "transparent"
          border.width: 1
          border.color: "lightblue"

          ScrollView {
            anchors.fill: parent
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            TextArea {
              id: passwd
              leftPadding: 5
              focus: true
              font.pixelSize: topLayout.fontPixel
              cursorVisible: true
              selectByMouse: true
              verticalAlignment: TextEdit.AlignVCenter
              mouseSelectionMode: TextEdit.SelectWords
              wrapMode: TextEdit.Wrap
              placeholderText: qsTr("输入密码")

              Keys.onTabPressed: input.forceActiveFocus()
              Component.onCompleted: forceActiveFocus()
            }
          }
        }

        Button {
          id: encrypt
          height: parent.height
          font.pixelSize: topLayout.fontPixel
          text: qsTr("加密")
          onClicked: {
            encipheror.setPasswd(passwd.text)
            var flag = encipheror.verify(input.text)
            if (!flag) {
              output.text = qsTr("程序内部问题，无法加解密！！！")
              return
            }

            output.text = encipheror.encrypt(input.text)
          }
        }

        Button {
          id: decrypt
          height: parent.height
          font.pixelSize: topLayout.fontPixel
          text: qsTr("解密")
          onClicked: {
            encipheror.setPasswd(passwd.text)
            if (!encipheror.validEncryptText(input.text)) {
              output.text = qsTr("非法解密文本！！！")
              return
            }

            output.text = encipheror.decrypt(input.text)
          }
        }
      }
    }

    Rectangle {
      id: inputRect
      width: parent.width
      height: (parent.height - topField.height - parent.spacing * 2) / 2
      color: "transparent"
      border.width: 5
      border.color: "lightgray"

      ScrollView {
        anchors.fill: parent
        anchors.margins: 5
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        TextArea {
          id: input
          leftPadding: 5
          font.pixelSize: topLayout.fontPixel
          selectByMouse: true
          mouseSelectionMode: TextEdit.SelectWords
          wrapMode: TextEdit.Wrap
          placeholderText: qsTr("输入...")
        }
      }
    }

    Rectangle {
      id: outputRect
      width: parent.width
      height: inputRect.height
      color: "transparent"
      border.width: 5
      border.color: "lightgray"

      ScrollView {
        anchors.fill: parent
        anchors.margins: 5
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        TextArea {
          id: output
          font.pixelSize: topLayout.fontPixel
          selectByMouse: true
          mouseSelectionMode: TextEdit.SelectWords
          wrapMode: TextEdit.Wrap
          placeholderText: qsTr("输出...")
        }
      }
    }
  }
}
