#!/usr/bin/env bash
set -e

rm -rf build
meson --prefix /usr build
ninja dist -C build

VERSION=$(grep "version:" meson.build | head -n1 | cut -d"'" -f2)
TAR="budgie-backgrounds-${VERSION}.tar.xz"
VTAR="budgie-backgrounds-v${VERSION}.tar.xz"
PRECOMPILED_DIR="budgie-backgrounds-v${VERSION}"

mv build/meson-dist/$TAR $VTAR
gpg --armor --detach-sign $VTAR
gpg --verify "${VTAR}.asc"

for FORMAT in jpg jxl; do
    STAGING="build/precompiled-${FORMAT}/${PRECOMPILED_DIR}"
    PRECOMPILED_TAR="budgie-backgrounds-v${VERSION}-precompiled-${FORMAT}.tar.xz"
    rm -rf "build/precompiled-${FORMAT}"
    mkdir -p "$STAGING"
    mogrify -path "$STAGING" -format "$FORMAT" -strip -resize "3840x2160^" backgrounds/*.jpg
    sed -e 's|@prefix@|/usr|g' -e "s/\.jxl</.${FORMAT}</g" data/budgie-backgrounds.xml.in > "${STAGING}/budgie-backgrounds.xml"
    tar -C "build/precompiled-${FORMAT}" -cJf "$PRECOMPILED_TAR" "$PRECOMPILED_DIR"
    gpg --armor --detach-sign "$PRECOMPILED_TAR"
    gpg --verify "${PRECOMPILED_TAR}.asc"
done
