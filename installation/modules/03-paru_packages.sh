#!/usr/bin/env bash
# =====================================================================
#     INSTALACIÓN DE PARU + PAQUETES AUR
# =====================================================================
PARU_SYSTEM=(
    "pwvucontrol"                 # Control de volumen GTK4 para PipeWire
    "wlogout"                     # Menú de apagado a pantalla completa
    "overskride-bin"              # Gestor de Bluetooth moderno
    "hyprshot-gui-bin"            # GUI para hyprshot
)

PARU_THEMES=(
    "catppuccin-gtk-theme-mocha"
    "colloid-catppuccin-theme-git"
    "papirus-folders-git"
    "bibata-cursor-theme-bin"
)

# --- [ 2. UNIFICACIÓN ] ---
PARU_PKGS=(
    "${PARU_SYSTEM[@]}"
    "${PARU_THEMES[@]}"
)

# =====================================================================
#   INSTALAR PARU
# =====================================================================
# --- [ 3. INSTALACIÓN DE PARU ] ---
echo -e "${BLUE}🛠️ Verificando instalador de AUR (Paru)...${NC}"

if ! command -v paru &> /dev/null; then
    echo -e "${YELLOW}⏳ Paru no encontrado. Compilando desde origen...${NC}"
    
    # Limpieza preventiva
    rm -rf /tmp/paru
    
    # Clonar
    if git clone https://aur.archlinux.org/paru.git /tmp/paru; then
        # Compilar (execute_step con cd incluido)
        execute_step "Compilando e instalando Paru" \
                     "cd /tmp/paru && makepkg -si --noconfirm" \
                     "Paru"
        
        # Limpiar
        rm -rf /tmp/paru
    fi

    # Verificar que Paru quedó instalado
    if ! command -v paru &> /dev/null; then
        echo -e "${RED}❌ Error crítico: No se pudo instalar Paru. Abortando...${NC}"
        ERROR_COUNT=$(cat "$ERROR_COUNT_FILE" 2>/dev/null || echo "0")
        echo $((ERROR_COUNT + 1)) > "$ERROR_COUNT_FILE"
        exit 1
    fi
else
    echo -e "${GREEN}✅ Gestor Paru: OK${NC}"
fi

# =====================================================================
#    INSTALAR PAQUETES AUR
# =====================================================================
for pkg in "${PARU_PKGS[@]}"; do
    if pacman -Qi "$pkg" &>/dev/null || paru -Qi "$pkg" &>/dev/null; then
        echo -e "${GREEN}✅ $pkg ya instalado${NC}"
        continue
    fi
    
    execute_step "AUR → $pkg" \
                 "paru -S --needed --noconfirm $pkg" \
                 "$pkg"
done
echo -e "${GREEN}✅ Paquetes AUR instalados correctamente.${NC}"