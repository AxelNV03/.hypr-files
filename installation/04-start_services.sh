#!/bin/bash
# =====================================================================
# ORQUESTACIÓN DE SERVICIOS Y ENTORNO
# =====================================================================

echo -e "${BLUE}⚙️ Configurando servicios del sistema...${NC}"

# 1. Habilitar Bluetooth
execute_step "Habilitando Bluetooth" \
             "sudo systemctl enable --now bluetooth" \
             "Bluetooth Service"

# 2. Habilitar NetworkManager
execute_step "Habilitando Red" \
             "sudo systemctl enable --now NetworkManager" \
             "Network Service"

# 3. Configurar el reloj del sistema (Hora automática e interoperabilidad con Dual-Boot)             
execute_step "Sincronizando reloj y activando servicio de tiempo" \
             "sudo timedatectl set-ntp true && sudo systemctl enable --now systemd-timesyncd" \
             "Time Sync"

# 4. Crear carpetas de usuario estándar (XDG Home)
execute_step "Creando carpetas personales (XDG)" \
             "xdg-user-dirs-update" \
             "XDG User Dirs"

# 5. Configurar pkgfile (Mapeo para el "command-not-found" automático de Zsh)
execute_step "Indexando base de datos de pkgfile" \
             "sudo pkgfile -u" \
             "pkgfile Update"

# 6. Cambiar Shell por defecto a Zsh para tu usuario local
execute_step "Cambiando Shell a Zsh" \
             "chsh -s \$(which zsh) \$USER" \
             "Zsh Shell Change"

# 7. Configuración de Idioma Regional (Locales)
execute_step "Configurando idioma (es_MX)" \
             "sudo sed -i 's/#es_MX.UTF-8 UTF-8/es_MX.UTF-8 UTF-8/' /etc/locale.gen && sudo locale-gen" \
             "Locale Generation"

execute_step "Estableciendo LANG por defecto" \
             "echo 'LANG=es_MX.UTF-8' | sudo tee /etc/locale.conf" \
             "Locale Conf"

# 9. Mantenimiento del ciclo de vida del SSD (Crucial para laptops)
execute_step "Habilitando mantenimiento de SSD (fstrim)" \
             "sudo systemctl enable fstrim.timer" \
             "FSTrim Timer"

