#!/bin/bash

# Função para instalar Hyprdots
install_hyprdots() {
    echo "Instalando Hyprdots..."
    sudo pacman -S --needed git base-devel
    git clone --depth 1 https://github.com/prasanthrangan/hyprdots ~/HyDE
    cd ~/HyDE/Scripts || { echo "Falha ao acessar o diretório HyDE/Scripts."; return 1; }
    ./install.sh
}

# Função para instalar End-4's Hyprland Dotfiles
install_end_4_dotfiles() {
    echo "Instalando End-4's Hyprland Dotfiles..."
    bash <(curl -s "https://end-4.github.io/dots-hyprland-wiki/setup.sh")
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
            *) echo "Opção inválida!" ;;
        esac
    done
}