#!/usr/bin/bash

# Da permiso de ejecución a los scripts
chmod +x scripts_Installation/*.sh

# Ejecutar cada script en orden
for script in scripts_Installation/*.sh; do
    echo "Ejecutando $script..."
    "$script"
done

echo "Todos los scripts han sido ejecutados."