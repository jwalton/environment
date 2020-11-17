#!/usr/bin/env bash
set -e
source "./scripts/common.sh"

log "Setting up zsh..."
if ! which zsh > /dev/null; then
    if which apt > /dev/null; then
        sudo apt install -yqq zsh
    else
        log_error "Can't install zsh!"
        exit 1
    fi
fi
if ! which curl > /dev/null; then
    if which apt; then
        sudo apt install -yqq curl
    else
        log_error "Can't install curl!"
        exit 1
    fi
fi

ZSH_INSTALLED=$(which zsh)
if [ -z ${ZSH_INSTALLED} ]; then
    log_error "No zsh found!"
    exit 1
fi
if [ -n "${ZSH_INSTALLED}" ] && [ "${ZSH_INSTALLED}" != "${SHELL}" ]; then
    log "Setting default shell to zsh"
    chsh -s $(which zsh)
fi
if [ ! -e ~/.oh-my-zsh ]; then
    log "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

./scripts/install-homedir.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
    ./scripts/install-mac.sh
elif [[ "$OSTYPE" == "linux"* ]]; then
    ./scripts/install-linux.sh
fi

./scripts/install-vscode.sh

echo Done!
