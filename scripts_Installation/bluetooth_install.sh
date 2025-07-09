#!/usr/bin/env bash

# Modo estricto: si cualquier comando falla, el script se detendrá.
set -e

# Captura los errores y muestra un mensaje
trap 'echo "❌ Ocurrió un error durante la instalación."' ERR

# Mensaje de inicio
echo -e "\nInstalando y configurando Bluetooth..."

# Instala Bluetooth
yay -S --noconfirm bluez blueman > /dev/null 2>&1

# Mensajes final
echo "✔️ Bluetooth se ha instalado y configurado correctamente."
