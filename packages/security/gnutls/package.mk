# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gnutls"
PKG_VERSION="3.6.16"
PKG_SHA256="1b79b381ac283d8b054368b335c408fedcb9b7144e0c07f531e3537d4328f3b3"
PKG_LICENSE="LGPL2.1"
PKG_SITE="https://gnutls.org"
PKG_URL="https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libidn2 nettle zlib"
PKG_LONGDESC="A library which provides a secure layer over a reliable transport layer."

PKG_CONFIGURE_OPTS_TARGET="--disable-doc \
                           --disable-full-test-suite \
                           --disable-guile \
                           --disable-libdane \
                           --disable-padlock \
                           --disable-tests \
                           --disable-tools \
                           --disable-valgrind-tests \
                           --enable-local-libopts \
                           --enable-fips140-mode \
                           --with-idn \
                           --with-included-libtasn1 \
                           --with-included-unistring \
                           --without-p11-kit \
                           --without-tpm"
#makeinstall_target() {
#  make install DESTDIR="$INSTALL/../.INSTALL_PKG"
#}
