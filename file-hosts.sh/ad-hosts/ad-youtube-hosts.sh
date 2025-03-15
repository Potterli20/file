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
    for url in "${filter_domain[@]}" "${filter_hosts[@]}"; do
        curl -s -L --connect-timeout 15 "$url" >>./filter_data.tmp
    done
}

# Analyse Data
function AnalyseData() {
    filter_data=(
        $(cat ./filter_data.tmp |
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

    function generate_file() {
        local filename=$1
        shift
        echo "$@" > "../$filename"
    }

    function generate_common_headers() {
        local title_suffix=$1
        echo "! Checksum: ${adfilter_checksum}"
        echo "! Title: ${adfilter_title} for ${title_suffix}"
        echo "! Description: ${adfilter_description}"
        echo "! Version: ${adfilter_version}"
        echo "! TimeUpdated: ${adfilter_timeupdated}"
        echo "! Expires: ${adfilter_expires}"
        echo "! Homepage: ${adfilter_homepage}"
        echo "! Total: ${adfilter_total}"
    }

    generate_file "ad-youtube-adblock.txt" "$(generate_common_headers "adblock")"
    generate_file "ad-youtube-adguardhome.txt" "$(generate_common_headers "adguardhome")"
    generate_file "ad-youtube-clash.yaml" "payload:" "$(generate_common_headers "Clash")"
    generate_file "ad-youtube-clash-premium.yaml" "payload:" "$(generate_common_headers "Clash")"
    generate_file "ad-youtube-dnsmasq.conf" "$(generate_common_headers "Dnsmasq")"
    generate_file "ad-youtube-domains.txt" "$(generate_common_headers "Pi-hole")"
    generate_file "ad-youtube-hosts.txt" "$(generate_common_headers "hosts")" "# (DO NOT REMOVE)"
    generate_file "ad-youtube-quantumult.yaml" "$(generate_common_headers "Quantumult")"
    generate_file "ad-youtube-shadowrocket.list" "$(generate_common_headers "shadowrocket")"
    generate_file "ad-youtube-smartdns.conf" "$(generate_common_headers "SmartDNS")"
    generate_file "ad-youtube-surge.yaml" "$(generate_common_headers "Surge")"
    generate_file "ad-youtube-unbound.conf" "$(generate_common_headers "Unbound")"
    generate_file "ad-youtube-bind9.conf" "$(generate_common_headers "Dind9")" "\$TTL 30" "@ IN SOA rpz.trli.home. hostmaster.rpz.trli.home. 1643540837 86400 3600 604800 30" "NS localhost."
    generate_file "ad-youtube-adguardhome-dnstype.txt" "$(generate_common_headers "AdguardHome dnstype")"
    generate_file "ad-youtube-singbox.json" "{" "  \"checksum\": \"${adfilter_checksum}\"," "  \"title\": \"${adfilter_title} for Singbox\"," "  \"description\": \"${adfilter_description}\"," "  \"version\": \"${adfilter_version}\"," "  \"timeUpdated\": \"${adfilter_timeupdated}\"," "  \"expires\": \"${adfilter_expires}\"," "  \"homepage\": \"${adfilter_homepage}\"," "  \"total\": ${adfilter_total}," "  \"rules\": []" "}"
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
            echo "  - DOMAIN,${filter_data[$filter_data_task]}" >>../ad-youtube-singbox.srs
        done

        # Append rules to JSON file
        sed -i '$ s/]/,/' ../ad-youtube-singbox.json
        for filter_data_task in "${!filter_data[@]}"; do
            echo "    \"DOMAIN-SUFFIX,${filter_data[$filter_data_task]},REJECT\"," >>../ad-youtube-singbox.json
        done
        sed -i '$ s/,$/]/' ../ad-youtube-singbox.json
    }
    if [ ! -f "../ad-youtube-domains.txt" ]; then
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
