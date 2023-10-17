#!/bin/sh

echo "请输入需要检测的域名 (比如. www.baidu.com):"
read host
echo "请输入域名的端口 (比如. 80，443):"
read ports

echo -e "HEAD / HTTP/1.1\r\nHost: $host\r\nConnection: close\r\n\r\n" > request.txt

openssl s_client -connect $host:$ports -tls1_3 -sess_out session.pem -ign_eof < request.txt

result=$(openssl s_client -connect $host:$ports -tls1_3 -sess_in session.pem -early_data request.txt 2>&1)

if echo "$result" | grep -q "Early data was accepted"; then
    echo "此地址支持Early data（0-RTT 连接）"
else
    echo "此地址不支持Early data（0-RTT 连接）"
fi
