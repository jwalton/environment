# Environment

## Mac Installation

First, install vscode and Cascadia Code Font, then:

```sh
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
$ brew install git
$ brew install git-bash-completion
$ mkdir dev && cd dev && git clone git@github.com:jwalton/environment.git && ./mac-preferences.sh && ./install.sh
$ ./install-vscode-extensions.sh
```