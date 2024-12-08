#!/bin/bash

# Definir caminho dos scripts
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts"

# Importar módulos
source "$SCRIPT_DIR/package_manager.sh"
source "$SCRIPT_DIR/system_update.sh"
source "$SCRIPT_DIR/software_installation.sh"
source "$SCRIPT_DIR/webapp_config.sh"
source "$SCRIPT_DIR/dotfiles.sh"
source "$SCRIPT_DIR/system_config.sh"

# Menu principal
main_menu() {
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
        echo "1. Instalar Apps"
        echo "2. Instalar WebApps"
        echo "3. Instalar Dotfiles do Hyprland"
        echo "4. Sincronizar relógio (Localtime)"
        echo "0. Sair"
        echo
        read -p "Escolha uma opção: " choice

        case $choice in
            1) install_apps_menu ;;
            2) install_webapps_menu ;;
            3) install_hyprland_dotfiles_menu ;;
            4) sync_windows_clock ;;
            0) echo "Saindo..."; exit 0 ;;
            *) echo "Opção inválida!" ;;
        esac
    done
}

# Verificar dependências
check_dependencies() {
    local dependencies=("bash" "git" "flatpak")
    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo "Dependência ausente: $dep"
            exit 1
        fi
    done
}

# Executar verificações e menu principal
check_dependencies
main_menu