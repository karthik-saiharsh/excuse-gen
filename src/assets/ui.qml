/*
'''
Author: ILLINDALA KARTHIK SAIHARSH
Version: 1.0.0
Date: 17/09/2024
license: MIT
Description: A simple app that keeps generating excuses, built using Python, Qt and the Excuser Api
'''
*/

import QtQuick
import QtQuick.Window
import Qt5Compat.GraphicalEffects

Window {
    title: "Excuse Generator"
    width: 550
    height: 420
    visible: true
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnBottomHint
    id: win
    color: "#00000000"  

    //////// Global Variables ////////
    property list<string> cat: ["All", "Family", "Office", "Children", "College", "Party", "Funny", "Unbelievable", "Developers", "Gaming"]
    property int index: 0
    property int temp: 0
    property string excuse: "";
    //////// Global Variables ////////

    // Importing Custom Fonts
    FontLoader {
        id: font_normal
        source: "font_normal.ttf"
    }

    FontLoader {
        id: font_bold
        source: "font_bold.ttf"
    }

    // Main Display Window
    Rectangle {
        id: bg
        anchors.centerIn: parent
        height: win.height - 50
        width: win.width - 50
        color: "#1c1c1e"
        radius: 30
        border.color: "#3d3d3f" 
        border.width: 1

        // TitleBar
        Rectangle {
            width: bg.width - 50
            height: 50
            color: "#00000000"
            anchors.top: bg.top
            anchors.left: bg.left
            radius: 20
            
            DragHandler {
                onActiveChanged: win.startSystemMove()
            }
        }

        // Close Button
        Text {
            text: "✕"
            font {
                family: font_bold.name
                pixelSize: 11
                bold: true
            }
            color: "#f0faef"
            anchors {
                top: bg.top
                right: bg.right
                topMargin: 15
                rightMargin: 20
            }

            MouseArea {
                anchors.fill: parent
                id: close
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: win.close()
            }

            scale: close.containsMouse ? 1.3 : 1
            Behavior on scale {NumberAnimation{duration: 350; easing.type: Easing.OutExpo}}
        }

        // Info Button
        Text {
            text: "?"
            font {
                family: font_normal.name
                pixelSize: 15
            }
            color: "#f0faef"
            anchors {
                top: bg.top
                right: bg.right
                topMargin: 13
                rightMargin: 40
            }

            MouseArea {
                anchors.fill: parent
                id: info
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: link.display_about()
            }

            scale: info.containsMouse ? 1.3 : 1
            Behavior on scale {NumberAnimation{duration: 350; easing.type: Easing.OutExpo}}
        }

        // Description
        Rectangle {
            width: bg.width
            height: 50
            anchors {
                left: bg.left
                top: bg.top
                topMargin: 50
            }
            color: "#00000000"
            
            Text {
                width: parent.width
                text: "Never run out of excuses ever again\nExcuses that keep coming"
                font {
                    family: font_normal.name
                    pixelSize: 16
                }
                horizontalAlignment: Qt.AlignHCenter
                color: "#ffffff"
            }
        }

        // Type Selector
        Rectangle {
            width: bg.width
            height: 50
            anchors {
                left: bg.left
                top: bg.top
                topMargin: 120
            }
            // color: "#00000000"
            color: "#00000000"
            
            // Back button for type
            Image {
                source: "back.svg"
                width: 18
                height: 18
                scale: back.containsMouse ? 1.3 : 1
                Behavior on scale {NumberAnimation {duration: 350; easing.type: Easing.OutExpo}}
                anchors{
                    top: parent.top
                    left: parent.left
                    leftMargin: 160
                    topMargin: 16
                }

                MouseArea {
                    id: back
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: index = index - 1 < 0 ? cat.length + index-1 : index-1;
                    
                }
            }

            Text {
                width: parent.width
                height: parent.height
                text: cat[index]
                font {
                    family: font_normal.name
                    pixelSize: 16
                }
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                color: "#ffffff"
            }

            // Next button for type
            Image {
                source: "next.svg"
                width: 18
                height: 18
                scale: next.containsMouse ? 1.3 : 1
                Behavior on scale {NumberAnimation {duration: 350; easing.type: Easing.OutExpo}}
                anchors{
                    top: parent.top
                    left: parent.left
                    leftMargin: 320
                    topMargin: 16
                }
                MouseArea {
                    id: next
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: index=(index+1)%cat.length
                    
                }
            }
        }

        // Get Excuse Button
        Rectangle {
            width: 250
            height: 35
            radius: 10
            color: "#ffffff"
            opacity: 0.85
            scale: btn.containsMouse ? 1.1 : 1
            Behavior on scale {NumberAnimation {duration: 350; easing.type: Easing.OutExpo}}
            anchors{
                left: parent.left
                top: parent.top
                leftMargin: 130
                topMargin: 180
            }

            Text {
                width: parent.width
                height: parent.height
                text: "Get Excuse"
                color: "#1c1c1e"
                font {
                    family: font_bold.name
                    pixelSize: 15
                    bold: true
                }
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter

            }

            MouseArea {
                id: btn
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {excuse="Loading...";
                link.getExcuse(cat[index]);}
            }
        }

        // Excuse Area
        Rectangle {
            width: parent.width
            height: 150
            radius: 20
            color: "#00000000"
            anchors {
                left: parent.left
                top: parent.top
                topMargin: 220
            }

            Text {
                text: excuse
                width: parent.width
                height: parent.height
                padding: 15
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                clip: true
                wrapMode: Text.WordWrap
                color: "#ffffff"
                font {
                    family: font_normal.name
                    pixelSize: 15
                }
            }
        }
    }


    // Drop Shadow for App
    RectangularGlow {
        
        anchors.fill: bg
        color: "#80000000"
        spread: 0.1
        glowRadius: 20
        cornerRadius: 30
        z: -1
        
    }

    Connections{
        //enabled: bool
        //ignoreUnknownSignals: bool
        target: link
    }
}
