OUTFILE=${2:-out.gif}

if ! which ffmpeg > /dev/null; then
  echo "Need ffmpeg installed."
  exit 1
fi

if [ -z "${1}" ]; then
  echo "Need input filename."
  exit 1
fi


ffmpeg -i $1 -pix_fmt rgb24 -r 10 ${OUTFILE}
