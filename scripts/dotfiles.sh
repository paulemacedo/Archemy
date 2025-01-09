#!/bin/bash

# Import helper
source scripts/helper.sh

# My Dotfiles
install_dotfiles () {
    info_msg "Installing my Dotfiles..."
    git clone https://github.com/paulemacedo/dotfiles.git ~/dotfiles
    cd ~/dotfiles || { error_msg "Failed to access the dotfiles directory."; return 1; }
    ./setup.sh
    success_msg "Dotfiles installed successfully!"
}

# Function to install Hyprdots
install_hyprdots() {
    info_msg "Installing Hyprdots..."
    sudo pacman -S --needed git base-devel
    git clone --depth 1 https://github.com/prasanthrangan/hyprdots ~/HyDE
    cd ~/HyDE/Scripts || { error_msg "Failed to access the HyDE/Scripts directory."; return 1; }
    ./install.sh
    success_msg "Hyprdots installed successfully!"
}

# Function to install End-4's Hyprland Dotfiles
install_end_4_dotfiles() {
    info_msg "Installing End-4's Hyprland Dotfiles..."
    bash <(curl -s "https://end-4.github.io/dots-hyprland-wiki/setup.sh")
    success_msg "End-4's Hyprland Dotfiles installed successfully!"
}

# Hyprland Dotfiles installation menu
install_hyprland_dotfiles_menu() {
    while true; do
        echo "============================="
        echo "   Choose your Dotfiles      "
        echo "============================="
        echo "1. Paule's Dotfiles (My Dotfiles)"
        echo "2. Hyprdots"
        echo "3. End-4's Hyprland Dotfiles"
        echo "0. Back"

        read -p "Choose an option: " choice

        case $choice in
            1) install_dotfiles || { warn_msg "Installation failed, returning to menu..."; continue; } ;;
            2) install_hyprdots && break ;;
            3) install_end_4_dotfiles && break ;;
            0) break ;;
            *) warn_msg "Invalid option!" ;;
        esac
    done
}
