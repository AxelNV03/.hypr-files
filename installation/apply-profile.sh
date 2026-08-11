#!/usr/bin/env bash
# =====================================================================
#     APPLY-PROFILE — Aplica una receta desde profiles/*.toml
#     Uso: apply-profile.sh <perfil>
# =====================================================================

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.hypr-files}"
PROFILE="$1"

# --- 1. Validar que el perfil existe ---
if [ -z "$PROFILE" ]; then
    echo "❌ Uso: apply-profile.sh <perfil>" >&2
    exit 1
fi

PROFILE_FILE="$DOTFILES_DIR/profiles/$PROFILE.toml"
if [ ! -f "$PROFILE_FILE" ]; then
    echo "❌ Perfil '$PROFILE' no encontrado" >&2
    exit 1
fi

# --- 2. Función para leer el TOML ---
get_toml_value() {
    grep "^$1\s*=" "$PROFILE_FILE" | head -1 | sed 's/.*=\s*"\(.*\)"/\1/'
}

# --- 3. Lista de apps con diseño ---
DESIGN_APPS=(
    "hypr" "waybar" "rofi" "swaync" "wlogout"
    "gtk-3.0" "gtk-4.0" "fastfetch"
)

DEST="$HOME/.config"
DESIGNS_SRC="$DOTFILES_DIR/designs"
ERRORS=0

# --- 4. Aplicar cada diseño ---
for app in "${DESIGN_APPS[@]}"; do
    DESIGN=$(get_toml_value "$app")
    [ -z "$DESIGN" ] && continue
    [ ! -d "$DESIGNS_SRC/$app/$DESIGN" ] && continue

        # Definir destino según la app
    if [ "$app" = "hypr" ]; then
        TARGET="$DEST/$app/modules"
    else
        TARGET="$DEST/$app"
    fi

    # Crear carpeta si no existe
    mkdir -p "$TARGET"

    # Aplicar diseño
    if ! stow -d "$DESIGNS_SRC/$app" -t "$TARGET" "$DESIGN" 2>/dev/null; then
        echo "❌ $app → $DESIGN falló" >&2
        ((ERRORS++))
    fi
done

# --- 5. Wallpaper + matugen ---
WALLPAPER=$(get_toml_value "path")
if [ -n "$WALLPAPER" ] && [ -f "$DOTFILES_DIR/$WALLPAPER" ]; then
    cp "$DOTFILES_DIR/$WALLPAPER" "$DEST/wallpaper"
    command -v matugen &>/dev/null && matugen image "$DEST/wallpaper" --source-color-index 0
fi

exit $ERRORS