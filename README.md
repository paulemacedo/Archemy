# 🦇 Archemy: Sistema de Instalação e Configuração Linux

## Descrição
Script modular para instalação e configuração de sistemas Linux, com foco em distribuições Arch e derivadas.

## Recursos
- Detecção automática do gerenciador de pacotes
- Instalação de pacotes via pacman, paru, yay, apt, dnf e Flatpak
- Configuração de WebApps
- Instalação de dotfiles do Hyprland
- Otimizações de sistema

## Pré-requisitos
- Bash
- Git

## Uso
   ```bash
   git clone https://github.com/paulemacedo/Archemy.git
   cd Archemy
   ./install.sh
   ```
## Módulos
- `package_manager.sh`: Gerenciamento de pacotes
- `system_update.sh`: Atualização do sistema
- `software_installation.sh`: Instalação de aplicativos
- `webapp_config.sh`: Configuração de WebApps
- `dotfiles.sh`: Instalação de dotfiles
- `system_config.sh`: Configurações do sistema

## Contribuição
Pull requests são bem-vindos. Para mudanças importantes, abra uma issue primeiro.

## Licença
[MIT]

🦇 Criado por Paule Macedo