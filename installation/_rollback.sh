#!/bin/bash
# =====================================================================
# INSTALACIÓN AUTOMATIZADA - ARCH / DERIVADAS
# =====================================================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

LOG_FILE="$HOME/.dotfiles_install.log"
ERROR_COUNT_FILE="/tmp/dotfiles_error_count.$$"
echo "0" > "$ERROR_COUNT_FILE"

execute_step() {
    local msg="$1"
    local cmd="$2"
    local pkg="$3"
    echo -ne "${YELLOW}[...]${NC} $msg"
    if bash -c "$cmd" >> "$LOG_FILE" 2>&1; then
        echo -e "\r\033[K✅ $pkg: OK"
    else
        echo -e "\r\033[K❌ $pkg: Fallo"
        local count=$(cat "$ERROR_COUNT_FILE")
        echo $((count + 1)) > "$ERROR_COUNT_FILE"
        
        echo -e "\n--- ERROR DETECTADO ---" >> "$LOG_FILE"
        echo -e "Acción: $msg" >> "$LOG_FILE"
        echo -e "Comando: $cmd" >> "$LOG_FILE"
        echo -e "-----------------------\n" >> "$LOG_FILE"
    fi
}

export -f execute_step
export LOG_FILE ERROR_COUNT_FILE