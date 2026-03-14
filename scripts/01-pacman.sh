#!/bin/bash

# --- 1. Lista de paquetes ---
PACMAN_PKGS=(
    # --- [ NÚCLEO Y HERRAMIENTAS DE DESCARGA ] ---
    "base-devel"          # Herramientas de compilación (indispensable para AUR)
    "git"                 # Clonar repositorios y uso de Paru
    "curl"                # Transferencia de datos (vital para scripts)
    "wget"                # Descarga de archivos desde terminal
    "jq"                  # Procesador de JSON (necesario para grimblast y scripts)
    "polkit"              # Elevación de privilegios
    "polkit-gnome"        # Agente visual para contraseñas (GUI)
    "vulkan-intel"
    "intel-media-driver"
    "libva-intel-driver"
    "libnotify"
    "ufw"
    "tlp"
    "tlp-rdw"
    "reflector"

    # --- [ RED Y CONECTIVIDAD ] ---
    "networkmanager"      # Servicio de gestión de redes
    "network-manager-applet" # Icono de red para la barra (nm-applet)
    "ntfs-3g"             # Soporte de lectura/escritura para discos Windows
    "bluez"                 # Stack base de Bluetooth
    "bluez-utils"           # Herramientas de terminal (bluetoothctl)
    "blueman"               # Gestor visual de Bluetooth (Icono en la barra)
    "network-manager-applet" # El icono 'nm-applet' para el Wi-Fi (Ya lo tienes)
    "dnsmasq"               # Para dar Ips en hostpot

    # --- [ COMPRESIÓN TOTAL (Multi-formato) ] ---
    "unrar"               # Extraer .rar
    "p7zip"               # Soporte .7z
    "unzip"               # Extraer .zip
    "zip"                 # Crear .zip
    "lrzip"               # Soporte Long Range ZIP
    "lz4"                 # Compresión ultra rápida
    "lzo"                 # Compresión veloz
    "cpio"                # Archivador clásico de Unix
    "unarchiver"          # Extractor universal (el "abre-todo")

    # --- [ ENTORNO HYPRLAND (Core) ] ---
    "hyprland"            # El compositor (Window Manager)
    "wayland"             # Protocolo base
    "xorg-xwayland"       # Compatibilidad con apps X11
    "qt5-wayland"         # Integración Qt5 en Wayland
    "qt6-wayland"         # Integración Qt6 en Wayland
    "xdg-utils"           # Herramientas de integración (open URL, etc)
    "xdg-user-dirs"       # Gestión de carpetas de usuario (Home)
    "xdg-desktop-portal"  # Backend de comunicación
    "xdg-desktop-portal-hyprland" # Portal específico para Hyprland

    # --- [ AUDIO (Arquitectura Pipewire) ] ---
    "pipewire"            # Motor de audio moderno
    "pipewire-pulse"      # Emulación de PulseAudio para apps
    "pipewire-alsa"       # Soporte para aplicaciones que usan ALSA (indispensable)
    "wireplumber"         # Gestor de sesiones y dispositivos
    "pavucontrol"         # Mezclador de audio visual (GUI)
    "pipewire-zeroconf"
    

    # --- [ INTERFAZ, ESTÉTICA Y CAPTURA ] ---
    "waybar"              # Barra de estado superior
    "hyprpaper"           # Gestor de fondos de pantalla
    "hyprlock"            # Bloqueador de pantalla oficial (Ecosistema Hypr)
    "hypridle"            # Gestor de tiempo para bloqueo
    "wlogout"             # Menú visual de salida (Apagar, Reiniciar, etc.)
    "gammastep"           # Filtro de luz azul (noche)
    "wl-clipboard"        # Gestión de portapapeles en Wayland
    "cliphist"            # El gestor de historial del portapapeles
    "grim"                # Capturador de pantalla
    "slurp"               # Selector de área de pantalla

    # --- [ TERMINAL Y SHELL ] ---
    "kitty"                       # Emulador de terminal (GPU accelerated)
    "zsh"                         # Shell interactiva principal
    "zsh-autosuggestions"         # Sugerencias tipo "fish"
    "zsh-syntax-highlighting"     # Colores mientras escribes
    "zsh-history-substring-search" # Buscar comandos previos con flechas
    "fastfetch"                   # Info del sistema al abrir terminal
    "btop"                        # Monitor de recursos elegante
    "htop"                        # Monitor de recursos clásico
    "expac"                       # Necesario para tu alias 'rip' (ver instalados recientes)
    "fzf"                         # Buscador difuso para el plugin de zsh
    "pkgfile" # PARA QUE FUNCIONE: source /usr/share/doc/pkgfile/command-not-found.zsh

    # --- [ EDITORES Y PRODUCTIVIDAD ] ---
    "vim"                 # Editor rápido para terminal
    "neovim"              # El IDE moderno en terminal
    "firefox"             # Navegador principal
    "obsidian"            # Notas y gestión de conocimiento
    "bitwarden"           # Gestor de contraseñas

    # --- [ GESTIÓN DE ARCHIVOS Y MULTIMEDIA ] ---
    "thunar"              # Explorador de archivos
    "thunar-archive-plugin" # Integración de comprimidos en Thunar
    "thunar-volman"         # Para que detecte cuando conectas una USB.
    "tumbler"               # Para miniaturas de fotos en el explorador thunar
    "ffmpegthumbnailer"     # Miniaturas videos                 
    "file-roller"         # Gestor visual de archivos comprimidos
    "gvfs"                # Papelera, montaje de USBs y red en Thunar
    "gvfs-mtp"            # Soporte para conectar dispositivos Android/MTP (indispensable)
    "vlc"                 # Reproductor multimedia
    "vlc-plugins-all"     # Soporte total de códecs
    "playerctl"           # Control de medios por teclado
    "brightnessctl"       # Control de brillo por teclado

    # --- [ FUENTES E ICONOS ] ---
    "ttf-jetbrains-mono-nerd"  # La reina de la terminal
    "ttf-font-awesome"         # Tus iconos de la Waybar
    "noto-fonts-cjk"           # Soporte para caracteres chinos/japoneses/coreanos (¡Indispensable!)
    "noto-fonts-emoji"         # Emojis (obligatorio para Slack/Discord/Web)
    "ttf-dejavu"               # Fuente Sans/Serif estándar para la web
    "ttf-liberation"           # Compatibilidad métrica con fuentes de MS
    "otf-font-awesome"    
)

echo -e "${BLUE}📦 Iniciando instalación de paquetes...${NC}"

# --- 2. Bucle de Instalación Individual ---
for pkg in "${PACMAN_PKGS[@]}"; do
    # Usamos execute_step para cada paquete individualmente
    execute_step "Instalando: $pkg" \
                 "sudo pacman -S --needed --noconfirm $pkg" \
                 "$pkg"
done