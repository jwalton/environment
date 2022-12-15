#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/common.sh"

# Backup git singing key
GIT_SIGNING_KEY=$(git config --global user.signingkey || echo "")

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

    if which pinentry-mac > /dev/null && which gpgconf > /dev/null; then
        log "Generating gpg-agent.conf"
        mkdir -p ~/.gnupg
        echo "
# This file was automatically generated.
# After editing this file, run `gpgconf --kill gpg-agent`

# 8 Hours
max-cache-ttl 28800
default-cache-ttl 28800
pinentry-program $(which pinentry-mac)
" > ~/.gnupg/gpg-agent.conf
        gpgconf --kill gpg-agent
    else
        log "Skipping gpg-agent.conf"
    fi
fi
