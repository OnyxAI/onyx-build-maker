#!/bin/bash

ONYX_VERSION=1.0.0

ONYX_FOLDER="/home/pi/Onyx"

wget http://download.onyxlabs.fr/onyx-build/onyx-v$ONYX_VERSION-Linux-armv6l.tar.gz

# stop onyx

# Delete current onyx install
rm -rf $ONYX_FOLDER

#  install onyx
tar zxvf onyx-v$ONYX_VERSION-Linux-armv6l.tar.gz

# init
cd $ONYX_FOLDER

# restart Onyx
