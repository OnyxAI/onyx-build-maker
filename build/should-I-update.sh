#!/bin/bash

CURRENT_VERSION=$(curl -s 'https://raw.githubusercontent.com/OnyxProject/Onyx/master/version.json' | jq -r '.version')

echo "CURRENT ONYX VERSION IS :"
echo $CURRENT_VERSION

LAST_VERSION=$(cat last-version.txt)
echo "LAST VERSION BUILD ON THIS MACHINE IS :"
echo $LAST_VERSION

if [ "$CURRENT_VERSION" != "$LAST_VERSION" ]
then
        echo "NOT EQUAL, BUILDING"
        bash build.sh v$CURRENT_VERSION
else
        echo "EQUAL, NOT BUILDING"
fi

echo $CURRENT_VERSION > last-version.txt
