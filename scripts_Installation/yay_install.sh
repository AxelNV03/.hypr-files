#!/usr/bin/env bash

# Clona el repositorio de yay
git clone https://aur.archlinux.org/yay.git > /dev/null 2>&1

# Cambia al directorio de yay
cd yay

# Instala yay
makepkg -si --noconfirm > /dev/null 2>&1

# Sale y borra el directorio
cd ..
sudo rm -rf yay > /dev/null 2>&1

# Muestra el mensaje de instalación
echo "✔️ Yay ha sido instalado correctamente."