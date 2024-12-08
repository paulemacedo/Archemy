#!/bin/bash

# Função para sincronizar o relógio do Windows
sync_windows_clock() {
    read -p "Deseja configurar o relógio para Localtime? (y/n): " confirm
    if [[ $confirm == [yY] ]]; then
        echo "Configurando relógio para Localtime..."
        sudo timedatectl set-local-rtc 1 --adjust-system-clock
        timedatectl
    else
        echo "Operação cancelada."
    fi
}

# Função para configurações gerais do sistema
system_optimization() {
    echo "Otimizando configurações do sistema..."
    
    # Desabilitar beep do sistema
    sudo bash -c 'echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf'
    
    # Aumentar limites de inotify
    sudo bash -c 'echo "fs.inotify.max_user_watches=524288" > /etc/sysctl.d/40-max-user-watches.conf'
    sudo sysctl --system
}