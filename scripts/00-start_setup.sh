#!/bin/bash

# 1. Ruta absoluta
BASE_DIR=$(cd "$(dirname "$0")" && pwd)

# 2. Dar permisos de ejecución
chmod +x "$BASE_DIR/lib/rollback.sh"
chmod +x "$BASE_DIR"/*.sh

# 3. Importar el motor de Rollback
source "$BASE_DIR/lib/rollback.sh"
print_line() {
    echo -e "${YELLOW}==========================================${NC}"
}

print_line
echo -e "${GREEN}   🚀 INICIANDO INSTALACIÓN DE DOTFILES   ${NC}"
print_line

# 5. Sección de módulos adicionales
echo -e "${BLUE}📂 Ejecutando módulos adicionales...${NC}"
print_line

MODULOS=$(ls "$BASE_DIR"/*.sh | grep -vE "00-" | sort)

for script in $MODULOS; do
    if [ -f "$script" ]; then
        NOMBRE_MODULO=$(basename "$script")
        echo -e "${YELLOW}▶ Lanzando módulo: $NOMBRE_MODULO${NC}"
        source "$script"
        print_line
    fi
done

# 6. Resumen Final
if [ $ERROR_COUNT -eq 0 ]; then
    echo -e "${GREEN}    ✨ ¡Proceso finalizado con éxito!${NC}"
else
    echo -e "${RED}⚠️  $ERROR_COUNT error(es).${NC}"
    echo -e "${YELLOW}Log: $LOG_FILE${NC}"
fi
print_line