#!/usr/bin/env bash

# This script is executed by the Vagrant shell provisioner which runs
# as the root user.

# Set bash as the shell for the vagrant user
# (not the default in the puppetlabs/ubuntu-14.04-64-nocm box)
sudo chsh -s /bin/bash vagrant

# Add the latest updates to installed software
echo "updating ubuntu system software..."
apt-get update
apt-get -y dist-upgrade

#######################################################################
# Install the Oracle JDK
#######################################################################
echo "installing software-properties-common..."
# software-properties-common required for add-apt-repository command
apt-get -y install software-properties-common
# add ppa for oracle jdk ubuntu package: https://launchpad.net/~webupd8team/+archive/java
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo "installing Oracle JDK..."
# accept the oracle license before installing
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get -qy install oracle-java7-installer
# set the java environment variables
apt-get install oracle-java7-set-default

#######################################################################
# Install maven (for trusty this is maven 3.0.5)
#######################################################################
apt-get -y install maven

#######################################################################
# Install gvm (http://gvmtool.net/) for managing other jvm-based installs
#######################################################################
echo "downloading and installing gvm..."
# run the gvm installation as the vagrant user instead of root
sudo -i -H -u vagrant curl -s get.gvmtool.net | sudo -i -H -u vagrant bash
# replace default gvm config
rm /home/vagrant/.gvm/etc/config
echo "gvm_auto_answer=true" >> /home/vagrant/.gvm/etc/config
echo "gvm_suggestive_selfupdate=false" >> /home/vagrant/.gvm/etc/config
chown vagrant:vagrant /home/vagrant/.gvm/etc/config
