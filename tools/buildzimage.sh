#!/bin/sh

clear
echo "Building zImage"

##Self set parameters
export ARCH="arm"
export DEFCONFIG="m0_00_defconfig"
export CPU_THREADS="5"
export BUILD_ENV="/home/ricky/Desktop/kernel_development"
export CROSS_COMPILE="/opt/toolchains/arm-eabi-4.4.3/bin/arm-eabi-"

##Automatic parameters
export KERNELDIR="$BUILD_ENV/kernel_source"
export TOOLS_DIR="$BUILD_ENV/tools"
export USE_SEC_FIPS_MODE=true

##Compiling zImage
echo "COMPILING ZIMAGE $(date)" >>$TOOLS_DIR/build.log
cd $KERNELDIR/
make clean && make mrproper
make $DEFCONFIG
#make -j$CPU_THREADS || exit 1
make || exit 1
echo "COMPILED ZIMAGE $(date)" >>$TOOLS_DIR/build.log

