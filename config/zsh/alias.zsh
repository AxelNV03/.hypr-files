# --- [ ALIASES MEJORADOS ] ---

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
# alias clock='tty-clock -c -s -C 4'      # Reloj centrado (C4 es azul, combina con P10k)
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

# Atajos para archivos de configuración (Edición rápida)
alias zconf='micro ~/.zshrc'            # Cambia 'micro' por tu editor (nvim, code, etc)
alias p10conf='micro ~/.p10k.zsh'
alias hconf='micro ~/.config/hypr/hyprland.conf'