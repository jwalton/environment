#!/usr/bin/env bash

if ! which nvm > /dev/null; then
    echo Installing nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
fi
