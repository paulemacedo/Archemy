#!/bin/bash

# Carregando a configuração do gerenciador de pacotes
source config.sh

# Definindo os pacotes a serem instalados
PACKAGES="git base-devel fish paru flatpak kitty"

# Verificando se o arquivo de configuração foi carregado corretamente
echo "Gerenciador de Pacotes: $PKG_MANAGER"
echo "Pacotes a serem instalados: $PACKAGES"

# Instalando ferramentas com o gerenciador de pacotes detectado
if [ "$PKG_MANAGER" == "paru" ]; then
    echo "Usando o gerenciador de pacotes paru..."
    paru -Syu --needed $PACKAGES --noconfirm
elif [ "$PKG_MANAGER" == "yay" ]; then
    echo "Usando o gerenciador de pacotes yay..."
    yay -Syu --needed $PACKAGES --noconfirm
else
    echo "Usando o gerenciador de pacotes pacman..."
    sudo pacman -Syu --needed $PACKAGES --noconfirm
fi

echo "Configuração básica do sistema concluída!"