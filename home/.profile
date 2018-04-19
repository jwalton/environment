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

