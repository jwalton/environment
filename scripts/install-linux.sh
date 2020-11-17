#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/common.sh"

ARCH="$(arch)"

if ! which starship > /dev/null; then
    if "$ARCH" == "aarch64"; then
        log_warn "Skipping starship install for Raspberry Pi."
        # sudo apt install -qqy build-essential openssl
        # ${DIR}/install-rust.sh
        # # Need -j 1 here, or we'll run out of RAM on the Pi.  :(
        # cargo install -j 1 starship
    else
        log "Installing starship"
        bash -c "$(curl -fsSL https://starship.rs/install.sh)" "" -y
    fi
fi