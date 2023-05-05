#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/common.sh"

if [[ "$OSTYPE" == "darwin"* ]]; then
    brew update --quiet
    brew install --quiet golang
    PATH="$PATH:/usr/local/opt/go/libexec/bin"
elif which apt > /dev/null ; then
    sudo apt update
    wget https://dl.google.com/go/go1.17.6.linux-amd64.tar.gz
    sudo tar -C /usr/local/ -xzf go1.17.6.linux-amd64.tar.gz
    # sudo apt get -y golang
else
    log_error "Can't figure out how to install golang!"
fi

if which go > /dev/null ; then
    export GOPATH=$HOME/.go
    go install golang.org/x/tools/cmd/godoc@latest
    go install golang.org/x/lint/golint@latest
    go install github.com/ramya-rao-a/go-outline@latest
    go install github.com/rogpeppe/godef@latest
    go install github.com/sqs/goreturns@latest
    go install github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest
    go install github.com/stamblerre/gocode@latest
    go install golang.org/x/tools/gopls@latest
    go install github.com/mdempsky/gocode@latest
    go install github.com/go-delve/delve/cmd/dlv@latest
fi