#!/bin/bash

# --- Configuración ---
LOG_FILE="$HOME/.dotfiles_install.log"
# 1. Declaramos el contador al inicio
ERROR_COUNT=0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Limpiar log anterior al iniciar
echo "--- Inicio de instalación: $(date) ---" > "$LOG_FILE"

# Función Centralizada
execute_step() {
    local msg="$1"
    local cmd="$2"
    local pkg="$3"

    echo -ne "${YELLOW}[...]${NC} $msg"

    if eval "$cmd" >> "$LOG_FILE" 2>&1; then
        echo -e "\r\033[K✅ $pkg: OK"
    else
        echo -e "\r\033[K❌ $pkg: Fallo"
        
        # 2. Sumamos 1 al contador de errores
        ((ERROR_COUNT++))
        
        # Registro en el log
        echo -e "\n--- ERROR DETECTADO ---" >> "$LOG_FILE"
        echo -e "Acción: $msg" >> "$LOG_FILE"
        echo -e "Comando: $cmd" >> "$LOG_FILE"
        echo -e "-----------------------\n" >> "$LOG_FILE"
    fi
}

# Exportamos tanto la función como la variable
export -f execute_step
export ERROR_COUNT