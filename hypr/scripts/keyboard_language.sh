#!/bin/bash

#Variable de lenguaje
current_layout=

# Muestra el mensaje
if [ "$current_layout" == 1 ]; then
    notify-send "Teclado cambiado" "Diseño: Español (ES)" --icon=input-keyboard
else
    notify-send "Teclado cambiado" "Diseño: Inglés (US)" --icon=input-keyboard
fi
