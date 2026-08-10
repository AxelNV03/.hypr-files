#!/usr/bin/env bash
# =====================================================================
#     APLICACIONES PERSONALES — Tu stack de productividad
#     Editores, navegador, herramientas de desarrollo, multimedia.
# =====================================================================

# --- [ 1. EDITORES E IDE ] ---
PKGS_EDITORS=(
    "nvim"                        # Neovim — Editor principal basado en teclado
    "vim"                         # Vim clásico — Respaldo si la config de Neovim se rompe
)

# --- [ 2. NAVEGADOR Y COMUNICACIÓN ] ---
PKGS_INTERNET=(
    "firefox"                     # Navegador principal
    "bitwarden"                   # Gestor de contraseñas
)

# --- [ 3. NOTAS Y CONOCIMIENTO ] ---
PKGS_KNOWLEDGE=(
    "obsidian"                    # Base de conocimientos en Markdown
)

# --- [ 4. DESARROLLO ] ---
PKGS_DEVELOPMENT=(
    "rust"                        # Lenguaje Rust + Cargo
    "imagemagick"                 # Manipulación de imágenes por CLI
)

# --- [ 5. PERSONALIZACIÓN VISUAL ] ---
PKGS_THEMING=(
    "matugen"                     # Generador de paletas Material You desde wallpaper
    "lxappearance"                # Configuración de temas GTK
    "xsettingsd"                  # Demonio de configuración Xsettings
    "dconf"                       # Sistema de configuración GNOME (temas)
    "gnome-themes-extra"          # Temas adicionales GTK
    "papirus-icon-theme"          # Tema de iconos Papirus
    "nwg-look"                    # Configurador visual de temas GTK para Wayland
)

# --- [ 6. MULTIMEDIA Y OCIO ] ---
PKGS_MULTIMEDIA=(
    "mpv"                         # Reproductor de video ligero
    "easyeffects"                 # Procesador de efectos de audio (ecualizador, limitador)
)

# --- [ 7. EXPLORADOR DE ARCHIVOS CLI ] ---
PKGS_CLI_TOOLS=(
    "yazi"                        # Explorador de archivos CLI ultra-rápido (Rust, Vim motions)
    "expac"                       # Extractor de datos de pacman — Útil para alias personalizados
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
    "${PKGS_CLI_TOOLS[@]}"
)

echo "📦 Total de paquetes personales: ${#ALL_PACKAGES[@]}"
PACKAGES_STR="${ALL_PACKAGES[*]}"
execute_step "Instalando paquetes core desde repositorios oficiales" \
             "sudo pacman -S --needed --noconfirm $PACKAGES_STR" \
             "Base-Packages"