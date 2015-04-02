#!/bin/bash
#install dependencies
apt-get install libaio-dev cmake bison ncurses-dev
$CURRENT_PWD = "`pwd`"

#download mysql from ...
wget http://download.softagency.net/MySQL/Downloads/MySQL-5.6/mysql-5.6.15.tar.gz
tar -zxvf mysql-5.6.15.tar.gz

#make
cd mysql-5.6.15
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_UNIX_ADDR=/usr/local/mysql/mysql.sock -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS:STRING=utf8,gbk -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DENABLED_LOCAL_INFILE=1 -DMYSQL_DATADIR=/usr/local/mysql  -DMYSQL_TCP_PORT=3306 -DENABLE_DOWNLOADS=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_PERFSCHEMA_STORAGE_ENGINE=1
make
make install

#config
cd /usr/local/mysql
groupadd mysql
useradd -r -g mysql mysql
chown -R mysql .
scripts/mysql_install_db --user=mysql
chown -R root .
chown -R mysql data
cp $CURRENT_PWD/my.cnf /etc/my.cnf
cp support-files/mysql.server /etc/init.d/mysql
chmod +x /etc/init.d/mysql
