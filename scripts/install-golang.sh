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
    sudo apt get -y golang
else
    log_error "Can't figure out how to install golang!"
fi

if which go > /dev/null ; then
    export GOPATH=$HOME/.go
    go get -u golang.org/x/tools/cmd/godoc \
      golang.org/x/lint/golint \
      github.com/ramya-rao-a/go-outline \
      github.com/rogpeppe/godef \
      github.com/sqs/goreturns \
      github.com/uudashr/gopkgs/v2/cmd/gopkgs \
      github.com/stamblerre/gocode \
      golang.org/x/tools/gopls \
      github.com/mdempsky/gocode \
      github.com/go-delve/delve/cmd/dlv
fi