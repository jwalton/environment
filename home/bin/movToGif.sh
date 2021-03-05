if ! which ffmpeg > /dev/null; then
  echo "Need ffmpeg installed."
  exit 1
fi

# Print usage instructions.
printUsage() {
  cat <<END
usage: `basename $0` [-h] [-w width] [-r framerate] [infile] [outfile]

Optional Arguments:
    -h        - Display this help message.
    -w        - Set width of output
    -r        - Set framerate of output

END
}

WIDTH=
FRAMERATE=30
OUT=

# Parse command line options.
while getopts hr:o:w: OPT; do
    case "$OPT" in
        h)
            printUsage
            exit 0
            ;;
        r)
            FRAMERATE=$OPTARG
            ;;
        o)
            OUT=$OPTARG
            ;;
        w)
            WIDTH=$OPTARG
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

# Figure out output file
if [ -z "${OUT}" ]; then
  OUT=$2
fi
if [ -z "${OUT}" ]; then
  OUT=${1%.*}.gif
fi


# Stole these filters from https://mattj.io/posts/2021-02-27-create-animated-gif-and-webp-from-videos-using-ffmpeg/
FILTERS="fps=$FRAMERATE"

if [ -n "${WIDTH}" ]; then
  FILTERS="${FILTERS},scale=${WIDTH}:-1:flags=lanczos"
fi

# Fix pallette.
FILTERS="${FILTERS},split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse"

ffmpeg -i "$1" -vf "$FILTERS" "$OUT"
