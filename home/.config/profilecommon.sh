export AWS_DEFAULT_REGION=us-east-1

# Reset path to work around https://github.com/creationix/nvm/issues/1652
# if [ -f "/usr/bin/getconf" ]; then
#     export PATH="$(getconf PATH)"
# fi

if [ -e /usr/local ]; then
    export PATH=/usr/local/bin:$PATH
    export PATH=/usr/local/sbin:$PATH
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Use for e.g. synology where we have /opt/bin/ipkg
if [ -e /opt/bin ]; then
    export PATH="/opt/bin:$PATH"
fi

# This lazy loads NVM, based on code from http://broken-by.me/lazy-load-nvm/
if [ -e "$HOME/.nvm" ]; then
    load_nvm() {
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    }
    nvm() {
        unset -f nvm
        load_nvm
        nvm "$@"
    }
    node() {
        unset -f node
        load_nvm
        node "$@"
    }
    npm() {
        unset -f npm
        load_nvm
        npm "$@"
    }
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

# rbenv
if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi

# Add keys from keychain.
# ssh-add -A

