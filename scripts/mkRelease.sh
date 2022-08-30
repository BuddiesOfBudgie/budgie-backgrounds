#!/usr/bin/env bash
set -e

rm -rf build
meson --prefix /usr build
ninja dist -C build

VERSION=$(grep "version:" meson.build | head -n1 | cut -d"'" -f2)
TAR="budgie-backgrounds-${VERSION}.tar.xz"
VTAR="budgie-backgrounds-v${VERSION}.tar.xz"

mv build/meson-dist/$TAR $VTAR

gpg --armor --detach-sign $VTAR
gpg --verify "${VTAR}.asc"
