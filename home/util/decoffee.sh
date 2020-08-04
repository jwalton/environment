#!/usr/bin/env bash

#
# Some handy regexes for search/replace in visual studio:
#
#     ([\w\.]*) != null \? \1 : {}  =>  $1 || {}
#     ([\w\.]*) != null \? \1 : \[\]  => $1 || []
#     ([\w\.]*) != null \? \1\.(\w*) : undefined  =>  $1 && $1.$2
#     ([\w\.\[\]$]*) == null  =>  !$1
#     ([\w\.\[\]$]*) != null  =>  $1
#     for\(let (\w*) in ([\w.\[\]$]*)\)  =>  for(const $1 of Object.keys($2))
#

if [ $# -eq 0 ]; then
    echo Need a filename
    exit 1
fi

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILENAME=$1

npx decaffeinate --use-js-modules --loose ${FILENAME}
set +e

echo Beautify
npx prettier --write --single-quote --print-width 100 --tab-width 4 --trailing-comma es5 ${FILENAME%.*}.js

if npx eslint --fix ${FILENAME%.*}.js; then
    echo Clean eslint run
else
    echo eslint found errors.  Adding eslint-disable.
    node ${DIR}/eslint-disable.js ${FILENAME%.*}.js | cat - ${FILENAME%.*}.js > ${FILENAME%.*}.js.temp
    mv ${FILENAME%.*}.js.temp ${FILENAME%.*}.js
fi
set -e

git rm ${FILENAME}
git add ${FILENAME%.*}.js
