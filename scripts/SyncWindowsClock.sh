#!/bin/bash

echo "Configurando relógio para Localtime..."
sudo timedatectl set-local-rtc 1 --adjust-system-clock

echo "Verificando a configuração atual:"
timedatectl
