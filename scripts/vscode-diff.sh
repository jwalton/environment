#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

CODE_PREFS_DIR="$HOME/.config/Code/User"
if [[ "$OSTYPE" == "darwin"* ]]; then
    CODE_PREFS_DIR="$HOME/Library/Application Support/Code/User"
fi

diff "${DIR}/../vscode/prefs" "${CODE_PREFS_DIR}"
