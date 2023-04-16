wget https://raw.githubusercontent.com/columndeeply/hosts/main/hosts00
wget https://raw.githubusercontent.com/columndeeply/hosts/main/hosts01

cat hosts00 hosts01 | sort | uniq > columndeeply-hosts.txt
