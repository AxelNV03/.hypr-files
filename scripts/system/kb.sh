#!/usr/bin/env bash
set -euo pipefail

idx="$(
  hyprctl devices | awk '
    # Cada vez que empieza un teclado nuevo, reseteamos variables del bloque
    /^\tKeyboard at / { idx=""; main="no"; next }

    # Guardamos el índice cuando aparece dentro del bloque
    /\t\t\tactive layout index:/ { idx=$NF; next }

    # Si este teclado es el principal, imprimimos el idx guardado
    /\t\t\tmain: yes/ { print idx; exit }
  '
)"

# kb_layout = us,latam  => 0=US, 1=LAT
if [[ "${idx:-0}" == "1" ]]; then
  echo "󰌌 LAT"
else
  echo "󰌌 US"
fi
