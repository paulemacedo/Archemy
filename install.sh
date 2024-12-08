#!/bin/bash

# Carregando a configuração do gerenciador de pacotes
if [ -f scripts/config.sh ]; then
    source scripts/config.sh
else
    echo "Erro: config.sh não encontrado!" >&2
    exit 1
fi
# Função para atualizar o sistema
update_system() {
    echo "Atualizando o sistema..."
    case "$PKG_MANAGER" in
        paru)
            paru -Syu --noconfirm
            ;;
        yay)
            yay -Syu --noconfirm
            ;;
        apt)
            sudo apt update && sudo apt upgrade -y
            ;;
        dnf)
            sudo dnf upgrade --refresh -y
            ;;
        pacman)
            sudo pacman -Syu --noconfirm
            ;;
        *)
            echo "Gerenciador de pacotes não suportado: $PKG_MANAGER"
            exit 1
            ;;
    esac
}
# Funções de instalação
install_software() {
    SOFTWARE=$1
    FLATPAK_ID=$2
    PKG_ID=$3

    if [ -n "$PKG_ID" ]; then
        install_package "$PKG_ID" || install_flatpak "$FLATPAK_ID"
    else
        install_flatpak "$FLATPAK_ID"
    fi
}

install_package() {
    local package=$1
    echo "Instalando pacote: $package"

    case "$PKG_MANAGER" in
        paru)
            paru -Sy --needed $package --noconfirm || install_flatpak $package
            ;;
        yay)
            yay -Sy --needed $package --noconfirm || install_flatpak $package
            ;;
        apt)
            sudo apt install -y $package || install_flatpak $package
            ;;
        dnf)
            sudo dnf install -y $package || install_flatpak $package
            ;;
        *)
            sudo pacman -Sy --needed $package --noconfirm || install_flatpak $package
            ;;
    esac
}

install_flatpak() {
    local package=$1
    echo "Instalando pacote via flatpak: $package"
    flatpak install flathub $package -y
}

# Funções de instalação de pacotes
install_basic_system_packages() {
    install_software "Git" "com.git.git" "git"
    install_software "Fish" "com.fishshell.fish" "fish"
    install_software "Flatpak" "org.flatpak.Flatpak" "flatpak"
    install_software "Kitty" "io.kitty.Kitty" "kitty"
    if [[ "$PKG_MANAGER" == "pacman" || "$PKG_MANAGER" == "yay" || "$PKG_MANAGER" == "paru" ]]; then
        install_software "Base-devel" "" "base-devel"
        install_software "Paru" "" "paru"
    else
        echo "Gerenciador de pacotes não é compatível com pacotes exclusivos do Arch."
        echo "Pacotes exclusivos do Arch não serão instalados."
    fi
}

install_devtools_packages() {
    install_software "Python3" "org.python.Python3" "python3"
    install_software "Python3-pip" "" "python3-pip"
    install_software "Node.js" "org.nodejs.Node" "nodejs"
    install_software "VS Code" "com.visualstudio.code" ""
    install_software "GitHub Desktop" "io.github.shiftey.Desktop" ""
}

install_media_tools_packages() {
    install_software "VLC" "org.videolan.VLC" "vlc"
    install_software "GIMP" "org.gimp.GIMP" "gimp"
    install_software "Inkscape" "org.inkscape.Inkscape" "inkscape"
}

install_gaming_tools_packages() {
    install_software "Steam" "com.valvesoftware.Steam" "steam"
    install_software "Lutris" "net.lutris.Lutris" "lutris"
}

install_terminal_tools_packages() {
    install_software "Fastfetch" "com.github.fastfetch.Fastfetch" "fastfetch"
    install_software "Nitch" "com.github.nitch.Nitch" "nitch"
    install_software "Btop" "com.github.aristocratos.Btop" "btop"
    install_software "Cava" "com.github.karlstav.Cava" "cava"
    install_software "Pokemon Colorscripts" "" "pokemon-colorscripts-git"
    install_software "Neo" "com.github.neo.Neo" "neo"
}

# Função para o submenu de instalação de aplicativos
install_apps_menu() {
    while true; do
        echo "1. Instalar Pacotes Básicos do Sistema"
        echo "2. Instalar Ferramentas de Desenvolvimento"
        echo "3. Instalar Ferramentas de Mídia"
        echo "4. Instalar Ferramentas de Jogos"
        echo "5. Instalar Ferramentas de Terminal"
        echo "0. Voltar ao menu principal"
        echo
        read -p "Escolha uma opção: " sub_choice

        case $sub_choice in
            1) install_basic_system_packages ;;
            2) install_devtools_packages ;;
            3) install_media_tools_packages ;;
            4) install_gaming_tools_packages ;;
            5) install_terminal_tools_packages ;;
            0) break ;;
            *) echo "Opção inválida!" ;;
        esac
    done
}


# Atualizar o sistema antes de instalar qualquer coisa
update_system

# Menu principal
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
    echo "1. Instalar Apps"
    echo "2. Instalar WebApps"
    echo "3. Instalar Dotfiles do Hyprland"
    echo "4. Sincronizar relógio (Localtime)"
    echo "0. Sair"
    echo
    read -p "Escolha uma opção: " choice

    case $choice in
        1) install_apps_menu ;;
        2) run_script scripts/webapps.sh ;;
        3) run_script scripts/hyprland_dotfiles.sh ;;
        4) run_script scripts/SyncWindowsClock.sh ;;
        0) echo "Saindo..."; exit 0 ;;
        *) echo "Opção inválida!" ;;
    esac
done
