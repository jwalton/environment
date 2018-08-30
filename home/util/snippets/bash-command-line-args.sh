#!/usr/bin/env bash

# Adapted from: http://blog.mafr.de/2007/08/05/cmdline-options-in-shell-scripts/
# See also: http://wiki.bash-hackers.org/howto/getopts_tutorial

# Print usage instructions.
printUsage() {
  cat <<END
usage: `basename $0` [-h] [-d thing] [files]

where:
    files - Test files to run.

Optional Arguments:
    -h        - Display this help message.
    -d        - Set thing.

Examples:

    Run All Tests:
        ./bin/selenium-tests.sh

    Run One Test:
        ./bin/selenium-tests.sh test-e2e/e2e/browser-test/lts_farmboy.js

    Debug a Test:
        ./bin/selenium-tests.sh test-e2e/e2e/browser-test/lts_farmboy.js \\
          -- --grep "should create a thing" --inspect-brk
END
}

# Parse command line options.
while getopts hd: OPT; do
    case "$OPT" in
        h)
            printUsage
            exit 0
            ;;
        d)
            THING=$OPTARG
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
if [ $# -eq 0 ]; then
    printUsage >&2
    exit 1
fi

# Access additional arguments as usual through
# variables $@, $*, $1, $2, etc. or using this loop:

cmd "$@"

