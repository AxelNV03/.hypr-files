# Archivo de alias para Zsh
# Este archivo se carga al iniciar Zsh

alias ls='ls --color=always'            # Listar archivos con colores
alias grep='grep --color=always'        # Resaltar coincidencias en grep
alias cl='clear'                        # Limpiar la terminal
alias image='kitty +kitten icat'        # Mostrar imágenes en la terminal
alias off='shutdown -hP now'            # Apagar el sistema
alias ..='cd ..'                        # Subir un nivel en el sistema de archivos
alias ...='cd ../..'                    # Subir dos niveles en el sistema de archivos
alias ....='cd ../../..'                # Subir tres niveles en el sistema de archivos
alias ex='exit'                         # Salir de la terminal
alias clock='tty-clock -c -s -C 3'      # Reloj en la terminal
alias system='sudo systemctl'           # Alias para systemctl
alias wl='nmcli device wifi list'	# Alias para ver lista de wifi 
alias wcon='nmcli device wifi connect'	# Alias para conectarse a una red wifi 


# Solo en thinkpad
alias winM='sudo mount -t ntfs-3g /dev/nvme0n1p2 /mnt/windows -o uid=$(id -u),gid=$(id -g),umask=000'
alias winD='cd /mnt/windows/Users/Axel/Downloads'
 
