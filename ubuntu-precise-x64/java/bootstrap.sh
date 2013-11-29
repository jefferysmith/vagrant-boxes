#!/usr/bin/env bash

# This script is executed by the Vagrant shell provisioner which runs 
# as the root user.

# Add the latest updates to installed software
echo "updating ubuntu system software..."
apt-get update
# for precise64 - prevent grub-pc modal window preventing successful upgrade
# see https://github.com/mitchellh/vagrant/issues/289#issuecomment-12408200
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

# install Oracle JDK 
echo "installing python-software-properties..."
# python-software-properties required for add-apt-repository command
apt-get -y install python-software-properties
# add ppa for oracle jdk ubuntu package: https://launchpad.net/~webupd8team/+archive/java
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo "installing Oracle JDK..."
# accept the oracle license before installing
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get -y install oracle-java7-installer
# set the java environment variables
apt-get install oracle-java7-set-default
