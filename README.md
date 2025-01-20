
<div align="center">
   <a href="http://paulemacedo.vercel.app"><img src="assets/Archemy.png" alt="Archemy Icon" width="100" height="100" /></a>
   <p>Archemy is a modular script for installing and configuring Linux systems, focusing on Arch and its derivatives.</p>
   <div>
      <img src="https://img.shields.io/badge/bash-432E54?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Bash" />
      <img src="https://img.shields.io/badge/Made%20by-Paule-432E54?style=for-the-badge" alt="Made by" />
      <img src="https://img.shields.io/badge/Made%20with%20-❤️-432E54?style=for-the-badge&color=432E54" alt="Love" />
      <img src="https://img.shields.io/github/license/paulemacedo/Archemy?style=for-the-badge&color=432E54" alt="GitHub license" />
   </div>
</div>

## Features
- Automatic package manager detection
- Package installation via pacman, paru, yay, apt, dnf, and Flatpak
- WebApps configuration
- Hyprland dotfiles installation
- System optimizations

## Usage
   ```bash
   git clone https://github.com/paulemacedo/Archemy.git
   cd Archemy
   ./main.sh
   ```
## Options
   - `No Commands`: Runs the main script with menu
   - `-h, --help`: Displays the help message
   - `-i, --minimal`: Installs all applications
   - `-c, --complete`: Installs all applications and syncs the clock with Windows

## Modules
- `package_manager.sh`: Package management
- `system_update.sh`: System update
- `software_installation.sh`: Application installation
- `dotfiles.sh`: Hyprland dotfiles installation
- `system_config.sh`: System configurations
- `helper.sh`: Auxiliary functions for messages, logs, backups, and checks

## Contribution
Pull requests are welcome. For major changes, please open an issue first.
