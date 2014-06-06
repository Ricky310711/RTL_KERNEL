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
cd $BUILD_ENV
git push -u origin master

echo "Push to GIT complete"
