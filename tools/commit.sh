#!/bin/sh

clear

echo "Setting parameters"

##Self set parameters
export BUILD_ENV="/home/ricky/Desktop/kernel_development"

echo "Set parameters"
echo "Changing to master"

##Change directory
cd $BUILD_ENV

echo "Detecting/adding changes"

##Adding changes
git add .
git add -u

echo "Changes detected and added"
echo "Making commit"

##Making commit
echo "Enter the commit name:"
read COMMIT_NAME
git commit -m "$COMMIT_NAME"

echo "Added $COMMIT_NAME"

