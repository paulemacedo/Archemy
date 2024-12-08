#!/bin/bash

# Função para configurar um WebApp
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
EOF

    echo "WebApp $name configurado!"
}

# Configurando WebApps
configure_webapp "Telegram" "https://web.telegram.org/" "telegram"
configure_webapp "WhatsApp" "https://web.whatsapp.com/" "whatsapp"

echo "Todos os WebApps foram configurados!"