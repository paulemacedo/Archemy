#!/bin/bash

# Importar helper
source scripts/helper.sh

# Function to synchronize Windows clock
sync_windows_clock() {
    if confirm_action "Do you want to set the clock to Localtime?"; then
        info_msg "Setting clock to Localtime..."
        sudo timedatectl set-local-rtc 1 --adjust-system-clock
        timedatectl
        success_msg "Clock successfully set to Localtime!"
    else
        warn_msg "Operation cancelled."
    fi
}

# Function for general system configurations
system_optimization() {
    info_msg "Optimizing system configurations..."
    
    # Disable system beep
    sudo bash -c 'echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf'
    
    # Increase inotify limits
    sudo bash -c 'echo "fs.inotify.max_user_watches=524288" > /etc/sysctl.d/40-max-user-watches.conf'
    sudo sysctl --system

    success_msg "System configurations optimized successfully!"
}