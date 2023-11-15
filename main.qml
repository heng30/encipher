import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

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
    anchors.margins: 5
    spacing: 10

    Keys.onEscapePressed: Qt.quit()

    Rectangle {
      id: topField
      width: parent.width
      height: 40

      Row {
        anchors.fill: parent
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
              placeholderText: qsTr("请输入密码")

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
            encipher.setPasswd(passwd.text)
            var flag = encipher.verify(input.text)
            if (!flag) {
              output.text = qsTr("程序内部问题，无法加解密！！！")
              return
            }

            output.text = encipher.encrypt(input.text)
          }
        }

        Button {
          id: decrypt
          height: parent.height
          font.pixelSize: topLayout.fontPixel
          text: qsTr("解密")
          onClicked: {
            encipher.setPasswd(passwd.text)
            if (!encipher.validEncryptText(input.text)) {
              output.text = qsTr("非法解密文本！！！")
              return
            }

            output.text = encipher.decrypt(input.text)
          }
        }
      }
    }

    Rectangle {
      id: inputRect
      width: parent.width
      height: (parent.height - topField.height - parent.spacing * 2) / 2
      color: "transparent"
      border.width: 1
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
          placeholderText: qsTr("请输入明文...")
        }
      }
    }

    Rectangle {
      id: outputRect
      width: parent.width
      height: inputRect.height
      color: "transparent"
      border.width: 1
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
          placeholderText: qsTr("输出的密文")
          readOnly: true
        }
      }
    }
  }
}
