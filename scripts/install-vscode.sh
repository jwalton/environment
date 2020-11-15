#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if ! which code > /dev/null; then
    echo "**** VSCode not installed - skipping installation of extensions."
    echo "**** After installing VSCode, run ./scripts/vscode.sh"
else
    CODE_PREFS_DIR="${HOME}/.config/Code/User"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        CODE_PREFS_DIR="${HOME}/Library/Application Support/Code/User"
    fi

    echo "Copying VSCode Preferences"
    mkdir -p "$CODE_PREFS_DIR"
    cp -r "${DIR}/../vscode/prefs/" "${CODE_PREFS_DIR}/"

    echo "Installing VSCode Extensions"
    cat ${DIR}/../vscode-extensions.txt | \
        grep -v -e '^#.*$' | \
        grep -v -e '^[[:space:]]*$' | \
        xargs -n 1 code --install-extension
fi
