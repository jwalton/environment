# ulimit -n 256000

source ${HOME}/.config/profilecommon.sh
source ${HOME}/.config/bash/ps1.sh

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Color in LS
export CLICOLOR=true

# iterm2 integration
source ~/.iterm2_shell_integration.bash
