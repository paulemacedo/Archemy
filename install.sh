#!/bin/bash

# Carregando a configuração do gerenciador de pacotes
source config.sh

# Função para instalar pacotes
install_packages() {
    local packages="$1"
    echo "Pacotes a serem instalados: $packages"

    if [ "$PKG_MANAGER" == "paru" ]; then
        paru -Syu --needed $packages --noconfirm
    elif [ "$PKG_MANAGER" == "yay" ]; then
        yay -Syu --needed $packages --noconfirm
    elif [ "$PKG_MANAGER" == "apt" ]; then
        sudo apt update
        sudo apt install -y $packages
    elif [ "$PKG_MANAGER" == "dnf" ]; then
        sudo dnf install -y $packages
    else
        sudo pacman -Syu --needed $packages --noconfirm
    fi
}

# Função para instalar scripts específicos
run_script() {
    echo "Executando: $1"
    bash "$1" || { echo "Erro ao executar $1"; exit 1; }
}

# Instalar todos os componentes
install_all() {
    for script in scripts/*.sh; do
        run_script "$script"
    done
}

# Menu interativo
while true; do
    echo "▄▄▄       ██▀███   ▄████▄   ██░ ██ ▓█████  ███▄ ▄███▓▓██   ██▓"
    echo "▒████▄    ▓██ ▒ ██▒▒██▀ ▀█  ▓██░ ██▒▓█   ▀ ▓██▒▀█▀ ██▒ ▒██  ██▒"
    echo "▒██  ▀█▄  ▓██ ░▄█ ▒▒▓█    ▄ ▒██▀▀██░▒███   ▓██    ▓██░  ▒██ ██░"
    echo "░██▄▄▄▄██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒░▓█ ░██ ▒▓█  ▄ ▒██    ▒██   ░ ▐██▓░"
    echo " ▓█   ▓██▒░██▓ ▒██▒▒ ▓███▀ ░░▓█▒░██▓░▒████▒▒██▒   ░██▒  ░ ██▒▓░"
    echo " ▒▒   ▓▒█░░ ▒▓ ░▒▓░░ ░▒ ▒  ░ ▒ ░░▒░▒░░ ▒░ ░░ ▒░   ░  ░   ██▒▒▒"
    echo "  ▒   ▒▒ ░  ░▒ ░ ▒░  ░  ▒    ▒ ░▒░ ░ ░ ░  ░░  ░      ░ ▓██ ░▒░"
    echo "  ░   ▒     ░░   ░ ░         ░  ░░ ░   ░   ░      ░    ▒ ▒ ░░"
    echo "      ░  ░   ░     ░ ░       ░  ░  ░   ░  ░       ░    ░ ░"
    echo 
    echo "============================================================="
    echo "Cada script é um feitiço que invoca um conjunto de programas."
    echo "                                            🦇Paule Macedo🦇"
    echo "============================================================="
    echo 
    echo "🦇 O ritual da noite está prestes a começar..."
    echo "⚰️ Uma força sombria desperta para dominar a instalação de sua máquina."
    echo "🖤 Sinta o poder ancestral enquanto você invoca programas e ferramentas."
    echo "🕯️ Com um simples comando, os feitiços do sistema e das ferramentas serão lançados."
    echo "🦇 Sua jornada no abismo do código começou. Escolha sua opção abaixo..."
    echo
    echo "1. Instalar Pacotes Básicos do Sistema"
    echo "2. Instalar Ferramentas de Desenvolvimento"
    echo "3. Instalar Ferramentas de Mídia"
    echo "4. Instalar Ferramentas de Jogos"
    echo "5. Instalar Ferramentas de Terminal"
    echo "6. Configurar Webapps"
    echo "7. Hyprland DotFiles"
    echo "8. Sincronizar Relógio do Windows"
    echo "9. Instalar Tudo"
    echo "0. Sair"
    echo
    echo "Escolha suas opções (separadas por espaço):"
    read -p "Exemplo: 1 3 5: " choices
    echo

    PACKAGES=""

    for choice in $choices; do
        case $choice in
            1) PACKAGES+="git base-devel fish paru flatpak kitty " ;;
            2) PACKAGES+="python nodejs git code github-desktop " ;;
            3) PACKAGES+="vlc gimp inkscape " ;;
            4) PACKAGES+="steam lutris " ;;
            5) PACKAGES+="fastfetch nitch btop cava pokemon-colorscripts-git neo " ;;
            6) run_script scripts/webapps.sh ;;
            7) run_script scripts/hyprland_dotfiles.sh ;;
            8) run_script scripts/SyncWindowsClock.sh ;;
            9) install_all ;;
            0) echo "Saindo..."; exit 0 ;;
            *) echo "Opção inválida: $choice" ;;
        esac
    done

    if [ -n "$PACKAGES" ]; then
        install_packages "$PACKAGES"
    fi
done