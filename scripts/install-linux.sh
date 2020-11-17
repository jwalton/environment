#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/common.sh"

if ! which starship > /dev/null; then
    log "Installing starship"
    curl -fsSL https://starship.rs/install.sh | bash
fi