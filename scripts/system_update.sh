#!/bin/bash

# Import necessary modules
source scripts/package_manager.sh
source scripts/helper.sh

# Function to update the system
update_system() {
    info_msg "Updating the system..."
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
            error_msg "Unsupported package manager: $PKG_MANAGER"
            return 1
            ;;
    esac
    success_msg "System updated successfully!"
}

# Function to clean caches and orphan packages
clean_system() {
    info_msg "Cleaning system..."
    case "$PKG_MANAGER" in
        paru|yay)
            "$PKG_MANAGER" -Sc --noconfirm
            "$PKG_MANAGER" -Yc --noconfirm
            ;;
        apt)
            sudo apt autoremove -y
            sudo apt autoclean
            ;;
        dnf)
            sudo dnf autoremove -y
            sudo dnf clean all
            ;;
        pacman)
            sudo pacman -Sc --noconfirm
            sudo pacman -Rns "$(pacman -Qtdq)" --noconfirm 2>/dev/null || true
            ;;
        *)
            error_msg "Unsupported package manager: $PKG_MANAGER"
            return 1
            ;;
    esac
    success_msg "System cleaned successfully!"
}