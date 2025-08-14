# Función para buscar archivos por nombre (insensible a mayúsculas)
 # $1 = cadena a buscar, $2 = ruta (opcional, por defecto .)
searchfile() {
  find "${2:-.}" -type f -iname "*$1*"
}

# Crear un Hotspot Wi-Fi
# $1 = SSID, $2 = contraseña
red() {    
    DISPOSITIVO=$(nmcli device status | grep wifi | grep -v disconnected | awk '{print $1}' | head -n 1)

    # verifica que no haya argumentos vacíos
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Uso: red <SSID> <contraseña>"
        return 1
    fi

    # Reinicia el NetworkManager
    echo -e "\nReiniciando NetworkManager..."
    sudo systemctl restart NetworkManager > /dev/null 2>&1 || {
        echo "Error reiniciando NetworkManager"
        return 1
    }

    # Espera un momento para asegurarse de que el servicio esté activo
    sleep 5

    # Verifica si el dispositivo está conectado a una red Wi-Fi
    if nmcli device status | grep -q "^$DISPOSITIVO *wifi *conectado"; then
        echo "Desconectando $DISPOSITIVO..."
        nmcli device disconnect "$DISPOSITIVO"
    else
        echo "$DISPOSITIVO no está conectado."
    fi

    sleep 5

    # Crea el Hotspot Wi-Fi
    echo -e "\nCreando Hotspot con SSID '$1'..."
    nmcli device wifi hotspot ifname "$DISPOSITIVO" band a ssid "$1" password "$2" || {
        echo "Error creando el hotspot"
        return 1
    }

    echo "Hotspot creado correctamente."
}

