#!/bin/bash

source $(dirname $0)/../etc/checkEnvs.sh

ROOTFS_BUILD_DIR=$BUILDROOT/packages/buildroot/output_rootfs/build
STAGINGDIR=${STAGINGDIR:-$BUILDROOT/packages/buildroot/output_rootfs/staging}
ROOTFS=${ROOTFS:-$BUILDROOT/rootfs}
USR_LIB_SO_LIBS=" \
			libbmp.so* \
			libdirect-*.so* \
			libdirectfb-*.so* \
			libfreetype.so* \
			libfusion-*.so* \
			libgif.so* \
			libjpeg.so* \
			libpng.so* \
			libshm.so* \
			libst2fx.so* \
			libtiff.so* \
			libz.so* \
			libQt*.so* \
			directfb*"

#TODO: Is need to remove usr/lib/directfb-1.4* directory??

echo "$USR_LIB_SO_LIBS"
echo "Cleaning staging $STAGINGDIR"
pushd $STAGINGDIR/usr/lib 2>/dev/null && rm -fr $USR_LIB_SO_LIBS && popd

echo "Cleaning rootfs $ROOTFS"
pushd $ROOTFS/usr/lib 2>/dev/null && rm -fr $USR_LIB_SO_LIBS && popd

echo "Cleaning rootfs_nfs ${ROOTFS}_nfs"
pushd ${ROOTFS}_nfs/usr/lib 2>/dev/null && rm -fr $USR_LIB_SO_LIBS && popd

echo "Cleaning multicom libraries from rootfs and rootfs_nfs"
pushd ${ROOTFS}/root 2>/dev/null && rm -fr ./multicom* && popd
pushd ${ROOTFS}_nfs/root 2>/dev/null && rm -fr ./multicom* && popd

rm -f $ROOTFS_BUILD_DIR/.*_installed
