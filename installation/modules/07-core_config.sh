#!/bin/bash
# =======================================================================
#     CONFIGURA EL CORE DE UNA NUEVA INSTALACIÓN
# =======================================================================

# Detección de ruta si no viene de install.sh
echo -e "${BLUE}🔗 Mapeando dotfiles core al sistema...${NC}"

SRC="$DOTFILES_DIR/core"
DEST="$HOME/.config"

mkdir -p "$DEST"

# --- Core apps ---
CORE_APPS=(
    "kitty"
    "matugen"
    "zsh"
)

for app in "${CORE_APPS[@]}"; do
    if [ -d "$SRC/$app" ]; then
        # Limpiar destino
        if [ -e "$DEST/$app" ] || [ -L "$DEST/$app" ]; then
            echo -e "${YELLOW}🧹 Limpiando $DEST/$app...${NC}"
            rm -rf "$DEST/$app"
        fi
        mkdir -p "$DEST/$app"
        
        # Enlazar contenido del paquete
        echo -e "${YELLOW}🔗 Enlazando $app...${NC}"
        if stow -d "$SRC/$app" -t "$DEST/$app" . 2>&1; then
            echo -e "${GREEN}✅ Core → $app${NC}"
        else
            echo -e "${RED}❌ Falló: $app${NC}"
        fi
    fi
done

# --- .zshrc al home ---
if [ -f "$SRC/.zshrc" ]; then
    echo -e "${YELLOW}🔗 Enlazando .zshrc...${NC}"
    rm -f "$HOME/.zshrc" 2>/dev/null
    ln -sf "$SRC/.zshrc" "$HOME/.zshrc"
    echo -e "${GREEN}✅ Core → .zshrc${NC}"
fi

# --- Hypr: symlink del directorio completo ---
HYPR_DIR="$DEST/hypr"
if [ -e "$HYPR_DIR" ] || [ -L "$HYPR_DIR" ]; then
    echo -e "${YELLOW}🧹 Limpiando $HYPR_DIR...${NC}"
    rm -rf "$HYPR_DIR"
fi
ln -sf "$SRC/hypr" "$HYPR_DIR"
echo -e "${GREEN}✅ Core → hypr${NC}"

echo -e "${GREEN}✅ Core funcional instalado.${NC}"