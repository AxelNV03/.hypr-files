# --- [ ALIASES MEJORADOS ] ---
export PAGOS_PATH="/home/nv/Proyectos/GestorPagos-Streaming"
export CARNE_PATH="/home/nv/Proyectos/Carniceria"


# Navegación y Listado
alias ls='ls --color=auto'              # Listar con color inteligente (auto no ensucia archivos)
alias grep='grep --color=auto'          # Resaltar coincidencias de forma inteligente
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Utilidades de Terminal
alias cl='clear'
alias ex='exit'
alias c='wl-copy'                       # Copiar al portapapeles de Wayland
alias rl='source ~/.zshrc'              # Recargar configuración de zsh
alias image='kitty +kitten icat'        # Mostrar imágenes en Kitty
alias h='history'                       # Acceso rápido al historial

# Administración de Sistema (ThinkPad/CachyOS)
alias system='sudo systemctl'
alias off='shutdown -hP now'
alias update='paru -Syu'                # Actualizar sistema y AUR
alias yay='paru'                        # Compatibilidad por memoria muscular
alias mirr='sudo rate-mirrors arch | sudo tee /etc/pacman.d/mirrorlist' # Optimizar espejos
alias j='journalctl -p 3 -xb'           # Ver errores críticos del sistema (Journal)

# Red y WiFi (nmcli)
alias wl='nmcli device wifi list'       # Ver redes disponibles
alias wcon='nmcli device wifi connect'  # Uso: wcon "SSID" password "PASS"

# Git Pro
alias gl='git --no-pager log --oneline --graph --decorate --all'

# Mantenimiento de Arch
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)' # Limpiar paquetes huérfanos
alias fixpacman='sudo rm /var/lib/pacman/db.lck' # Por si se bloquea pacman
alias fix-screens='killall -9 grim slurp grimblast 2>/dev/null && notify-send "Screenshot fix" "Procesos limpiados con éxito"'

# docker
alias dkup='docker compose up -d' # Levantar todo por primera vez o tras cambios
alias dkdown='docker compose down' # Detener y eliminar contenedores 
alias dkstart='docker compose start'
alias dkstop='docker compose stop'
alias dkls='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Networks}}"'
alias dklogs='docker compose logs -f'

# Streaming
alias pagos-start='docker compose -f $PAGOS_PATH/docker-compose.yml up -d'
alias pagos-stop='docker compose -f $PAGOS_PATH/docker-compose.yml stop'
alias pagos-down='docker compose -f $PAGOS_PATH/docker-compose.yml down -v'
alias pagos-logs='docker logs -f pagos_app'
alias pagos-db='docker exec -it pagos_db mariadb -u nava -p1234 streaming'
alias pagos-bash='docker exec -it pagos_app bash'
alias pagos-seed_admin='docker exec -it pagos_app python -m app.core.seeders.seed_admin'
alias pagos-build='docker compose -f $PAGOS_PATH/docker-compose.yml up -d --build'

# TLP
alias charge='sudo tlp chargeonce'
# ------------------------------------------------------------------
# 🥩 ENTORNOS CARNICERÍA (NestJS + Postgres)
# ------------------------------------------------------------------
alias carne-start='docker compose -f $CARNE_PATH/docker-compose.yml up -d'
alias carne-stop='docker compose -f $CARNE_PATH/docker-compose.yml stop'
alias carne-down='docker compose -f $CARNE_PATH/docker-compose.yml down'
alias carne-logs='docker logs -f contenedor_nestjs'
alias carne-bash='docker exec -it contenedor_nestjs sh' # Alpine usa 'sh' en lugar de 'bash'
alias carne-build='docker compose -f $CARNE_PATH/docker-compose.yml up -d --build --force-recreate'

# Base de Datos (PostgreSQL nativo en terminal)
alias carne-psql='docker exec -it contenedor_postgresql psql -U admin_carniceria -d carniceria_db'
alias carne-db="docker exec -it contenedor_nestjs npx prisma studio --port 5555 --browser none"
alias carne-migrate='docker exec -it contenedor_nestjs npx prisma migrate deploy'
alias carne-permisos="sudo chown -R \$USER:\$USER . && chmod -R u+rw ."

