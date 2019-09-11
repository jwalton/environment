#!/bin/bash
## ARGS - INFILE, WIDTH SIZE, OUTFILE, FRAME RATE (DEFAULT 10), DELAY (DEFAULT 8)

# From https://github.com/skickar/MakeGifMacOS

WIDTH=${2:-500}
OUTFILE=${3:-out}
FRAMERATE=${4:-10}
DELAY=${5:-8}
echo "Set to $WIDTH wide"
echo "Set to $FRAMERATE framerate"
echo "Set to $DELAY delay"

 ffmpeg -i "$1"  -vf scale="$WIDTH":-1 -r "$FRAMERATE" ./ffout%3d.png
 convert -delay "$DELAY" -loop 0 ./ffout*.png ./"$OUTFILE".gif
 rm ffout*.png

