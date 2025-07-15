#!/usr/bin/env bash

# Script para Configurar la terminal en Arch Linux
# Incluye zsh, starship y otras herramientas útiles
# Autor: Nava
# Fecha: 13 de julio de 2025

# Modo seguro: falla en errores, variables no definidas o comandos fallidos en tuberías
set -euo pipefail

# Función para manejar errores
handle_error() {
    echo "❌ Error en la línea $1: '$2' falló."
    exit 1
}
trap 'handle_error $LINENO "$BASH_COMMAND"' ERR

# Lista de paquetes
FONTS_PKGS="ttf-cascadia-code-nerd ttf-jetbrains-mono ttf-firacode-nerd" # Fuentes para terminal
ZSH_PKGS="zsh zsh-autosuggestions zsh-syntax-highlighting" # Paquetes zsh para terminal
EXTRA_PKGS="starship fastfetch atuin kitty" # Herramientas adicionales

ALL_PKGS="$FONTS_PKGS $ZSH_PKGS $EXTRA_PKGS" # Todos los paquetes a instalar


# Instalación de todos los paquetes necesarios
echo "🔄 Instalando paquetes necesarios..."
sudo pacman -S --noconfirm --needed $ALL_PKGS > /dev/null 2>&1

# Establecer zsh como shell por defecto
echo "🔄 Estableciendo zsh como shell por defecto..."
which zsh &>/dev/null || {
    echo "❌ zsh no está instalado. Instalando..."
    sudo pacman -S --noconfirm --needed $ZSH_PKGS > /dev/null 2>&1
}

# Copia la configuracion de Kitty
echo "🔄 Configurando Kitty..."
rm -r ~/.config/kitty
ln -sf ~/.hypr-files/kitty ~/.config/kitty

# Copia la configuracion de ZSH
echo "🔄 Configurando ZSH..."
mv $HOME/.zshrc $HOME/.zshrc.bak 2>/dev/null || true
ln -sf ~/.hypr-files/zsh/zsh-file.zsh $HOME/.zshrc

# Poner el tema de Starship (Actual: gruvbox-rainbow)
starship preset gruvbox-rainbow -o ~/.config/starship.toml > /dev/null 2>&1

# Copia la configuracion de Fastfetch
rm -r ~/.config/fastfetch > /dev/null 2>&1 || true
ln -sf ~/.hypr-files/fastfetch ~/.config/

# Copia los colores de dircolors
echo "🔄 Configurando dircolors..."
rm -r ~/.config/dircolors > /dev/null 2>&1 || true
ln -sf ~/.hypr-files/dircolors ~/.config/

