#!/bin/bash

# Install necessary packages
sudo pacman -S --needed git base-devel

# Clone the repository
git clone --depth 1 https://github.com/prasanthrangan/hyprdots ~/HyDE

# Navigate to the Scripts directory
cd ~/HyDE/Scripts

# Run the install script
./install.sh