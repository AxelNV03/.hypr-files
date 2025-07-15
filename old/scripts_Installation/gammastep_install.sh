#!/usr/bin/env bash

# Modo estricto: si cualquier comando falla, el script se detendrá.
set -e

# Captura los errores y muestra un mensaje
trap 'echo "❌ Ocurrió un error durante la instalación."' ERR

# Mensaje de inicio
echo -e "\nInstalando Gammastep..."

# Instala Gammastep
yay -S --noconfirm gammastep > /dev/null 2>&1

# Rutas
SOURCE=~/Hyprland-conf/gammastep/
DEST=~/.config/

# Elimina cualquier configuración previa (carpeta o symlink)
[ -e "$DEST" ] && rm -rf "$DEST" > /dev/null 2>&1

# Crea el enlace simbólico
ln -s "$SOURCE" "$DEST"

# Mensaje final
echo "✔️ Gammastep se ha instalado y configurado correctamente."
