#!/bin/bash

# Importar módulos necessários
source scripts/package_manager.sh
source scripts/helper.sh

# Função para atualizar o sistema
update_system() {
    info_msg "Atualizando o sistema..."
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
            error_msg "Gerenciador de pacotes não suportado: $PKG_MANAGER"
            return 1
            ;;
    esac
    success_msg "Sistema atualizado com sucesso!"
}

# Função para limpar caches e pacotes órfãos
clean_system() {
    info_msg "Limpando sistema..."
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
            error_msg "Gerenciador de pacotes não suportado: $PKG_MANAGER"
            return 1
            ;;
    esac
    success_msg "Sistema limpo com sucesso!"
}