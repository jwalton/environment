#!/usr/bin/env bash

echo Setting up zsh...
if ! which zsh; then
    if which apt; then
        sudo apt install zsh -y
    else
        echo "** Can't install zsh!"
    fi
fi

ZSH=$(which zsh)
if [ -n "${ZSH}" ] && [ "${ZSH}" != "${SHELL}" ]; then
    echo "Setting default shell to zsh"
    chsh -s $(which zsh)
fi
if [ ! -e ~/.oh-my-zsh ]; then
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

./scripts/install-homedir.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
    ./scripts/install-mac.sh
fi

./scripts/install-vscode.sh

echo Done!
