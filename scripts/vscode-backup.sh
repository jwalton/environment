#!/usr/bin/env bash
# Run this to backup vscode settings
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

CODE_PREFS_DIR="$HOME/.config/Code/User"
if [[ "$OSTYPE" == "darwin"* ]]; then
    CODE_PREFS_DIR="$HOME/Library/Application Support/Code/User"
fi

cp "${CODE_PREFS_DIR}/snippets/"* "${DIR}/../vscode/prefs/snippets"
cp "${CODE_PREFS_DIR}/"*.json "${DIR}/../vscode/prefs"