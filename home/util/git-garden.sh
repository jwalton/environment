#!/usr/bin/env bash
set -e

# Get the latest state from the origin
git fetch --all -q

# Prune branches that exist in refs/remotes but no longer exist on origin
git remote prune origin > /dev/null

echo 'Delete all remote branches that have been merged (saved refs in /tmp/delete-remote.log)'
BRANCHES_TO_DELETE=$(
git branch -r --merged origin/master |
  grep origin |
  grep -v '>' |
  grep -v master |
  grep -v stable
)

# Log the branches in case something goes horribly wrong
echo ${BRANCHES_TO_DELETE} | xargs -L 1 bash -c 'echo "$(git rev-parse $1) $1"' _ > /tmp/delete-remote.log

# Delete them all!
echo ${BRANCHES_TO_DELETE} | \
  xargs -L1 \
  xargs git push origin --delete > /dev/null

echo "Deleted $(wc -l /tmp/delete-remote.log) branches"
echo

# Clean up anything local copies of branches we deleted from the origin.
git remote prune origin

echo Delete all local branches that have been merged
git branch --merged master |
  grep -v master |
  xargs git branch -d > /tmp/delete-local.log
echo "Deleted $(wc -l /tmp/delete-local.log) branches"
echo

echo Branches on local that are not on remote
git branch -r |
  awk '{print $1}' |
  egrep -v -f /dev/fd/0 <(git branch -vv | grep origin)

