#!/bin/sh

clear

echo "Setting parameters"

##Self set parameters
export BUILD_ENV="/home/ricky/Desktop/kernel_development"

echo "Set parameters"
echo "Changing to master"

##Change directory
cd $BUILD_ENV

echo "Pushing to GIT"

##Pushing
git push git@github.com:ricky310711/RTL_KERNEL.git master

echo "Push to GIT complete"
