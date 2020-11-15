#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo Copying files...
cp -r "${DIR}/../home/." "${HOME}/"
cp "${DIR}/../oh-my-zsh-themes/"* "${HOME}/.oh-my-zsh/custom/themes"

if [[ "$OSTYPE" == "darwin"* ]]; then
    cp -r "${DIR}/../machome/." "${HOME}/"
fi
