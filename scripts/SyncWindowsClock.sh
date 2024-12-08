#!/bin/bash

read -p "Tem certeza de que deseja configurar o relógio para Localtime? (y/n): " confirm
if [[ $confirm == [yY] ]]; then
    echo "Configurando relógio para Localtime..."
    sudo timedatectl set-local-rtc 1 --adjust-system-clock

    echo "Verificando a configuração atual:"
    timedatectl
else
    echo "Operação cancelada."
fi
