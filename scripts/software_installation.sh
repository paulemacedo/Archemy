#!/bin/bash

# Fonte dos módulos necessários
source scripts/package_manager.sh
source scripts/helper.sh

# Funções de instalação de pacotes
install_basic_system_packages() {
    install_package "git" "com.git.git"
    install_package "fish" "com.fishshell.fish"
    install_package "flatpak" "org.flatpak.Flatpak"
    install_package "kitty" "io.kitty.Kitty"

    if [[ "$PKG_MANAGER" == "pacman" || "$PKG_MANAGER" == "yay" || "$PKG_MANAGER" == "paru" ]]; then
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

install_cybersecurity_packages() {
    install_package "burpsuite" "org.burpsuite.BurpSuite"
    # install_package "nmap" "org.nmap.Nmap"
    # install_package "wireshark-qt" "org.wireshark.Wireshark"
    # install_package "metasploit" "org.metasploit.Metasploit"
    # install_package "john" "org.johntheripper.JohnTheRipper"
    # install_package "hydra" "org.thc-hydra.Hydra"
}

install_media_tools_packages() {
    install_package "vlc" "org.videolan.VLC"
    install_package "gimp" "org.gimp.GIMP"
}

install_gaming_tools_packages() {
    install_package "parsec" ""
    install_package "steam" "com.valvesoftware.Steam"
    install_package "lutris" "net.lutris.Lutris"
}

install_terminal_tools_packages() {
    install_package "fastfetch" "com.github.fastfetch.Fastfetch"
    install_package "btop" "com.github.aristocratos.Btop"
    install_package "cava" "com.github.karlstav.Cava"
    install_package "pokemon-colorscripts-git"
}

# Função para instalar todos os aplicativos
install_all_apps() {
    install_basic_system_packages
    install_devtools_packages
    install_media_tools_packages
    install_gaming_tools_packages
    install_terminal_tools_packages
}

# Application installation menu
install_apps_menu() {
    while true; do
        echo
        echo "============================="
        echo "      What to install?       "
        echo "============================="
        echo "1. Basic System Packages"
        echo "2. Development Tools"
        echo "3. Media Tools"
        echo "4. Gaming Tools"
        echo "5. Terminal Tools"
        echo "6. Install All"
        echo "0. Back"

        read -p "Choose an option: " choice

        case $choice in
            1) install_basic_system_packages ;;
            2) install_devtools_packages ;;
            3) install_media_tools_packages ;;
            4) install_gaming_tools_packages ;;
            5) install_terminal_tools_packages ;;
            6) install_all_apps ;;
            0) break ;;
            *) echo "Invalid option!" ;;
        esac
    done
}
