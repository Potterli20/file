sudo sed -i 's/#DNS=/DNS=1.1.1.1 1.0.0.1/g' /etc/systemd/resolved.conf
sudo systemctl daemon-reload
sudo systemctl restart systemd-networkd
sudo systemctl restart systemd-resolved
sudo prlimit --pid $$ --nofile=500000:500000
ulimit -a
sudo apt-get -qq update
sudo apt reinstall curl git libnss3* ca-certificates grep findutils -y
