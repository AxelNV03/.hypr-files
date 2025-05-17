#!/usr/bin/env bash

# Clona el repositorio de yay
git clone https://aur.archlinux.org/yay.git

# Cambia al directorio de yay
cd yay

# Instala yay
makepkg -si --noconfirm

# Sale y borra el directorio
cd ..
sudo rm -rf yay

# Muestra el mensaje de instalación
sleep 3
echo "yay ha sido instalado correctamente."