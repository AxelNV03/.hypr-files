#!/usr/bin/env bash

# Modo estricto: si cualquier comando falla, el script se detendrá.
set -euo pipefail

# Captura los errores y muestra un mensaje
trap 'echo "❌ Ocurrió un error durante la instalación."' ERR

# Mensaje de inicio
echo -e "\nInstalando Waybar..."

# Instala las fuentes y emojis para Waybar
yay -S --noconfirm waybar nerd-fonts noto-fonts-emoji ttf-font-awesome > /dev/null 2>&1

# Rutas
SOURCE=~/.hypr-files/waybar
DEST=~/.config/waybar

# Eliminar configuración previa (si existe)
if [ -e "$DEST" ]; then
    echo "⚠️ Eliminando configuración previa en $DEST..."
    rm -rf "$DEST"
fi

# Crear directorio padre por si no existe
mkdir -p "$(dirname "$DEST")"

# Crear enlace simbólico
ln -s "$SOURCE" "$DEST"

echo -e "✔️ Waybar se ha instalado y configurado correctamente.\n"