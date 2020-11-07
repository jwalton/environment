#!/usr/bin/env bash

set -e

if ! which brew > /dev/null; then
    echo Installing brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew install git
else
    echo Updating brew
    brew update
fi

echo Setting up preferences
./mac-preferences.sh

echo Installing mac apps
if ! which mas > /dev/null; then
    echo Installing mas
    brew install mas
fi
if ! which gh > /dev/null; then
    echo Installing GitHub CLI
    brew install gh
fi
if ! which aws > /dev/null; then
    echo Installing AWS CLI
    brew install awscli
fi
if ! which ip > /dev/null; then
    echo Installing iproute2mac
    brew install iproute2mac
fi
if ! which ip > /dev/null; then
    echo Installing youtube-dl
    brew install youtube-dl
fi
echo Installing Xcode
mas install 497799835
echo Installing Slack
mas install 803453959
echo Installing WhatsApp
mas install 1147396723
echo Installing Telegram
mas install 747648890
echo Installing Microsoft OneNote
mas install 784801555
echo Installing Microsoft To Do
mas install 1274495053
echo Installing Keynote
mas install 409183694
echo Installing Pages
mas install 409201541
echo Installing Numbers
mas install 409203825
echo Installing iMovie
mas install 408981434
# 682658836 GarageBand (10.3.5)

brewCaskInstall () {
    if brew cask list $1 > /dev/null; then
        echo "$1 already installed"
    else
        brew cask install $1
    fi
}

brewCaskInstall veracrypt

./install.sh

# If we don't run this command, then the mac will change it's
# hostname from DHCP.  See https://apple.stackexchange.com/questions/272036/how-to-refuse-dhcp-server-to-change-my-hostname.
Echo 'Please run "sudo scutil --set HostName yourcomputername"'