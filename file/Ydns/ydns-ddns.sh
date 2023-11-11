#!/bin/bash
# https://ydns.io 域名解析，双域名版，by：小贝塔

YDNS_USER="邮箱"
YDNS_PASSWD="密钥"
YDNS_HOST4="域名4"
YDNS_HOST6="域名6"

# 定义解析函数
ddns(){
    curl -u "$YDNS_USER:$YDNS_PASSWD" https://ydns.io/api/v1/update/?host=${1}\&ip=${2}
}

# ipv4
ipv4=$(curl -s https://v4.ident.me)
ip4=123
if [ ${ipv4} != ${ip4} ]; then
    ddns $YDNS_HOST4 $ipv4
    sed -i "s/^ip4=.*/ip4=${ipv4}/" "$0"
fi

# ipv6
ipv6=$(curl -s https://v6.ident.me)
ip6=240e:345:4d15:3600:d967:d60d:cc9a:1592
if [ ${ipv6} != ${ip6} ]; then
    ddns $YDNS_HOST6 $ipv6
    sed -i "s/^ip6=.*/ip6=${ipv6}/" "$0"
fi
