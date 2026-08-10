#!/bin/bash
# =====================================================================
# INSTALA REFLECTOR PARA LOS MIRRORS
# =====================================================================
execute_step "Instalando reflector" \
             "sudo pacman -S --needed --noconfirm reflector" \
             "reflector"