# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="gobject-introspection"
PKG_VERSION="1.74.0"
PKG_SHA256="347b3a719e68ba4c69ff2d57ee2689233ea8c07fc492205e573386779e42d653"
PKG_LICENSE="LGPL"
PKG_SITE="https://gitlab.gnome.org/GNOME/gobject-introspection"
PKG_URL="https://download.gnome.org/sources/gobject-introspection/1.74/gobject-introspection-1.74.0.tar.xz"
PKG_DEPENDS_HOST="libffi:host Python3:host glib:host meson:host pcre2:host"
PKG_DEPENDS_TARGET="toolchain Python3 glib libffi pcre2 glibc gobject-introspection:host"
PKG_LONGDESC="GObject introspection tools and libraries.A convenient wrapper for the GObject+ library for use in Python programs."
#PKG_TOOLCHAIN="autotools"
#PKG_TOOLCHAIN="configure"
#PKG_BUILD_FLAGS="-gold"

#PKG_CONFIGURE_OPTS_TARGET="--enable-thread --disable-introspection"
##-Dgi_cross_pkgconfig_sysroot_path=$TOOLCHAIN/$TARGET_NAME/sysroot \

PKG_MESON_OPTS_HOST=" -Dpython=python3 -Dcairo=disabled \
  -Dbuild_introspection_data=false"

	#-Dbuild_introspection_data=false"

PKG_MESON_OPTS_TARGET=" \
	-Dpython=python3 \
	-Dcairo=disabled \
	-Dgi_cross_use_prebuilt_gi=true \
        -Dgi_cross_binary_wrapper=/tmp/cw.sh  \
	"
#contents of /tmp/cw.sh is at the last of the file , in comments.

pre_configure_target() {
  export PYTHON_INCLUDES="$($SYSROOT_PREFIX/usr/bin/python3-config --includes)"
  echo " !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! we haoyq check: PYTHON_INCLUDES=$PYTHON_INCLUDES"
  export PYTHON=python3
  export  LIB_DIR="${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib"
  #export PKG_CONFIG_LIBDIR="${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib/pkgconfig"
  #export PKG_CONFIG_PATH="${TOOLCHAIN}/lib/pkgconfig:${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/share/pkgconfig"
  export CFLAGS=" ${CFLAGS} $PYTHON_INCLUDES  -L${TOOLCHAIN}/${TARGET_NAME}/sysroot/usr/lib "
  export CPPFLAGS="${CFLAGS}"
  export CXXFLAGS="${CFLAGS}"
  export GI_SCANNER_DEBUG=save-temps
# as https://stackoverflow.com/questions/847179/multiple-glibc-libraries-on-a-single-host said:
# we haoyq add the extra to link "-Wl,--rpath=/path/to/newglibc    -Wl,--dynamic-linker=/path/to/newglibc/ld-linux.so.2 "
  export LDFLAGS+=" -lpcre2-8 -lc -lz -lm -lffi -lresolv -lresolv -lresolv"
#    ## in order to make meson found libva in version 2.5 not version 1.5 , we haoyq added @2023/1/3
  echo "we check --------------------------------------------------------------------: LIB_DIR=${LIB_DIR}; PKG_CONFIG_LIBDIR=${PKG_CONFIG_LIBDIR}; PKG_CONFIG_PATH=${PKG_CONFIG_PATH} ; CFLAGS=${CFLAGS} ; LDFLAGS=${LDFLAGS}"

# in order to make proot work , we need a /mnt directory in built image to make a rootfs for guestfs.
#  mkdir -p  $PKG_BUILD/image/system/mnt
# it should be in system generated place , because it is now every build mkdir new directory. in scripts/image 
}
#
#post_makeinstall_target() {
#  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
#  find $INSTALL/usr/lib -name "*.pyc" -exec rm -rf "{}" ";"
#
#  rm -rf $INSTALL/usr/bin
#  rm -rf $INSTALL/usr/share/pygobject
#}
#
#
# the following is the contents of /tmp/cw.sh ; remember to remove the first columu comment and mount the system.img in /srv (in order to make gobject-introspection work in target environment ---- althougt it should not work in this way )in advance. and install proot in host(apt install proot). proot is a good tool in cross compile . we haoyq at 2023-02
##!/bin/sh
#
#
#PROOT_RPATH=/srv
#PROOT_BPATH=/mnt
#PROOT_WPATH=/mnt/aafdc9f9-6474-4852-8835-7319550e78d9/tmp/xt/funhometv/funhome.tv.hwmate/build.FunHomeTV-Generic.x86_64-1.0.1/gobject-introspection-1.74.0/.x86_64-libreelec-linux-gnu/
#
#CMD_PROOT="proot -r $PROOT_RPATH -b $PROOT_BPATH -w $PROOT_WPATH "
#
#
#echo "COMMAND IS :$@"
#
#
#echo "CMD_PROOT is :$CMD_PROOT"
#
#
#exec $CMD_PROOT $@
#
