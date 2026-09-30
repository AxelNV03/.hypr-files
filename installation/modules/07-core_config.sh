#!/bin/bash
# =======================================================================
#     CONFIGURA EL CORE DE UNA NUEVA INSTALACIÓN
# =======================================================================

# Detección de ruta si no viene de install.sh
echo -e "${BLUE}🔗 Mapeando dotfiles core al sistema...${NC}"

SRC="$DOTFILES_DIR/core"
DEST="$HOME/.config"

# SRC="$HOME/.hypr-files/core"
# DEST="$HOME/testing"

mkdir -p "$DEST"

# --- Core apps ---
CORE_APPS=(
    "kitty"
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

# --- Hypr: stow manual (no folding) ---
HYPR_DIR="$DEST/hypr"
if [ -e "$HYPR_DIR" ] || [ -L "$HYPR_DIR" ]; then
    echo -e "${YELLOW}🧹 Limpiando $HYPR_DIR...${NC}"
    rm -rf "$HYPR_DIR"
fi

echo -e "${YELLOW}🔗 Enlazando hypr...${NC}"
mkdir -p "$HYPR_DIR"
if stow --no-folding -d "$SRC/hypr" -t "$HYPR_DIR" . 2>&1; then
    echo -e "${GREEN}✅ Core → hypr${NC}"
else
    echo -e "${RED}❌ Falló: hypr${NC}"
fi


# --- Matugen: stow manual (no folding) ---
MATUGEN_DIR="$DEST/matugen"
if [ -e "$MATUGEN_DIR" ] || [ -L "$MATUGEN_DIR" ]; then
    echo -e "${YELLOW}🧹 Limpiando $MATUGEN_DIR...${NC}"
    rm -rf "$MATUGEN_DIR"
fi

echo -e "${YELLOW}🔗 Enlazando matugen...${NC}"
mkdir -p "$MATUGEN_DIR"
if stow --no-folding -d "$SRC/matugen" -t "$MATUGEN_DIR" . 2>&1; then
    echo -e "${GREEN}✅ Core → matugen${NC}"
else
    echo -e "${RED}❌ Falló: matugen${NC}"
fi


echo -e "${GREEN}✅ Core funcional instalado.${NC}"
