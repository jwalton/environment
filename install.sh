#!/usr/bin/env bash
chsh -s /bin/zsh
if [ ! -e ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

cp -r ./home/ ~/
cp ./home/.config/zsh/jwalton.zsh-theme ~/.oh-my-zsh/custom/themes