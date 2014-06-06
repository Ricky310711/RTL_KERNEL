#!/bin/sh

clear
##Purging
echo "Purging"
apt-get purge openjdk-\* icedtea-\* icedtea6-\*

##Adding java repository
echo "Adding java repository"
add-apt-repository ppa:webupd8team/java

##Updating package list
echo "Updating packagelist"
apt-get update

##Installing dependancies
echo "Downloading and installing dependancies"
apt-get install git gnupg ccache lzop flex bison gperf build-essential zip curl zlib1g-dev zlib1g-dev:i386 libc6-dev lib32bz2-1.0 lib32ncurses5-dev x11proto-core-dev libx11-dev:i386 libreadline6-dev:i386 lib32z1-dev libgl1-mesa-glx:i386 libgl1-mesa-dev g++-multilib mingw32 tofrodos python-markdown libxml2-utils xsltproc libreadline6-dev lib32readline-gplv2-dev libncurses5-dev bzip2 libbz2-dev libbz2-1.0 libghc-bzlib-dev lib32bz2-dev squashfs-tools pngcrush schedtool dpkg-dev preload openjdk-7-jre

##Symlinking
echo "Symlinking libGL.so.1"
ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so

##Installing repo
echo "Installing repo"
mkdir ~/bin && curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && chmod a+x ~/bin/repo

##Exporting path
echo "Exporting $PATH"
echo "export PATH=~/bin:$PATH" >> ~/.bashrc

##Setting up GIT
echo "Setting up GIT"
echo "Enter GIT username:"
read GIT_NAME
git config --global user.name "$GIT_NAME"

echo "Enter GIT email:"
read GIT_EMAIL
git config --global user.email "$GIT_EMAIL"

echo "Enabling credential helper"
git config --global credential.helper cache
echo "Configuring cache"
git config --global credential.helper 'cache --timeout=360000'

