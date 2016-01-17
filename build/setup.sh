#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive;

# back up ssh keys because PinguyBuilder deletes them
mkdir /home/tmp;
cp -Rf /root/.ssh /home/tmp/.;

# Update system
apt-get update;
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade;
# Install necessary packages
apt-get -y install git openbox network-manager-gnome volumeicon-alsa lightdm libffi-dev pcmanfm tint2 nitrogen build-essential ruby ruby-sinatra ruby-dev libwebkit-dev lxterminal;

# Pull source
cd /tmp;
git clone https://github.com/SymphonyOS/symphonyos.git;
cp -Rf /tmp/symphonyos/build /tmp/build;
rm -Rf /tmp/symphonyos/build;
cp -Rf /tmp/symphonyos/* /.;
rm -Rf /tmp/symphonyos;

# Install PinguyBuilder
wget http://nyc.symphonyos.com/pinguybuilder_4.3-2_all.deb;
dpkg -i pinguybuilder_4.3-2_all.deb;
apt-get -fy install;
cp /tmp/build/PinguyBuilder.conf /etc/.;

#Pinguybuilder fix
#sed -i -e 's@user-uid [0-9]*@user-uid 990@' /usr/share/initramfs-tools/scripts/casper-bottom/25adduser

# Build/Install Ruby Gems
gem install gtk2;
gem install gtk-webkit-ruby;
gem install parseconfig;


# Pull xresprobe (no longer in Ubuntu as of 15.10)
#wget https://launchpad.net/ubuntu/+source/xresprobe/0.4.24ubuntu9/+build/1274262/+files/xresprobe_0.4.24ubuntu9_amd64.deb;
#dpkg -i xresprobe_0.4.24ubuntu9_amd64.deb;
#apt-get -fy install;

#PinguyBuilder dist;
#mv /home/PinguyBuilder/PinguyBuilder/symphonyos_16.0_amd64* /;
# place ssh keys back in /root
#cp -Rf /home/tmp/.ssh /root/.;