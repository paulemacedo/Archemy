#!/bin/bash

echo "Configurando WebApps..."
mkdir -p ~/.local/share/applications/

# Telegram
cat <<EOF > ~/.local/share/applications/telegram.desktop
[Desktop Entry]
Name=Telegram
Exec=brave --app=https://web.telegram.org/
Icon=telegram
Type=Application
EOF

# WhatsApp
cat <<EOF > ~/.local/share/applications/whatsapp.desktop
[Desktop Entry]
Name=WhatsApp
Exec=brave --app=https://web.whatsapp.com/
Icon=whatsapp
Type=Application
EOF

echo "WebApps configurados!"
