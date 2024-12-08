#!/bin/bash

# Função para configurar WebApps
configure_webapp() {
    local name=$1
    local url=$2
    local icon=$3

    echo "Configurando WebApp: $name..."
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

    echo "WebApp $name configurado!"
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
        read -p "Escolha uma ou mais opções (ex: 1 2 3): " sub_choice

        for choice in $sub_choice; do
            case $choice in
                1) configure_webapp "Telegram" "https://web.telegram.org/" "telegram" ;;
                2) configure_webapp "WhatsApp" "https://web.whatsapp.com/" "whatsapp" ;;
                3) configure_webapp "Gmail" "https://mail.google.com/" "gmail"
                4)
                    configure_webapp "Telegram" "https://web.telegram.org/" "telegram"
                    configure_webapp "WhatsApp" "https://web.whatsapp.com/" "whatsapp"
                    configure_webapp "Gmail" "https://mail.google.com/" "gmail"
                    echo "Todos os WebApps foram configurados!"
                    ;;
                0) return ;;
                *) echo "Opção inválida: $choice" ;;
            esac
        done
    done
}