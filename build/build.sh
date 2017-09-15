#!/bin/bash

if [ -z "$1" ]
  then
    echo "You must pass a specific tag."
    echo "Ex: ./build.sh 3.0.0"
    exit 1
fi

arch=$(arch)
os=$(uname -s)
dest_file=onyx-v$1-$os-$arch.tar.gz

echo "Building file $dest_file"

# clean folder if exit
rm -rf Onyx

# Cloning repository
git clone https://github.com/OnyxProject/Onyx Onyx

# Go to folder
cd Onyx

# remove git folder
rm -rf .git

# install dependencies
source setup.sh

# Move back
cd ..

# creating archive
tar zcvf $dest_file Onyx

#remove last version file if exist
rm -rf last_version.txt

echo $1 >> last_version.txt

echo "Build completed !"
