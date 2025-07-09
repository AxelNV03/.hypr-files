#!/usr/bin/bash

# Da permiso de ejecución a los scripts
chmod +x scripts_Installation/*.sh

# Copia el bashrc
echo -e "\nCopia de seguridad de .bashrc y reemplazo..."
cp ~/.bashrc ~/.bashrc.bak
cp ~/Hyprland-conf/.bashrc ~/.bashrc
echo "✔️ .bashrc copiado correctamente."

# Instala yay
./scripts_Installation/yay_install.sh

# Ejecutar cada script en orden
for script in scripts_Installation/*.sh; do
    if [[ "$script" != "scripts_Installation/yay_install.sh" ]]; then
        echo "Ejecutando $script..."
        "$script"
    fi
done

# Finalizar1
echo "Todos los scripts han sido ejecutados. Reiniciando el sistema para aplicar los cambios."
sleep 5
reboot