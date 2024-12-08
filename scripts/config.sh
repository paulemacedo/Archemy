#!/bin/bash

# Função para detectar o gerenciador de pacotes
detect_package_manager() {
    if command -v paru &> /dev/null; then
        echo "paru"
    elif command -v yay &> /dev/null; then
        echo "yay"
    else
        echo "pacman"
    fi
}

# Detectando o gerenciador de pacotes
PKG_MANAGER=$(detect_package_manager)

# Salvando o gerenciador de pacotes detectado em um arquivo de configuração
echo "PKG_MANAGER=$PKG_MANAGER" > config.sh

echo "Gerenciador de pacotes detectado: $PKG_MANAGER"
