wget https://github.com/j-moriarti/pDNSf-Hosts-collection/releases/download/v1.0.0/pDNSf-hosts-part0.txt
wget https://github.com/j-moriarti/pDNSf-Hosts-collection/releases/download/v1.0.0/pDNSf-hosts-part1.txt
wget https://github.com/j-moriarti/pDNSf-Hosts-collection/releases/download/v1.0.0/pDNSf-hosts-part2.txt

cat pDNSf-hosts-part0.txt pDNSf-hosts-part1.txt pDNSf-hosts-part2.txt | sort | uniq > pDNSf-hosts.txt
