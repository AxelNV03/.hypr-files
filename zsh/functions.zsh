#!/bin/zsh

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

# Función para hacer commit en un proyecto Git específico
gcom() {
     # 1. Verifica que el directorio actual sea un repositorio de Git.
     if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
          echo "❌ Error: No estás en un repositorio de Git."
          return 1
     fi
     
     # 2. Verifica que se haya pasado un mensaje de commit.
     if [ -z "$1" ]; then
          echo "❌ Error: Se necesita un mensaje para el commit."
          echo "Uso correcto: gcom \"Este es mi mensaje\""
          return 1
     fi
     
     # 3. Ejecuta los comandos en el directorio actual.
     echo "📂 Realizando commit en el proyecto actual..."
     git add -A
     git commit -m "$1"
     
     echo "✅ ¡Commit realizado con éxito!"
}


# Función para hacer push en un proyecto Git específico, con opción de commit previo
# $1 = nombre de la rama, $2 = mensaje de commit opcional
gpush() {
     # 1. Verifica que estés en un repositorio de Git.
     if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
          echo "❌ Error: No estás en un repositorio de Git."
          return 1
     fi
     
     # 2. OBTENER EL NOMBRE DE LA RAMA ACTUAL AUTOMÁTICAMENTE.
     local current_branch=$(git rev-parse --abbrev-ref HEAD)
     
     # 3. Si existe un mensaje de commit (AHORA ES $1), llama a gcom.
     if [ -n "$1" ]; then
          echo "💬 Mensaje detectado. Haciendo commit primero..."
          gcom "$1"
          if [ $? -ne 0 ]; then
          echo "❌ Error durante el push de la rama $current_branch. Proceso cancelado."
          return 1
          fi
     fi
     
     # 4. Ejecuta el push USANDO LA RAMA DETECTADA.
     echo "🚀 Realizando push a la rama actual ('$current_branch')..."
     git push origin "$current_branch"
     
     echo "✅ ¡Push completado con éxito!"
}
