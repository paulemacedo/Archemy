#!/bin/bash

# Importar módulos
source "scripts/package_manager.sh"
source "scripts/system_update.sh"
source "scripts/software_installation.sh"
source "scripts/webapp_config.sh"
source "scripts/dotfiles.sh"
source "scripts/system_config.sh"
source "scripts/helper.sh"



# Function to display help
show_help() {
    echo
    echo "Archemy: Linux Installation and Configuration System"
    echo
    echo "Description:"
    echo "  Archemy is a script for installing and configuring Linux systems,"
    echo "  focusing on Arch and derivative distributions. It automates the installation of"
    echo "  packages, WebApps configuration, Hyprland dotfiles installation, and"
    echo "  system optimizations."
    echo
    echo "Features:"
    echo "  - Automatic package manager detection"
    echo "  - Package installation via pacman, paru, yay, apt, dnf, and Flatpak"
    echo "  - WebApps configuration"
    echo "  - Hyprland dotfiles installation"
    echo "  - System optimizations"
    echo
    echo "Options:"
    echo "  ./main.sh -h, --help        Display this help message"
    echo "  ./main.sh -i, --minimal     Install all applications"
    echo "  ./main.sh -w, --webapps     Install all WebApps"
    echo "  ./main.sh -c, --complete    Install all applications, WebApps, and sync the clock"
    echo "  ./main.sh                   Run the script without options to display the interactive menu"
}

# Verificar argumentos de linha de comando
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
elif [[ "$1" == "-i" || "$1" == "--minimal" ]]; then
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
echo "Each script is a spell that invokes a set of programs."
echo "                                               ─ Paule Macedo"
echo "============================================================="
echo 
echo "- The night ritual is about to begin..."
echo "- A dark force awakens to dominate the installation of your machine."
echo "- Feel the ancestral power as you invoke programs and tools."
echo "- With a simple command, system and tool spells will be cast."
echo "- Your journey into the abyss of code has begun. Choose your option below..."
echo
echo "1. Install Apps"
echo "2. Install Hyprland Dotfiles"
echo "3. Sync Clock (Localtime)"
echo "0. Exit"
echo
read -p "Choose an option: " choice

case $choice in
    1) install_apps_menu ;;
    2) install_hyprland_dotfiles_menu ;;
    3) sync_windows_clock ;;
    0) echo "Exiting..."; exit 0 ;;
    *) echo "Invalid option!" ;;
esac
    done
}

# Check and install dependencies using package_manager.sh
check_dependencies() {
    local dependencies=("bash" "git" "flatpak")
    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo "Missing dependency: $dep. Attempting to install..."
            install_package "$dep"
        fi
    done
}

# Executar verificações e menu principal
#check_dependencies
main_menu