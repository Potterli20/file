curl https://edge.microsoft.com/abusiveadblocking/api/v1/blocklist | grep -oP '(?<=url":")(.*?)(?=")' > ad-edge-hosts.txt
