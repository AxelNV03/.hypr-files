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

# Funcion para cambiar de Rama en Git
git_rama() {
  if [ -z "$1" ]; then
    echo "Uso: git_rama <nombre_de_rama>"
    return 1
  fi
  git checkout "$1"
}

# Funcion para crear nueva rama
git_nueva_rama() {
  if [ -z "$1" ]; then
    echo "Uso: git_nueva_rama <nombre_de_rama>"
    return 1
  fi
  git checkout dev
  git checkout -b "$1"
  git push -u origin "$1"
}

# Funcion para hacer merge
git_merge() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Uso: git_merge <rama_origen> <rama_destino>"
    return 1
  fi
  git checkout "$2" || return 1
  git merge "$1"
  if [ $? -eq 0 ]; then
    git push origin "$2"
    echo "Merge completado y push realizado."
  else
    echo "Hubo conflictos, resuélvelos antes de hacer push."
  fi
}

# Commit rápido con mensaje
git_commit() {
  if [ -z "$1" ]; then
    echo "Uso: git_commit <mensaje>"
    return 1
  fi
  git commit -am "$1"
}

# Commit + push en la rama actual
git_push() {
  git add .
  git commit -m "Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"
  git push
  echo "Push realizado en la rama $(git branch --show-current)."
}

# Pull de la rama actual
git_pull() {
  git pull origin $(git branch --show-current)
}

# restaurar commit 
last_commit() {
  git reset --hard HEAD~1
  echo "Último commit eliminado y cambios borrados."
}
