#!/usr/bin/env bash

# Modo Seguro
set -e

# Mensaje de error
trap 'echo "❌ Ocurrió un error durante la instalación."' ERR

# Mensaje de inicio
echo -e "\nInstalando y configurando SwayNC..."

# Istala swaync
yay -S --noconfirm swaync > /dev/null 2>&1

# Rutas
SOURCE=~/Hyprland-conf/swaync
DEST=~/.config/swaync

# Elimina cualquier configuración previa (carpeta o symlink)
[ -e "$DEST" ] && rm -rf "$DEST" > /dev/null 2>&1

# Crea el enlace simbólico
ln -s "$SOURCE" "$DEST"

# Mensaje final
echo "✔️ SwayNC se ha instalado y configurado correctamente."

