#!/usr/bin/env bash
set -e

rm -rf build
meson --prefix /usr build
ninja dist -C build

VERSION=$(grep "version:" meson.build | head -n1 | cut -d"'" -f2)
TAR="budgie-backgrounds-${VERSION}.tar.xz"
VTAR="budgie-backgrounds-v${VERSION}.tar.xz"
PRECOMPILED_DIR="budgie-backgrounds-v${VERSION}"
PRECOMPILED_TAR="budgie-backgrounds-v${VERSION}-precompiled.tar.xz"

mv build/meson-dist/$TAR $VTAR

STAGING="build/precompiled/${PRECOMPILED_DIR}"
rm -rf build/precompiled
mkdir -p "$STAGING"
mogrify -path "$STAGING" -strip -resize "3840x2160^" backgrounds/*.jpg
sed -e 's|@prefix@|/usr|g' -e 's/\.jxl</.jpg</g' data/budgie-backgrounds.xml.in > "${STAGING}/budgie-backgrounds.xml"
tar -C build/precompiled -cJf "$PRECOMPILED_TAR" "$PRECOMPILED_DIR"

gpg --armor --detach-sign $VTAR
gpg --verify "${VTAR}.asc"
gpg --armor --detach-sign $PRECOMPILED_TAR
gpg --verify "${PRECOMPILED_TAR}.asc"
