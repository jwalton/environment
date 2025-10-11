#!/usr/bin/env bash
set -e

# Run with `--dry-run` for dry run.
RSYNC_FLAGS=""
DRY_RUN="FALSE"
if [ -n "$1" ]; then
    echo "Dry run mode."
    RSYNC_FLAGS="--dry-run"
    DRY_RUN="TRUE"
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/common.sh"

# Backup git singing key
log "Backup signing key..."
GIT_SIGNING_KEY=$(git config --global user.signingkey || echo "")

log "Copying files..."
rsync -av ${RSYNC_FLAGS} "${DIR}/../home/." "${HOME}/"
rsync -av ${RSYNC_FLAGS} "${DIR}/../oh-my-zsh-themes/"* "${HOME}/.oh-my-zsh/custom/themes"

# Restore signing key settings
if [ "${DRY_RUN}" != "TRUE" ]; then
    log "Restore signing key..."
    if [ -z "${GIT_SIGNING_KEY}" ]; then
        git config --global --unset user.signingkey || true
    else
        git config --global user.signingkey "${GIT_SIGNING_KEY}"
    fi
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    log "Copying Mac files..."
    rsync -av ${FLAGS} "${DIR}/../machome/." "${HOME}/"
fi
