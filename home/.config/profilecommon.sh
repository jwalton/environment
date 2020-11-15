source ${HOME}/.config/bash/aliases.sh

export AWS_DEFAULT_REGION=us-east-1

# Reset path to work around https://github.com/creationix/nvm/issues/1652
# if [ -f "/usr/bin/getconf" ]; then
#     export PATH="$(getconf PATH)"
# fi

if [ -e /usr/local ]; then
    export PATH=/usr/local/bin:$PATH
    export PATH=/usr/local/sbin:$PATH
fi

export PATH="$PATH:$HOME/util"

# Use for e.g. synology where we have /opt/bin/ipkg
if [ -e /opt/bin ]; then
    export PATH="/opt/bin:$PATH"
fi

# nvm/node.js
if [ -e "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# rust
if [ -e "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# golang
if [ -e "$HOME/go" ]; then
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin
fi

# Maven
if [ -e /usr/local/apache-maven-3.6.3 ]; then
    export PATH="$PATH:/usr/local/apache-maven-3.6.3/bin"
fi

# pip3 stuff
if [ -e "$HOME/Library/Python/3.7" ]; then
    export PATH="$HOME/Library/Python/3.7/bin/:$PATH"
fi

# coreutils
if [ -e /usr/local/bin/brew ] && brew --cellar coreutils > /dev/null 2>&1; then
    export PATH="$PATH:$(brew --prefix coreutils)/libexec/gnubin"
fi

# rbenv
if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi

# Add keys from keychain.
# ssh-add -A

