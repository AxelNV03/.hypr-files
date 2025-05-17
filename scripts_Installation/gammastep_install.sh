#!/usr/bin/bash

# Instala Gammastep
yay -S --noconfirm gammastep

# Borra el directorio de configuración si existe
if [ -d ~/.config/gammastep ]; then
    rm -rf ~/.config/gammastep
fi

# crea el directorio de configuración
mkdir -p ~/.config/gammastep

# Crea un enlace simbólico al archivo de configuración
ln -sf ~/Hyprland-conf/gammastep/ ~/.config/gammastep/



