#!/usr/bin/env bash
set -e

DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

echo "Default branch is ${DEFAULT_BRANCH}"

log() {
  echo "${1}"
  echo "${1}" >> /tmp/git-garden-delete.log
}

function confirm() {
    MESSAGE=$1

    read -r -p "${MESSAGE} [Y/n] " input

    case $input in
        [yY][eE][sS]|[yY]|"")
                echo yes
                ;;
        [nN][oO]|[nN])
                echo no
                ;;
        *)
                echo "Invalid input..."
                exit 1
                ;;
    esac
}

# Given a list of branches, print them and their short hashes.
print_branches() {
  BRANCHES=$1
  PREFIX=$2
  echo "$BRANCHES" | xargs -L1 -I'{}' bash -c 'printf "%s%-60s %s\n" "'"$PREFIX"'" "{}" "$(git rev-parse --short {})"'
}

delete_branches() {
  TYPE=$1
  BRANCHES_TO_DELETE=$2

  print_branches "$BRANCHES_TO_DELETE" "  "
  if [ $(confirm "Delete branches?") == "yes" ]; then
    print_branches "$BRANCHES_TO_DELETE" "  " >> /tmp/git-garden-delete.log

    case $TYPE in
        "remote")
            echo "$BRANCHES_TO_DELETE" | sed -e 's/^[ ]*origin\///' | xargs git push origin --delete > /dev/null
            ;;
        "local")
            echo "$BRANCHES_TO_DELETE" | xargs git branch -d > /dev/null
            ;;
        *)
            echo "Invalid type ${TYPE}"
            exit 1
            ;;
    esac
  else
    log "Skipping deleting branches..."
  fi

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
    delete_branches "remote" "${BRANCHES_TO_DELETE}"
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
    delete_branches "local" "${BRANCHES_TO_DELETE}"
  fi
}

log "$(date) - Running in $(pwd)"

# Get the latest state from the origin
git fetch --all -q

# Prune branches that exist in refs/remotes but no longer exist on origin
git remote prune origin > /dev/null

delete_origin_merged master
if [ "$DEFAULT_BRANCH" != "master" ]; then
  delete_origin_merged "$DEFAULT_BRANCH"
fi

# Clean up anything local copies of branches we deleted from the origin.
git remote prune origin

delete_local_merged master
if [ "$DEFAULT_BRANCH" != "master" ]; then
  delete_local_merged "$DEFAULT_BRANCH"
fi

echo 'Branches on local that are not on remote:'
git branch -r |
  awk '{print $1}' |
  egrep -v -f /dev/fd/0 <(git branch -vv | grep origin)

