#!/bin/bash

# Função para instalar Hyprdots
install_hyprdots() {
    echo "Instalando Hyprdots..."
    sudo pacman -S --needed git base-devel
    git clone --depth 1 https://github.com/prasanthrangan/hyprdots ~/HyDE
    cd ~/HyDE/Scripts || { echo "Falha ao acessar o diretório HyDE/Scripts."; exit 1; }
    ./install.sh
    echo "Hyprdots instalado com sucesso!"
}

# Função para instalar End-4's Hyprland Dotfiles
install_end_4() {
    echo "Instalando End-4's Hyprland Dotfiles..."
    bash <(curl -s "https://end-4.github.io/dots-hyprland-wiki/setup.sh")
    echo "End-4's Hyprland Dotfiles instalado com sucesso!"
}

# Menu interativo
while true; do
    echo "============================="
    echo "   Escolha seu Dotfiles      "
    echo "============================="
    echo "1. Hyprdots"
    echo "2. End-4's Hyprland Dotfiles"
    echo "0. Sair"
    echo
    read -p "Escolha uma opção: " choice
    echo

    case $choice in
        1) install_hyprdots ; break ;;
        2) install_end_4 ; break ;;
        0) echo "Saindo..." ; exit ;;
        *) echo "Opção inválida! Tente novamente." ;;
    esac
done
