#!/bin/bash

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
    echo " - Paule Macedo"
    echo "============================================================="
    echo 
    echo "🦇 O ritual da noite está prestes a começar..."
    echo "⚰️ Uma força sombria desperta para dominar a instalação de sua máquina."
    echo "🖤 Sinta o poder ancestral enquanto você invoca programas e ferramentas."
    echo "🕯️ Com um simples comando, os feitiços do sistema e das ferramentas serão lançados."
    echo "🦇 Sua jornada no abismo do código começou. Escolha sua opção abaixo..."
    echo
    echo "1. Instalar Sistema Básico"
    echo "2. Ferramentas de Desenvolvimento"
    echo "3. Ferramentas de Mídia"
    echo "4. Jogos"
    echo "5. Ferramentas de Terminal"
    echo "6. Configurar Webapps"
    echo "7. Hyprland DotFiles"
    echo "8. Instalar Tudo"
    echo "0. Sair"
    echo
    echo "Escolha suas opções (separadas por espaço):"
    read -p "Exemplo: 1 3 5: " choices
    echo

    for choice in $choices; do
        case $choice in
            1) run_script scripts/system.sh ;;
            2) run_script scripts/devtools.sh ;;
            3) run_script scripts/media_tools.sh ;;
            4) run_script scripts/gaming_tools.sh ;;
            5) run_script scripts/terminal_tools.sh ;;
            6) run_script scripts/webapps.sh ;;
            7) run_script scripts/hyprland_dotfiles.sh ;;
            8) run_script scripts/install_all.sh ;;
            0) echo "Saindo..."; exit 0 ;;
            *) echo "Opção inválida: $choice" ;;
        esac
    done
