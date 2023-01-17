sudo sed -i 's/#DNS=/DNS=8.8.8.8 8.8.4.4/g' /etc/systemd/resolved.conf
sudo systemctl daemon-reload
sudo systemctl restart systemd-networkd
sudo systemctl restart systemd-resolved
sudo prlimit --pid $$ --nofile=500000:500000