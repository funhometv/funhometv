# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# copyright (c) 2023 Eric Hao (e.hao@aol.com)

PKG_NAME="dbus-glib"
PKG_VERSION="0.112"
PKG_SHA256="7d550dccdfcd286e33895501829ed971eeb65c614e73aadb4a08aeef719b143a"
PKG_LICENSE="GPL"
PKG_SITE="https://freedesktop.org/wiki/Software/dbus"
PKG_URL="https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.112.tar.gz"
PKG_DEPENDS_TARGET="toolchain dbus glib expat"
PKG_LONGDESC="A message bus, used for sending messages between applications."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic +lto"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_have_abstract_sockets=yes \
                           ac_cv_func_posix_getpwnam_r=yes \
                           have_abstract_sockets=yes \
                           --enable-static \
                           --disable-shared \
                           --disable-tests \
                           --disable-bash-completion \
			   --enable-gtk-doc-html=no \
                           --enable-asserts=no"
#enable-gtk-doc
export enable_gtk_doc="no"
#export enable_gtk_doc

######pre_configure_target(){
post_unpack(){
   #we make a patch for don't build tools or examples. because the old patch don't work, and working patch not found.
   cd ${PKG_BUILD}
   pwd
   echo "we haoyq patch Makefile.am"
   ls -l Makefile.am
   sed -i "s'SUBDIRS = dbus-gmain dbus tools test doc'SUBDIRS = dbus-gmain dbus test'" Makefile.am
   sed -i "s'SUBDIRS = dbus-gmain dbus tools test doc'SUBDIRS = dbus-gmain dbus test'" Makefile.in
   ls -l Makefile.am
#   echo "contents of Makefile.am"
#   cat ../Makefile.am
   echo "end of Makefile.am"

   echo "we haoyq patch dbus/Makefile.am"
   ls -l dbus/Makefile.am
   sed -i "s'SUBDIRS = . examples'SUBDIRS = . '" dbus/Makefile.am
   sed -i "s'SUBDIRS = . examples'SUBDIRS = . '" dbus/Makefile.in
   ls -l dbus/Makefile.am


   echo "we haoyq patch configure.ac"
   sed -i "s|dbus/examples/Makefile||" configure.ac
   sed -i "s|dbus/examples/statemachine/Makefile||" configure.ac

   sed -i "s|GTK_DOC_CHECK.*$||" configure.ac

   sed -i "s|doc/Makefile||" configure.ac
   sed -i "s|doc/dbus-binding-tool.1||" configure.ac
   sed -i "s|doc/reference/Makefile||" configure.ac
   sed -i "s|doc/reference/version.xml||" configure.ac
   

#   echo "contents of dbus/Makefile.am"
#   cat ../dbus/Makefile.am
   echo "we remove dbus/examples the directory "
   rm -fr dbus/examples
   rm -fr doc
   echo "we haoyq finished patch Makefile.am"
   cd -
}

#post_configure_target(){
#
#}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/dbus-binding-tool
}
