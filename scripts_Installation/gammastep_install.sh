#!/usr/bin/bash

# Instala Gammastep
yay -S --noconfirm gammastep


# Copia el archivo de configuración
mkdir -p ~/.config/gammastep

# Crea un enlace simbólico al archivo de configuración
ln -sf ~/Hyprland-conf/gammastep/ ~/.config/gammastep/



