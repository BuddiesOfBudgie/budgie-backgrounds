#!/usr/bin/env bash

INPUT="$1"
OUTPUT="$2"

cp "$INPUT" "$OUTPUT" || exit 1

mogrify -format jpg "$OUTPUT" || exit 2
mogrify -resize 3840x "$OUTPUT" || exit 3

QUALITY="$(identify -verbose $OUTPUT | grep 'Image:\|Quality')"

if [[ "$QUALITY" > 90 ]]; then
    mogrify -quality 90 "$OUTPUT" || exit 4
fi

jhead -autorot -de -di -du -c "$OUTPUT" || exit 5
