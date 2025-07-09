#!/usr/bin/env bash

# Modo estricto: si cualquier comando falla, el script se detendrá.
set -e

# Captura los errores y muestra un mensaje
trap 'echo "❌ Ocurrió un error durante la instalación."' ERR

# Mensaje de inicio
echo -e "\nInstalando Waybar..."

# Instala Waybar
yay -S --noconfirm waybar > /dev/null 2>&1

# Instala las fuentes y emojis para Waybar
yay -S --noconfirm nerd-fonts noto-fonts-emoji ttf-font-awesome > /dev/null 2>&1

# Rutas
SOURCE=~/Hyprland-conf/waybar
DEST=~/.config/waybar

# Elimina cualquier configuración previa (carpeta o symlink)
[ -e "$DEST" ] && rm -rf "$DEST" > /dev/null 2>&1

# Crea el enlace simbólico
ln -s "$SOURCE" "$DEST"

# Mensaje final
echo "✔️ Waybar se ha instalado correctamente."
