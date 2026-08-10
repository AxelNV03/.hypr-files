#!/bin/bash
# =====================================================================
#     INSTALACIÓN AUTOMATIZADA — ARCH/DERIVADAS + HYPRLAND
# =====================================================================

# --- Sudo una sola vez ---
echo -e "${YELLOW}🔑 Solicitando privilegios administrativos...${NC}"
if ! sudo -v; then
    echo -e "${RED}❌ Error: No se pudieron obtener privilegios. Abortando.${NC}"
    exit 1
fi

# Mantener sesión sudo viva en segundo plano
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
SUDO_PID=$!
trap 'kill $SUDO_PID' EXIT


# --- Rutas base ---
BASE_DIR=$(cd "$(dirname "$0")" && pwd)
DOTFILES_DIR=$(cd "$BASE_DIR/../" && pwd)

# --- Permisos de ejecución ---
chmod +x "$BASE_DIR/_rollback.sh"
chmod +x "$BASE_DIR"/0[0-6]*.sh 2>/dev/null
chmod +x "$BASE_DIR"/0x-*.sh 2>/dev/null

# --- Motor de logging ---
source "$BASE_DIR/_rollback.sh"

# --- Utilidades ---
print_line() {
    echo -e "${YELLOW}==========================================${NC}"
}

print_section() {
    local title="$1"
    print_line
    echo -e "${BLUE}📂 $title${NC}"
    print_line
}

# --- Detección de hardware ---
IS_LAPTOP=false
if [ -d /sys/class/power_supply ] && ls /sys/class/power_supply/BAT* >/dev/null 2>&1; then
    IS_LAPTOP=true
fi

# --- Banner ---
print_line
echo -e "${GREEN}🚀 INICIANDO INSTALACIÓN DE HYPRLAND DOTFILES${NC}"
echo -e "${YELLOW}Directorio: $DOTFILES_DIR${NC}"
echo -e "${YELLOW}Hardware: $($IS_LAPTOP && echo 'Laptop' || echo 'Desktop')${NC}"
print_line

# --- Módulos de instalación ---
print_section "Ejecutando módulos de instalación"

declare -a SCRIPTS=(
    # "$BASE_DIR/00-reflector.sh"
    # "$BASE_DIR/01-mirrors.sh"
    # "$BASE_DIR/02-packages.sh"
    # "$BASE_DIR/03-paru.sh"
    # "$BASE_DIR/04-start_services.sh"
    # "$BASE_DIR/05-battery.sh"  #Solo se ejecuta si es laptop
    "$BASE_DIR/06-core_config.sh"
)

# Solo ejecutar battery si es laptop
if $IS_LAPTOP; then
    SCRIPTS+=("$BASE_DIR/05-battery.sh")
fi

for script in "${SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        NOMBRE_MODULO=$(basename "$script")
        echo -e "${YELLOW}▶ Lanzando módulo: $NOMBRE_MODULO${NC}"
        
        # Exportar variables que los scripts puedan necesitar
        export BASE_DIR DOTFILES_DIR
        source "$script"
        
        print_line
    else
        echo -e "${RED}⚠️  Módulo no encontrado: $script${NC}"
    fi
done

# --- Resumen final ---
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