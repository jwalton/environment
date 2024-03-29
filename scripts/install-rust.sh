#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/common.sh"

# Install rust
if ! which rustup > /dev/null; then
    log "Installing rustup"
    curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
    source "${HOME}/.cargo/env"
    rustup update
    export PATH="$HOME/.cargo/bin:$PATH"

    cargo install --locked cargo-outdated
    cargo install --locked cargo-audit
    cargo install --locked cargo-udeps
else
    log_debug "Rust already installed"
fi
