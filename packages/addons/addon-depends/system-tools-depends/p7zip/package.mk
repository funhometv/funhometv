# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="p7zip"
PKG_VERSION="16.02"
PKG_SHA256="5eb20ac0e2944f6cb9c2d51dd6c4518941c185347d4089ea89087ffdd6e2341f"
PKG_LICENSE="GPL"
PKG_SITE="http://p7zip.sourceforge.net/"
PKG_URL="http://downloads.sourceforge.net/project/p7zip/p7zip/${PKG_VERSION}/p7zip_${PKG_VERSION}_src_all.tar.bz2"
PKG_DEPENDS_HOST="gcc:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="p7zip is a port of 7za.exe for POSIX systems like Unix."
PKG_TOOLCHAIN="manual"


make_host() {
# in order to resolve "MyWindows.h:83:40: error: narrowing conversion of '-2147467263' from 'LONG' {aka 'int'} to 'unsigned int' [-Wnarrowing]" as "https://sourceforge.net/p/p7zip/bugs/226/" said.
	cd ${PKG_BUILD}
	ls -l CPP/Windows/ErrorMsg.cpp
	sed -i "s'switch(errorCode)'switch(HRESULT(errorCode))'" CPP/Windows/ErrorMsg.cpp
	sed -i "s'switch(messageID)'switch(HRESULT(messageID))'" CPP/Windows/ErrorMsg.cpp
	ls -l CPP/Windows/ErrorMsg.cpp
	cd -
# end of resolve upper problem
  make CXX=$CXX CC=$CC 7za
}

make_target() {
# in order to resolve "MyWindows.h:83:40: error: narrowing conversion of '-2147467263' from 'LONG' {aka 'int'} to 'unsigned int' [-Wnarrowing]" as "https://sourceforge.net/p/p7zip/bugs/226/" said.
	cd ${PKG_BUILD}
	ls -l CPP/Windows/ErrorMsg.cpp
	sed -i "s'switch(errorCode)'switch(HRESULT(errorCode))'" CPP/Windows/ErrorMsg.cpp
	sed -i "s'switch(messageID)'switch(HRESULT(messageID))'" CPP/Windows/ErrorMsg.cpp
	ls -l CPP/Windows/ErrorMsg.cpp
	cd -
# end of resolve upper problem
  make CXX=$CXX CC=$CC 7z 7za
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp bin/7za $TOOLCHAIN/bin
}

makeinstall_target(){
  mkdir -p $INSTALL/usr/bin
    cp -Pv bin/7za $INSTALL/usr/bin
    cp -Pv bin/7z $INSTALL/usr/bin
    cp -Pv bin/7z.so $INSTALL/usr/bin
}
