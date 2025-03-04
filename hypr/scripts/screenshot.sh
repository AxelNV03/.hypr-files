#!/bin/bash

# Directorio donde se guardarán las capturas
DIR="/home/$(whoami)/Imágenes/Capturas de pantalla"

#Crea el directorio si no esta
mkdir -p "$DIR"

# Nombre del archivo (puedes usar la fecha y hora para evitar sobrescribir)
FILENAME="$DIR/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

# Captura la pantalla
grim -g "$(slurp)" "$FILENAME"

# Notificación opcional (requiere dunst o similar)
notify-send "Captura guardada" "$FILENAME"

