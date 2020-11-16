#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/common.sh"

if ! which code > /dev/null; then
    log_error "VSCode not installed - skipping installation of extensions."
    log_error "After installing VSCode, run ./scripts/vscode.sh"
else
    CODE_PREFS_DIR="${HOME}/.config/Code/User"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        CODE_PREFS_DIR="${HOME}/Library/Application Support/Code/User"
    fi

    log "Copying VSCode Preferences to ${CODE_PREFS_DIR}"
    mkdir -p "$CODE_PREFS_DIR"
    cp -r "${DIR}/../vscode/prefs/" "${CODE_PREFS_DIR}/"

    log "Installing VSCode Extensions"
    INSTALLED_EXTENSIONS=$(code --list-extensions)
    install_extension() {
        EXT=$1
        if ! echo ${INSTALLED_EXTENSIONS} | grep ${EXT} > /dev/null; then
            code --install-extension ${EXT}
        fi
    }

    EXTENSIONS_TO_INSTALL=$(cat ${DIR}/../vscode-extensions.txt | \
        grep -v -e '^#.*$' | \
        grep -v -e '^[[:space:]]*$')
    for EXT in $EXTENSIONS_TO_INSTALL; do
        install_extension $EXT
    done

    diff_extensions() {
        diff <(cat ${DIR}/../vscode-extensions.txt | \
            grep -v -e '^#.*$' | \
            grep -v -e '^[[:space:]]*$' | sort) \
            <(code --list-extensions | sort) | grep '>'
    }

    # Compare extensions we installed to what's actually installed
    EXT_DIFF=diff_extensions
    if [ -n "${EXT_DIFF}" ]; then
        log_warn "Warning: You have vscode extensions installed that are not in vscode-extensions.txt"
        diff_extensions
    fi
fi
