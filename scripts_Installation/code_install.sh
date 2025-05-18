#!/usr/bin/env bash

# Modo estricto: si cualquier comando falla, el script se detendrá.
set -e

# Captura los errores y muestra un mensaje
trap 'echo "❌ Ocurrió un error durante la instalación."' ERR

# Mensaje de inicio
echo -e "\nInstalando y configurando Vscode..."

# Instalación de dependencias
sudo pacman -S --noconfirm visual-studio-code-bin > /dev/null 2>&1

# Mensaje de éxito
echo "✅ Vscode instalado y configurado correctamente."