#!/usr/bin/env bash
# =====================================================================
#     APLICACIONES PERSONALES — Tu stack de productividad
#     Editores, navegador, herramientas de desarrollo, multimedia.
# =====================================================================

# --- [ 1. EDITORES E IDE ] ---
PKGS_EDITORS=(
    "nvim"                        # Neovim — Editor principal basado en teclado
    "vim"                         # Vim clásico — Respaldo
)

# --- [ 2. NAVEGADOR Y COMUNICACIÓN ] ---
PKGS_INTERNET=(
    "firefox"                     # Navegador principal
    "bitwarden"                   # Gestor de contraseñas
    "telegram-desktop"            # Mensajería instantánea
)

# --- [ 3. NOTAS Y CONOCIMIENTO ] ---
PKGS_KNOWLEDGE=(
    "obsidian"                    # Base de conocimientos en Markdown
)

# --- [ 4. DESARROLLO ] ---
PKGS_DEVELOPMENT=(
    "rust"                        # Lenguaje Rust + Cargo — Apps GTK4
    "imagemagick"                 # Manipulación de imágenes por CLI
    "gtk3"                        # Toolkit GTK3 — Dependencia de apps
)

# --- [ 5. PERSONALIZACIÓN VISUAL ] ---
PKGS_THEMING=(
    "matugen"                     # Generador de paletas Material You
    "lxappearance"                # Configuración de temas GTK
    "xsettingsd"                  # Demonio de configuración Xsettings
    "dconf"                       # Configuración GNOME (temas)
    "gnome-themes-extra"          # Temas adicionales GTK
    "papirus-icon-theme"          # Tema de iconos Papirus
    "nwg-look"                    # Configurador visual de temas GTK
    "adwaita-fonts"               # Fuente Adwaita Sans
)

# --- [ 6. MULTIMEDIA Y OCIO ] ---
PKGS_MULTIMEDIA=(
    "mpv"                         # Reproductor de video ligero
    "easyeffects"                 # Procesador de efectos de audio
)

# --- [ 7. TERMINAL Y SHELL ] ---
PKGS_TERMINAL=(
    "kitty"                       # Emulador de terminal
    "zsh"                         # Shell interactivo
    "zsh-autosuggestions"         # Sugerencias del historial
    "zsh-syntax-highlighting"     # Resaltado de sintaxis
    "zsh-history-substring-search" # Búsqueda en historial
    "zsh-completions"             # Autocompletado extra
    "bash-completion"             # Autocompletado Bash
    "fastfetch"                   # Info del sistema
    "btop"                        # Monitor de recursos
    "fzf"                         # Buscador difuso
    "pkgfile"                     # "Command not found"
    "man-db"                      # Páginas de manual
    "man-pages"                   # Documentación extra
    "eza"                         # ls moderno
    "bat"                         # cat con colores
    "zoxide"                      # cd inteligente
    "ripgrep"                     # grep moderno
    "fd"                          # find moderno
    "tealdeer"                    # tldr
    "ncdu"                        # Análisis de disco
    "tree"                        # Visualización de árbol
)

# --- [ 8. EXPLORADOR DE ARCHIVOS CLI ] ---
PKGS_CLI_TOOLS=(
    "yazi"                        # Explorador de archivos CLI
    "expac"                       # Extractor de datos de pacman
)

# --- [ 9. SEGURIDAD ] ---
PKGS_SECURITY=(
    "ufw"                         # Firewall simple
    # "cursor-clip"               # Pendiente
)

# =====================================================================
#                 UNIFICACIÓN E INSTALACIÓN
# =====================================================================

ALL_PACKAGES=(
    "${PKGS_EDITORS[@]}"
    "${PKGS_INTERNET[@]}"
    "${PKGS_KNOWLEDGE[@]}"
    "${PKGS_DEVELOPMENT[@]}"
    "${PKGS_THEMING[@]}"
    "${PKGS_MULTIMEDIA[@]}"
    "${PKGS_TERMINAL[@]}"
    "${PKGS_CLI_TOOLS[@]}"
    "${PKGS_SECURITY[@]}"
)

echo "📦 Total de paquetes personales: ${#ALL_PACKAGES[@]}"
PACKAGES_STR="${ALL_PACKAGES[*]}"
execute_step "Instalando paquetes personales" \
             "sudo pacman -S --needed --noconfirm $PACKAGES_STR" \
             "Personal-Packages"

# =====================================================================
#    PAQUETES AUR (PERSONALES)
# =====================================================================
PARU_PERSONAL=(
    "losslesscut-bin"             # Editor de video sin pérdida
    "brave-origin-bin"            # Brave Browser
    "visual-studio-code-bin"      # VS Code
    "elecwhat-bin"                # Cliente de WhatsApp ligero (usa electron del sistema)
)

for pkg in "${PARU_PERSONAL[@]}"; do
    if pacman -Qi "$pkg" &>/dev/null || paru -Qi "$pkg" &>/dev/null; then
        echo -e "${GREEN}✅ $pkg ya instalado${NC}"
        continue
    fi
    
    execute_step "AUR → $pkg" \
                 "paru -S --needed --noconfirm $pkg" \
                 "$pkg"
done

echo -e "${GREEN}✅ Paquetes personales instalados correctamente.${NC}"