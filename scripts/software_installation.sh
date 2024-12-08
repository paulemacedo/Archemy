#!/bin/bash

# Fonte dos módulos necessários
source ./package_manager.sh
source ./helper.sh

# Funções de instalação de pacotes
install_basic_system_packages() {
    install_package "git" "com.git.git"
    install_package "fish" "com.fishshell.fish"
    install_package "flatpak" "org.flatpak.Flatpak"
    install_package "kitty" "io.kitty.Kitty"

    if [[ "$PKG_MANAGER" == "pacman" || "$PKG_MANAGER" == "yay" || "$PKG_MANAGER" == "paru" ]]; então
        install_package "base-devel"
        install_package "paru"
    fi
}

install_devtools_packages() {
    install_package "python3" "org.python.Python3"
    install_package "python3-pip"
    install_package "nodejs" "org.nodejs.Node"
    install_package "code" "com.visualstudio.code"
    install_package "github-desktop" "io.github.shiftey.Desktop"
}

install_media_tools_packages() {
    install_package "vlc" "org.videolan.VLC"
    install_package "gimp" "org.gimp.GIMP"
    install_package "inkscape" "org.inkscape.Inkscape"
}

install_gaming_tools_packages() {
    install_package "steam" "com.valvesoftware.Steam"
    install_package "lutris" "net.lutris.Lutris"
}

install_terminal_tools_packages() {
    install_package "fastfetch" "com.github.fastfetch.Fastfetch"
    install_package "btop" "com.github.aristocratos.Btop"
    install_package "cava" "com.github.karlstav.Cava"
    install_package "pokemon-colorscripts-git"
}

# Menu de instalação de aplicativos
install_apps_menu() {
    while true; do
        echo "============================="
        echo "   O que deseja instalar?    "
        echo "============================="
        echo "1. Pacotes Básicos do Sistema"
        echo "2. Ferramentas de Desenvolvimento"
        echo "3. Ferramentas de Mídia"
        echo "4. Ferramentas de Jogos"
        echo "5. Ferramentas de Terminal"
        echo "6. Instalar Todos"
        echo "0. Voltar"

        read -p "Escolha uma opção: " choice

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
            0) break ;;
            *) echo "Opção inválida!" ;;
        esac
    done
}