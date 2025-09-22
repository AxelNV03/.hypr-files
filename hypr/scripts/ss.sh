# #!/bin/bash
# # Script para capturar un área de la pantalla con grim y slurp

# # Crear la carpeta si no existe
# mkdir -p ~/Media/ss

# # Contar cuántas capturas .png hay en ~/Media/ss
# count=$(ls ~/Media/ss/*.png 2>/dev/null | wc -l)
# next=$((count + 1))

# # Seleccionar un área de la pantalla usando slurp
# area=$(slurp)

# # Usar grim para capturar la selección
# name=~/Media/ss/screenshot_$next.png

# grim -g "$area" "$name"

# wl-copy < "$name"

#!/bin/bash
# Script para capturar un área de la pantalla con grim y slurp

# Definir la carpeta de destino
DEST_DIR="$HOME/Imágenes/capturas"

# Crear la carpeta si no existe
mkdir -p "$DEST_DIR" || { echo "Error: No se pudo crear $DEST_DIR"; exit 1; }

# Verificar si la carpeta es escribible
if [[ ! -w "$DEST_DIR" ]]; then
    echo "Error: No se puede escribir en $DEST_DIR"
    exit 1
fi

# Contar capturas existentes (usando find para mayor robustez)
count=$(find "$DEST_DIR" -maxdepth 1 -type f -name "*.png" | wc -l)
next=$((count + 1))

# Generar un nombre de archivo con marca de tiempo
timestamp=$(date +%Y%m%d_%H%M%S)
name="$DEST_DIR/screenshot_${timestamp}_${next}.png"

# Seleccionar un área de la pantalla usando slurp
area=$(slurp 2>/dev/null)
if [[ -z "$area" ]]; then
    echo "Error: Selección cancelada o fallida"
    exit 1
fi

# Usar grim para capturar la selección
if ! grim -g "$area" "$name"; then
    echo "Error: No se pudo capturar la pantalla"
    exit 1
fi

# Copiar la imagen al portapapeles
if wl-copy < "$name"; then
    # Enviar notificación de éxito
    notify-send "Captura de pantalla" "Guardada en $name y copiada al portapapeles"
else
    echo "Error: No se pudo copiar la imagen al portapapeles"
    exit 1
fi