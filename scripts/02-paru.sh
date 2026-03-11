#!/bin/bash

# --- 1. Configuración de paquetes AUR ---
PARU_PKGS=(
    "rofi-wayland"                  # Lanzador de aplicaciones para Wayland
    "losslesscut-bin"               # Editor de video sin pérdida (Super útil)
    "grimblast-git"                 # Capturas de pantalla pro para Hyprland
    "visual-studio-code-bin"
    "oh-my-zsh-git"
    "zsh-theme-powerlevel10k-git"   # El motor de tu prompt .p10k.zsh
    "elecwhat-bin"
    "brave-bin"
    "bibata-cursor-theme-bin"       # El cursor que pusiste (Bibata-Modern-Ice)
    "catppuccin-gtk-theme-mocha"    # El tema visual (Catppuccin-Mocha)
    "papirus-icon-theme"            # Los iconos (Papirus-Dark)
    "nwg-look"                      # HERRAMIENTA CLAVE (Léeme abajo)
    "papirus-icon-theme"
    "papirus-folders-git"
)

echo -e "${BLUE}🛠️ Verificando instalador de AUR (Paru)...${NC}"

# 1. Instalación de Paru si no existe
if ! command -v paru &> /dev/null; then
    echo -e "${YELLOW}⏳ Paru no encontrado. Instalando...${NC}"
    
    # Clonar e instalar en una sola operación
    if git clone https://aur.archlinux.org/paru-bin.git /tmp/paru-bin; then
        (
            cd /tmp/paru-bin || exit
            makepkg -si --noconfirm
        )
        rm -rf /tmp/paru-bin
    fi

    # --- CLÁUSULA DE SEGURIDAD: Si después del intento no existe, detenemos el script ---
    if ! command -v paru &> /dev/null; then
        echo -e "${RED}❌ Error crítico: No se pudo instalar Paru. Abortando...${NC}"
        exit 1
    fi
else
    echo -e "✅ Gestor Paru: OK"
fi

# 3. Instalación de la lista de paquetes AUR
echo -e "${BLUE}📦 Iniciando instalación de paquetes AUR con Paru...${NC}"

for pkg in "${PARU_PKGS[@]}"; do
    execute_step "Instalando desde AUR: $pkg" \
                 "paru -S --needed --noconfirm $pkg" \
                 "$pkg"
done