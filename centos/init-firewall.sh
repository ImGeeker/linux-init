#!/bin/bash
#-----------------------------------------------
# this shell will init firewall
# create at 2013-06-16
# author Huzi.Wang[huzi.wh@gmail.com]
#-----------------------------------------------

# install dependency
yum -y install iptables policycoreutils
# clearn before set policy DOR is INPUT
/sbin/iptables -P INPUT ACCEPT
# clearn all policy
/sbin/iptables -F
/sbin/iptables -X
/sbin/iptables -Z

# start set policy
# allow lo interface data package
/sbin/iptables -A INPUT -i lo -j ACCEPT
# 开放TCP协议22端口，以便能ssh，如果你是在有固定ip的场所，可以使用 -s 来限定客户端的ip
/sbin/iptables -A INPUT -p tcp --dport 22 -j ACCEPT
# 开放TCP协议80端口供web服务
/sbin/iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# 10.241.121.15 是另外一台服务器的内网ip，由于之间有通信，
# 接受所有来自10.241.121.15的TCP请求,如果还有其他内网服务器需要通讯也是按照次配置
#/sbin/iptables -A INPUT -p tcp -s 10.241.121.15 -j ACCEPT
# accept ping 
/sbin/iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
# look url http://www.netingcn.com/iptables-localhost-not-access-internet.html
/sbin/iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
# 屏蔽上述规则以为的所有请求，不可缺少，否则防火墙没有任何过滤的功能
/sbin/iptables -P INPUT DROP

echo "save iptables"
service iptables save
# 查看是否生效
iptables -L -n


