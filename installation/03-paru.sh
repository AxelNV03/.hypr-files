#!/usr/bin/env bash
# =====================================================================
#     INSTALACIÓN DE PARU + PAQUETES AUR
# =====================================================================

# --- [ 1. CATÁLOGO DE PAQUETES AUR ] ---

# Sistema y utilidades para Hyprland
PARU_SYSTEM=(
    "greetd-tuigreet-git"         # Interfaz TUI para greetd — Login minimalista
    "pwvucontrol"                 # Control de volumen GTK4 nativo para PipeWire
    "wlogout"                     # Menú de apagado/cierre de sesión a pantalla completa
    "overskride-bin"              # Gestor de Bluetooth moderno para Wayland
    "quickshell-git"              # Shell rápido para widgets y paneles en Hyprland
    "oh-my-zsh-git"
    "hyprshot-gui-bin"
)

# Temas y personalización visual
PARU_THEMES=(
    "catppuccin-gtk-theme-mocha"
    "colloid-catppuccin-theme-git"
    "papirus-folders-git"
    "bibata-cursor-theme-bin"
)

# Aplicaciones de usuario
PARU_APPS=(
    "losslesscut-bin"             # Editor de video sin pérdida — Cortes rápidos
    "brave-origin-bin"    # Brave Browser (nightly)
    "visual-studio-code-bin"      # VS Code oficial de Microsoft (con telemetría y extensiones propietarias)
)

# --- [ 2. UNIFICACIÓN ] ---
PARU_PKGS=(
    "${PARU_SYSTEM[@]}"
    "${PARU_THEMES[@]}"
    "${PARU_APPS[@]}"
)

# --- [ 3. INSTALACIÓN DE PARU ] ---
echo -e "${BLUE}🛠️ Verificando instalador de AUR (Paru)...${NC}"

# 2. Compilación e Instalación Idempotente de Paru
if ! command -v paru &> /dev/null; then
    echo -e "${YELLOW}⏳ Paru no encontrado. Compilando desde origen...${NC}"
    
    # ─── SOLUCIÓN AL BUG ANTERIOR ───
    # Limpiamos preventivamente para que git clone jamás vuelva a decir que la ruta ya existe
    rm -rf /tmp/paru
    
    if git clone https://aur.archlinux.org/paru.git /tmp/paru; then
        (
            cd /tmp/paru || exit 1
            execute_step "Instalando Paru" \
                         "makepkg -si --noconfirm" \
                         "Paru"                
        )
        rm -rf /tmp/paru
    fi

    # Cláusula de escape si la compilación falla
    if ! command -v paru &> /dev/null; then
        echo -e "${RED}❌ Error crítico: No se pudo consolidar Paru. Abortando...${NC}"
        # Sumamos al contador global para que tu install.sh se entere del fallo
        incrementar_contador_errores 2>/dev/null
        exit 1
    fi
else
    echo -e "✅ Gestor Paru: OK"
fi

# --- [ 4. INSTALACIÓN DE PAQUETES AUR ] ---
echo -e "${BLUE}📦 Instalando paquetes desde AUR...${NC}"
for pkg in "${PARU_PKGS[@]}"; do
    execute_step "AUR → $pkg" \
                 "paru -S --needed --noconfirm $pkg" \
                 "$pkg"
done

echo -e "${GREEN}✅ Paquetes AUR instalados correctamente.${NC}"