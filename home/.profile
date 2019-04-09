# ulimit -n 256000

source ${HOME}/.bash_config/ps1.sh
source ${HOME}/.bash_config/aliases.sh

export PYTHONPATH=/usr/local/lib/python2.7/site-packages/
export AWS_DEFAULT_REGION=us-east-1

# Reset path to work around https://github.com/creationix/nvm/issues/1652
export PATH="/usr/local/bin:$(getconf PATH)"
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$PATH:~/util
export PATH="/usr/local/opt/mongodb@3.2/bin:$PATH"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Color in LS
export CLICOLOR=true

# Needed for installing node-canvas
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig

# Temporary hack for broken xcode (http://stackoverflow.com/questions/26563079/mac-osx-getting-segmentation-faults-on-every-c-program-even-hello-world-af)
export MACOSX_DEPLOYMENT_TARGET=10.9

# golang stuff
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# iterm2 integration
source ~/.iterm2_shell_integration.bash

# Nix
if [ -e /Users/jwalton/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jwalton/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Add keys from keychain.
ssh-add -A

# node-canvas stuff
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export LDFLAGS="-L/usr/local/opt/icu4c/lib -L/usr/local/opt/libffi/lib"
export CPPFLAGS=-I/usr/local/opt/icu4c/include
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig:/usr/local/opt/icu4c/lib/pkgconfig"