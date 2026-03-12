# Buscar archivos con esteroides (muestra detalles)
searchfile() {
  find "${2:-.}" -type f -iname "*$1*" -ls
}

# Git Commit Simplificado
gcom() {
     if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
          echo "❌ No es un repo Git."
          return 1
     fi
     
     if [ -z "$1" ]; then
          echo "❌ Uso: gcom \"mensaje\""
          return 1
     fi
     
     git add -A
     git commit -m "$1"
}

# Git Push Inteligente (con pull previo para evitar rebotes)
gpush() {
     local current_branch=$(git rev-parse --abbrev-ref HEAD)
     
     # Si pasas un argumento, lo usamos como mensaje de commit
     if [ -n "$1" ]; then
          gcom "$1" || return 1
     fi

     echo "Syncing con el remoto antes de subir..."
     git pull --rebase origin "$current_branch"
     
     echo "🚀 Subiendo a '$current_branch'..."
     git push origin "$current_branch"
}

# Crear un Hotspot Wi-Fi (Banda de 5GHz por defecto para velocidad)
# Uso: red <SSID> <contraseña>
red() {    
     # 1. Detectar el nombre de la interfaz wifi automáticamente (ej. wlan0)
     local DISPOSITIVO=$(nmcli -t -f DEVICE,TYPE device status | grep ":wifi$" | cut -d: -f1 | head -n 1)

     if [ -z "$DISPOSITIVO" ]; then
          echo "❌ Error: No se detectó ninguna tarjeta Wi-Fi activa."
          return 1
     fi

     if [ -z "$1" ] || [ -z "$2" ]; then
          echo "⚠️  Uso: red <SSID> <contraseña>"
          return 1
     fi

     # 2. Reiniciar NetworkManager con elegancia
     echo -n "🔄 Reiniciando NetworkManager..."
     sudo systemctl restart NetworkManager
     
     # Bucle corto para esperar a que el servicio esté listo (máx 5 seg)
     for i in {1..5}; do
          if nmcli general status | grep -q "running"; then break; fi
          sleep 1
     done
     echo " ¡Listo!"

     # 3. Desconectar de la red actual si está ocupado
     if nmcli device status | grep -q "^$DISPOSITIVO.*conectado"; then
          echo "🔌 Liberando $DISPOSITIVO..."
          nmcli device disconnect "$DISPOSITIVO" > /dev/null
          sleep 2
     fi

     # 4. Crear el Hotspot
     # Nota: 'band a' es 5GHz (rápido). Si falla en dispositivos viejos, usa 'band bg' (2.4GHz)
     echo "🛰️  Lanzando Hotspot: '$1'..."
     if nmcli device wifi hotspot ifname "$DISPOSITIVO" band a ssid "$1" password "$2"; then
          echo "✅ Hotspot activo. ¡Tu ThinkPad ahora es un router!"
     else
          echo "❌ Falló la creación del Hotspot. Intentando en banda 2.4GHz..."
          nmcli device wifi hotspot ifname "$DISPOSITIVO" band bg ssid "$1" password "$2"
     fi
}

dkinfo() {
    echo -e "\n\e[1;34m--- CONTAINERS ---\e[0m"
    docker ps -a

    echo -e "\n\e[1;32m--- IMAGES ---\e[0m"
    docker images

    echo -e "\n\e[1;33m--- VOLUMES ---\e[0m"
    docker volume ls

    echo -e "\n\e[1;35m--- NETWORKS (User defined) ---\e[0m"

     # Filtra las redes por defecto (bridge, host, none) y el ID de red para que sea scannable
     docker network ls | awk '$2 !~ /^(bridge|host|none)$/'
     echo ""
}

# 🚪 Entrar a la CLI de MariaDB rápido
# Uso: dkin mariadb-protecmor
dkin() {
    docker exec -it "$1" mariadb -u nava -p
}

