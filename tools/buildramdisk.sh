#!/bin/sh

clear
echo "Building ramdisk"

##Self set parameters
export BUILD_ENV="/home/ricky/Desktop/kernel_development"
export CROSS_COMPILE="/opt/toolchains/arm-eabi-4.4.3/bin/arm-eabi-"

##Automatic parameters
export KERNELDIR="$BUILD_ENV/kernel_source"
export RAMFS_SOURCE="$BUILD_ENV/ramfs"
export RAMFS_TMP="$BUILD_ENV/ramfstmp"
export TOOLS_DIR="$BUILD_ENV/tools"
export USE_SEC_FIPS_MODE=true

##Update ramdisk
echo "UPDATING MODULES $(date)" >>$TOOLS_DIR/build.log
cp -ax $RAMFS_SOURCE $RAMFS_TMP
find $RAMFS_TMP -name .git -exec rm -rf {} \;
rm -rf $RAMFS_TMP/tmp/*
rm -rf $RAMFS_TMP/.hg
echo "UPDATED MODULES $(date)" >>$TOOLS_DIR/build.log

##Compiling modules
echo "COMPILING MODULES $(date)" >>$TOOLS_DIR/build.log
mkdir -p $RAMFS_TMP/lib/modules
find -name '*.ko' -exec cp -av {} $RAMFS_TMP/lib/modules/ \;
${CROSS_COMPILE}strip --strip-unneeded $RAMFS_TMP/lib/modules/* 
echo "COMPILED MODULES $(date)" >>$TOOLS_DIR/build.log

##Building ramdisk
echo "BUILDING RAMDISK $(date)" >>$TOOLS_DIR/build.log
cd $RAMFS_TMP
find | fakeroot cpio -H newc -o > $RAMFS_TMP.cpio 2>/dev/null
ls -lh $RAMFS_TMP.cpio
gzip -9 $RAMFS_TMP.cpio
echo "BUILD RAMDISK $(date)" >>$TOOLS_DIR/build.log

##Compiling boot.img
echo "COMPILING BOOT.IMG $(date)" >>$TOOLS_DIR/build.log
mkdir $BUILD_ENV/tmp
chmod 777 $TOOLS_DIR/mkbootimg
$TOOLS_DIR/mkbootimg --kernel $KERNELDIR/arch/arm/boot/zImage --ramdisk $RAMFS_TMP.cpio.gz --board smdk4x12 --base 0x10000000 -o $BUILD_ENV/tmp/boot.img
echo "COMPILED BOOT.IMG $(date)" >>$TOOLS_DIR/build.log



