#!/usr/bin/env bash

# Script para instalar dependencias esenciales para Hyprland en Arch Linux
# Incluye polkit-gnome, herramientas de Wayland, fuentes y utilidades
# Autor: Nava
# Fecha: 13 de julio de 2025

# Modo seguro: falla en errores, variables no definidas o comandos fallidos en tuberías
set -euo pipefail

# Función para manejar errores
handle_error() {
    echo "❌ Error en la línea $1: '$2' falló."
    exit 1
}
trap 'handle_error $LINENO "$BASH_COMMAND"' ERR

# Verificar permisos de sudo
if ! sudo -v &>/dev/null; then
    echo "❌ Este script requiere permisos de sudo."
    exit 1
fi

# Actualizar el sistema antes de instalar
echo "🔄 Actualizando el sistema..."
sudo pacman -Syu --noconfirm > /dev/null 2>&1

# Lista de paquetes organizados por categoría
BASE_PKGS="base-devel polkit polkit-gnome"  # Dependencias base y Polkit
WAYLAND_PKGS="wayland xorg-xwayland qt5-wayland qt6-wayland xdg-utils xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-hyprland"  # Soporte Wayland
FONTS_PKGS="ttf-dejavu ttf-liberation ttf-jetbrains-mono ttf-font-awesome"  # Fuentes
TOOLS_PKGS="thunar gvfs rofi brightnessctl wl-clipboard fastfetch htop btop ntfs-3g playerctl gammastep"  # Herramientas y utilidades

# Combinar todos los paquetes
ALL_PKGS="$BASE_PKGS $WAYLAND_PKGS $FONTS_PKGS $TOOLS_PKGS"

# Instalar paquetes
echo "📦 Instalando dependencias: $ALL_PKGS"
sudo pacman -S --needed --noconfirm $ALL_PKGS > /dev/null 2>&1

# Crear directorios de usuario por defecto
echo "📂 Creando directorios de usuario por defecto..."
xdg-user-dirs-update

# Crea enlace simbólico para gammastep
SOURCE=~/.hypr-files/gammastep/
DEST=~/.config/gammastep/

# Elimina cualquier configuración previa (carpeta o symlink)
[ -e "$DEST" ] && rm -rf "$DEST" > /dev/null 2>&1

# Crea el enlace simbólico
ln -s "$SOURCE" ~/.config/

echo "✔️ Instalación y configuración completadas. Reinicia Hyprland para aplicar los cambios."