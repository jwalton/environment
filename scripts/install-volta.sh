#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/common.sh"

if [ -e "$HOME/.volta" ]; then
    log_debug "Volta already installed."
else
    log "Installing volta/node.js"
    curl https://get.volta.sh | bash -s -- --skip-setup
fi
