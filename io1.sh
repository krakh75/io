#!/bin/bash

# Update package lists and upgrade installed packages
sudo apt update && sudo apt upgrade -y

# Update package lists again
sudo apt update

# Update GRUB bootloader
sudo update-grub

# Reboot the system
sudo reboot

