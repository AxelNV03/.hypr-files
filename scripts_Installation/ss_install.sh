#!/usr/bin/env bash

# Modo estricto: si cualquier comando falla, el script se detendrá.
set -e

# Captura los errores y muestra un mensaje
trap 'echo "❌ Ocurrió un error durante la instalación."' ERR

# Mensaje de inicio
echo -e "\nInstalando y configurando Capturas de pantalla..."

# Instalación de dependencias
sudo pacman -S --noconfirm --needed grim slurp > /dev/null 2>&1

# Crear el directorio ~/Media/ss para guardar las capturas de pantalla
mkdir -p ~/Media/ss

# Mensaje de éxito
echo "✅ Capturas de pantalla instaladas y configuradas correctamente."

