#!/bin/bash

# Colores para la terminal
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${BLUE}🚀 Configurando umbrales de batería ...${NC}"

# 2. Escribir configuración (usando printf para que sea compatible con eval)
TLP_CONTENT="TLP_ENABLE=1\nSTART_CHARGE_THRESH_BAT0=20\nSTOP_CHARGE_THRESH_BAT0=80\nSTART_CHARGE_THRESH_BAT1=20\nSTOP_CHARGE_THRESH_BAT1=80\nCPU_SCALING_GOVERNOR_ON_AC=performance\nCPU_SCALING_GOVERNOR_ON_BAT=powersave"

execute_step "Configurando umbrales (20/80)" "echo -e '$TLP_CONTENT' | sudo tee /etc/tlp.conf" "TLP-Conf"

# 3. Habilitar y arrancar servicios
execute_step "Habilitando servicio TLP" "sudo systemctl enable --now tlp" "TLP-Service"
execute_step "Aplicando cambios de batería" "sudo tlp start" "TLP-Apply"