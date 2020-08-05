#!/bin/sh

# Print usage instructions.
printUsage() {
  cat <<END
usage: `basename $0` [-h] [oldEmailAddress] [newEmailAddress]

where:
    oldEmailAddress - The old email address to fix.
    newEmailAddress - The new email address to change to.

Optional Arguments:
    -h        - Display this help message.

END
}

# Parse command line options.
while getopts h OPT; do
    case "$OPT" in
        h)
            printUsage
            exit 0
            ;;
        \?)
            # getopts issues an error message
            printUsage >&2
            exit 1
            ;;
    esac
done

# Remove the switches we parsed above.
shift `expr $OPTIND - 1`

# We want at least one non-option argument.
# Remove this block if you don't need it.
if [ ! $# -eq 2 ]; then
    printUsage >&2
    exit 1
fi


# Access additional arguments as usual through
# variables $@, $*, $1, $2, etc. or using this loop:
# for PARAM; do
#     echo $PARAM
# done

OLD_EMAIL=${1:-"jwalton@solinkcorp.com"}
NEW_EMAIL=${2:-"dev@lucid.thedreaming.org"}

# Fix for future commits.
echo "Updating default email for this repo to ${NEW_EMAIL}"
git config user.email ${NEW_EMAIL}

# Fix all past commits.
echo "Fixing past commits from ${OLD_EMAIL} to ${NEW_EMAIL}"
git filter-branch --env-filter '
OLD_EMAIL="'${OLD_EMAIL}'"
CORRECT_NAME="Jason Walton"
CORRECT_EMAIL="'${NEW_EMAIL}'"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags

echo Review to make sure it worked, then:
echo
echo     git push --force --tags origin 'refs/heads/*'
