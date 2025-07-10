#!/usr/bin/env bash

# Modo estricto: si cualquier comando falla, el script se detendrá.
set -e

# Captura los errores y muestra un mensaje
trap 'echo "❌ Ocurrió un error durante la instalación."' ERR

# Mensaje de inicio
echo -e "\nInstalando WhatsApp..."

# Instala WhatsApp
yay -S --noconfirm whatsapp-nativefier > /dev/null 2>&1

# Asigna permisos de ejecución a la app
sudo chmod g=rx /opt/whatsapp-nativefier
sudo chmod o=rx /opt/whatsapp-nativefier

# Mensaje final
echo "✔️ WhatsApp se ha instalado y configurado correctamente."
