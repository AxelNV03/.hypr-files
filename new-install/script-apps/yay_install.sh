#!/usr/bin/env bash

# Modo seguro
set -euo pipefail

# Manejo de errores mejorado
trap 'echo "❌ Error en línea $LINENO. Comando fallido: $BASH_COMMAND"; exit 1' ERR

# Verificar dependencias
if ! command -v git &> /dev/null || ! pacman -Qi base-devel &> /dev/null; then
    echo "❌ Error: Necesitas instalar git y base-devel primero."
    echo "Ejecuta: sudo pacman -S --needed git base-devel"
    exit 1
fi

# Verificar si yay ya está instalado
if command -v yay &> /dev/null; then
    echo "✔️ yay ya está instalado. Saltando instalación."
    exit 0
fi

# Mensaje de inicio
echo -e "\nInstalando y configurando yay..."

# Variables
YAY_REPO="https://aur.archlinux.org/yay.git"
YAY_DIR="$(mktemp -d)/yay"

# Clonar y compilar yay
git clone "$YAY_REPO" "$YAY_DIR" > /dev/null 2>&1
cd "$YAY_DIR" || exit 1
makepkg -si --noconfirm > /dev/null 2>&1

# Limpieza
rm -rf -- "$YAY_DIR" > /dev/null 2>&1

# Mensaje de éxito
echo "✔️ Yay ha sido instalado correctamente."

#fgao210204