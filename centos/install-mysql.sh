#!/bin/bash

#install dependency
yum -y install  gcc gcc-c++ autoconf automake zlib* fiex* libxml* ncurses-devel libmcrypt* libtool-ltdl-devel* cmake make cmake-gui libaio-devel 
#dowload mysql
wget http://download.softagency.net/MySQL/Downloads/MySQL-5.6/mysql-5.6.13.tar.gz
# extract
tar -zxvf mysql-5.6.13.tar.gz
cd mysql-5.6.13
##make & install
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_UNIX_ADDR=/usr/local/mysql/mysql.sock -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS:STRING=utf8,gbk -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DENABLED_LOCAL_INFILE=1 -DMYSQL_DATADIR=/usr/local/mysql  -DMYSQL_TCP_PORT=3306 -DENABLE_DOWNLOADS=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_PERFSCHEMA_STORAGE_ENGINE=1
make
make install
add mysql user
echo 'add mysql user'
cd /usr/local/mysql
groupadd mysql
useradd -r -g mysql mysql
chown -R mysql:mysql .
#config file
echo 'init database'
mkdir -p /data/mysql/5.6.13
scripts/mysql_install_db --user=mysql --datadir=/data/mysql/5.6.13
chown -R root .
chown -R mysql /data/mysql/5.6.13
#init database
echo 'compy config file'
cp support-files/mysql.server /etc/init.d/mysql
cp support-files/my-default.cnf /etc/my.cnf 
chmod +x /etc/init.d/mysql
mkdir /var/log/mysql
chown -R mysql /var/log/mysql

