#!/bin/sh

BACKEND="$1"
INPUT="$2"
OUTPUT="$3"

if [ "$BACKEND" = "cjxl" ]; then
    # 1. Resize and strip metadata to a temporary JPEG
    TMP_JPG="$(mktemp --suffix=.jpg)"
    trap 'rm -f "$TMP_JPG"' EXIT

    convert "$INPUT" -strip -resize "3840x2160^" "$TMP_JPG" || exit 1

    # 2. Encode temporary JPEG to JXL
    # -d 1.0 = visually lossless
    # -e 7 = effort setting
    # -j 0 = allow lossless jpeg
    cjxl "$TMP_JPG" "$OUTPUT" -j 0 -d 1.0 -e 7 || exit 2
else
    # use mogrify (assuming mogrify has been built with JXL support)
    mogrify -path "$(dirname "$OUTPUT")" -format jxl -strip -resize "3840x2160^" "$INPUT" || exit 1
fi
