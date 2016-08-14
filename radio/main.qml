import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Pickers 1.3
import Qt.labs.settings 1.0
import QtQuick.LocalStorage 2.0
import QtMultimedia 5.4
import "db.js" as DB

MainView {
    objectName: "mainView"
    applicationName: "radio"


    width: units.gu(100)
    height: units.gu(75)
    theme.name: "Ubuntu.Components.Themes.SuruDark"

    PageStack {
        id: mainStack
        Component.onCompleted: {
            push(tabs)
        }
    }
    Tabs {
        id: tabs
        Tab {
            id: main
            title: "Radio"


            Page {
                id: rootPage



                Settings {
                    id: settings
                    property string state: "false"
                }


                Column {
                    id: col1
                    spacing: units.gu(1)
                    anchors {
                        margins: units.gu(2)
                        fill: parent
                    }


                    ListModel {
                        id: dbprimary

                        Component.onCompleted: {
                            DB.jobDB()
                            restartdb.start()
                        }
                    }


                    Timer {
                        id: restartdb
                        interval: 5000; triggeredOnStart: true; running: true; repeat: true
                        onTriggered: {
                            if (settings.state !== "true") {
                                dbprimary.clear()
                                DB.jobDB()
                                settings.state = "false"
                            }
                        }
                    }


                    OptionSelector {
                        id:os1
                        containerHeight: parent.height - col2.height *2 - units.gu(2)
                        text: i18n.tr("Select a stantion:")
                        model: dbprimary
                        expanded: false
                        delegate: OptionSelectorDelegate { text: name }
                    }

                    Label {
                        text: (" ")
                    }

                    Label {
                        id:describe
                        font.pixelSize: units.gu(1.8)
                        width: parent.width
                        anchors.horizontalCenter:parent.horizontalCenter
                        text: {Text:describe}
                    }

                    Label {
                        text: (" ")
                    }
                    Label {
                        id: playsource
                        font.pixelSize: units.gu(1.8)
                        width: parent.width
                        anchors.horizontalCenter:parent.horizontalCenter
                        text: ""
                    }


                    Label {
                        id: volumes
                        anchors.left: parent.left
                    }
                    Slider {
                        function formatValue(v) {
                            volumes.text='Volumes '+v.toFixed(1)
                          //  var channel = os1.selectedIndex;
                            //DB.lightradio(v.toFixed(0), channel)
                            mediaPlayer.volume(v.toFixed(0))
                            return
                        }
                        minimumValue: 0
                        maximumValue: 1
                        value: 0.3
                        live: true
                    }

                    MediaPlayer {

                        id: mediaPlayer
                        source: ""
                        volume : 1
                        property string title: !!metaData.title ?
                                                   qsTr("%1").arg(metaData.title) :
                                                   metaData.title


                    }


                }
                Column{
                    id: col2
                    spacing: units.gu(1)
                    anchors {
                        margins: units.gu(2)
                        bottom: parent.bottom
                        left: parent.left
                        right: parent.right
                    }


                    Row{
                        spacing: units.gu(2)
                        anchors.horizontalCenter:parent.horizontalCenter

                        Button{
                            id: light
                            color: "#068706"
                            width: units.gu(14)
                            height: units.gu(6)
                            text: i18n.tr("On")
                            onClicked:{
                                var channel = os1.selectedIndex;
                                // col2.radioChannel(channel);
                                describe.text = dbprimary.get(channel).descripcion
                                if (settings.state !== "false") {
                                    light.text=i18n.tr("Pause")
                                    playsource.text = mediaPlayer.title

                                    mediaPlayer.source = dbprimary.get(channel).ip
                                    mediaPlayer.play()

                                    settings.state = "false"
                                    //stat.text = i18n.tr("Off")
                                    // console.log('off')

                                }
                                else  {
                                    light.text=i18n.tr("Play")
                                    mediaPlayer.stop();
                                    settings.state = i18n.tr("true")

                                    //stat.text = i18n.tr("On")
                                    //   console.log('on')

                                }
                            }
                        }


                    }
                }
            }
        }


        Tab {
            id: options
            title: i18n.tr("Add stantion")
            page: Loader {
                parent: config
                anchors.fill: parent
                source: (tabs.selectedTab === options) ? Qt.resolvedUrl("option.qml") : ""
            }
        }

        Tab {
            id: edit
            title: i18n.tr("Edit radio")
            page: Loader {
                parent: edit
                anchors.fill: parent
                source: (tabs.selectedTab === edit) ? Qt.resolvedUrl("radio_add.qml") : ""
            }

        }

        Tab {
            id: about
            title: i18n.tr("About")
            page: Loader {
                parent: config
                anchors.fill: parent
                source: (tabs.selectedTab === about) ? Qt.resolvedUrl("about.qml") : ""
            }
        }

    }
}
