#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/common.sh"

log "Copying files..."
cp -r "${DIR}/../home/." "${HOME}/"
cp "${DIR}/../oh-my-zsh-themes/"* "${HOME}/.oh-my-zsh/custom/themes"

if [[ "$OSTYPE" == "darwin"* ]]; then
    log "Copying Mac files..."
    cp -r "${DIR}/../machome/." "${HOME}/"
fi
