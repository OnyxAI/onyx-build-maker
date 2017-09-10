#!/usr/bin/env bash

systemctl enable ssh.service

curl -SLs https://raw.githubusercontent.com/OnyxProject/Onyx/master/install_debian_script.sh | bash

mkdir /root/skills

apt-get install -y nginx subversion

cd /home

svn export --force https://github.com/OnyxProject/enclosure-onyx/trunk/home/pi

cd /

sudo svn export --force https://github.com/OnyxProject/enclosure-onyx/trunk/etc

cd /home/pi/bin

chmod +x onyx
chmod +x start
chmod +x view_log

cd /home/pi

sudo cp -r nltk_data/ /root/

function validate_url(){
  if [[ `wget -S --spider $1  2>&1 | grep 'HTTP/1.1 200 OK'` ]];
  then
    wget http://downloads.sourceforge.net/project/onyxproject/onyx-build/onyx-v$ONYX_VERSION-Linux-armv6l.tar.gz
  else
    echo "FILE NOT EXIST"
    echo "EXIT"
    exit 1
  fi
}

ONYX_VERSION=$(curl -s 'https://raw.githubusercontent.com/OnyxProject/Onyx/master/version.json' | jq -r '.version')


validate_url http://downloads.sourceforge.net/project/onyxproject/onyx-build/onyx-v$ONYX_VERSION-Linux-armv6l.tar.gz

tar zxvf onyx-v$ONYX_VERSION-Linux-armv6l.tar.gz

sudo grep "ExecStart" /lib/systemd/system/getty@.service | sudo sed -i 's|ExecStart=-/sbin/agetty --noclear %I $TERM|ExecStart=-/sbin/agetty --autologin pi --noclear %I $TERM|g' /lib/systemd/system/getty@.service

sudo systemctl enable getty@tty1.service
