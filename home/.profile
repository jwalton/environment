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

source "${HOME}/.config/aliases.sh"
source "${HOME}/.config/bash/aliases.sh"
source "${HOME}/.config/profilecommon.sh"

if [ -e "${HOME}/.config/profilelocal.sh" ]; then
    source ${HOME}/.config/profilelocal.sh
fi
