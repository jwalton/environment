#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/common.sh"

# Backup git singing key
GIT_SIGNING_KEY=$(git config --global user.signingkey)

log "Copying files..."
cp -r "${DIR}/../home/." "${HOME}/"
cp "${DIR}/../oh-my-zsh-themes/"* "${HOME}/.oh-my-zsh/custom/themes"

# Restore singing key settings
if [ -z "${GIT_SIGNING_KEY}" ]; then
    git config --global --unset user.signingkey
else
    git config --global user.signingkey "${GIT_SIGNING_KEY}"
fi


if [[ "$OSTYPE" == "darwin"* ]]; then
    log "Copying Mac files..."
    cp -r "${DIR}/../machome/." "${HOME}/"
fi
