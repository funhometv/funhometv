# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2021 Eric Hao (uucoin@163.com)

PKG_NAME="memcached"
PKG_VERSION="1.6.9"
PKG_SHA256="d5a62ce377314dbffdb37c4467e7763e3abae376a16171e613cbe69956f092d1"
PKG_LICENSE="BSD"
PKG_SITE="https://www.memcached.org/"
PKG_URL="http://www.memcached.org/files/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libevent"
PKG_LONGDESC="Free & open source, high-performance, distributed memory object caching system, generic in nature, but intended for use in speeding up dynamic web applications by alleviating database load."

#PKG_CONFIGURE_OPTS_HOST="--disable-nls --disable-acl --without-selinux"
PKG_CONFIGURE_OPTS_TARGET=" --with-libevent=$SYSROOT_PREFIX/usr "
