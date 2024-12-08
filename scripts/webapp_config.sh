#!/bin/bash

# Importar helper
source ./helper.sh

# Função para configurar WebApps
configure_webapp() {
    local name=$1
    local url=$2
    local icon=$3

    info_msg "Configurando WebApp: $name..."
    mkdir -p ~/.local/share/applications/

    cat <<EOF > ~/.local/share/applications/${name,,}.desktop
[Desktop Entry]
Name=$name
Exec=brave --app=$url
Icon=$icon
Type=Application
Categories=Network;WebBrowser;
Terminal=false
EOF

    success_msg "WebApp $name configurado com sucesso!"
}

# Função para instalar todos os WebApps
install_all_webapps() {
    configure_webapp "Telegram" "https://web.telegram.org/" "telegram"
    configure_webapp "WhatsApp" "https://web.whatsapp.com/" "whatsapp"
    # Adicione outros WebApps aqui
}

# Menu de WebApps
install_webapps_menu() {
    while true; do
        echo "============================="
        echo "   O que deseja instalar?    "
        echo "============================="
        echo "1. Configurar Telegram"
        echo "2. Configurar WhatsApp"
        echo "3. Configurar Todos os WebApps"
        echo "0. Voltar ao menu principal"
        echo

        read -p "Escolha uma opção: " choice

        case $choice in
            1) configure_webapp "Telegram" "https://web.telegram.org/" "telegram" ;;
            2) configure_webapp "WhatsApp" "https://web.whatsapp.com/" "whatsapp" ;;
            3)
                install_all_webapps
                success_msg "Todos os WebApps foram configurados!"
                ;;
            0) return ;;
            *) warn_msg "Opção inválida: $choice" ;;
        esac
    done
}
