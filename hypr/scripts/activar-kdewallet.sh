#!/bin/bash
# Iniciar KDE Wallet daemon
kwalletd6 &
# Esperar un poco para que se inicie
sleep 1
# Abrir el wallet por defecto (opcional)
kwallet-query --folder=kdewallet --list-entries kdewallet