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
source "$SCRIPT_DIR/helper.sh"

# Verificar argumentos de linha de comando
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
elif [[ "$1" == "-i || "$1" == "--minimal" ]]; then
    install_all_apps
    exit 0
elif [[ "$1" == "-w" || "$1" == "--webapps" ]]; then
    install_all_webapps
    exit 0
elif [[ "$1" == "-c" || "$1" == "--complete" ]]; then
    install_all_apps
    install_all_webapps
    sync_windows_clock
    exit 0
fi


# Função para exibir a ajuda
show_help() {
    echo "Uso: $0 [opções]"
    echo
    echo "Archemy: Sistema de Instalação e Configuração Linux"
    echo
    echo "Descrição:"
    echo "  Archemy é um script para instalação e configuração de sistemas Linux,"
    echo "  com foco em distribuições Arch e derivadas. Ele automatiza a instalação de"
    echo "  pacotes, configuração de WebApps, instalação de dotfiles do Hyprland e"
    echo "  otimizações de sistema."
    echo
    echo "Recursos:"
    echo "  - Detecção automática do gerenciador de pacotes"
    echo "  - Instalação de pacotes via pacman, paru, yay, apt, dnf e Flatpak"
    echo "  - Configuração de WebApps"
    echo "  - Instalação de dotfiles do Hyprland"
    echo "  - Otimizações de sistema"
    echo
    echo "Opções:"
    echo "  ./main.sh -h, --help        Exibe esta mensagem de ajuda"
    echo "  ./main.sh -i, --minimal     Instala todos os aplicativos"
    echo "  ./main.sh -w, --webapps     Instala todos os WebApps"
    echo "  ./main.sh -c, --complete    Instala todos os aplicativos, WebApps e sincroniza o relógio"
    echo "  ./main.sh                   Execute o script sem opções para exibir o menu interativo"
}

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

# Verificar e instalar dependências usando o package_manager.sh
check_dependencies() {
    local dependencies=("bash" "git" "flatpak")
    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo "Dependência ausente: $dep. Tentando instalar..."
            install_package "$dep"
        fi
    done
}

# Executar verificações e menu principal
check_dependencies
main_menu