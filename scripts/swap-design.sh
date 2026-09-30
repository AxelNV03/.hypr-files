#!/usr/bin/env bash
# =====================================================================
#     SWAP-DESIGN — Cambia el diseño de UNA app
#     Uso: swap-design.sh <app> <diseño>
#     Ejemplo: swap-design.sh waybar design_1
# =====================================================================

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.hypr-files}"
DESIGNS_SRC="$DOTFILES_DIR/designs"
DESTINO="$HOME/.config"

APP="${1:-}"
DESIGN="${2:-}"

if [ -z "$APP" ] || [ -z "$DESIGN" ]; then
    echo "❌ Uso: swap-design.sh <app> <diseño>" >&2
    exit 1
fi

# Verificar que el diseño existe según el tipo de app
case "$APP" in
    hyprlock)
        [ -f "$DESIGNS_SRC/hyprlock/$DESIGN.conf" ] || {
            echo "❌ No existe $DESIGNS_SRC/hyprlock/$DESIGN.conf" >&2
            exit 1
        }
        ;;
    starship)
        [ -f "$DESIGNS_SRC/starship/$DESIGN.toml" ] || {
            echo "❌ No existe $DESIGNS_SRC/starship/$DESIGN.toml" >&2
            exit 1
        }
        ;;
    *)
        [ -d "$DESIGNS_SRC/$APP/$DESIGN" ] || {
            echo "❌ No existe $DESIGNS_SRC/$APP/$DESIGN" >&2
            exit 1
        }
        ;;
esac

# Aplicar según el tipo de app
case "$APP" in
    hypr)
        TARGET="$DESTINO/hypr/modules"
        mkdir -p "$TARGET"
        rm -f "$TARGET/animations.lua" "$TARGET/appearance.lua"
        ln -sf "$DESIGNS_SRC/hypr/$DESIGN/animations.lua" "$TARGET/animations.lua"
        ln -sf "$DESIGNS_SRC/hypr/$DESIGN/appearance.lua" "$TARGET/appearance.lua"
        echo "✅ hypr → $DESIGN"
        ;;

    hyprlock)
        TARGET="$DESTINO/hypr"
        mkdir -p "$TARGET"
        rm -f "$TARGET/hyprlock.conf"
        ln -sf "$DESIGNS_SRC/hyprlock/$DESIGN.conf" "$TARGET/hyprlock.conf"
        echo "✅ hyprlock → $DESIGN"
        ;;

    starship)
        TARGET="$DESTINO/matugen/templates"
        mkdir -p "$TARGET"
        rm -f "$TARGET/starship-colors.toml"
        ln -sf "$DESIGNS_SRC/starship/$DESIGN.toml" "$TARGET/starship-colors.toml"
        echo "✅ starship → $DESIGN"
        ;;

    *)
        TARGET="$DESTINO/$APP"
        rm -rf "$TARGET" 2>/dev/null
        mkdir -p "$TARGET"
        if stow -d "$DESIGNS_SRC/$APP" -t "$TARGET" "$DESIGN" 2>/dev/null; then
            echo "✅ $APP → $DESIGN"
        else
            echo "❌ $APP → $DESIGN falló" >&2
            exit 1
        fi
        ;;
esac