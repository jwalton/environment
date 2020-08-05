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

./install.sh