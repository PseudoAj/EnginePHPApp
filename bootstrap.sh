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
systemctl start httpd #Replaced
systemctl enable httpd #replaced
echo -e "----Modified Mod Security----\n\n"

## Install engineAPI
mkdir -p $GITDIR
cd $GITDIR
git clone -b $ENGINEBRANCH $ENGINEAPIGIT
git clone $ENGINEAPITEMPLATES
git clone $ENGINEAPIMODULES
echo -e "----Installed engineAPI----\n\n"

mkdir -p $SERVERURL/phpincludes/
#ln -s $GITDIR/engineAPITemplates/* $GITDIR/engineAPI/engine/template/ #creates symbolic link between all the template files
ln -s $GITDIR/engineAPI-Modules/src/modules/* $GITDIR/engineAPI/engine/engineAPI/latest/modules/ #Creates symbolic link between the modules
ln -s $GITDIR/engineAPI/engine/ $SERVERURL/phpincludes/ #All required modules are linked in phpincludes
echo -e "----Modules have been loaded----\n\n"

## Application configuarations
#mkdir -p $SERVERURL/$DOCUMENTROOT/app

#ln -s /vagrant/src/ $SERVERURL/$SITEROOT
#ln -s $SERVERURL/phpincludes/engine/engineAPI/latest $SERVERURL/phpincludes/engine/engineAPI/4.0

#rm -f /etc/php.ini
#rm -f /etc/httpd/conf/httpd.conf

#ln -s /vagrant/serverConfiguration/php.ini /etc/php.ini
#ln -s /vagrant/serverConfiguration/vagrant_httpd.conf /etc/httpd/conf/httpd.conf

#mkdir -p /vagrant/serverConfiguration/serverlogs
#touch /vagrant/serverConfiguration/serverlogs/error_log
#systemctl httpd restart

#mkdir -p $SERVERURL/phpincludes/databaseConnectors/

#ln -s /vagrant/serverConfiguration/database.lib.wvu.edu.remote.php $SERVERURL/phpincludes/databaseConnectors/database.lib.wvu.edu.remote.php
#echo -e "----Application configurations have been set----\n\n"

## Templates are loaded here
#mkdir -p $GITDIR/engineAPITemplates/library2012.2col/templateIncludes
#ln -s /vagrant/serverConfiguration/templateHeader.php $GITDIR/engineAPITemplates/library2012.2col/templateIncludes/templateHeader.php
#ln -s /vagrant/serverConfiguration/templateFooter.php $GITDIR/engineAPITemplates/library2012.2col/templateIncludes/templateFooter.php
#ln -s $GITDIR/engineAPITemplates/library2012.1col/templateIncludes/2colHeaderIncludes.php $GITDIR/engineAPITemplates/library2012.2col/templateIncludes/2colHeaderIncludes.php

#mkdir -p $GITDIR/engineAPITemplates/library2012.3col/templateIncludes
#ln -s /vagrant/serverConfiguration/templateHeader.php $GITDIR/engineAPITemplates/library2012.3col/templateIncludes/templateHeader.php
#ln -s /vagrant/serverConfiguration/templateFooter.php $GITDIR/engineAPITemplates/library2012.3col/templateIncludes/templateFooter.php
#ln -s $GITDIR/engineAPITemplates/library2012.1col/templateIncludes/3colHeaderIncludes.php $GITDIR/engineAPITemplates/library2012.3col/templateIncludes/3colHeaderIncludes.php
#echo -e "----Templates loaded----\n\n"

## Favicon
#touch /home/www.libraries.wvu.edu/public_html/favicon.ico
#echo -e "----Favicon loaded----\n\n"

## Base Post Setup
#ln -s $SERVERURL $ENGINEAPIHOME
#ln -s $GITDIR/engineAPI/public_html/engineIncludes/ $SERVERURL/$DOCUMENTROOT/engineIncludes
#echo -e "----Base post setup done----\n\n"

## Setup the EngineAPI Database
#/etc/init.d/mysqld start
#chkconfig mysqld on
#mysql -u root < /tmp/git/engineAPI/sql/vagrantSetup.sql
#mysql -u root EngineAPI < /tmp/git/engineAPI/sql/EngineAPI.sql
#echo -e "----Mysql stuff done----\n\n"
