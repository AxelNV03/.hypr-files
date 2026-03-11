# --- Configuración de Mirrors (UNAM + USA) ---

# 1. Generar la nueva lista de mirrors
# --country: Filtra por México (MX) y Estados Unidos (US)
# --protocol: Usamos https para mayor seguridad
# --sort: Los ordena por velocidad de descarga (rate)
# --save: Donde guardar el resultado
MIRROR_CMD="sudo reflector --country 'Mexico,United States' --protocol https --latest 20 --sort rate --save /etc/pacman.d/mirrorlist"

execute_step "Optimizando mirrors (UNAM/USA)" "$MIRROR_CMD" "Mirrors-Update"

# 3. Refrescar la base de datos de paquetes con los nuevos mirrors
execute_step "Sincronizando repositorios" "sudo pacman -Syy" "Pacman-Update"