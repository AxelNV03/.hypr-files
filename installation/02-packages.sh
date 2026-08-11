#!/usr/bin/env bash
# =====================================================================
#     BASE HYPRLAND — Infraestructura genérica (Desktop/Laptop)
#     Todo lo necesario para que Hyprland funcione. Sin apps personales.
# =====================================================================

# --- [ 1. SISTEMA Y COMPILACIÓN ] ---
PKGS_SYSTEM=(
    "base-devel"                  # Herramientas de compilación (gcc, make, binutils) — Vital para AUR
    "linux-headers"               # Headers del kernel para compilar módulos (drivers, VirtualBox)
    "dkms"                        # Recompila automáticamente módulos del kernel al actualizarlo
    "git"                         # Control de versiones — Clonar dotfiles y helper AUR
    "curl"                        # Transferencia de datos para scripts y APIs
    "wget"                        # Descarga de archivos alternativa
    "polkit"                      # Marco de privilegios — Permisos de administración para apps gráficas
    "jq"                          # Procesador JSON en terminal — Útil para scripts que interactúan con APIs
    "stow"                        # Administrador de symlinks — Aplica y cambia diseños al instante sin duplicar archivos
)

# --- [ 2. RED, BLUETOOTH E IMPRESIÓN ] ---
PKGS_CONNECTIVITY=(
    "networkmanager"              # Demonio central de red (Wi-Fi, Ethernet, VPN)
    "bluez"                       # Pila de protocolos Bluetooth
    "bluez-utils"                 # Herramientas CLI Bluetooth (bluetoothctl)
    "cups"                        # Sistema de impresión — Evita errores en apps que linkan libcups
    "dnsmasq"                     # Servidor DNS/DHCP ligero para redes locales
)

# --- [ 3. WAYLAND + HYPRLAND CORE ] ---
PKGS_HYPRLAND=(
    "hyprland"                    # El compositor de ventanas dinámicas
    "wayland"                     # Protocolo gráfico moderno
    "xorg-xwayland"               # Compatibilidad apps X11 en Wayland
    "qt5-wayland"                 # Soporte Wayland nativo para apps Qt5
    "qt6-wayland"                 # Soporte Wayland nativo para apps Qt6
    "libxkbcommon"                # Manejo y traducción de distribuciones de teclado
    "xdg-utils"                   # Herramientas estándar de escritorio (xdg-open)
    "xdg-user-dirs"               # Genera carpetas ~/Documentos, ~/Descargas, etc.
    "xdg-desktop-portal"          # Backend de permisos y diálogos para Wayland
    "xdg-desktop-portal-hyprland" # Portal específico para Hyprland — Compartir pantalla, capturas
    "xdg-desktop-portal-gtk"      # Portal de respaldo GTK — Diálogos abrir/guardar archivo
)

# --- [ 4. COMPONENTES DEL ENTORNO HYPRLAND ] ---
# Demonios y utilidades que necesita Hyprland para funcionar como entorno completo
PKGS_HYPRLAND_ENV=(
    "hyprpolkitagent"             # Agente de autenticación — Prompt gráfico para sudo
    "hyprpaper"                   # Gestor de fondos de pantalla multi-monitor
    "hyprlock"                    # Bloqueador de pantalla seguro con efectos visuales
    "hypridle"                    # Demonio de inactividad — Atenúa y bloquea tras X minutos
    "hyprshot"                    # Capturador de pantalla nativo para Hyprland
    "hyprsunset"                  # Filtro de luz azul nocturna (similar a redshift)
    "kanshi"                      # Gestor dinámico de perfiles de pantalla (hotplug HDMI)
    "brightnessctl"               # Control de brillo de pantalla — Laptops y monitores DDC/CI
    "rofi-wayland"                # Launcher de aplicaciones nativo Wayland
    "cliphist"                    # Historial de portapapeles — Soporta texto e imágenes
    "wl-clipboard"                # Utilidades wl-copy y wl-paste para scripts
    "wf-recorder"                 # Grabador de pantalla por CLI para wlroots
    "playerctl"                   # Control de reproductores multimedia desde teclado
    "swaybg"                      # Wallpaper genérico (funciona en VM)
)

# --- [ 5. AUDIO CON PIPEWIRE ] ---
PKGS_AUDIO=(
    "pipewire"                    # Servidor de audio moderno (baja latencia)
    "pipewire-pulse"              # Compatibilidad con apps PulseAudio
    "pipewire-alsa"               # Compatibilidad con ALSA
    "wireplumber"                 # Gestor de sesiones — Detección y políticas de dispositivos
    "qpwgraph"                    # Matriz gráfica de conexiones de audio
)

# --- [ 6. BARRAS DE ESTADO Y NOTIFICACIONES ] ---
PKGS_UI=(
    "waybar"                      # Barra de estado altamente configurable (CSS/GTK)
    "swaync"                      # Centro de notificaciones moderno para Wayland
)

# --- [ 7. TERMINAL Y SHELL ] ---
PKGS_TERMINAL=(
    "kitty"                       # Emulador de terminal acelerado por GPU
    "zsh"                         # Shell interactivo avanzado
    "zsh-autosuggestions"         # Sugerencias inteligentes basadas en historial
    "zsh-syntax-highlighting"     # Resaltado de sintaxis en comandos
    "zsh-history-substring-search" # Búsqueda en historial escribiendo cualquier parte del comando
    "fastfetch"                   # Información del sistema ultra-rápida (reemplaza neofetch)
    "btop"                        # Monitor de recursos visual e interactivo en terminal
    "fzf"                         # Buscador difuso interactivo
    "pkgfile"                     # "Command not found" con sugerencias de paquetes
    "man-db"                      # Páginas de manual
    "man-pages"                   # Documentación extra de kernel y POSIX
)

# --- [ 8. COMPRESIÓN Y ARCHIVOS ] ---
PKGS_COMPRESSION=(
    "unarchiver"                  # Extractor universal (rar, 7z, zip, codificaciones raras)
    "p7zip"                       # Soporte completo .7z
    "unrar"                       # Soporte .rar
    "unzip"                       # Soporte .zip
    "zip"                         # Creación .zip
    "lrzip"                       # Compresor optimizado para archivos masivos
    "lz4"                         # Compresión ultra-rápida
    "lzo"                         # Compresión enfocada en velocidad
    "cpio"                        # Archivador clásico Unix (initramfs)
)

# --- [ 9. TIPOGRAFÍAS ] ---
PKGS_FONTS=(
    "ttf-jetbrains-mono-nerd"     # Monoespaciada principal con glifos Nerd Font — Necesaria para barras
    "ttf-font-awesome"            # Iconos vectoriales para barras y widgets
    "otf-font-awesome"            # Variación OpenType para compatibilidad extendida
    "noto-fonts-cjk"              # Caracteres chinos, japoneses y coreanos — Evita cuadros en web
    "noto-fonts-emoji"            # Emojis a color en navegadores y apps
    "ttf-dejavu"                  # Fuente de respaldo genérica Sans, Serif, Mono
    "ttf-liberation"              # Métricamente idénticas a Arial, Times New Roman, Courier
)

# --- [10. SISTEMA DE ARCHIVOS Y EXPLORADOR ] ---
PKGS_FILES=(
    "thunar"                      # Explorador de archivos ligero (XFCE)
    "tumbler"                     # Demonio de miniaturas para Thunar
    "ffmpegthumbnailer"           # Miniaturas de video
    "file-roller"                 # Interfaz gráfica para compresión/descompresión
    "gvfs"                        # Sistema de archivos virtual — Papelera, montaje USB
    "gvfs-mtp"                    # Soporte montaje Android/MTP
    "ncdu"                        # Análisis de uso de disco en terminal
    "tree"                        # Visualización de directorios en árbol
)
# =====================================================================
#                 UNIFICACIÓN E INSTALACIÓN
# =====================================================================

ALL_PACKAGES=(
    "${PKGS_SYSTEM[@]}"
    "${PKGS_CONNECTIVITY[@]}"
    "${PKGS_HYPRLAND[@]}"
    "${PKGS_HYPRLAND_ENV[@]}"
    "${PKGS_AUDIO[@]}"
    "${PKGS_UI[@]}"
    "${PKGS_TERMINAL[@]}"
    "${PKGS_COMPRESSION[@]}"
    "${PKGS_FONTS[@]}"
    "${PKGS_FILES[@]}"
)

echo "📦 Total de paquetes base Hyprland: ${#ALL_PACKAGES[@]}"

PACKAGES_STR="${ALL_PACKAGES[*]}"
execute_step "Instalando paquetes core desde repositorios oficiales" \
             "sudo pacman -S --needed --noconfirm $PACKAGES_STR" \
             "Base-Packages"