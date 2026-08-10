// ~/.hyprland-dotfiles/core/quickshell/shell.qml
import QtQuick
import quickshell

Shell {
    // Aquí es donde cargaremos nuestros componentes o mini-apps más adelante
    
    // Una ventana flotante de prueba
    VariantsWindow {
        id: mainWidget
        title: "Mi Mini App"
        
        // Configuraciones de Wayland a través de Quickshell
        WlrLayershell.layer: WlrLayershell.Layer.Top
        WlrLayershell.namespace: "quickshell-widget"
        
        width: 350
        height: 500
        
        // Cargamos el diseño visual que está en la carpeta de designs
        Loader {
            id: designLoader
            anchors.fill: parent
            // Apuntamos al archivo de diseño actual
            source: "../../designs/quickshell/default/main.qml"
        }
    }
}