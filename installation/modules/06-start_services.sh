#!/bin/bash
# =====================================================================
#     ORQUESTACIÓN DE SERVICIOS Y ENTORNO
# =====================================================================

echo -e "${BLUE}⚙️ Configurando servicios del sistema...${NC}"

# --- 1. Bluetooth ---
execute_step "Habilitando Bluetooth" \
             "sudo systemctl enable --now bluetooth" \
             "Bluetooth-Service"

# --- 2. NetworkManager ---
execute_step "Habilitando NetworkManager" \
             "sudo systemctl enable --now NetworkManager" \
             "Network-Service"

# --- 3. Impresión (CUPS) ---
execute_step "Habilitando CUPS (impresión)" \
             "sudo systemctl enable --now cups" \
             "CUPS-Service"

# --- 4. Firewall (UFW) ---
execute_step "Habilitando UFW (firewall)" \
             "sudo systemctl enable --now ufw" \
             "UFW-Service"

# --- 5. Reloj del sistema ---
execute_step "Sincronizando reloj (NTP)" \
             "sudo timedatectl set-ntp true && sudo systemctl enable --now systemd-timesyncd" \
             "Time-Sync"

# --- 6. Carpetas XDG ---
execute_step "Creando carpetas personales (XDG)" \
             "xdg-user-dirs-update" \
             "XDG-User-Dirs"

# --- 7. pkgfile (Command Not Found) ---
execute_step "Indexando base de datos de pkgfile" \
             "sudo pkgfile -u" \
             "pkgfile-Update"

# --- 8. Shell por defecto (Zsh) ---
execute_step "Cambiando Shell a Zsh" \
             "chsh -s /usr/bin/zsh $USER" \
             "Zsh-Shell-Change"

# --- 9. Locale (es_MX) ---
execute_step "Generando locale es_MX.UTF-8" \
             "sudo sed -i 's/#es_MX.UTF-8 UTF-8/es_MX.UTF-8 UTF-8/' /etc/locale.gen && sudo locale-gen" \
             "Locale-Generation"

execute_step "Estableciendo LANG por defecto" \
             "echo 'LANG=es_MX.UTF-8' | sudo tee /etc/locale.conf" \
             "Locale-Conf"

# --- 10. SSD TRIM ---
execute_step "Habilitando mantenimiento de SSD (fstrim)" \
             "sudo systemctl enable fstrim.timer" \
             "FSTrim-Timer"

echo -e "${GREEN}✅ Servicios configurados.${NC}"