#!/bin/bash
# =====================================================================
#     MIRRORS — Configura mirrors de México y USA con reflector
# =====================================================================

MIRROR_CMD="sudo reflector \
    --country 'Mexico,United States' \
    --protocol https \
    --latest 30 \
    --completion-percent 95 \
    --sort rate \
    --save /etc/pacman.d/mirrorlist"

execute_step "Optimizando mirrors (MX + USA)" \
             "$MIRROR_CMD" \
             "Mirrors-Update"

execute_step "Mostrando los 5 mirrors más rápidos" \
             "echo '--- Top 5 ---' && head -n 5 /etc/pacman.d/mirrorlist" \
             "Top-Mirrors"

execute_step "Sincronizando bases de datos de paquetes" \
             "sudo pacman -Syy" \
             "Pacman-Sync"