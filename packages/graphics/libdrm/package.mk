
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libdrm"
#PKG_VERSION="2.4.99"
PKG_VERSION="2.4.110"
PKG_SHA256="eecee4c4b47ed6d6ce1a9be3d6d92102548ea35e442282216d47d05293cf9737"
PKG_LICENSE="GPL"
PKG_SITE="http://dri.freedesktop.org"
PKG_URL="https://dri.freedesktop.org/libdrm/libdrm-2.4.110.tar.xz"
PKG_DEPENDS_TARGET="toolchain libpciaccess"
PKG_LONGDESC="The userspace interface library to kernel DRM services."
PKG_TOOLCHAIN="meson"

get_graphicdrivers

PKG_DRM_CONFIG="-Dnouveau=false \
                -Domap=false \
                -Dexynos=false \
                -Dtegra=false"

listcontains "$GRAPHIC_DRIVERS" "(i915|i965)" &&
  PKG_DRM_CONFIG+=" -Dintel=true" || PKG_DRM_CONFIG+=" -Dintel=false"

listcontains "$GRAPHIC_DRIVERS" "(r200|r300|r600|radeonsi)" &&
  PKG_DRM_CONFIG+=" -Dradeon=true" || PKG_DRM_CONFIG+=" -Dradeon=false"

listcontains "$GRAPHIC_DRIVERS" "radeonsi" &&
  PKG_DRM_CONFIG+=" -Damdgpu=true" || PKG_DRM_CONFIG+=" -Damdgpu=false"

listcontains "$GRAPHIC_DRIVERS" "vmware" &&
  PKG_DRM_CONFIG+=" -Dvmwgfx=true" || PKG_DRM_CONFIG+=" -Dvmwgfx=false"

listcontains "$GRAPHIC_DRIVERS" "vc4" &&
  PKG_DRM_CONFIG+=" -Dvc4=true" || PKG_DRM_CONFIG+=" -Dvc4=false"

listcontains "$GRAPHIC_DRIVERS" "freedreno" &&
  PKG_DRM_CONFIG+=" -Dfreedreno=true" || PKG_DRM_CONFIG+=" -Dfreedreno=false"

listcontains "$GRAPHIC_DRIVERS" "etnaviv" &&
  PKG_DRM_CONFIG+=" -Detnaviv=true" || PKG_DRM_CONFIG+=" -Detnaviv=false"

PKG_MESON_OPTS_TARGET="-Dlibkms=false \
                       $PKG_DRM_CONFIG \
                       -Dcairo-tests=false \
                       -Dman-pages=false \
                       -Dvalgrind=false \
                       -Dfreedreno-kgsl=false \
                       -Dinstall-test-programs=false \
                       -Dudev=false"

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -a $PKG_BUILD/.$TARGET_NAME/tests/modetest/modetest $INSTALL/usr/bin/
}
