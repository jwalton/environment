#!/usr/bin/env bash

echo Setting up zsh...
chsh -s /bin/zsh
if [ ! -e ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

echo Copying files...
cp -r ./home/ ~/
cp ./oh-my-zsh-themes/* ~/.oh-my-zsh/custom/themes

if ! which nvm > /dev/null; then
    echo Installing nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
fi

echo Done!