#!/bin/bash
# Script para capturar un área de la pantalla con grim y slurp

# Crear la carpeta si no existe
mkdir -p ~/Media/ss

# Contar cuántas capturas .png hay en ~/Media/ss
count=$(ls ~/Media/ss/*.png 2>/dev/null | wc -l)
next=$((count + 1))

# Seleccionar un área de la pantalla usando slurp
area=$(slurp)

# Usar grim para capturar la selección
grim -g "$area" ~/Media/ss/screenshot_$next.png

echo "Captura de pantalla guardada como screenshot_$next.png en ~/Media/ss/"
