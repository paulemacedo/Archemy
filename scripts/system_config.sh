#!/bin/bash

# Importar helper
source scripts/helper.sh

# Função para sincronizar o relógio do Windows
sync_windows_clock() {
    if confirm_action "Deseja configurar o relógio para Localtime?"; then
        info_msg "Configurando relógio para Localtime..."
        sudo timedatectl set-local-rtc 1 --adjust-system-clock
        timedatectl
        success_msg "Relógio configurado para Localtime com sucesso!"
    else
        warn_msg "Operação cancelada."
    fi
}

# Função para configurações gerais do sistema
system_optimization() {
    info_msg "Otimizando configurações do sistema..."
    
    # Desabilitar beep do sistema
    sudo bash -c 'echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf'
    
    # Aumentar limites de inotify
    sudo bash -c 'echo "fs.inotify.max_user_watches=524288" > /etc/sysctl.d/40-max-user-watches.conf'
    sudo sysctl --system

    success_msg "Configurações do sistema otimizadas com sucesso!"
}