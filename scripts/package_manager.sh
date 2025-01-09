#!/bin/bash

# Import helper
source scripts/helper.sh

# Function to detect the package manager
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

# Global variable to store the package manager
PKG_MANAGER=$(detect_package_manager)

# Generic function to install package
install_package() {
    local package=$1
    local fallback_flatpak=${2:-}
    local apt_package_name=${3:-$package}
    local dnf_package_name=${4:-$package}

    echo "Installing package: $package via $PKG_MANAGER"

    case "$PKG_MANAGER" in
        paru)
            paru -Sy --needed "$package" --noconfirm || install_flatpak "${fallback_flatpak:-$package}"
            ;;
        yay)
            yay -Sy --needed "$package" --noconfirm || install_flatpak "${fallback_flatpak:-$package}"
            ;;
        apt)
            sudo apt install -y "$apt_package_name" || install_flatpak "${fallback_flatpak:-$package}"
            ;;
        dnf)
            sudo dnf install -y "$dnf_package_name" || install_flatpak "${fallback_flatpak:-$package}"
            ;;
        pacman)
            sudo pacman -Sy --needed "$package" --noconfirm || install_flatpak "${fallback_flatpak:-$package}"
            ;;
        *)
            echo "Unsupported package manager: $PKG_MANAGER"
            return 1
            ;;
    esac
}

# Function to install via Flatpak
install_flatpak() {
    local package=$1
    if [ -n "$package" ]; then
        echo "Installing package via flatpak: $package"
        flatpak install flathub "$package" -y
    fi
}