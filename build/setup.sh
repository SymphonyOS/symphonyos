#!/usr/bin/env bash

# Update system
apt-get update;
apt-get -y upgrade;

# Install necessary packages
apt-get -y install openbox lightdm pcmanfm tint2 nitrogen build-essential ruby ruby-sinatra ruby-dev libwebkit-dev lxterminal nm-applet volumeicon git;

# Pull source
cd /tmp;
git clone git@github.com:ryanpq/symphonyos.git;
rm -Rf /tmp/symphonyos/build;
cp -Rf /tmp/symphonyos/* /.;
rm -Rf /tmp/symphonyos;

# Build/Install Ruby Gems
gem install gtk2;
gem install webkit;
gem install parseconfig;
gem install pp;

# Pull xresprobe (no longer in Ubuntu as of 15.10)
wget https://launchpad.net/ubuntu/+source/xresprobe/0.4.24ubuntu9/+build/1274262/+files/xresprobe_0.4.24ubuntu9_amd64.deb;
dpkg -i xresprobe_0.4.24ubuntu9_amd64.deb;
apt-get -fy install;
# Pull builder script
wget http://nyc.symphonyos.com/pinguybuilder_4.3-2_all.deb;
dpkg -i pinguybuilder_4.3-2_all.deb;
apt-get -fy install;