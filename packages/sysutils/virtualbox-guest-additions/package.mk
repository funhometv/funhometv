# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 Eric Hao (e.hao@aol.com)

PKG_NAME="virtualbox-guest-additions"
PKG_VERSION="7.0.6"
PKG_SHA256="f146d9a86a35af0abb010e628636fd800cb476cc2ce82f95b0c0ca876e1756ff"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL3"
PKG_SITE="https://www.virtualbox.org/"
PKG_URL="https://download.virtualbox.org/virtualbox/7.0.6/VirtualBox-7.0.6.tar.bz2"
PKG_DEPENDS_HOST="toolchain:host makeself:host"
#PKG_DEPENDS_TARGET="toolchain Python3 fuse glib:host glib libdnet libtirpc openssl alsa pulseaudio libxslt makeself yasm libXmu libX11 libXrandr libXt zlib systemd"
PKG_DEPENDS_TARGET="toolchain Python3 fuse glib:host glib libdnet libtirpc openssl alsa pulseaudio libxslt libXmu libX11 libXrandr libXt zlib systemd pam"
PKG_LONGDESC="from https://src.fedoraproject.org/rpms/virtualbox-guest-additions.git to make an alternate install, without user action to install iso as a disk.This package replaces the application of Virtualbox's own methodology to install Guest Additions (in menu: Devices | Insert Guest Additions CD-image file).  VirtualBox is a powerful x86 and AMD64/Intel64 virtualization product for enterprise as well as home use. This package contains the VirtualBox Guest Additions which support better integration of VirtualBox guests with the Host, including file sharing, clipboard sharing and Seamless mode.  Aditional note: this package can be installed on an non-guest system, because it is harmless and services would not run anyway."
PKG_TOOLCHAIN="manual"


#PKG_CONFIGURE_OPTS_TARGET="--disable-docs \
#                           --disable-tests \
#                           --disable-deploypkg \
#			   --disable-containerinfo \
#                           --without-pam \
#                           --without-gtk2 \
#                           --without-gtkmm \
#                           --without-ssl \
#                           --without-x \
#                           --without-xerces \
#                           --without-icu \
#                           --without-kernel-modules \
#                           --with-udev-rules-dir=/usr/lib/udev/rules.d/ \
#                           --with-sysroot=$SYSROOT_PREFIX"

#post_unpack() {
#  mv $PKG_BUILD/$PKG_NAME/* $PKG_BUILD/

#  sed -i -e 's|.*common-agent/etc/config/Makefile.*||' $PKG_BUILD/configure.ac
#  mkdir -p $PKG_BUILD/common-agent/etc/config
#}

pre_configure_target() {

echo " -------------------------------------------------------------pre_configure_target----------------- virtualbox-guest-addtion"
pwd
cd ..
    # Remove prebuilt binaries
    find -name '*.py[co]' -delete
    rm -r src/VBox/Additions/WINNT
    rm -r src/VBox/Additions/os2
    rm -r kBuild/
    rm -r tools/
    # Remove bundle X11 sources and some lib sources, before patching.
    rm -r src/VBox/Additions/x11/x11include/
    rm -r src/VBox/Additions/3D/mesa/mesa-21.3.8/
    rm -r src/libs/liblzf-3.*/
    rm -r src/libs/libpng-1.6.*/
    rm -r src/libs/libxml2-2.9.*/
    rm -r src/libs/openssl-3.*/
    rm -r src/libs/zlib-1.2.*/
    rm -r src/libs/curl-7.*/
    rm -r src/libs/libvorbis-1.3.*/
    rm -r src/libs/libogg-1.3.*/
    rm -r src/libs/libtpms-0.9.0/

cd -
}

make_target() {

PAM_DIR=$(get_build_dir pam)/libpam
PAM_INCLUDE=$PAM_DIR/include
PAM_LIB=$PAM_DIR/.install_pkg/usr/lib
DIR_NEED_ADD=$SYSROOT_PREFIX/usr/include
echo "we haoyq check PAM_INCLUDE:$PAM_INCLUDE, PAM_LIB:$PAM_LIB"
echo " -----------------------------------------------------make_target------------------------- virtualbox-guest-addtion"
pwd
cd ..

	    #--with-yasm=$(get_build_dir yasm)  \
	    #--with-makeself=$(get_build_dir makeself) \

    ./configure --only-additions --disable-kmods  \
	    --with-gcc=${TARGET_PREFIX}gcc \
	    --with-g++=${TARGET_PREFIX}g++ \
	    --with-linux=$(get_build_dir linux) \
	    --with-openssl-dir=$(get_build_dir openssl) \
	    --build-headless
    . ./env.sh
	echo "------------------after source env.sh -------------------make_target-------------- virtualbox-guest-addition"
    umask 0022
    
    # VirtualBox build system installs and builds in the same step,
    # not always looking for the installed files in places they have
    # really been installed to. Therefore we do not override any of
    # the installation paths, but install the tree with the default
    # layout under 'obj' and shuffle files around in %%install.
    #kmk %{_smp_mflags}                                             \

    echo "start kmk -----------------make_target ----------------"
    
    sed -i "3513,3520s,^,#," Config.kmk
	#at the root include add the pam_include_dir
    sed -i "1949s,$, $PAM_INCLUDE $SYSROOT_PREFIX/usr/include," Config.kmk
	#at RUNTIME_LIB add the SYSROOT_PREFIX/usr/lib
    sed -i "2184s,$, $SYSROOT_PREFIX/usr/lib," Config.kmk
    # in order to use our own lib , and avoid cross link problem"
    sed -i "s,/usr/X11R6/lib64,$SYSROOT_PREFIX/usr/lib,g" Config.kmk
    sed -i "s,/usr/X11R6/lib,$SYSROOT_PREFIX/usr/lib,g" Config.kmk
    sed -i "s,/usr/X11R6/lib32,$SYSROOT_PREFIX/usr/lib,g" Config.kmk
    # in order to link libSM 
    sed -i "s,pthread m rt dl,pthread m rt dl SM ICE,g" Config.kmk
    sed -i "s,TEMPLATE_VBOXGUESTR3EXE_LIBS     = pthread rt m dl, TEMPLATE_VBOXGUESTR3EXE_LIBS     = pthread rt m dl SM ICE,g" Config.kmk


   # CFLAGS+=" -I$(get_build_dir pam)/.$TARGET_NAME -lpam " 
    kmk \
        VBOX_ONLY_ADDITIONS=1                                      \
        KBUILD_VERBOSE=2                                           \
        PATH_OUT="$PWD/obj"                                        \
        TOOL_YASM_AS=yasm                                          \
        VBOX_USE_SYSTEM_XORG_HEADERS=1                             \
        VBOX_USE_SYSTEM_GL_HEADERS=1                               \
        VBOX_NO_LEGACY_XORG_X11=1                                  \
        SDK_VBOX_LIBPNG_INCS="$PAM_INCLUDE"                                    \
        SDK_VBOX_LIBXML2_INCS="$PAM_INCLUDE"                                   \
        SDK_VBOX_LZF_LIBS="lzf pam"                                    \
        SDK_VBOX_LZF_INCS=" $PAM_INCLUDE "                    \
        SDK_VBOX_OPENSSL_INCS="$PAM_INCLUDE"                                   \
        SDK_VBOX_OPENSSL_LIBS="ssl crypto"                         \
        SDK_VBOX_ZLIB_INCS="$PAM_INCLUDE"                                      \
        VBOX_BUILD_PUBLISHER=_FunHomeTV

    echo "kmk end -----------------make_target------------------"
cd -

}

makeinstall_target() {
    # The directory layout created below attempts to mimic the one of
    # the commercially supported version to minimize confusion
    cd ..
    mkdir -p $INSTALL/bin
    mkdir -p $INSTALL/sbin
    mkdir -p $INSTALL/lib/security
    
    # Guest-additions tools
    install -m 0755 -t $INSTALL/sbin   \
        obj/bin/additions/VBoxService            
    
    #for     %{SOURCE5}
    cp -Pv $PKG_DIR/scripts/mount.vboxsf $INSTALL/sbin

    
    install -m 0755 -t $INSTALL/bin    \
        obj/bin/additions/VBoxDRMClient          \
        obj/bin/additions/VBoxClient             \
        obj/bin/additions/VBoxControl	\
	obj/bin/additions/mount.vboxsf
    
    # Guest libraries
    install -m 0755 -t $INSTALL/lib/security \
        obj/bin/additions/pam_vbox.so
    
    #install -p -m 0755 -D src/VBox/Additions/x11/Installer/98vboxadd-xclient \
    #    $INSTALL/etc/X11/xinit/xinitrc.d/98vboxadd-xclient.sh
    #ln -s ../../etc/X11/xinit/xinitrc.d/98vboxadd-xclient.sh \
    #    $INSTALL/bin/VBoxClient-all
    #desktop-file-install --dir=$INSTALL/etc/xdg/autostart/ \
    #    --remove-key=Encoding src/VBox/Additions/x11/Installer/vboxclient.desktop
    #desktop-file-validate \
    #    $INSTALL/etc/xdg/autostart/vboxclient.desktop
    
    #install -p -m 0644 -D %{SOURCE1} $INSTALL%{_unitdir}/vboxservice.service
    #install -p -m 0644 -D %{SOURCE3} $INSTALL%{_udevrulesdir}/60-vboxguest.rules
    #install -p -m 0644 -D %{SOURCE4} $INSTALL%{_unitdir}/vboxclient.service
    
    cd -

}

#post_makeinstall_target() {
#  rm -rf $INSTALL/sbin
#  rm -rf $INSTALL/usr/share
#  rm -rf $INSTALL/etc/vmware-tools/scripts/vmware/network
#
#  find $INSTALL/etc/vmware-tools/ -type f | xargs sed -i '/.*expr.*/d'
#}

post_install() {
  enable_service vboxservice.service
  enable_service vboxclient.service
	# we added the static lib for virtualbox_guest_additions, others should not use it .
	if [ -e $SYSROOT_PREFIX/usr/lib/libstdc++.a ]; then
		rm  $SYSROOT_PREFIX/usr/lib/libstdc++.a
	fi
}
