# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gnupg"
PKG_VERSION="2.2.19"
PKG_SHA256="242554c0e06f3a83c420b052f750b65ead711cc3fddddb5e7274fcdbb4e9dec0"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.gnupg.org/"
PKG_URL="https://www.gnupg.org/ftp/gcrypt/gnupg/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libgpg-error npth libgcrypt libksba libassuan"
PKG_DEPENDS_INIT="toolchain  libgpg-error npth libgcrypt libksba libassuan"
PKG_LONGDESC="A General purpose cryptographic library."
PKG_TOOLCHAIN="configure"
# libgcrypt-1.7.x fails to build with LTO support
# see for example https://bugs.gentoo.org/show_bug.cgi?id=581114

# copied from configure --help
#  --with-libgpg-error-prefix=PFX
#                          prefix where GPG Error is installed (optional)

#  --with-libgcrypt-prefix=PFX
#                          prefix where LIBGCRYPT is installed (optional)
#  --with-libassuan-prefix=PFX
#                          prefix where LIBASSUAN is installed (optional)
#  --with-ksba-prefix=PFX  prefix where KSBA is installed (optional)
#  --with-npth-prefix=PFX  prefix where NPTH is installed (optional)

# copied from previous template
#
			    #CC_FOR_BUILD=$HOST_CC \
  #                           ac_cv_sys_symbol_underscore=no \
  #                           --enable-asm \
  #                           --with-gnu-ld \
  #
			    #
        #--disable-gpg-blowfish \
        #--disable-gpg-cast5 \
        #--disable-gpg-idea \
        #--disable-gpg-md5 \
        #--disable-gpg-rmd160 \
			    #
			    #
			    #
			    #

pre_configure_target() {

echo "in pre_configure_target()" 

  PKG_CONFIGURE_OPTS_TARGET=" \
                             --with-libgpg-error-prefix=$SYSROOT_PREFIX/usr \
			     --with-libgcrypt-prefix=$SYSROOT_PREFIX/usr \
			     --with-libassuan-prefix=$SYSROOT_PREFIX/usr \
			     --with-ksba-prefix=$SYSROOT_PREFIX/usr \
			     --with-npth-prefix=$SYSROOT_PREFIX/usr \
			     --enable-static --disable-shared \
			     --disable-zip  --disable-bzip2 \
	                     --disable-card-support \
	      	             --disable-ccid-driver \
                             --disable-dirmngr \
			     --disable-gnutls \
        --disable-gpgtar \
        --disable-ldap \
        --disable-libdns \
        --disable-nls \
        --disable-ntbtls \
        --disable-photo-viewers \
        --disable-regex \
        --disable-scdaemon \
        --disable-sqlite \
        --disable-wks-tools \
	--disable-exec \
        --without-zlib \
                             --disable-doc"

echo "out pre_configure_target()"
}
pre_make_target(){

echo "in pre_make_target()"
#in order to generate static build
sed -i -e "s/extra_bin_ldflags =/extra_bin_ldflags = -pie -static /" g10/Makefile

echo "out pre_make_target()"
}
#uper is ok for target
#following is for init
pre_build_init() {
#  PKG_MAKE_OPTS_INIT="ARCH=$TARGET_ARCH \
#                      HOSTCC=$HOST_CC \
#                      CROSS_COMPILE=$TARGET_PREFIX \
#                      KBUILD_VERBOSE=1 \
#                      install"
echo "in pre_build_init()"

  mkdir -p $PKG_BUILD/.$TARGET_NAME-init
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME-init

echo "out pre_build_init()"

}

pre_configure_init() {

echo "in pre_configure_init()"

  PKG_CONFIGURE_OPTS_INIT=" \
                             --with-libgpg-error-prefix=$SYSROOT_PREFIX/usr \
                             --with-libgcrypt-prefix=$SYSROOT_PREFIX/usr \
                             --with-libassuan-prefix=$SYSROOT_PREFIX/usr \
                             --with-ksba-prefix=$SYSROOT_PREFIX/usr \
                             --with-npth-prefix=$SYSROOT_PREFIX/usr \
			     --enable-static --disable-shared \
			                                 --disable-zip  --disable-bzip2 \
                             --disable-card-support \
                             --disable-ccid-driver \
                             --disable-dirmngr \
                             --disable-gnutls \
        --disable-gpgtar \
        --disable-ldap \
        --disable-libdns \
        --disable-nls \
        --disable-ntbtls \
        --disable-photo-viewers \
        --disable-regex \
        --disable-scdaemon \
        --disable-sqlite \
        --disable-wks-tools \
        --disable-exec \
        --without-zlib \

                             --disable-doc"
echo "out pre_configure_init()"

}

makeinstall_init(){

echo "in makeinstall_init()"
sed -i -e "s/extra_bin_ldflags =/extra_bin_ldflags = -pie -static /" g10/Makefile
#make clean
mkdir -p $INSTALL/usr/sbin
mv g10/gpgv $INSTALL/usr/sbin/gpgv-d
make

mkdir -p $INSTALL/usr/sbin
cp -Pv g10/gpgv $INSTALL/usr/sbin/gpgv-s
cp -Pv g10/gpgv $INSTALL/usr/sbin/gpgv
echo "out  makeinstall_init()"

}


pre_makeinstall_init() {

echo "in pre_makeinstall_init()"
##LD_FLAGS+=" -pie -static"
LDFLAGS="$LDFLAGS -pie -static "
export
(
cd g10
#make $LD_FLAGS  gpgv
mkdir -p $INSTALL/usr/sbin
cp -Pv gpgv $INSTALL/usr/sbin/gpgvs
)
echo "out pre_makeinstall_init()"

}

post_makeinstall_target() {

  #sed -e "s:\(['= ]\)\"/usr:\\1\"$SYSROOT_PREFIX/usr:g" -i src/$PKG_NAME-config
  #cp src/$PKG_NAME-config $SYSROOT_PREFIX/usr/bin

  #rm -rf $INSTALL/usr/bin

  #copy the public key for verify to the system
  mkdir -p $INSTALL/etc
  cp -Pv $PKG_DIR/configfile/pubring.kbx $INSTALL/etc

}
