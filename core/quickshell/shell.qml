import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls   // ← Para usar Button

ShellRoot {
    id: root
    
    Window {
        id: themeSelector
        visible: true   // ← true para verlo al ejecutar
        width: 500
        height: 450
        color: "transparent"
        
        Rectangle {
            anchors.fill: parent
            radius: 16
            color: Qt.rgba(30, 30, 46, 0.95)
            border.color: "#585b70"
            border.width: 1
            
            Column {
                anchors.centerIn: parent
                spacing: 20
                
                Text {
                    text: "🎨 Theme Selector"
                    color: "#cdd6f4"
                    font.pixelSize: 22
                    font.bold: true
                }
                
                Button {
                    text: "🐣 Default"
                    onClicked: Quickshell.execDetached([
                        "bash", 
                        "~/.hypr-files/scripts/apply-profile.sh", 
                        "default"
                    ])
                }
                
                Button {
                    text: "🪟 Windows XP"
                    onClicked: Quickshell.execDetached([
                        "bash", 
                        "~/.hypr-files/scripts/apply-profile.sh", 
                        "windows_xp"
                    ])
                }
            }
        }
    }
}