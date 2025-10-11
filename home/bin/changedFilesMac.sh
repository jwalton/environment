#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

FOLDERS=(
    "/Applications"
    "/System/Volumes/Data/System/Library"
    "/etc"
    "/opt"
    "/sbin"
    "/usr"
    "/Library/Preferences"
    "/Library/LaunchAgents"
    "/bin"
    "/Users/jwalton/bin"
    "/Users/jwalton/Applications"
)

echo $(date) > ~/modified.txt

for folder in "${FOLDERS[@]}"; do
    echo "Checking $folder"
    sudo find "$folder" -type f -newer ~/modtest -print >> ~/modified.txt
done

cat ~/modified.txt
touch ~/modtest
