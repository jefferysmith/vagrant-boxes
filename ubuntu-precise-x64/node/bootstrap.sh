#!/usr/bin/env bash

# This script is executed by the Vagrant shell provisioner which runs 
# as the root user.

# Add the latest updates to installed software
echo "updating ubuntu system software..."
apt-get update
# for precise64 - prevent grub-pc modal window preventing successful upgrade
# see https://github.com/mitchellh/vagrant/issues/289#issuecomment-12408200
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

# install node.js
echo "installing python-software-properties..."
# python-software-properties required for add-apt-repository command
apt-get -y install python-software-properties
# add ppa for node.js ubuntu package: https://launchpad.net/~chris-lea/+archive/node.js
add-apt-repository -y ppa:chris-lea/node.js
apt-get update
echo "installing node.js..."
apt-get -y install nodejs

# install Grunt CLI globally
npm install -gy grunt-cli
