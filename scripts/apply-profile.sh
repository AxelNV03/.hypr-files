#!/usr/bin/env bash
# =====================================================================
#     APPLY-PROFILE — Aplica una receta desde profiles/*.toml
#     Uso: apply-profile.sh <perfil>
# =====================================================================

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.hypr-files}"
PROFILE="$1"

if [ -z "$PROFILE" ]; then
    echo "❌ Uso: apply-profile.sh <perfil>" >&2
    exit 1
fi

PROFILE_FILE="$DOTFILES_DIR/profiles/$PROFILE.toml"
if [ ! -f "$PROFILE_FILE" ]; then
    echo "❌ Perfil '$PROFILE' no encontrado" >&2
    exit 1
fi

get_toml_value() {
    grep "^$1\s*=" "$PROFILE_FILE" | head -1 | sed 's/.*=\s*"\(.*\)"/\1/'
}

APPS_DESIGN=(
    "fastfetch"
    "hypr"
    "hyprlock"
    "rofi"
    "starship"
    "swaync"
    "waybar"
    "wlogout"
)

SWAP_SCRIPT="$DOTFILES_DIR/scripts/swap-design.sh"
ERRORS=0

# Aplicar cada app usando swap-design.sh
for app in "${APPS_DESIGN[@]}"; do
    DESIGN=$(get_toml_value "$app")
    [ -z "$DESIGN" ] && continue

    if ! bash "$SWAP_SCRIPT" "$app" "$DESIGN" 2>/dev/null; then
        echo "❌ $app → $DESIGN falló" >&2
        ((ERRORS++))
    fi
done

# Wallpaper + matugen
WALLPAPER=$(get_toml_value "path")
if [ -n "$WALLPAPER" ] && [ -f "$DOTFILES_DIR/$WALLPAPER" ]; then
    EXT="${WALLPAPER##*.}"
    
    # 1. Borrar wallpaper anterior
    rm -f "$HOME/.config"/wallpaper.* 2>/dev/null
    
    # 2. Copiar nuevo
    cp "$DOTFILES_DIR/$WALLPAPER" "$HOME/.config/wallpaper.$EXT"
    
    # 3. Recargar Hyprland
    hyprctl reload 2>/dev/null || true
    
    # 4. Reiniciar hyprpaper
    pkill hyprpaper 2>/dev/null || true
    sleep 0.3
    hyprpaper -c "$HOME/.config/hypr/hyprpaper.conf" &>/dev/null &
    disown
    
    # 5. Generar colores
    command -v matugen &>/dev/null && matugen image "$HOME/.config/wallpaper.$EXT" --source-color-index 0
fi

exit $ERRORS