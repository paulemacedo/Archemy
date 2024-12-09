#!/bin/bash

# Importar helper
source scripts/helper.sh

# Função para instalar Hyprdots
install_hyprdots() {
    info_msg "Instalando Hyprdots..."
    sudo pacman -S --needed git base-devel
    git clone --depth 1 https://github.com/prasanthrangan/hyprdots ~/HyDE
    cd ~/HyDE/Scripts || { error_msg "Falha ao acessar o diretório HyDE/Scripts."; return 1; }
    ./install.sh
    success_msg "Hyprdots instalado com sucesso!"
}

# Função para instalar End-4's Hyprland Dotfiles
install_end_4_dotfiles() {
    info_msg "Instalando End-4's Hyprland Dotfiles..."
    bash <(curl -s "https://end-4.github.io/dots-hyprland-wiki/setup.sh")
    success_msg "End-4's Hyprland Dotfiles instalado com sucesso!"
}

# Menu de instalação de Dotfiles
install_hyprland_dotfiles_menu() {
    while true; do
        echo "============================="
        echo "   Escolha seu Dotfiles      "
        echo "============================="
        echo "1. Hyprdots"
        echo "2. End-4's Hyprland Dotfiles"
        echo "0. Voltar"

        read -p "Escolha uma opção: " choice

        case $choice in
            1) install_hyprdots && break ;;
            2) install_end_4_dotfiles && break ;;
            0) break ;;
            *) warn_msg "Opção inválida!" ;;
        esac
    done
}