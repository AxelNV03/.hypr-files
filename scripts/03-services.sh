#!/bin/bash

echo -e "${BLUE}⚙️  Configurando servicios del sistema...${NC}"

# 1. Habilitar Bluetooth
execute_step "Habilitando Bluetooth" \
             "sudo systemctl enable --now bluetooth" \
             "Bluetooth Service"

# 2. Habilitar NetworkManager
execute_step "Habilitando Red" \
             "sudo systemctl enable --now NetworkManager" \
             "Network Service"

# 3. Configurar el reloj del sistema (Hora automática)
execute_step "Sincronizando reloj" \
             "sudo timedatectl set-ntp true" \
             "Time Sync"

# 4. Crear carpetas de usuario
execute_step "Creando carpetas personales (XDG)" \
             "xdg-user-dirs-update" \
             "XDG User Dirs"

# 5. Configurar pkgfile (para que funcione el 'command-not-found' de config.zsh)
execute_step "Indexando base de datos de pkgfile" \
             "sudo pkgfile -u" \
             "pkgfile Update"

# 6. Cambiar Shell por defecto a Zsh
execute_step "Cambiando Shell a Zsh" \
             "sudo chsh -s $(which zsh) $USER" \
             "Zsh Shell Change"

# 7. Configuración de Idioma (Locales)
execute_step "Configurando idioma (es_MX)" \
             "sudo sed -i 's/#es_MX.UTF-8 UTF-8/es_MX.UTF-8 UTF-8/' /etc/locale.gen && sudo locale-gen" \
             "Locale Generation"

execute_step "Estableciendo LANG por defecto" \
             "echo 'LANG=es_MX.UTF-8' | sudo tee /etc/locale.conf" \
             "Locale Conf"

# 8. Configurar Firewall (UFW)
execute_step "Configurando Firewall (UFW)" \
             "sudo systemctl enable --now ufw && \
              sudo ufw default deny incoming && \
              sudo ufw default allow outgoing && \
              sudo ufw --force enable" \
             "UFW Firewall"

# 9. Mantenimiento de SSD (VITAL para T490)
execute_step "Habilitando mantenimiento de SSD (fstrim)" \
             "sudo systemctl enable fstrim.timer" \
             "FSTrim Timer"

# # --- Configuración Maestra de Iconos (Look Sólido) ---
# execute_step "Instalando Papirus y Herramientas" \
#     "sudo pacman -S --noconfirm papirus-icon-theme papirus-folders-git" \
#     "Install-Icons"

# execute_step "Aplicando Color Teal al Tema Dark (Fix Brillo)" \
#     "sudo papirus-folders -C teal -t Papirus-Dark
#     "Apply-Teal-Dark"

# # Refrescar caché por si acaso
