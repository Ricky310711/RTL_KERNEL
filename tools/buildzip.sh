#!/bin/sh

clear
echo "Building zip"

##Self set parameters
export OUTPUT_DIR="/home/ricky/Desktop"
export BUILD_ENV="/home/ricky/Desktop/kernel_development"
export CROSS_COMPILE="/opt/toolchains/arm-eabi-4.4.3/bin/arm-eabi-"

##Automatic parameters
export RAMFS_TMP="$BUILD_ENV/ramfstmp"
export TOOLS_DIR="$BUILD_ENV/tools"

##Building Zip
rm -rf $OUTPUT_DIR/CompiledKernel.zip 
chown --recursive root $BUILD_ENV/tmp
cp -ax $TOOLS_DIR/META-INF $BUILD_ENV/tmp
cd $BUILD_ENV/tmp
zip $OUTPUT_DIR/CompiledKernel.zip -r META-INF boot.img 
chown root $OUTPUT_DIR/CompiledKernel.zip
rm -rf $BUILD_ENV/tmp
rm -rf $RAMFS_TMP

