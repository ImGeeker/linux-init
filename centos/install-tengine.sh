#!/bin/bash
#-----------------------------------------------
# this shell will install nginx(tengine) into /usr/local/webserver/nginx
# create at 2013-06-16
# author Huzi.Wang[huzi.wh@gmail.com]
#-----------------------------------------------

USER="www"
GROUP="www"
DIR=`pwd`
TEMP_DIR="/tmp/nginx"
INSTALL_DIR="/usr/local/webserver"
CONF_PATH="/etc/nginx"
echo "this shell will install nginx(tengine) in /usr/local/webserver/nginx"
echo "download nginx from tengine.taobao.org to /usr/local/src"

# if www or www-data user exist
id "www-data"  >& /dev/null
if [$? -ne 0]; then
    id "www" >& /dev/null
    if [$? -ne 0 ]; then
        useradd -g -r $GROUP $USER
fi


# if install dir not exist do create
if [!-x $INSTALL_DIR];then
    mkdir /usr/local/webserver
fi

# if temp dir not exist do create
if [ !-x"$TEMP_DIR" ]; then
    mkdir $TEMP_DIR
else:
    rm -rf $TEMP_DIR/*
fi

cd $TEMP_DIR
#download into init-system/nginx
wget "http://tengine.taobao.org/download/tengine-1.5.1.tar.gz"
echo "download pcre-8.33 rom /usr/local/src"
wget "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.33.tar.bz2"

echo "discrompression nginx package on current path"
tar -xvf ./pcre-8.33.tar.bz2
tar -zxvf ./tengine-1.5.1.tar.gz

echo "starting build"
cd tengine-1.5.1
./configure --user=$USER --group=$GROUP --prefix=/usr/local/webserver/nginx --conf-path=$CONF_PATH --with-http_concat_module --with-http_sysguard_module --with-http_stub_status_module --with-pcre=../pcre-8.33 --http-client-body-temp-path=/var/tmp/nginx/client --http-proxy-temp-path=/var/tmp/nginx/proxy --http-fastcgi-temp-path=/var/tmp/nginx/fastcgi --http-uwsgi-temp-path=/var/tmp/nginx/uwsgi --http-scgi-temp-path=/var/tmp/nginx/scgi --with-http_geoip_module --with-http_gzip_static_module
make
make install
echo "starting cp config file"
cd $DIR
mkdir /var/tmp/nginx
chown -R $USER:$GROUP /var/tmp/nginx
chown -R $USER:$GROUP /usr/local/webserver/nginx
chown root /usr/local/webserver/nginx/sbin/nginx
chmod +s /usr/local/webserver/nginx/sbin/nginx

# download nginx init script
cp init.d/nginx /etc/init.d/nginx
# copy all default config file
cp -r ../config/nginx/* $CONF_PATH/
chmod +x /etc/init.d/nginx
/sbin/chkconfig nginx on
chkconfig --list nginx

service nginx start
# 在浏览器访问80端口


