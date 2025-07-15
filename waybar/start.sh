#!/usr/bin/env bash

# Ruta base de temas
DIR="$HOME/.config/waybar/themes"

# Verifica que el archivo del tema actual existe
THEME_FILE="$DIR/actual_theme.txt"

if [[ ! -f "$THEME_FILE" ]]; then
    echo "❌ No se encontró el archivo: $THEME_FILE"
    exit 1
fi

# Lee el nombre del tema
THEME="$(< "$THEME_FILE")"

# Verifica que el directorio del tema existe
if [[ ! -d "$DIR/$THEME" ]]; then
    echo "❌ El tema '$THEME' no existe en $DIR"
    exit 1
fi

# Ejecuta Waybar con la configuración del tema
waybar -c "$DIR/$THEME/config.jsonc" -s "$DIR/$THEME/style.css"
