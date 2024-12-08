#!/bin/bash

# Carregando a configuração do gerenciador de pacotes
if [ -f scripts/config.sh ]; then
    source scripts/config.sh
else
    echo "Erro: config.sh não encontrado!" >&2
    exit 1
fi

# Variável para armazenar os pacotes a serem instalados
PACKAGES=()

# Definindo os pacotes a serem instalados
BASIC_SYSTEM_PACKAGES="git fish flatpak kitty"
ARCH_EXCLUSIVE_PACKAGES="base-devel paru"
DEVTOOLS_PACKAGES="python nodejs git code github-desktop"
ALL_PACKAGES=("$BASIC_SYSTEM_PACKAGES" "$DEVTOOLS_PACKAGES" "$MEDIA_TOOLS_PACKAGES" "$GAMING_TOOLS_PACKAGES" "$TERMINAL_TOOLS_PACKAGES")
GAMING_TOOLS_PACKAGES="steam lutris"
TERMINAL_TOOLS_PACKAGES="fastfetch nitch btop cava pokemon-colorscripts-git neo"

# Adicionando todos os pacotes em uma variável
ALL_PACKAGES=($BASIC_SYSTEM_PACKAGES $DEVTOOLS_PACKAGES $MEDIA_TOOLS_PACKAGES $GAMING_TOOLS_PACKAGES $TERMINAL_TOOLS_PACKAGES)

# Função para instalar pacotes
install_packages() {
    echo "Pacotes a serem instalados: ${PACKAGES[@]}"

    case "$PKG_MANAGER" in
        paru)
            paru -Sy --needed ${PACKAGES[@]} --noconfirm
            ;;
        yay)
            yay -Sy --needed ${PACKAGES[@]} --noconfirm
            ;;
        apt)
            sudo apt update
            sudo apt install -y ${PACKAGES[@]}
            ;;
        dnf)
            sudo dnf install -y ${PACKAGES[@]}
            ;;
        *)
            sudo pacman -Sy --needed ${PACKAGES[@]} --noconfirm
            ;;
    esac
}

# Função para instalar scripts específicos
run_script() {
    echo "Executando: $1"
    bash "$1" || { echo "Erro ao executar $1" >&2; exit 1; }
}

install_all() {
    # Instalar todos os componentes
    PACKAGES=($ALL_PACKAGES)
    install_packages
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


    for choice in $choices; do
        case $choice in
            1) 
                PACKAGES+=($BASIC_SYSTEM_PACKAGES)
                if [[ "$PKG_MANAGER" == "pacman" || "$PKG_MANAGER" == "yay" || "$PKG_MANAGER" == "paru" ]]; then
                    PACKAGES+=($ARCH_EXCLUSIVE_PACKAGES)
                else
                    echo "Gerenciador de pacotes não é compatível com pacotes exclusivos do Arch."
                    echo "Pacotes exclusivos do Arch não serão instalados."
                fi
                ;;
            2) PACKAGES+=($DEVTOOLS_PACKAGES) ;; 
            3) PACKAGES+=($MEDIA_TOOLS_PACKAGES) ;;
            4) PACKAGES+=($GAMING_TOOLS_PACKAGES) ;;
            5) PACKAGES+=($TERMINAL_TOOLS_PACKAGES) ;;
            6) run_script scripts/webapps.sh ;;
            7) run_script scripts/hyprland_dotfiles.sh ;;
            8) run_script scripts/SyncWindowsClock.sh ;;
            9) install_all ;;
            0) echo "Saindo..."; exit 0 ;;
            *) echo "Opção inválida: $choice" ;;
        esac
    done

    if [ -n "$PACKAGES" ]; then
        install_packages
    fi
done 