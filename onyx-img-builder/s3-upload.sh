#!/bin/bash

if [ -z "$1" ] && [ -z "$2" ] 
  then
    echo "You must pass a specific tag."
    echo "Ex: ./s3-upload.sh v3.0.0 2017-09-15"
    exit 1
fi

arch=$(arch)
os=$(uname -s)
dest_file=ONYX-jessie-rpix_$2.img.gz

file=$dest_file
bucket=$AMAZON_S3_BUCKET
resource="/${bucket}/${1}/${file}"
contentType="application/x-compressed-tar"
dateValue=`date -R`
stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"
s3Key=$AMAZON_S3_KEY
s3Secret=$AMAZON_S3_SECRET
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
curl -X PUT -T "${file}" \
  -H "Host: ${bucket}.s3.amazonaws.com" \
  -H "Date: ${dateValue}" \
  -H "Content-Type: ${contentType}" \
  -H "Authorization: AWS ${s3Key}:${signature}" \
  https://${bucket}.s3.amazonaws.com/${1}/${file}