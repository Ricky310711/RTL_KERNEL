#!/bin/sh

clear
##Self set parameters
export ARCH="arm"
export DEFCONFIG="m0_00_defconfig"
export CPU_THREADS="5"
export OUTPUT_DIR="/home/ricky/Desktop"
export BUILD_ENV="/home/ricky/Desktop/kernel_development"
export CROSS_COMPILE="/opt/toolchains/arm-eabi-4.4.3/bin/arm-eabi-"

##Automatic parameters
export KERNELDIR="$BUILD_ENV/kernel_source"
export RAMFS_SOURCE="$BUILD_ENV/ramfs"
export RAMFS_TMP="$BUILD_ENV/ramfstmp"
export TOOLS_DIR="$BUILD_ENV/tools"
export USE_SEC_FIPS_MODE=true

echo "START TIME $(date)" >$TOOLS_DIR/build.log
echo "" >>$TOOLS_DIR/build.log
chown root $TOOLS_DIR/build.log

echo "---- Set Parameters ---- 10%"

##Using clean sources
echo "CLEANING SOURCES $(date)" >>$TOOLS_DIR/build.log
rm -rf $KERNELDIR
rm -rf $OUTPUT_DIR/CompiledKernel.zip 
cp -ax /home/ricky/Desktop/clean_kernel_source $KERNELDIR
chown --recursive root $KERNELDIR
echo "CLEAN SOURCES COPIED $(date)" >>$TOOLS_DIR/build.log

##Compiling zImage
echo "COMPILING ZIMAGE $(date)" >>$TOOLS_DIR/build.log
cd $KERNELDIR/
make clean && make mrproper
make $DEFCONFIG
#make -j$CPU_THREADS || exit 1
make || exit 1
echo "COMPILED ZIMAGE $(date)" >>$TOOLS_DIR/build.log

echo "---- Compiled zImage ---- 70%"

##Update ramdisk
echo "UPDATING MODULES $(date)" >>$TOOLS_DIR/build.log
cp -ax $RAMFS_SOURCE $RAMFS_TMP
find $RAMFS_TMP -name .git -exec rm -rf {} \;
rm -rf $RAMFS_TMP/tmp/*
rm -rf $RAMFS_TMP/.hg
echo "UPDATED MODULES $(date)" >>$TOOLS_DIR/build.log

echo "---- Updated Ramdisk ---- 80%"

##Compiling modules
echo "COMPILING MODULES $(date)" >>$TOOLS_DIR/build.log
mkdir -p $RAMFS_TMP/lib/modules
find -name '*.ko' -exec cp -av {} $RAMFS_TMP/lib/modules/ \;
${CROSS_COMPILE}strip --strip-unneeded $RAMFS_TMP/lib/modules/* 
echo "COMPILED MODULES $(date)" >>$TOOLS_DIR/build.log

echo "---- Compiled Modules ---- 85%"

##Building ramdisk
echo "BUILDING RAMDISK $(date)" >>$TOOLS_DIR/build.log
cd $RAMFS_TMP
find | fakeroot cpio -H newc -o > $RAMFS_TMP.cpio 2>/dev/null
ls -lh $RAMFS_TMP.cpio
gzip -9 $RAMFS_TMP.cpio
echo "BUILD RAMDISK $(date)" >>$TOOLS_DIR/build.log

echo "---- Built Ramdisk ---- 90%"

##Compiling boot.img
echo "COMPILING BOOT.IMG $(date)" >>$TOOLS_DIR/build.log
mkdir $BUILD_ENV/tmp
chmod 777 $TOOLS_DIR/mkbootimg
$TOOLS_DIR/mkbootimg --kernel $KERNELDIR/arch/arm/boot/zImage --ramdisk $RAMFS_TMP.cpio.gz --board smdk4x12 --base 0x10000000 -o $BUILD_ENV/tmp/boot.img
echo "COMPILED BOOT.IMG $(date)" >>$TOOLS_DIR/build.log

echo "---- Compiled Boot.img ---- 95%"

##Building Zip
echo "BUILDING ZIP FILE $(date)" >>$TOOLS_DIR/build.log
chown --recursive root $BUILD_ENV/tmp
cp -ax $TOOLS_DIR/META-INF $BUILD_ENV/tmp
cd $BUILD_ENV/tmp
zip $OUTPUT_DIR/CompiledKernel.zip -r META-INF boot.img 
chown root $OUTPUT_DIR/CompiledKernel.zip
rm -rf $BUILD_ENV/tmp
rm -rf $RAMFS_TMP
rm -rf $RAMFS_TMP.cpio.gz
echo "ZIP FILE BUILT $(date)" >>$TOOLS_DIR/build.log

echo "" >>$TOOLS_DIR/build.log
echo "END TIME $(date)" >>$TOOLS_DIR/build.log

echo "---- Zip Created ---- 100%"
echo "Check $TOOLS_DIR/build.log for errors"

