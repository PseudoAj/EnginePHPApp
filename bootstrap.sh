#!/bin/bash


# Variables for the shell script
## Directories
GITDIR="/tmp/git"
ENGINEAPIHOME="/home/engineAPI"
SERVERURL="/home/engineAPP"
DOCUMENTROOT="public_html" #Folder where all the webhost is contained with
SITEROOT=$DOCUMENTROOT/app #Folder where the website lies with


## Engine Specific
ENGINEAPIGIT="https://github.com/wvulibraries/engineAPI.git"
ENGINEAPITEMPLATES="https://github.com/wvulibraries/engineAPITemplates.git"
ENGINEAPIMODULES="https://github.com/wvulibraries/engineAPI-Modules.git"
ENGINEBRANCH="master"


# Install the required packages
## Add the RPM for PHP5.6 to CentOS7
rpm -Uvh --nosignature http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -Uvh --nosignature https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh --nosignature https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y update
echo -e "----Added the RPM for PHP 5.6 and MySQL----\n\n"

yum -y install httpd httpd-devel httpd-manual httpd-tools
echo -e "----Installed Apache----\n\n"

yum -y install mysql-connector-java mysql-connector-odbc mysql-devel mysql-lib mysql-server
echo -e "----Installed MySQL----\n\n"

yum -y install mod_auth_kerb mod_auth_mysql mod_authz_ldap mod_evasive mod_perl mod_security mod_ssl mod_wsgi
echo -e "----Installed Auth Plugins for MySQL----\n\n"

yum -y install php56w php56w-bcmath php56w-cli php56w-common php56w-gd php56w-ldap php56w-mbstring php56w-mcrypt php56w-mysql php56w-odbc php56w-pdo php56w-pear php56w-pear-Benchmark php56w-pecl-apc php56w-pecl-imagick php56w-pecl-memcache php56w-soap php56w-xml php56w-xmlrpc
echo -e "----Installed PHP 5.6----\n\n"

#echo "Installing php"
#yum -y install php php-bcmath php-cli php-common php-gd php-ldap php-mbstring php-mcrypt php-mysql php-odbc php-pdo php-pear php-pear-Benchmark php-pecl-apc php-pecl-imagick php-pecl-memcache php-soap php-xml php-xmlrpc

yum -y install wget
wget -c https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
mv phpunit.phar /usr/local/bin/phpunit
echo -e "----Installed PHPUNIT----\n\n"

yum -y install git
echo -e "----Installed git----\n\n"

yum -y install emacs emacs-common emacs-nox
echo -e "----Installed emacs----\n\n"

## Modifying the configurations
mv /etc/httpd/conf.d/mod_security.conf /etc/httpd/conf.d/mod_security.conf.bak
#/etc/init.d/httpd start
#chkconfig httpd on
systemctl start httpd #Replaced
systemctl enable httpd #replaced
echo -e "----Modified Mod Security----\n\n"

## Install engineAPI Templates and Modules
mkdir -p $GITDIR
cd $GITDIR
git clone $ENGINEAPITEMPLATES
git clone $ENGINEAPIMODULES
echo -e "----Installed engineAPI----\n\n"

#APP Specific
##Link your src folder
rm -f /var/www/html/*
ln -s /vagrant/src/* /var/www/html/

## Remove the existing config
rm -f /etc/httpd/conf/httpd.conf

##Link config
ln -s /vagrant/serverConfiguration/httpd.conf /etc/httpd/conf/httpd.conf

##Make the logs
mkdir -p /vagrant/serverConfiguration/serverlogs
touch /vagrant/serverConfiguration/serverlogs/error_log
systemctl restart httpd
#/etc/init.d/httpd restart
