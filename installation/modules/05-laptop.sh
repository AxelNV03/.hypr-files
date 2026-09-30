#!/usr/bin/env bash
# =====================================================================
#     CONFIGURACIÓN ESPECÍFICA DE LAPTOPS
#     Brillo, energía (TLP), umbral de batería si el hardware lo soporta
# =====================================================================

echo -e "${BLUE}🚀 Configurando laptop...${NC}"

# --- 1. Control de brillo ---
execute_step "Instalando brightnessctl" \
             "sudo pacman -S --needed --noconfirm brightnessctl" \
             "Install-brightnessctl"

# --- 2. TLP (reemplaza a power-profiles-daemon) ---
execute_step "Instalando TLP" \
             "sudo pacman -S --needed --noconfirm tlp" \
             "Install-TLP"

execute_step "Activando servicio TLP" \
             "sudo systemctl enable --now tlp.service" \
             "Enable-TLP"

execute_step "Enmascarando rfkill (evita conflicto)" \
             "sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket" \
             "Mask-rfkill"

# --- 3. Umbral de batería (solo si el hardware lo soporta) ---
# TLP detecta automáticamente. Configuramos los valores DESEADOS,
# si el hardware no los soporta, TLP los ignora silenciosamente.
execute_step "Configurando umbrales de batería (si aplica)" \
             "sudo mkdir -p /etc/tlp.d && \
              echo 'START_CHARGE_THRESH_BAT0=40' | sudo tee /etc/tlp.d/00-battery-threshold.conf && \
              echo 'STOP_CHARGE_THRESH_BAT0=80' | sudo tee -a /etc/tlp.d/00-battery-threshold.conf" \
             "Battery-Threshold"

execute_step "Aplicando configuración TLP" \
             "sudo tlp start" \
             "TLP-Start"

# --- 4. Verificar ---
echo -e "${BLUE}📊 Estado de batería:${NC}"
tlp-stat -b | grep -E "charge|threshold|Plugin|Driver" || true

echo -e "${GREEN}✅ Laptop configurada.${NC}"