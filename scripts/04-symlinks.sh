#!/bin/bash
echo -e "${BLUE}⚙️  Configurando symlinks del sistema...${NC}"

# Variables
DOTFILES="$HOME/.hypr-files"
THEME=$(cat "$DOTFILES/profiles/.current_theme" | xargs)
THEME_DIR="$DOTFILES/profiles/$THEME"

link_dir() {
    local origen="$1"
    local destino="$2"

    # Si el destino existe y es un directorio real (no un link simbólico)
    if [ -d "$destino" ] && [ ! -L "$destino" ]; then
        echo -e "${YELLOW}⚠️  Borrando directorio existente en: $destino${NC}"
        rm -rf "$destino"
    fi

    # Si es un archivo real (no link), también lo borramos
    if [ -f "$destino" ] && [ ! -L "$destino" ]; then
        rm -f "$destino"
    fi

    # Ahora sí, el link quedará donde debe
    ln -sf "$origen" "$destino"
}

# Symlinks del tema
THEME_FOLDERS=($(find "$THEME_DIR" -maxdepth 1 -type d -not -path "$THEME_DIR" -not -name "hypr" -exec basename {} \;))

# Enlazar hypr manual
ln -sf $THEME_DIR/hypr/appearance.conf $DOTFILES/config/hypr/components/

echo -e "${BLUE}🎨 Inyectando estética del tema [$THEME]...${NC}"
for folder in "${THEME_FOLDERS[@]}"; do
    # Solo intentamos el enlace si la carpeta destino existe en el repo
    if [ -d "$DOTFILES/config/$folder" ]; then
        
        # Preparamos el mensaje y el comando para la función
        msg="Enlazando perfil de $folder"
        pkg="Profile-$folder"
        
        # Importante: El asterisco (*) debe ir dentro de las comillas 
        # o escapado para que eval lo maneje correctamente
        cmd="ln -sf $THEME_DIR/$folder/* $DOTFILES/config/$folder/"

        # Ejecutamos con tu función pro
        execute_step "$msg" "$cmd" "$pkg"
    fi
done


# Symlinks al sistema
# --- 1. Detectar carpetas base en el Repo ---
# Escaneamos $DOTFILES/config para saber qué carpetas existen
BASE_CONFIGS=($(find "$DOTFILES/config" -maxdepth 1 -type d -not -path "$DOTFILES/config" -exec basename {} \;))

echo -e "\n${BLUE}🚀 Proyectando configuraciones al sistema (~/.config)...${NC}"

# --- 2. Bucle de Enlace Atómico con execute_step ---
for folder in "${BASE_CONFIGS[@]}"; do
    # Definimos rutas claras
    OR=$DOTFILES/config/$folder
    DES=$HOME/.config/$folder

    # Usamos execute_step para llamar a tu función link_dir
    # Pasamos los argumentos entre comillas para que no se rompan
    execute_step "Enlazando $folder" "link_dir '$OR' '$DES'" "Config-$folder"
done


# Enlace de zsh
echo -e "\n${BLUE}🐚 Configurando el entorno Zsh...${NC}"

# 1. Enlazar el .zshrc principal al HOME
# Este es el archivo que Zsh busca al iniciar
OR_ZSH="$DOTFILES/config/zsh/.zshrc"
DES_ZSH="$HOME/.zshrc"
execute_step "Enlazando .zshrc al HOME" "link_dir '$OR_ZSH' '$DES_ZSH'" "Zsh-Core"

# 2. Enlazar la configuración de Powerlevel10k
# P10k busca específicamente el archivo .p10k.zsh en la raíz del HOME
OR_P10K="$DOTFILES/config/zsh/p10k.zsh"
DES_P10K="$HOME/.p10k.zsh"
execute_step "Enlazando configuración de P10k" "link_dir '$OR_P10K' '$DES_P10K'" "Zsh-P10k"