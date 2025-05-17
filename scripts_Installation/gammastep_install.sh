#!/usr/bin/env bash

# Instala Gammastep
yay -S --noconfirm gammastep

# Rutas
SOURCE=~/Hyprland-conf/gammastep
DEST=~/.config/gammastep

# Elimina cualquier configuración previa (carpeta o symlink)
[ -e "$DEST" ] && rm -rf "$DEST"

# Crea el enlace simbólico
ln -s "$SOURCE" "$DEST"

# Mensaje final
echo "✔️ Gammastep se ha instalado y configurado correctamente."
