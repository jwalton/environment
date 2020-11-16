# ulimit -n 256000

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

source ${HOME}/.config/profilecommon.sh
source ${HOME}/.config/bash/ps1.sh

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Color in LS
export CLICOLOR=true

# iterm2 integration
source ~/.iterm2_shell_integration.bash
