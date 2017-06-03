#!/bin/bash

if [ -z "$1" ]
  then
    echo "You must pass a specific tag."
    echo "Ex: ./build.sh v3.0.0"
    exit 1
fi

arch=$(arch)
os=$(uname -s)
dest_file=onyx-$1-$os-$arch.tar.gz

echo "Building file $dest_file"

# clean folder if exit
rm -rf onyx

# Cloning repository
git clone https://github.com/OnyxProject/Onyx onyx

# Go to folder
cd onyx

# remove git folder
rm -rf .git

# install dependencies
source setup.sh

# Move back
cd ..

# creating archive
tar zcvf $dest_file onyx
