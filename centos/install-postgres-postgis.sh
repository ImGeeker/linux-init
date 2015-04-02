#!/bin/bash
#install dependencies
yum install kernel-headers kernel-devel zlib-devel libxml2-devel readline-devel

#install proj
cd proj-4.8.0
./configure --prefix=/usr/local/proj
make
make install

#install geos
cd ../geos-3.4.2
./configure --prefix=/usr/local/geos
make
make install

#install gdal
cd ../gdal-1.9.2
./configure
make
make install
#install postgres
cd ../postgresql-9.3.4
./configure --prefix=/data/pgsql/9.3.4
make
make install

#configuration PATH
#PATH=$PATH:$HOME/bin
#export PATH
#PATH=$PATH:$HOME/bin
#PGSQL_HOME=/usr/local/pgsql
#PATH=$PATH:$PGSQL_HOME/bin
#PROJ_HOME=/usr/local/proj
#GEOS_HOME=/usr/local/geos
#PATH=$PATH:$PROJ_HOME/bin:$GEOS_HOME/bin
#LD_LIBRARY_PATH=$PGSQL_HOME/lib:$PROJ_HOME/lib:$GEOS_HOME/lib
#export PATH
#export PGSQL_HOME
#export PROJ_HOME
#export GEOS_HOME
#export LD_LIBRARY_PATH

##init database
#mkdir /usr/local/pgsql/data
#chown -R postgres:postgres /usr/local/pgsql
#su postgres
#initdb -D /usr/local/pgsql/data
## vi pg_hba.conf in last add:host all all all trust
## vi postgresql.conf  将文件中的#listen_address=’localhost’ 改为 listen_address=’*’  将#port=5432改为port=5432
#exit
#
##添加开机启动
## cp ./contrib/start-scripts/linux /etc/init.d/postgres
## chmod a+x /etc/init.d/postgres
## chown -R postgres:postgres /etc/init.d/postgres
#
##install postgis
#LDFLAGS=-lstdc++
#./configure -prefix=/usr/local/postgis --with-pgsql=/usr/local/pgsql/bin/pg_config --with-pgconfig=/usr/local/pgsql/bin/pg_config --with-proj=/usr/local/proj --with-geos=/usr/local/geos/bin/geos-config --with-geosconfig=/usr/local/geos/bin/geos-config --with-projdir=/usr/local/proj --with-xml2config=/usr/bin/xml2-config
#make
#make install
##create test database
## su postgres
## createdb  demogis
## psql -d demogis -f /usr/local/pgsql/share/contrib/postgis-2.0/postgis.sql
## psql -d demogis -f /usr/local/pgsql/share/contrib/postgis-2.0/spatial_ref_sys.sql

