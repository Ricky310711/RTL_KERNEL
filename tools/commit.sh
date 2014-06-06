#!/bin/sh

clear

echo "Setting parameters"

##Self set parameters
export BUILD_ENV="/home/ricky/Desktop/kernel_development"
export KERNELDIR="$BUILD_ENV/kernel_source"

echo "Changing to master"

##Change directory
cd $BUILD_ENV

echo "Cleaning sources"

##uSING CLEAN SOURCES
rm -rf $KERNELDIR
cp -ax /home/ricky/Desktop/clean_kernel_source $KERNELDIR
chown --recursive root $KERNELDIR

echo "Detecting/adding changes"

##Adding changes
git add .

echo "Making commit"

##Making commit
echo "Enter the commit name:"
read COMMIT_NAME
git commit -m "$COMMIT_NAME"


