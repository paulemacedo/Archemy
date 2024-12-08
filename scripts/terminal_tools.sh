#!/bin/bash

# Carregando a configuração do gerenciador de pacotes
source config.sh

# Definindo os pacotes a serem instalados
PACKAGES="fastfetch nitch btop cava pokemon-colorscripts-git neo"

# Verificando se o arquivo de configuração foi carregado corretamente
echo "Pacotes a serem instalados: $PACKAGES"

# Instalando ferramentas com o gerenciador de pacotes detectado
if [ "$PKG_MANAGER" == "paru" ]; then
    paru -Syu --needed $PACKAGES --noconfirm
elif [ "$PKG_MANAGER" == "yay" ]; then
    yay -Syu --needed $PACKAGES --noconfirm
elif [ "$PKG_MANAGER" == "apt" ]; then
    sudo apt update
    sudo apt install -y $PACKAGES
else
    sudo pacman -Syu --needed $PACKAGES --noconfirm
fi


echo "Ferramentas de terminal instaladas!"
