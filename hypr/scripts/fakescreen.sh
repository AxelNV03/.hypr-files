#!/bin/bash

# V2: Script que replica la secuencia manual descubierta.

# Revisamos el estado actual de la ventana.
ACTIVE_WINDOW_JSON=$(hyprctl activewindow -j)
IS_FULLSCREEN=$(echo "$ACTIVE_WINDOW_JSON" | jq -r '.fullscreen')
FULLSCREEN_MODE=$(echo "$ACTIVE_WINDOW_JSON" | jq -r '.fullscreenMode')

# Comprobamos si la ventana ya está en nuestro modo especial (maximizada pero creyéndose fullscreen).
if [[ "$IS_FULLSCREEN" == "true" && "$FULLSCREEN_MODE" == "1" ]]; then
    # Si SÍ está en ese modo, la devolvemos a la normalidad.
    hyprctl dispatch fullscreenstate 0 0
else
    # Si NO está en ese modo, ejecutamos tu secuencia manual de forma automatizada.
    # El comando --batch envía todas las instrucciones en un solo paquete, en orden.
    hyprctl --batch "dispatch fullscreenstate, * 2; dispatch fullscreen, 1"
fi