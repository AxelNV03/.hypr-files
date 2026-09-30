#!/bin/bash
# =====================================================================
#     INSTALACIÓN AUTOMATIZADA — ARCH/DERIVADAS + HYPRLAND
# =====================================================================

# --- Sudo único ---
echo -e "${YELLOW}🔑 Solicitando privilegios administrativos...${NC}"
if ! sudo -v; then
    echo -e "${RED}❌ Error: No se pudieron obtener privilegios. Abortando.${NC}"
    exit 1
fi

# Mantener sesión sudo viva en segundo plano
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
SUDO_PID=$!
trap 'kill $SUDO_PID' EXIT

# =====================================================================
# --- Rutas base ---
# =====================================================================
BASE_DIR=$(cd "$(dirname "$0")" && pwd)
DOTFILES_DIR=$(cd "$BASE_DIR/../" && pwd)
PROFILE_SCRIPT="$DOTFILES_DIR/scripts/apply-profile.sh"
MODULES_DIR="$BASE_DIR/modules"

# --- Permisos de ejecución ---
chmod +x "$BASE_DIR/_logger.sh"
chmod +x "$MODULES_DIR"/0[1-7]*.sh 2>/dev/null
chmod +x "$DOTFILES_DIR/scripts"/*.sh 2>/dev/null

# --- Motor de logging ---
source "$BASE_DIR/_logger.sh"

# =====================================================================
# --- Utilidades de formato ---
# =====================================================================
print_line() {
    echo -e "${YELLOW}==========================================${NC}"
}

print_section() {
    local title="$1"
    print_line
    echo -e "${BLUE}📂 $title${NC}"
    print_line
}

# =====================================================================
# --- Detección de hardware ---
# =====================================================================
IS_LAPTOP=false
if [ -d /sys/class/power_supply ] && ls /sys/class/power_supply/BAT* >/dev/null 2>&1; then
    IS_LAPTOP=true
fi

# =====================================================================
# --- Banner ---
# =====================================================================
print_line
echo -e "${GREEN}🚀 INICIANDO INSTALACIÓN DE HYPRLAND DOTFILES${NC}"
echo -e "${YELLOW}Directorio: $DOTFILES_DIR${NC}"
echo -e "${YELLOW}Hardware: $($IS_LAPTOP && echo 'Laptop' || echo 'Desktop')${NC}"
print_line

# =====================================================================
# --- Módulos de instalación ---
# =====================================================================
print_section "Ejecutando módulos de instalación"

declare -a SCRIPTS=(
    # "$MODULES_DIR/01-mirrors.sh"
    # "$MODULES_DIR/02-pacman_packages.sh"
    # "$MODULES_DIR/03-paru_packages.sh"
    # "$MODULES_DIR/04-personal_packages.sh"
)

# if $IS_LAPTOP; then
#     SCRIPTS+=("$MODULES_DIR/05-laptop.sh")
# fi

SCRIPTS+=(
    # "$MODULES_DIR/06-start_services.sh"
    "$MODULES_DIR/07-core_config.sh"
)

for script in "${SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        NOMBRE_MODULO=$(basename "$script")
        echo -e "${YELLOW}▶ Lanzando módulo: $NOMBRE_MODULO${NC}"
        
        export BASE_DIR DOTFILES_DIR
        source "$script"
        
        print_line
    else
        echo -e "${RED}⚠️  Módulo no encontrado: $script${NC}"
    fi
done

# =====================================================================
# --- Aplicar perfil default ---
# =====================================================================
print_section "Aplicando perfil default"

if [ -f "$PROFILE_SCRIPT" ]; then
    execute_step "Aplicando perfil default" \
                 "bash '$PROFILE_SCRIPT' default" \
                 "Perfil-default"
else
    echo -e "${RED}⚠️  apply-profile.sh no encontrado en $PROFILE_SCRIPT${NC}"
fi

# =====================================================================
# --- Resumen final ---
# =====================================================================
print_section "Resumen de instalación"

ERROR_COUNT=$(cat "$ERROR_COUNT_FILE" 2>/dev/null || echo "0")

if [ "$ERROR_COUNT" -eq 0 ]; then
    echo -e "${GREEN}    ✨ ¡Proceso finalizado con éxito!${NC}"
    echo -e "${GREEN}    Todos los módulos se completaron correctamente.${NC}"
else
    echo -e "${RED}⚠️  Se detectaron $ERROR_COUNT errores durante la instalación.${NC}"
    echo -e "${YELLOW}    Revisa el log para más detalles:${NC}"
    echo -e "${YELLOW}    $LOG_FILE${NC}"
fi

# --- Limpieza ---
rm -f "$ERROR_COUNT_FILE"
print_line
echo -e "${GREEN}   📋 Log guardado en: $LOG_FILE${NC}"
print_line
