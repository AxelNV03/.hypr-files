#!/usr/bin/env bash

# Instala WhatsApp
yay -S --noconfirm whatsapp-nativefier > /dev/null 2>&1

# Asigna permisos de ejecución a la app
sudo chmod g=rx /opt/whatsapp-nativefier
sudo chmod o=rx /opt/whatsapp-nativefier

# Mensaje final
echo "✔️ WhatsApp se ha instalado y configurado correctamente."
