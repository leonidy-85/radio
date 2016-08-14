import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.0 as ListItem
import Ubuntu.Components.Popups 1.3


Page {
    id: pageAbout
    title: ("О программе")


    Column {
        id: column

        spacing: units.gu(1)
        anchors {
            topMargin: units.gu(4)
            margins: units.gu(2)
            fill: parent
        }
        Image {
            id: image1
            anchors.horizontalCenter: parent.horizontalCenter
            width: 200
            height: 183
            source: "radio.png"
        }

//        Label {
//            text: (" ")
//        }
        Label {
            text: (" ")
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n.tr("Radio")
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n.tr("v0.1.1")
        }


        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n.tr("leonidy85@gmail.com")
        }


        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n.tr("2016")
        }
        Label {
            text: (" ")
        }
        Button {
            text: "PayPal RUB"
            width: 300
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                Qt.openUrlExternally("https://www.paypal.me/darbuka")
            }
        }

    }

}

