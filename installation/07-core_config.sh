#!/bin/bash
# =======================================================================
# CONFIGURA EL CORE DE UNA NUEVA INSTALACIÓN
# =======================================================================

echo -e "${BLUE}🔗 Mapeando dotfiles core al sistema...${NC}"

# 1. Definición de Variables de Origen y Destino
SRC="$DOTFILES_DIR/core"
DEST="$HOME/.config"

mkdir -p "$DEST"

# 2. Configurar Core
CORE_APPS=(
    "hypr"
    "gtk-3.0"
    "gtk-4.0"
    "kitty"
    "matugen"
    "quickshell"
    "zsh"
)

# Mapear a core
for app in "${CORE_APPS[@]}"; do
    if [ -d "$SRC/$app" ]; then
        # Limpiar destino completamente
        echo -e "${YELLOW}🧹 Limpiando $DEST/$app...${NC}"
        rm -rf "$DEST/$app"
    fi
    
    mkdir -p "$DEST/$app"

    # Stow (sin mkdir antes, stow lo maneja)
    echo -e "${YELLOW}🔗 Enlazando $app...${NC}"
    if stow -d "$SRC" -t "$DEST/$app" "$app" 2>&1; then
        echo -e "${GREEN}✅ Core → $app${NC}"
    else
        echo -e "${RED}❌ Falló: $app${NC}"
    fi
done


# .zshrc va directo al home
if [ -f "$SRC/.zshrc" ]; then
    echo -e "${YELLOW}🔗 Enlazando .zshrc...${NC}"
    rm -f "$HOME/.zshrc" 2>/dev/null
    ln -sf "$SRC/.zshrc" "$HOME/.zshrc"
    echo -e "${GREEN}✅ Core → .zshrc${NC}"
fi

echo -e "${GREEN}✅ Core funcional instalado.${NC}"