#!/bin/sh

INPUT="$1"
OUTPUT="$2"

cp "$INPUT" "$OUTPUT" || exit 1

mogrify -format jxl "$OUTPUT" || exit 2
mogrify -resize 3840x2160^ "$OUTPUT" || exit 3

QUALITY=$(identify -format %Q  $OUTPUT) 

if [ $QUALITY -gt 90 ]; then
    mogrify -quality 90 "$OUTPUT" || exit 4
fi

jhead -autorot -de -di -du -c "$OUTPUT" || exit 5
