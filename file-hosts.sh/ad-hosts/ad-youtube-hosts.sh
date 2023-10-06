# Get Data
function GetData() {
    filter_domain=(
        "https://raw.githubusercontent.com/kboghdady/youTube_ads_4_pi-hole/master/youtubelist.txt"
        "https://raw.githubusercontent.com/Ewpratten/youtube_ad_blocklist/master/blocklist.txt"
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/youtubeblacklist.txt"
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/blockeverything.txt"
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/ad-block-YouTube-Project.txt"
        "https://raw.githubusercontent.com/sonofhelga/yicklist/master/yick.list"

    )
    filter_hosts=(
        "https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Extension/GoodbyeAds-YouTube-AdBlock.txt"
    )
    mkdir ./ad-youtube-hosts && cd ./ad-youtube-hosts
    for filter_domain_task in "${!filter_domain[@]}"; do
        curl -s -L --connect-timeout 15 "${filter_domain[$filter_domain_task]}" >>./filter_domain.tmp
    done
    for filter_hosts_task in "${!filter_hosts[@]}"; do
        curl -s -L --connect-timeout 15 "${filter_hosts[$filter_hosts_task]}" >>./filter_hosts.tmp
    done
}
# Analyse Data
function AnalyseData() {
    filter_data=(
        $(cat ./filter_domain.tmp ./filter_hosts.tmp |
            sed 's/[ ]*//g' |
            sed '/^$/d' |
            sed "s/0\.0\.0\.0//g;s/127\.0\.0\.1//g;s/255.255.255.255//g;s/localhost//g;s/localhost.localdomain//g;s/broadcasthost//g;s/ip6-localhost//g;s/::1//g;s/ip6-loopback//g;s/ip6-localnet//g;s/fe80::1%lo0//g;s/ff00::0//g;s/ff02::1//g;s/ff02::2//g;s/ff02::3//g;s/ip6-mcastprefix//g;s/ip6-allnodes//g;s/ip6-allrouters//g;s/ip6-allhosts//g;/^$/d;s/[[:space:]]//g" |
            grep -v "=\|#\|<\|>\|!" |
            sort -u |
            uniq >./filter_data.tmp &&
            cat ./filter_data.tmp |
            grep -v "\.\." |
                awk "{ print $2 }")
    )
}
# Generate Information
function GenerateInformation() {
    adfilter_checksum=$(TZ=UTC-8 date "+%s" | base64)
    adfilter_description="HOSTS Project"
    adfilter_expires="24 hours (update frequency)"
    adfilter_homepage="https://file.trli.club:2083/ad-youtube-hosts/"
    adfilter_timeupdated=$(TZ=UTC-8 date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%Y-%m-%dT%H:%M:%S%:z")
    adfilter_title="trli's Ad Filter Youtube"
    adfilter_total=$(sed -n '$=' ./filter_data.tmp)
    adfilter_version=$(TZ=UTC-8 date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%Y%m%d")-$((10#$(TZ=UTC-8 date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%H") / 3))
    function adfilter_adblock() {
        echo "! Checksum: ${adfilter_checksum}" >../ad-youtube-adblock.txt
        echo "! Title: ${adfilter_title} for adblock" >>../ad-youtube-adblock.txt
        echo "! Description: ${adfilter_description}" >>../ad-youtube-adblock.txt
        echo "! Version: ${adfilter_version}" >>../ad-youtube-adblock.txt
        echo "! TimeUpdated: ${adfilter_timeupdated}" >>../ad-youtube-adblock.txt
        echo "! Expires: ${adfilter_expires}" >>../ad-youtube-adblock.txt
        echo "! Homepage: ${adfilter_homepage}" >>../ad-youtube-adblock.txt
        echo "! Total: ${adfilter_total}" >>../ad-youtube-adblock.txt
    }
    function adfilter_adguardhome() {
        echo "! Checksum: ${adfilter_checksum}" >../ad-youtube-adguardhome.txt
        echo "! Title: ${adfilter_title} for adguardhome" >>../ad-youtube-adguardhome.txt
        echo "! Description: ${adfilter_description}" >>../ad-youtube-adguardhome.txt
        echo "! Version: ${adfilter_version}" >>../ad-youtube-adguardhome.txt
        echo "! TimeUpdated: ${adfilter_timeupdated}" >>../ad-youtube-adguardhome.txt
        echo "! Expires: ${adfilter_expires}" >>../ad-youtube-adguardhome.txt
        echo "! Homepage: ${adfilter_homepage}" >>../ad-youtube-adguardhome.txt
        echo "! Total: ${adfilter_total}" >>../ad-youtube-adguardhome.txt
    }
    function adfilter_clash() {
        echo "payload:" >../ad-youtube-clash.yaml
        echo "# Checksum: ${adfilter_checksum}" >>../ad-youtube-clash.yaml
        echo "# Title: ${adfilter_title} for Clash " >>../ad-youtube-clash.yaml
        echo "# Description: ${adfilter_description}" >>../ad-youtube-clash.yaml
        echo "# Version: ${adfilter_version}" >>../ad-youtube-clash.yaml
        echo "# TimeUpdated: ${adfilter_timeupdated}" >>../ad-youtube-clash.yaml
        echo "# Expires: ${adfilter_expires}" >>../ad-youtube-clash.yaml
        echo "# Homepage: ${adfilter_homepage}" >>../ad-youtube-clash.yaml
        echo "# Total: ${adfilter_total}" >>../ad-youtube-clash.yaml
    }
    function adfilter_clash_premium() {
        echo "payload:" >../ad-youtube-clash-premium.yaml
        echo "# Checksum: ${adfilter_checksum}" >>../ad-youtube-clash-premium.yaml
        echo "# Title: ${adfilter_title} for Clash " >>../ad-youtube-clash-premium.yaml
        echo "# Description: ${adfilter_description}" >>../ad-youtube-clash-premium.yaml
        echo "# Version: ${adfilter_version}" >>../ad-youtube-clash-premium.yaml
        echo "# TimeUpdated: ${adfilter_timeupdated}" >>../ad-youtube-clash-premium.yaml
        echo "# Expires: ${adfilter_expires}" >>../ad-youtube-clash-premium.yaml
        echo "# Homepage: ${adfilter_homepage}" >>../ad-youtube-clash-premium.yaml
        echo "# Total: ${adfilter_total}" >>../ad-youtube-clash-premium.yaml
    }
    function adfilter_dnsmasq() {
        echo "# Checksum: ${adfilter_checksum}" >../ad-youtube-dnsmasq.conf
        echo "# Title: ${adfilter_title} for Dnsmasq " >>../ad-youtube-dnsmasq.conf
        echo "# Description: ${adfilter_description}" >>../ad-youtube-dnsmasq.conf
        echo "# Version: ${adfilter_version}" >>../ad-youtube-dnsmasq.conf
        echo "# TimeUpdated: ${adfilter_timeupdated}" >>../ad-youtube-dnsmasq.conf
        echo "# Expires: ${adfilter_expires}" >>../ad-youtube-dnsmasq.conf
        echo "# Homepage: ${adfilter_homepage}" >>../ad-youtube-dnsmasq.conf
        echo "# Total: ${adfilter_total}" >>../ad-youtube-dnsmasq.conf
    }
    function adfilter_domains() {
        echo "# Checksum: ${adfilter_checksum}" >../ad-youtube-domains.txt
        echo "# Title: ${adfilter_title} for Pi-hole " >>../ad-youtube-domains.txt
        echo "# Description: ${adfilter_description}" >>../ad-youtube-domains.txt
        echo "# Version: ${adfilter_version}" >>../ad-youtube-domains.txt
        echo "# TimeUpdated: ${adfilter_timeupdated}" >>../ad-youtube-domains.txt
        echo "# Expires: ${adfilter_expires}" >>../ad-youtube-domains.txt
        echo "# Homepage: ${adfilter_homepage}" >>../ad-youtube-domains.txt
        echo "# Total: ${adfilter_total}" >>../ad-youtube-domains.txt
    }
    function adfilter_hosts() {
        echo "# Checksum: ${adfilter_checksum}" >../ad-youtube-hosts.txt
        echo "# Title: ${adfilter_title} for hosts " >>../ad-youtube-hosts.txt
        echo "# Description: ${adfilter_description}" >>../ad-youtube-hosts.txt
        echo "# Version: ${adfilter_version}" >>../ad-youtube-hosts.txt
        echo "# TimeUpdated: ${adfilter_timeupdated}" >>../ad-youtube-hosts.txt
        echo "# Expires: ${adfilter_expires}" >>../ad-youtube-hosts.txt
        echo "# Homepage: ${adfilter_homepage}" >>../ad-youtube-hosts.txt
        echo "# Total: ${adfilter_total}" >>../ad-youtube-hosts.txt
        echo "# (DO NOT REMOVE)" >>../ad-youtube-hosts.txt
    }
    function adfilter_quantumult() {
        echo "# Checksum: ${adfilter_checksum}" >../ad-youtube-quantumult.yaml
        echo "# Title: ${adfilter_title} for Quantumult " >>../ad-youtube-quantumult.yaml
        echo "# Description: ${adfilter_description}" >>../ad-youtube-quantumult.yaml
        echo "# Version: ${adfilter_version}" >>../ad-youtube-quantumult.yaml
        echo "# TimeUpdated: ${adfilter_timeupdated}" >>../ad-youtube-quantumult.yaml
        echo "# Expires: ${adfilter_expires}" >>../ad-youtube-quantumult.yaml
        echo "# Homepage: ${adfilter_homepage}" >>../ad-youtube-quantumult.yaml
        echo "# Total: ${adfilter_total}" >>../ad-youtube-quantumult.yaml
    }
    function adfilter_shadowrocket() {
        echo "# Checksum: ${adfilter_checksum}" >../ad-youtube-shadowrocket.list
        echo "# Title: ${adfilter_title} for shadowrocket " >>../ad-youtube-shadowrocket.list
        echo "# Description: ${adfilter_description}" >>../ad-youtube-shadowrocket.list
        echo "# Version: ${adfilter_version}" >>../ad-youtube-shadowrocket.list
        echo "# TimeUpdated: ${adfilter_timeupdated}" >>../ad-youtube-shadowrocket.list
        echo "# Expires: ${adfilter_expires}" >>../ad-youtube-shadowrocket.list
        echo "# Homepage: ${adfilter_homepage}" >>../ad-youtube-shadowrocket.list
        echo "# Total: ${adfilter_total}" >>../ad-youtube-shadowrocket.list
    }
    function adfilter_smartdns() {
        echo "# Checksum: ${adfilter_checksum}" >../ad-youtube-smartdns.conf
        echo "# Title: ${adfilter_title} for SmartDNS " >>../ad-youtube-smartdns.conf
        echo "# Description: ${adfilter_description}" >>../ad-youtube-smartdns.conf
        echo "# Version: ${adfilter_version}" >>../ad-youtube-smartdns.conf
        echo "# TimeUpdated: ${adfilter_timeupdated}" >>../ad-youtube-smartdns.conf
        echo "# Expires: ${adfilter_expires}" >>../ad-youtube-smartdns.conf
        echo "# Homepage: ${adfilter_homepage}" >>../ad-youtube-smartdns.conf
        echo "# Total: ${adfilter_total}" >>../ad-youtube-smartdns.conf
    }
    function adfilter_surge() {
        echo "# Checksum: ${adfilter_checksum}" >../ad-youtube-surge.yaml
        echo "# Title: ${adfilter_title} for Surge " >>../ad-youtube-surge.yaml
        echo "# Description: ${adfilter_description}" >>../ad-youtube-surge.yaml
        echo "# Version: ${adfilter_version}" >>../ad-youtube-surge.yaml
        echo "# TimeUpdated: ${adfilter_timeupdated}" >>../ad-youtube-surge.yaml
        echo "# Expires: ${adfilter_expires}" >>../ad-youtube-surge.yaml
        echo "# Homepage: ${adfilter_homepage}" >>../ad-youtube-surge.yaml
        echo "# Total: ${adfilter_total}" >>../ad-youtube-surge.yaml
    }
    function adfilter_unbound() {
        echo "# Checksum: ${adfilter_checksum}" >../ad-youtube-unbound.conf
        echo "# Title: ${adfilter_title} for Unbound " >>../ad-youtube-unbound.conf
        echo "# Description: ${adfilter_description}" >>../ad-youtube-unbound.conf
        echo "# Version: ${adfilter_version}" >>../ad-youtube-unbound.conf
        echo "# TimeUpdated: ${adfilter_timeupdated}" >>../ad-youtube-unbound.conf
        echo "# Expires: ${adfilter_expires}" >>../ad-youtube-unbound.conf
        echo "# Homepage: ${adfilter_homepage}" >>../ad-youtube-unbound.conf
        echo "# Total: ${adfilter_total}" >>../ad-youtube-unbound.conf
    }
    function adfilter_bind9() {
        echo "# Checksum: ${adfilter_checksum}" >../ad-youtube-bind9.conf
        echo "# Title: ${adfilter_title} for Dind9 " >>../ad-youtube-bind9.conf
        echo "# Description: ${adfilter_description}" >>../ad-youtube-bind9.conf
        echo "# Version: ${adfilter_version}" >>../ad-youtube-bind9.conf
        echo "# TimeUpdated: ${adfilter_timeupdated}" >>../ad-youtube-bind9.conf
        echo "# Expires: ${adfilter_expires}" >>../ad-youtube-bind9.conf
        echo "# Homepage: ${adfilter_homepage}" >>../ad-youtube-bind9.conf
        echo "# Total: ${adfilter_total}" >>../ad-youtube-bind9.conf
        echo "\$TTL 30" >>../ad-youtube-bind9.conf
        echo "@ IN SOA rpz.trli.home. hostmaster.rpz.trli.home. 1643540837 86400 3600 604800 30" >>../ad-youtube-bind9.conf
        echo "NS localhost." >>../ad-youtube-bind9.conf
    }
    function adfilter_adguardhome_dnstype() {
        echo "! Checksum: ${adfilter_checksum}" >../ad-youtube-adguardhome-dnstype.txt
        echo "! Title: ${adfilter_title} for AdguardHome dnstype" >>../ad-youtube-adguardhome-dnstype.txt
        echo "! Description: ${adfilter_description}" >>../ad-youtube-adguardhome-dnstype.txt
        echo "! Version: ${adfilter_version}" >>../ad-youtube-adguardhome-dnstype.txt
        echo "! TimeUpdated: ${adfilter_timeupdated}" >>../ad-youtube-adguardhome-dnstype.txt
        echo "! Expires: ${adfilter_expires}" >>../ad-youtube-adguardhome-dnstype.txt
        echo "! Homepage: ${adfilter_homepage}" >>../ad-youtube-adguardhome-dnstype.txt
        echo "! Total: ${adfilter_total}" >>../ad-youtube-adguardhome-dnstype.txt
    }
    adfilter_adblock
    adfilter_adguardhome
    adfilter_clash
    adfilter_dnsmasq
    adfilter_domains
    adfilter_hosts
    adfilter_quantumult
    adfilter_shadowrocket
    adfilter_smartdns
    adfilter_surge
    adfilter_unbound
    adfilter_clash_premium
    adfilter_bind9
    adfilter_adguardhome_dnstype
}
# Output Data
function OutputData() {
    function FormatedOutputData() {
        for filter_data_task in "${!filter_data[@]}"; do
            echo "||${filter_data[$filter_data_task]}^" >>../ad-youtube-adblock.txt
            echo "|${filter_data[$filter_data_task]}^" >>../ad-youtube-adguardhome.txt
            echo "  - DOMAIN,${filter_data[$filter_data_task]}" >>../ad-youtube-clash.yaml
            echo "  - '+.${filter_data[$filter_data_task]}'" >>../ad-youtube-clash-premium.yaml
            echo "address=/${filter_data[$filter_data_task]}/" >>../ad-youtube-dnsmasq.conf
            echo "${filter_data[$filter_data_task]}" >>../ad-youtube-domains.txt
            echo "127.0.0.1 ${filter_data[$filter_data_task]}" >>../ad-youtube-hosts.txt
            echo "HOST-SUFFIX,${filter_data[$filter_data_task]},REJECT" >>../ad-youtube-quantumult.yaml
            echo "DOMAIN-SUFFIX,${filter_data[$filter_data_task]},REJECT" >>../ad-youtube-shadowrocket.list
            echo "address /${filter_data[$filter_data_task]}/#" >>../ad-youtube-smartdns.conf
            echo "DOMAIN,${filter_data[$filter_data_task]}" >>../ad-youtube-surge.yaml
            echo "local-zone: \"${filter_data[$filter_data_task]}\" always_nxdomain" >>../ad-youtube-unbound.conf
            echo "${filter_data[$filter_data_task]} CNAME ." >>../ad-youtube-bind9.conf
            echo "* ${filter_data[$filter_data_task]} CNAME ." >>../ad-youtube-bind9.conf
            echo "||${filter_data[$filter_data_task]}^$client=127.0.0.1,dnstype=A" >>../ad-youtube-adguardhome-dnstype.txt
        done
    }
    if [ ! -f "../ad-youtube-domains.txt " ]; then
        GenerateInformation && FormatedOutputData
        cd .. && rm -rf ./ad-youtube-hosts
    else
        cat ../ad-domains.txt | head -n $(sed -n '$=' ../ad-youtube-domains.txt) | tail -n +9 >./filter_data.old
        if [ "$(diff ./filter_data.tmp ./filter_data.old)" == "" ]; then
            cd .. && rm -rf ./ad-youtube-hosts
        else
            GenerateInformation && FormatedOutputData
            cd .. && rm -rf ./ad-youtube-hosts
        fi
    fi
}

## Process
# Call GetData
GetData
# Call AnalyseData
AnalyseData
# Call OutputData
OutputData
