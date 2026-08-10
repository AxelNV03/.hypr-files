#!/bin/bash
# =======================================================================
# CONFIGURA EL CORE DE UNA NUEVA INSTALACIÓN
# =======================================================================

echo -e "${BLUE}🔗 Mapeando dotfiles core al sistema...${NC}"

# 1. Definición de Variables de Origen y Destino
SRC="$DOTFILES_DIR/core"
DEST="$HOME/.config"

# Asegurar que el destino exista
mkdir -p "$DEST"

# 2. Escanea cada directorio dentro de core
mapfile -t directorios < <(
    find "$SRC" -mindepth 1 -maxdepth 1 -type d
)

# Mapear los Symlinks
for dir in "${directorios[@]}"; do
    PKG=$(basename "$dir")

    # Si es ZSH lo ignora
    if [ "$PKG" = "zsh" ]; then
        continue
    fi

    # Si existe en .config lo borra antes de hacer el symlink    
    if [ -e "$DEST/$PKG" ] || [ -L "$DEST/$PKG" ]; then
        rm -rf "$DEST/$PKG"    
    fi

    # Crea el enlace simbólico limpio
    execute_step "Enlazando core: $DIR_NAME" \
                 "ln -s '$dir' '$DEST/$PKG'" \
                 "Symlink-$PKG"
done

