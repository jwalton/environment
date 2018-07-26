#!/bin/sh

# Run this script, then:
#
#   git push --force --tags origin 'refs/heads/*'

# Fix for future commits.
git config user.email dev@lucid.thedreaming.org

# Fix all past commits.
git filter-branch --env-filter '
OLD_EMAIL="jwalton@benbria.ca"
CORRECT_NAME="Jason Walton"
CORRECT_EMAIL="dev@lucid.thedreaming.org"
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
