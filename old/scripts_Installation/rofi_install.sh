#!/usr/bin/env bash

# Modo estricto: si cualquier comando falla, el script se detendrá.
set -e

# Captura los errores y muestra un mensaje
trap 'echo "❌ Ocurrió un error durante la instalación."' ERR

# Mensaje de inicio
echo -e "\nInstalando y configurando Rofi..."

# Instala Rofi
yay -S --noconfirm rofi > /dev/null 2>&1

# Rutas
SOURCE=~/Hyprland-conf/rofi
DEST=~/.config/rofi

# Elimina cualquier configuración previa (carpeta o symlink)
[ -e "$DEST" ] && rm -rf "$DEST" > /dev/null 2>&1

# Crea el enlace simbólico
ln -s "$SOURCE" "$DEST"

# Elimina wofi
yay -Rns --noconfirm wofi > /dev/null 2>&1

# Mensaje final
echo "✔️ Rofi se ha instalado y configurado correctamente."