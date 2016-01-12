#!/usr/bin/env bash;

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