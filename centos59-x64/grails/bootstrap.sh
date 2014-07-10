#!/usr/bin/env bash

# This script is executed by the Vagrant shell provisioner which runs
# as the root user.

# Add the latest updates to installed software
echo "updating CentOS system software..."
yum -y update

####################
# Install oracle jdk
####################
echo "downloading and installing the JDK..."
# download the jdk rpm
mkdir /tmp/downloads
wget --no-verbose --output-document=/tmp/downloads/jdk.rpm --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u60-b19/jdk-7u60-linux-x64.rpm"
# install the package
rpm -Uvh /tmp/downloads/jdk.rpm
# set as system default
/usr/sbin/alternatives --install /usr/bin/java java /usr/java/latest/jre/bin/java 20000
/usr/sbin/alternatives --install /usr/bin/javaws javaws /usr/java/latest/jre/bin/javaws 20000
/usr/sbin/alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 20000
/usr/sbin/alternatives --install /usr/bin/jar jar /usr/java/latest/bin/jar 20000
# set global JAVA_HOME in /etc/profile.d
echo "export JAVA_HOME=/usr/java/latest" >> /etc/profile.d/java.sh
# clean up
rm -rf /tmp/downloads

#######################################################################
# Install gvm (http://gvmtool.net/) for managing groovy/grails installs
#######################################################################
echo "downloading and installing gvm..."
# run the gvm installation as the vagrant user instead of root
sudo -i -H -u vagrant curl -s get.gvmtool.net | sudo -i -H -u vagrant bash
# replace default gvm config
rm /home/vagrant/.gvm/etc/config
echo "gvm_auto_answer=true" >> /home/vagrant/.gvm/etc/config
echo "gvm_suggestive_selfupdate=false" >> /home/vagrant/.gvm/etc/config
chown vagrant:vagrant /home/vagrant/.gvm/etc/config

################
# Install Grails
################
echo "downloading and installing Grails"
sudo -i -H -u vagrant gvm install grails 2.3.3
