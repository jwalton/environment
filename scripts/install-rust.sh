#!/usr/bin/env bash

# Install rust
if ! which rustup > /dev/null; then
    echo Installing rustup
    curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
    source "${HOME}/.cargo/env"
    rustup update
fi
