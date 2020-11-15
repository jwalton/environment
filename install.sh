#!/usr/bin/env bash

echo Setting up zsh...
if ! which zsh; then
    if ! which apt; then
        echo "Can't install zsh!"
    else
        sudo apt install zsh -y
    fi
fi

if which zsh; then
    chsh -s $(which zsh)
    if [ ! -e ~/.oh-my-zsh ]; then
        echo "Installing oh-my-zsh"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi
fi

./scripts/install-homedir.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
    ./scripts/install-mac.sh
fi

./scripts/install-vscode.sh

echo Done!
