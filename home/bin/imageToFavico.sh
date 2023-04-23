if ! which convert > /dev/null; then
  echo "Need imagemagick 'convert' installed."
  exit 1
fi

# Print usage instructions.
printUsage() {
  cat <<END
usage: `basename $0` [-h] [infile] [outfile]

Optional Arguments:
    -r        - Set framerate of output

END
}

OUT=

# Parse command line options.
while getopts hr:o:w: OPT; do
    case "$OPT" in
        h)
            printUsage
            exit 0
            ;;
        o)
            OUT=$OPTARG
            ;;
        \?)
            # getopts issues an error message
            printUsage >&2
            exit 1
            ;;
    esac
done

shift `expr $OPTIND - 1`

# We want at least one non-option argument.
if [ $# -eq 0 ]; then
    printUsage >&2
    exit 1
fi

IN=$1

# Figure out output file
if [ -z "${OUT}" ]; then
  OUT=$2
fi
if [ -z "${OUT}" ]; then
  OUT=favicon.ico
fi

# See https://legacy.imagemagick.org/Usage/thumbnails/
convert "$IN" \
  \( +clone -rotate 90 +clone -mosaic +level-colors white \) \
  +swap -gravity center -composite \
  -resize 256x256 \
  -define icon:auto-resize="256,128,96,64,48,32,16" \
  "$OUT"