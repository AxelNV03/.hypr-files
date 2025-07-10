#!/usr/bin/env bash

# Habilitar el modo estricto: si cualquier comando falla, el script se detendrá.
set -e

# Si hubo un error, el mensaje será mostrado automáticamente gracias a `set -e`
trap 'echo "❌ Ocurrió un error durante la instalación. Por favor verifica los mensajes anteriores."' ERR

# Mensaje de inicio
echo -e "\nInstalando Brave..."

# Instala la fuente de ttf-font
yay -S --noconfirm ttf-font

# Instala Brave
yay -S --noconfirm brave-bin

# Si todo está bien, el mensaje de instalación
echo "✔️ Brave se ha instalado correctamente."