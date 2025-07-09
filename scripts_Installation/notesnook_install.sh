#!/usr/bin/env bash

# Modo estricto: si cualquier comando falla, el script se detendrá.
set -e

# Captura los errores y muestra un mensaje
trap 'echo "❌ Ocurrió un error durante la instalación."' ERR

# Mensaje de inicio
echo -e "\nInstalando notesnook..."

# Instala notesnook
yay -S --noconfirm notesnook-bin > /dev/null 2>&1

# Mensaje de instalación
echo "✔️ notesnook se ha instalado correctamente."