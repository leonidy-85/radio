import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.0 as ListItem
import Ubuntu.Components.Popups 0.1
import QtQuick.LocalStorage 2.0
import "db.js"  as DB

Page {
    id: pageradio
    title: i18n.tr("Manager Radio")


    property string name
    property string ip
    property string descripcion

    head.actions: [
        Action {
            iconName: "delete"
            onTriggered: {
                PopupUtils.open(dialog)
            }
            text: i18n.tr("Delete")
        }

    ]


    Item {
        Component {
        id: dialog
            Dialog {
                id: dialogs
                title: i18n.tr("Do you want to delete the") + " " + name + " " + i18n.tr("?")
                Button {
                    text: i18n.tr("Accept")
                    color: "green"
                    onClicked: {
                    DB.del(name)
                    PopupUtils.close(dialogs)
                    bguradar.text = i18n.tr("Radio has been deleted")
                    names.text = " "
                    ips.text = " "
                    txdescripcion.text = " "
                    }
                }
                Button {
                    text: i18n.tr("Cancel")
                    color: "red"
                    onClicked: PopupUtils.close(dialogs)
                }
            }
        }
    }

    Flickable {
        id: flickable

        anchors.fill: parent
        contentHeight: parent.height + units.gu(2)
        contentWidth: parent.width

        ListItem.Header {
            text: i18n.tr("Configure your radio")
        }

        Column {
            id: columnSuperior

            spacing: units.gu(1)
            anchors {
                topMargin: units.gu(4)
                margins: units.gu(2)
                fill: parent
            }

            Label {
                text: " "
            }

            Label {
                text: i18n.tr("radio name:")
            }

            TextField {
                id: names
                errorHighlight: false
                width: parent.width
                height: units.gu(4)
                font.pixelSize: FontUtils.sizeToPixels("medium")
                text: name
            }


            TextField {
                id: ips
                errorHighlight: false
                width: parent.width
                height: units.gu(4)
                font.pixelSize: FontUtils.sizeToPixels("medium")
                text: ip
            }


            Label {
                text: i18n.tr("Description:")
            }

            TextArea {
                id: txdescripcion
                width: parent.width
                height: units.gu(8)
                font.pixelSize: FontUtils.sizeToPixels("medium")
                text: descripcion
            }

            Button {
                id: save
                width: parent.width
                text: i18n.tr("Save station")
                onClicked: {
                    DB.del(name)
                    DB.insert(names.text, ips.text, txdescripcion.text)
                    save.text = i18n.tr("Changes has been saved")
                    settings.state = "true"
                }
            }

            ListItem.Header {
            }

            Label {
                id: info
                width: parent.width
                text: ""
            }
        }
    }
}


