#!/bin/bash
#
#  NV - V 1.0 - 26/02/25
#

# -----------------------------------------------------
# Busca el tema
# -----------------------------------------------------


# Ruta de los archivos
if [ -f ~/.config/waybar/tema_activo.sh ]; then
    themestyle = $(cat ~./config/waybar/tema_activo.sh)
else 
    echo "Tema no encontrado, cargando tema por defecto"
    themestyle =
fi

# -----------------------------------------------------
# Carga las configuraciones
# -----------------------------------------------------
configs = ""
styles = ""

