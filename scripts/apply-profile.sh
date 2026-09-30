#!/usr/bin/env bash
# =====================================================================
#     APPLY-PROFILE — Aplica una receta desde profiles/*.toml
#     Uso: apply-profile.sh <perfil>
# =====================================================================

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.hypr-files}"
PROFILE="${1:-}"

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

    if ! bash "$SWAP_SCRIPT" "$app" "$DESIGN"; then
        echo "❌ $app → $DESIGN falló" >&2
        ERRORS=$((ERRORS + 1))
    fi
done

# Wallpaper + matugen
WALLPAPER=$(get_toml_value "path")
PREFER=$(get_toml_value "prefer")

if [ -n "$WALLPAPER" ]; then
    if ! bash "$DOTFILES_DIR/scripts/change-wallpaper.sh" "$WALLPAPER" "$PREFER"; then
        echo "❌ Wallpaper falló" >&2
        ERRORS=$((ERRORS + 1))
    fi
fi



exit $ERRORS