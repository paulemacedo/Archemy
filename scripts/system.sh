#!/bin/bash

# Carregando a configuração do gerenciador de pacotes
source config.sh

# Definindo os pacotes a serem instalados
PACKAGES="git base-devel fish paru flatpak kitty"

# Verificando se o arquivo de configuração foi carregado corretamente
echo "Pacotes a serem instalados: $PACKAGES"


# Instalando ferramentas com o gerenciador de pacotes detectado
if [ "$PKG_MANAGER" == "paru" ]; then
    paru -Syu --needed $PACKAGES --noconfirm
elif [ "$PKG_MANAGER" == "yay" ]; then
    yay -Syu --needed $PACKAGES --noconfirm
elif [ "$PKG_MANAGER" == "apt" ]; then
    sudo apt install -y $PACKAGES
elif [ "$PKG_MANAGER" == "dnf" ]; then
    sudo dnf install -y $PACKAGES
else
    sudo pacman -Syu --needed $PACKAGES --noconfirm
fi

echo "Configuração básica do sistema concluída!"