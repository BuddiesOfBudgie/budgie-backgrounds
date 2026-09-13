#!/bin/sh

INPUT="$1"
OUTPUT="$2"

cp "$INPUT" "$OUTPUT" || exit 1

mogrify -format jxl -strip "$OUTPUT" || exit 2
mogrify -resize 3840x2160^ "$OUTPUT" || exit 3
