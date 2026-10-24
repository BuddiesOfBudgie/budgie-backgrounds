#!/bin/sh

BACKEND="$1"
INPUT="$2"
OUTPUT="$3"

if [ "$BACKEND" = "cjxl" ]; then
    # 1. Resize and strip metadata to a temporary PNG
    TMP_PNG="$(mktemp --suffix=.png)"
    trap 'rm -f "$TMP_PNG"' EXIT

    magick "$INPUT" -strip -resize "3840x2160^" "$TMP_PNG" || exit 1

    # 2. Encode temporary PNG to JXL
    # -d 1.0 = visually lossless
    # -e 7 = effort setting
    cjxl "$TMP_PNG" "$OUTPUT" -d 1.0 -e 7 || exit 2
else
    # use mogrify (assuming mogrify has been built with JXL support)
    mogrify -path "$(dirname "$OUTPUT")" -format jxl -strip -resize "3840x2160^" "$INPUT" || exit 1
fi
