#!/bin/bash
export PATH="$HOME/bin:$PATH"

function validate_url(){
  if [[ `wget -S --spider $1  2>&1 | grep 'HTTP/1.1 200 OK'` ]];
  then
    wget http://download.onyxlabs.fr/onyx-build/onyx-v$ONYX_VERSION-Linux-armv6l.tar.gz
  else
    echo "FILE NOT EXIST"
    echo "EXIT"
    exit 1
  fi
}

ONYX_VERSION=$(curl -s 'https://raw.githubusercontent.com/OnyxProject/Onyx/master/version.json' | jq -r '.version')
ONYX_FOLDER="/home/pi/Onyx"
TMP_DB="/tmp/onyx_db"
TMP_DATA="/tmp/onyx_data"

validate_url http://download.onyxlabs.fr/onyx-build/onyx-v$ONYX_VERSION-Linux-armv6l.tar.gz

# stop onyx
onyx stop

rm -rf $TMP_DB
rm -rf $TMP_DATA

mkdir $TMP_DB
mkdir $TMP_DATA

cp -ar $ONYX_FOLDER/onyx/db/. $TMP_DB
cp -ar $ONYX_FOLDER/onyx/data/. $TMP_DATA

# Delete current onyx install
rm -rf $ONYX_FOLDER

#  install onyx
tar zxvf onyx-v$ONYX_VERSION-Linux-armv6l.tar.gz

cp -ar $TMP_DB/. $ONYX_FOLDER/onyx/db
mkdir -p $ONYX_FOLDER/onyx/data
cp -ar $TMP_DATA/. $ONYX_FOLDER/onyx/data

# restart Onyx
onyx start
