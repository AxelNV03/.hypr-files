#!/usr/bin/env bash
# =====================================================================
#     CHANGE-WALLPAPER — Cambia el wallpaper y regenera colores
#     Uso: change-wallpaper.sh <wallpaper> [prefer]
#     Ejemplo: change-wallpaper.sh wp01 darkness
# =====================================================================

set -euo pipefail

# Rutas
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.hypr-files}"
WALLPAPERS_PATH="$DOTFILES_DIR/wallpapers"

# Validar argumento
WALLPAPER="${1:-}"
PREFER="${2:-}"


if [ -z "$WALLPAPER" ]; then
    echo "Error: Debes indicar un wallpaper (ej: $0 wp01)" >&2
    exit 1
fi

# Buscar el archivo con cualquier extensión
TARGET_FILE="$(find "$WALLPAPERS_PATH" -maxdepth 1 -type f -name "$WALLPAPER.*" -print -quit)"

if [ -z "$TARGET_FILE" ]; then
    echo "Error: No se encontró ningún wallpaper '$WALLPAPER' en $WALLPAPERS_PATH" >&2
    exit 1
fi

# Extraer extensión
EXT="${TARGET_FILE##*.}"

# 1. Borrar wallpaper anterior y copiar el nuevo
rm -f "$HOME/.config"/wallpaper.* 2>/dev/null || true
cp "$TARGET_FILE" "$HOME/.config/wallpaper.$EXT"
echo "✅ Wallpaper: $(basename "$TARGET_FILE") → ~/.config/wallpaper.$EXT"

# 2. Reiniciar hyprpaper
pkill hyprpaper 2>/dev/null || true
sleep 0.3
hyprpaper -c "$HOME/.config/hypr/hyprpaper.conf" &>/dev/null &
disown
echo "✅ Hyprpaper reiniciado"

# 3. Generar colores
if command -v matugen &>/dev/null; then
    if [ -n "$PREFER" ]; then
        matugen image "$HOME/.config/wallpaper.$EXT" --prefer "$PREFER"
        echo "✅ Colores regenerados (prefer: $PREFER)"
    else
        matugen image "$HOME/.config/wallpaper.$EXT" --prefer darkness
        echo "✅ Colores regenerados"
    fi
fi
# matugen image wallpaper.jpg --prefer {{ SCHEMA }}
# --prefer darkness	El color más oscuro
# --prefer lightness	El color más claro
# --prefer saturation	El color más saturado
# --prefer less-saturation	El menos saturado
# --prefer value	El de mayor valor (brillo)
# --prefer closest-to-fallback	Cercano a un color de referencia