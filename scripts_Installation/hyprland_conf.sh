#!/usr/bin/env bash

# Modo estricto: si cualquier comando falla, el script se detendrá.
set -e

# Captura los errores y muestra un mensaje
trap 'echo "❌ Ocurrió un error durante la configuración."' ERR

# Mensaje de inicio
echo -e "\nConfigurando Hyprland..."

# Rutas
SOURCE=~/Hyprland-conf/hypr
DEST=~/.config/hypr

# Elimina cualquier configuración previa (carpeta o symlink)
[ -e "$DEST" ] && rm -rf "$DEST" > /dev/null 2>&1

# Crea el enlace simbólico
ln -s "$SOURCE" "$DEST"

# Le da permisos de ejecución a los scripts
chmod +x ~/Hyprland-conf/hypr/scripts/*.sh

# Mensaje final
echo "✔️ Configuración de Hyprland completada."