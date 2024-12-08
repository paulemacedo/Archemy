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

# Variável global para armazenar o gerenciador de pacotes
PKG_MANAGER=$(detect_package_manager)

# Função para instalar pacote genérica
install_package() {
    local package=$1
    local fallback_flatpak=${2:-}

    echo "Instalando pacote: $package"

    case "$PKG_MANAGER" in
        paru)
            paru -Sy --needed "$package" --noconfirm || install_flatpak "${fallback_flatpak:-$package}"
            ;;
        yay)
            yay -Sy --needed "$package" --noconfirm || install_flatpak "${fallback_flatpak:-$package}"
            ;;
        apt)
            sudo apt install -y "$package" || install_flatpak "${fallback_flatpak:-$package}"
            ;;
        dnf)
            sudo dnf install -y "$package" || install_flatpak "${fallback_flatpak:-$package}"
            ;;
        pacman)
            sudo pacman -Sy --needed "$package" --noconfirm || install_flatpak "${fallback_flatpak:-$package}"
            ;;
        *)
            echo "Gerenciador de pacotes não suportado: $PKG_MANAGER"
            return 1
            ;;
    esac
}

# Função para instalar via Flatpak
install_flatpak() {
    local package=$1
    if [ -n "$package" ]; then
        echo "Instalando pacote via flatpak: $package"
        flatpak install flathub "$package" -y
    fi
}