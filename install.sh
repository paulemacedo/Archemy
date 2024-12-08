#!/bin/bash

# Função para detectar o gerenciador de pacotes
detect_package_manager() {
    if command -v paru &> /dev/null; then
        echo "paru"
    elif command -v yay &> /dev/null; then
        echo "yay"
    elif command -v apt &> /dev/null; then
        echo "apt"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    else
        echo "pacman"
    fi
}

# Detectando o gerenciador de pacotes
PKG_MANAGER=$(detect_package_manager)

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

# Função para instalar pacotes
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
        pacman)
            sudo pacman -Sy --needed $package --noconfirm || install_flatpak $package
            ;;
        *)
            echo "Gerenciador de pacotes não suportado: $PKG_MANAGER"
            exit 1
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
    install_software "VS Code" "com.visualstudio.code" "code"
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

# Função para configurar um WebApp
configure_webapp() {
    local name=$1
    local url=$2
    local icon=$3

    echo "Configurando WebApp: $name..."
    mkdir -p ~/.local/share/applications/

    cat <<EOF > ~/.local/share/applications/${name,,}.desktop
[Desktop Entry]
Name=$name
Exec=brave --app=$url
Icon=$icon
Type=Application
EOF

    echo "WebApp $name configurado!"
}

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

# Função para sincronizar o relógio do Windows
sync_windows_clock() {
    read -p "Tem certeza de que deseja configurar o relógio para Localtime? (y/n): " confirm
    if [[ $confirm == [yY] ]]; then
        echo "Configurando relógio para Localtime..."
        sudo timedatectl set-local-rtc 1 --adjust-system-clock

        echo "Verificando a configuração atual:"
        timedatectl
    else
        echo "Operação cancelada."
    fi
}

# Função para o submenu de instalação de aplicativos
install_apps_menu() {
    while true; do
        echo "1. Instalar Pacotes Básicos do Sistema"
        echo "2. Instalar Ferramentas de Desenvolvimento"
        echo "3. Instalar Ferramentas de Mídia"
        echo "4. Instalar Ferramentas de Jogos"
        echo "5. Instalar Ferramentas de Terminal"
        echo "6. Instalar Todos os Aplicativos"
        echo "0. Voltar ao menu principal"
        echo
        read -p "Escolha uma ou mais opções (ex: 1 2 3): " sub_choice

        for choice in $sub_choice; do
            case $choice in
                1) install_basic_system_packages ;;
                2) install_devtools_packages ;;
                3) install_media_tools_packages ;;
                4) install_gaming_tools_packages ;;
                5) install_terminal_tools_packages ;;
                6)
                    install_basic_system_packages
                    install_devtools_packages
                    install_media_tools_packages
                    install_gaming_tools_packages
                    install_terminal_tools_packages
                    ;;
                0) return ;;
                *) echo "Opção inválida: $choice" ;;
            esac
        done
    done
}

# Função para o submenu de WebApps
install_webapps_menu() {
    configure_webapp "Telegram" "https://web.telegram.org/" "telegram"
    configure_webapp "WhatsApp" "https://web.whatsapp.com/" "whatsapp"
    echo "Todos os WebApps foram configurados!"
}

# Função para o submenu de Dotfiles do Hyprland
install_hyprland_dotfiles_menu() {
    while true; do
        echo "============================="
        echo "   Escolha seu Dotfiles      "
        echo "============================="
        echo "1. Hyprdots"
        echo "2. End-4's Hyprland Dotfiles"
        echo "0. Voltar ao menu principal"
        echo
        read -p "Escolha uma opção: " sub_choice
        echo

        case $sub_choice in
            1) install_hyprdots ; return ;;
            2) install_end_4 ; return ;;
            0) return ;;
            *) echo "Opção inválida! Tente novamente." ;;
        esac
    done
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

# Executar o menu principal
main_menu