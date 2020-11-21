#!/usr/bin/env bash
set -e

DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

echo "Default branch is ${DEFAULT_BRANCH}"

log() {
  echo "${1}"
  echo "${1}" >> /tmp/git-garden-delete.log
}

# Given a list of branches, print them and their short hashes.
print_branches() {
  BRANCHES=$1
  PREFIX=$2
  echo "$BRANCHES" | xargs -L1 -I'{}' bash -c 'printf "%s%-60s %s\n" "'"$PREFIX"'" "{}" "$(git rev-parse --short {})"'
}

# Delete merged branches from the origin
delete_origin_merged() {
  TARGET_BRANCH=$1
  BRANCHES_TO_DELETE=$(
    git branch -r --merged "origin/${TARGET_BRANCH}" |
      grep origin |
      grep -v '>' |
      grep -v master |
      grep -v "${DEFAULT_BRANCH}" || echo ""
  )

  if [ -n "${BRANCHES_TO_DELETE}" ]; then
    log "Delete remote branches merged to ${TARGET_BRANCH}:"
    print_branches "$BRANCHES_TO_DELETE" "  "
    print_branches "$BRANCHES_TO_DELETE" "  " >> /tmp/git-garden-delete.log
    echo "$BRANCHES_TO_DELETE" | sed -e 's/^[ ]*origin\///' | xargs git push origin --delete > /dev/null
  fi
  echo
}

# Delete merged branches locally
delete_local_merged() {
  TARGET_BRANCH=$1
  BRANCHES_TO_DELETE=$(
    git branch --merged "${TARGET_BRANCH}" |
      grep -v master |
      grep -v "${DEFAULT_BRANCH}" || echo ""
  )
  if [ -n "${BRANCHES_TO_DELETE}" ]; then
    log "Delete local branches merged to ${TARGET_BRANCH}:"
    print_branches "$BRANCHES_TO_DELETE" "  "
    print_branches "$BRANCHES_TO_DELETE" "  " >> /tmp/git-garden-delete.log
    echo "$BRANCHES_TO_DELETE" | xargs git branch -d > /dev/null
    echo
  fi
}

log "$(date) - Running in $(pwd)"

# Get the latest state from the origin
git fetch --all -q

delete_origin_merged master
if [ "$DEFAULT_BRANCH" != "master" ]; then
  delete_origin_merged "$DEFAULT_BRANCH"
fi

delete_local_merged master
if [ "$DEFAULT_BRANCH" != "master" ]; then
  delete_local_merged "$DEFAULT_BRANCH"
fi

echo 'Branches on local that are not on remote:'
git branch -r |
  awk '{print $1}' |
  egrep -v -f /dev/fd/0 <(git branch -vv | grep origin)

