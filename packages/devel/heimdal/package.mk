# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="heimdal"
PKG_VERSION="7.8.0"
PKG_SHA256="fd87a207846fa650fd377219adc4b8a8193e55904d8a752c2c3715b4155d8d38"
PKG_LICENSE="BSD-3c"
PKG_SITE="http://www.h5l.org/"
PKG_URL="https://github.com/heimdal/heimdal/releases/download/heimdal-7.8.0/heimdal-7.8.0.tar.gz"
PKG_DEPENDS_HOST="toolchain e2fsprogs:host Python2:host ncurses:host"
PKG_LONGDESC="Kerberos 5, PKIX, CMS, GSS-API, SPNEGO, NTLM, Digest-MD5 and, SASL implementation."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-parallel"

PKG_CONFIGURE_OPTS_HOST="--enable-static --disable-shared \
                         --without-openldap \
                         --without-capng \
                         --without-sqlite3 \
                         --without-libintl \
                         --without-openssl \
                         --without-berkeley-db \
                         --without-readline \
                         --without-libedit \
                         --without-hesiod \
                         --without-x \
                         --disable-otp \
                         --disable-heimdal-documentation"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp -PR lib/asn1/asn1_compile $TOOLCHAIN/bin
}
