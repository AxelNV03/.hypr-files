#!/bin/bash

# Verificar dependencias
for cmd in hyprctl rofi; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: $cmd no está instalado." >&2
        exit 1
    fi
done

# Forzar detección de monitores
hyprctl reload

# Obtener nombres de los monitores
INTERNAL=$(hyprctl monitors | grep 'Monitor' | grep 'eDP' | awk '{print $2}')
EXTERNAL=$(hyprctl monitors | grep 'Monitor' | grep -v 'eDP' | awk '{print $2}' | head -n 1)

# Depuración
echo "Monitor interno: $INTERNAL"
echo "Monitor externo: $EXTERNAL"

# Verificar si se detectaron monitores
if [ -z "$INTERNAL" ]; then
    echo "Error: No se detectó el monitor interno (eDP)." >&2
    notify-send "Error" "No se detectó el monitor interno (eDP)."
    exit 1
fi
if [ -z "$EXTERNAL" ]; then
    echo "Error: No se detectó el monitor externo." >&2
    notify-send "Error" "No se detectó el monitor externo."
    exit 1
fi

# Menú de selección
choice=$(printf "Solo Laptop\nSolo Externa\nExtender\nEspejo" | rofi -dmenu -p "Pantalla")

# Verificar si se seleccionó una opción
if [ -z "$choice" ]; then
    echo "No se seleccionó ninguna opción."
    notify-send "Configuración de pantalla" "No se seleccionó ninguna opción."
    exit 0
fi

case "$choice" in
    "Solo Laptop")
        hyprctl keyword monitor "$EXTERNAL,disable"
        hyprctl keyword monitor "$INTERNAL,preferred,0x0,1"
        notify-send "Configuración de pantalla" "Modo Solo Laptop aplicado."
        ;;
    "Solo Externa")
        hyprctl keyword monitor "$INTERNAL,disable"
        hyprctl keyword monitor "$EXTERNAL,preferred,0x0,1"
        notify-send "Configuración de pantalla" "Modo Solo Externa aplicado."
        ;;
    "Extender")
        hyprctl keyword monitor "$INTERNAL,preferred,0x0,1"
        hyprctl keyword monitor "$EXTERNAL,preferred,1920x0,1"
        notify-send "Configuración de pantalla" "Modo Extender aplicado."
        ;;
    "Espejo")
        hyprctl keyword monitor "$INTERNAL,preferred,0x0,1"
        hyprctl keyword monitor "$EXTERNAL,preferred,0x0,1,mirror,$INTERNAL"
        notify-send "Configuración de pantalla" "Modo Espejo aplicado."
        ;;
esac