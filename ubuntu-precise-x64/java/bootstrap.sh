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


# install maven (for precise this is maven 3.0.4)
apt-get -y install maven


# try something like this if we need the latest version
#wget --no-verbose --directory-prefix=/tmp http://apache.mirror.iweb.ca/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz
#mkdir /usr/local/apache-maven
#tar -xzvf /tmp/apache-maven-3.1.1-bin.tar.gz -C /usr/local/apache-maven/
#echo "export M2_HOME=/usr/local/apache-maven/apache-maven-3.1.1" >> ~/.bashrc
#echo "export M2=/usr/local/apache-maven/apache-maven-3.1.1/bin" >> ~/.bashrc
#echo "export PATH=/usr/local/apache-maven/apache-maven-3.1.1/bin:$PATH" >> ~/.bashrc
# http://lasindu.com/installing-maven3-in-ubuntu-12-04/
