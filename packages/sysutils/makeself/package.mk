# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 Eric Hao (e.hao@aol.com)

PKG_NAME="makeself"
PKG_VERSION="2.4.5"
PKG_SHA256="91deafdbfddf130abe67d7546f0c50be6af6711bb1c351b768043bd527bd6e45"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/megastep/makeself"
PKG_URL="https://github.com/megastep/makeself/archive/refs/tags/release-2.4.5.tar.gz"
PKG_DEPENDS_HOST="ccache:host zlib:host lzo:host xz:host zstd:host"
PKG_NEED_UNPACK="$(get_pkg_directory zlib) $(get_pkg_directory lzo) $(get_pkg_directory xz) $(get_pkg_directory zstd)"
PKG_LONGDESC="Make self-extractable archives on Unix"
PKG_TOOLCHAIN="manual"

make_host() {
  CFLAGS="${CFLAGS} -fcommon " make 
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp makeself.sh $TOOLCHAIN/bin
}
