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

echo ██████╗ ██╗  ██╗ █████╗ ███╗   ███╗██████╗ ██╗██████╗ 
echo ██╔══██╗██║  ██║██╔══██╗████╗ ████║██╔══██╗██║██╔══██╗
echo ██║  ██║███████║███████║██╔████╔██║██████╔╝██║██████╔╝
echo ██║  ██║██╔══██║██╔══██║██║╚██╔╝██║██╔═══╝ ██║██╔══██╣
echo ██████╔╝██║  ██║██║  ██║██║ ╚═╝ ██║██║     ██║██║  ██║ 
echo ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝  


echo  ██████╗ ██╗  ██╗ █████╗ ███╗   ███╗██████╗ ██╗██████╗ 
echo ██╔════╝ ██║  ██║██╔══██╗████╗ ████║██╔══██╗██║██╔══██╗
echo ██║  ███╗███████║███████║██╔████╔██║██║  ██║██║██████╔╝
echo ██║   ██║██╔══██║██╔══██║██║╚██╔╝██║██║  ██║██║██╔═══╝ 
echo ╚██████╔╝██║  ██║██║  ██║██║ ╚═╝ ██║██████╔╝██║██║     
echo  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝╚═╝    

# Menu interativo
while true; do
    echo "============================="
    echo "   Instalador Automatizado   "
    echo "============================="
    echo "1. Instalar Sistema Básico"
    echo "2. Ferramentas de Desenvolvimento"
    echo "3. Ferramentas de Mídia"
    echo "4. Jogos"
    echo "5. Ferramentas de Terminal"
    echo "6. Configurar Webapps"
    echo "7. Instalar Tudo"
    echo "0. Sair"
    echo
    read -p "Escolha uma opção: " choice
    echo

    case $choice in
        1) run_script scripts/system.sh ;;
        2) run_script scripts/devtools.sh ;;
        3) run_script scripts/media_tools.sh ;;
        4) run_script scripts/gaming_tools.sh ;;
        5) run_script scripts/terminal_tools.sh ;;
        6) run_script scripts/webapps.sh ;;
        7) install_all ;;
        0) echo "Saindo..." && exit ;;
        *) echo "Opção inválida! Tente novamente." ;;
    esac
done
