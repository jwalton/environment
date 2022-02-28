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

# XFCE settings
if which xfconf-query > /dev/null; then
    # Focus follows mouse
    xfconf-query -c xfwm4 -p /general/click_to_focus -s false
    xfconf-query -c xfwm4 -p /general/focus_delay -s 0
fi

# Gnome settings
if which gsettings > /dev/null; then
    # Focus follows mouse
    gsettings set org.gnome.desktop.wm.preferences focus-mode mouse
fi
