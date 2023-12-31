#!/bin/bash

# Script must be run as sudo user.
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Handles installation cancelling.
trap 'echo "Installation stoped"; exit 1' INT

# Remove configuration files and scripts.
sudo rm -rf /etc/updatecheck >> /dev/null 2>&1
sudo systemctl disable update
sudo rm /etc/systemd/system/update.service >> /dev/null 2>&1
sudo rm /etc/systemd/system/graphical.target.wants/update.service>> /dev/null 2>&1
sudo systemctl daemon-reload >> /dev/null 2>&1
sudo rm /etc/sudoers.d/updatecheck >> /dev/null 2>&1

# Exit code
echo "Updatecheck successfully uninstalled"
exit 0
