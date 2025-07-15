#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cl='clear'
alias rofi-emoji='rofimoji'
alias ex=exit
alias off='shutdown -hP now'
alias startdb='sudo systemctl start mariadb'
alias java8='sudo archlinux-java set java-8-openjdk'
alias java21='sudo archlinux-java set java-21-openjdk'


#Kitty + kitten icat $1
# tty-clock -c -s -C 6
# Alias para buscar dentro de archivos (contenido)
alias searchonfiles='grep -riwl'

#Hamachi
#start/stop
alias start-hamachi='sudo systemctl start logmein-hamachi'
alias stop-hamachi='sudo systemctl stop logmein-hamachi'
alias status-hamachi='sudo systemctl status logmein-hamachi'

#Login
alias login-hamachi='sudo hamachi login'

#sesion
sesion-hamachi(){
    sudo hamachi attach $1
}

red(){
  sudo systemctl restart NetworkManager
  nmcli device disconnect wlan0
  nmcli device wifi hotspot ifname wlan0 band a ssid "$1" password "$2"
}

red() {
  if [ $# -ne 2 ]; then
    echo "Uso: red SSID contraseña"
    return 1
  fi
  sudo systemctl restart NetworkManager && \
  nmcli device disconnect wlan0 && \
  nmcli device wifi hotspot ifname wlan0 band a ssid "$1" password "$2"
}




# Función para buscar archivos por nombre (insensible a mayúsculas)
searchfile() {

  # $1 = cadena a buscar, $2 = ruta (opcional, por defecto .)
  find "${2:-.}" -type f -iname "*$1*"
}

# Función para activar hostpot
PS1='[\u@\h \W]\$ '
#PS1='~ \$ '

alias red='nmcli device wifi hotspot ifname wlan0 band a ssid "BOCHOLOVER" password "12345678"'
