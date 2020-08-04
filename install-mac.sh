#!/usr/bin/env bash

set -e

if ! which brew > /dev/null; then
    echo Installing brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew install git
fi

echo Setting up preferences
./mac-preferences.sh

./install.sh