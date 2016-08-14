import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.0 as ListItem
import QtQuick.LocalStorage 2.0
import "db.js" as DB

Page {
    id: pageAdd


    title: i18n.tr("Add station")
    Flickable {
        id: flickable

        anchors.fill: parent
        contentHeight: parent.height + units.gu(2)
        contentWidth: parent.width

        Column {
            id: columnSuperior

            spacing: units.gu(1)
            anchors {
                topMargin: units.gu(5)
                margins: units.gu(2)
                fill: parent
            }

            Label {
                text: i18n.tr("Write the name of the radio of station:")
            }

            TextField {
                id: name
                errorHighlight: false
                width: parent.width
                height: units.gu(4)
                font.pixelSize: FontUtils.sizeToPixels("medium")
                text: i18n.tr("RockFM")
            }
            Label {
                text: i18n.tr("Enter the ip of the radio of station:")
            }

            TextField {
                id: ip
                errorHighlight: false
                width: parent.width
                height: units.gu(4)
                font.pixelSize: FontUtils.sizeToPixels("medium")
                text: i18n.tr("http://nashe1.hostingradio.ru/rock-128.mp3")
            }


            Label {
                text: i18n.tr("Write a short description:")
            }

            TextArea {
                id: descripcion
                width: parent.width
                height: units.gu(8)
                font.pixelSize: FontUtils.sizeToPixels("medium")
                text: ''
            }
            Button {
                id: save
                width: parent.width
                text: i18n.tr("Save station")
                onClicked: {
                    DB.insert(name.text, ip.text, descripcion.text)
                    save.text = i18n.tr("Station saved")
                }
            }

        }
    }
}
