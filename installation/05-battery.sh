#!/usr/bin/env bash
# =====================================================================
#     INTERFAZ DE ENERGÍA UNIVERSAL — Agnóstica de Hardware
# =====================================================================

echo -e "${BLUE}🚀 Configurando gestión de energía global...${NC}"

# --- 1. Power Profiles Daemon ---
execute_step "Instalando power-profiles-daemon" \
             "sudo pacman -S --needed --noconfirm power-profiles-daemon" \
             "Install-PPD"

execute_step "Activando servicio de perfiles de energía" \
             "sudo systemctl enable --now power-profiles-daemon" \
             "Enable-PPD"

# Pequeña pausa para que el daemon esté listo antes de usarlo
sleep 0.5

execute_step "Estableciendo perfil de energía balanceado" \
             "powerprofilesctl set balanced" \
             "PPD-Balanced"

# --- 2. Umbral de carga de batería (multi-vendor, multi-batería) ---
BATTERY_THRESHOLD="${BATTERY_THRESHOLD:-80}"
BAT_FOUND=false

for bat_dir in /sys/class/power_supply/BAT*; do
    if [ -d "$bat_dir" ]; then
        BAT_NAME=$(basename "$bat_dir")
        BAT_CMD=""

        # Detectar archivo de control según firmware
        if [ -f "$bat_dir/charge_control_limit_max" ]; then
            # ASUS nativo (TUF Gaming, ROG)
            BAT_CMD="echo $BATTERY_THRESHOLD | sudo tee $bat_dir/charge_control_limit_max"
        elif [ -f "$bat_dir/charge_control_end_threshold" ]; then
            # Lenovo / ThinkPad moderno (Kernel API nativa)
            BAT_CMD="echo $BATTERY_THRESHOLD | sudo tee $bat_dir/charge_control_end_threshold"
        elif [ -f "$bat_dir/charge_stop_threshold_max" ]; then
            # Lenovo legacy / capas de compatibilidad
            BAT_CMD="echo $BATTERY_THRESHOLD | sudo tee $bat_dir/charge_stop_threshold_max"
        elif [ -f "$bat_dir/fw_charge_threshold" ]; then
            # Huawei / Otros fabricantes
            BAT_CMD="echo $BATTERY_THRESHOLD | sudo tee $bat_dir/fw_charge_threshold"
        fi

        if [ -n "$BAT_CMD" ]; then
            BAT_FOUND=true
            execute_step "Umbral de carga al ${BATTERY_THRESHOLD}% para: $BAT_NAME" \
                         "$BAT_CMD" \
                         "Battery-$BAT_NAME"
        fi
    fi
done

if [ "$BAT_FOUND" = false ]; then
    echo -e "${YELLOW}⚠️  No se detectaron baterías con control de umbral nativo. Saltando...${NC}"
    echo -e "${YELLOW}   Esto es normal en desktops o laptops sin soporte en kernel.${NC}"
fi