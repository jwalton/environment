#!/usr/bin/env bash
set -e

sudo apt-get install -y firefox vlc barrier openssh-server
sudo snap install --classic code

if dpkg -s xfce4-session &> /dev/null; then
    sudo apt-get install -y arc-theme
    
    echo
    echo To use arc-theme, update these settings:
    echo
    echo     Appearance => Style
    echo     Window Manager => Style
    echo
fi