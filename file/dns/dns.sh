sudo su
systemctl disable --now systemd-resolved.service
rm /etc/resolv.conf
echo 'nameserver 1.1.1.1' > /etc/resolv.conf