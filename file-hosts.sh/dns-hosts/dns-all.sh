function GetData() {
    echo -e "Fetching data..."
    cnacc_domain=(
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/Domains/china/video-domains"
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/Domains/china/china-root"
        "https://github.com/Potterli20/file/releases/download/github-hosts/bilibili-cdn.txt"
        "https://raw.githubusercontent.com/pexcn/daily/gh-pages/chinalist/chinalist.txt"
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt"
        "https://raw.githubusercontent.com/hq450/fancyss/master/rules/WhiteList_new.txt"
        "https://raw.githubusercontent.com/hq450/fancyss/master/rules/apple_china.txt"
        "https://raw.githubusercontent.com/hq450/fancyss/master/rules/cdn.txt"
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/win-update.txt"
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/apple-cn.txt"
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/Domains/china/Domains"
        "https://raw.githubusercontent.com/Loyalsoldier/domain-list-custom/release/apple.txt"
        "https://raw.githubusercontent.com/Loyalsoldier/domain-list-custom/release/icloud.txt"
        "https://raw.githubusercontent.com/Loyalsoldier/domain-list-custom/release/geolocation-cn.txt"
        "https://raw.githubusercontent.com/Loyalsoldier/domain-list-custom/release/cn.txt"
        "https://raw.githubusercontent.com/v2fly/domain-list-community/release/apple.txt"
        "https://raw.githubusercontent.com/v2fly/domain-list-community/release/icloud.txt"
        "https://raw.githubusercontent.com/v2fly/domain-list-community/release/cn.txt"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/China/China_Domain.list"
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/Domains/apple/Domains"
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-tld-list.txt"
    )
    cnacc_trusted=(
        "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf"
        "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf"
        "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/google.china.conf"
    )
    gfwlist_base64=(
        "https://raw.githubusercontent.com/Loukky/gfwlist-by-loukky/master/gfwlist.txt"
        "https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt"
        "https://raw.githubusercontent.com/poctopus/gfwlist-plus/master/gfwlist-plus.txt"
        "https://raw.githubusercontent.com/Loyalsoldier/domain-list-custom/release/gfwlist.txt"
    )
    gfwlist_domain=(
        "https://github.com/Potterli20/file/releases/download/github-hosts/bilibili-cdn.txt"
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-tld-list.txt"
        "https://raw.githubusercontent.com/filteryab/ir-blocked-domain/main/data/ir-blocked-domain"
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/Domains/apple/Domains"
        "https://raw.githubusercontent.com/SukkaW/Surge/master/Source/domainset/icloud_private_relay.conf"
        "https://raw.githubusercontent.com/missdeer/blocklist/master/toblock-optimized.lst"
        "https://gitlab.com/Wiggum27/blockers/-/raw/master/hosts"
        "https://raw.githubusercontent.com/smed79/blacklist/master/extra/facebook.txt"
        "https://dl.red.flag.domains/red.flag.domains.txt"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/Global/Global_Domain.list"
        "https://raw.githubusercontent.com/Loyalsoldier/domain-list-custom/release/steam.txt"
        "https://raw.githubusercontent.com/pexcn/daily/gh-pages/gfwlist/gfwlist.txt"
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/Domains/gfw/Domains"
        "https://github.com/Potterli20/file/releases/download/github-hosts/ad-edge-hosts.txt"
        "https://github.com/Potterli20/file/releases/download/cn-blocked-domain/domains.txt"
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/gfw.txt"
        "https://raw.githubusercontent.com/schrebra/Windows.10.DNS.Block.List/main/hosts.txt"
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/pihole-google.txt"
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/youtubeparsed"
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/shortlinksparsed"
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/proxiesparsed"
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/productsparsed"
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/mailparsed"
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/generalparsed"
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/fontsparsed"
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/firebaseparsed"
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/doubleclickparsed"
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/domainsparsed"
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/dnsparsed"
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/androidparsed"
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/analyticsparsed"
        "https://raw.githubusercontent.com/Loyalsoldier/cn-blocked-domain/release/domains.txt"
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt"
        "https://raw.githubusercontent.com/pexcn/gfwlist-extras/master/gfwlist-extras.txt"
        "https://raw.githubusercontent.com/hq450/fancyss/master/rules/gfwlist.conf"
        "https://raw.githubusercontent.com/Ewpratten/youtube_ad_blocklist/master/blocklist.txt"
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/greatfire.txt"
        "https://raw.githubusercontent.com/kboghdady/youTube_ads_4_pi-hole/master/youtubelist.txt"
        "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt"
        "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/AmazonFireTV.txt"
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/win-spy.txt"
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/win-extra.txt"
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/youtubeblacklist.txt"
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/blockeverything.txt"
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/ad-block-YouTube-Project.txt"
    )
    gfwlist2agh_modify=(
        "https://raw.githubusercontent.com/Potterli20/file/refs/heads/main/file-hosts/gfwlist2agh_modify/gfwlist2agh_modify_final.txt"
    )
    mkdir ./hosts-dns && cd ./hosts-dns
    for cnacc_domain_task in "${!cnacc_domain[@]}"; do
        curl -m 10 -s -L --connect-timeout 15 "${cnacc_domain[$cnacc_domain_task]}" | sed "s/^\.//g" >>./cnacc_domain.tmp
    done
    for cnacc_trusted_task in "${!cnacc_trusted[@]}"; do
        curl -m 10 -s -L --connect-timeout 15 "${cnacc_trusted[$cnacc_trusted_task]}" >>./cnacc_trusted.tmp
    done
    for gfwlist_base64_task in "${!gfwlist_base64[@]}"; do
        curl -m 10 -s -L --connect-timeout 15 "${gfwlist_base64[$gfwlist_base64_task]}" | base64 -d >>./gfwlist_base64.tmp
    done
    for gfwlist_domain_task in "${!gfwlist_domain[@]}"; do
        curl -m 10 -s -L --connect-timeout 15 "${gfwlist_domain[$gfwlist_domain_task]}" | sed "s/^\.//g" >>./gfwlist_domain.tmp
    done
    for gfwlist2agh_modify_task in "${!gfwlist2agh_modify[@]}"; do
        curl -m 10 -s -L --connect-timeout 15 "${gfwlist2agh_modify[$gfwlist2agh_modify_task]}" >>./gfwlist2agh_modify.tmp
    done
}
# Analyse Data
function AnalyseData() {
    echo -e "Analyzing data..."
    
    # 设置域名正则表达式
    domain_regex="^([a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$|^[a-zA-Z0-9]+\.(cn|org\.cn|ac\.cn|mil\.cn|net\.cn|gov\.cn|com\.cn|edu\.cn)$"
    lite_domain_regex="^([a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$"

    # 处理国内域名
    cat "./cnacc_domain.tmp" | grep -v "^#" | sed -E 's/^[[:space:]]*//;s/[[:space:]]*$//' \
        | sed -E 's/^(domain:|full:|\.)//g' | grep -E "${domain_regex}" | sort -u > "./cnacc_data.tmp"
    
    # 处理受信任的国内域名
    cat "./cnacc_trusted.tmp" | grep -v "^#" | sed -E 's/^server=\///;s/\/114\.114\.114\.114$//' \
        | grep -E "${domain_regex}" | sort -u > "./cnacc_trust.tmp"
    
    # 处理 base64 编码的域名列表
    cat "./gfwlist_base64.tmp" | while IFS= read -r line; do
        echo "$line" | grep -q "^#" && continue
        echo "$line" | base64 -d 2>/dev/null | sed -E 's/^[[:space:]]*//;s/[[:space:]]*$//' \
            | sed -E 's/^(|\|\||@@|\.|http:\/\/|https:\/\/)//g' \
            | grep -E "${domain_regex}" >> "./gfwlist_decoded.tmp"
    done

    # 处理普通域名列表
    cat "./gfwlist_domain.tmp" | grep -v "^#" \
        | sed -E 's/^(domain:|full:|https?:\/\/|\.)//g' | grep -E "${domain_regex}" \
        | sort -u > "./gfwlist_normal.tmp"
    
    # 合并所有 GFW 域名并去重
    cat "./gfwlist_decoded.tmp" "./gfwlist_normal.tmp" | sort -u > "./gfwlist_data.tmp"
    
    # 生成精简版数据
    cat "./cnacc_data.tmp" "./cnacc_trust.tmp" | sort -u > "./cnacc_full.tmp"
    cat "./cnacc_full.tmp" | rev | cut -d. -f1,2 | rev | sort -u > "./lite_cnacc_data.tmp"
    cat "./gfwlist_data.tmp" | rev | cut -d. -f1,2 | rev | sort -u > "./lite_gfwlist_data.tmp"

    # 读取数据到数组
    cnacc_data=($(cat "./cnacc_full.tmp"))
    gfwlist_data=($(cat "./gfwlist_data.tmp"))
    lite_cnacc_data=($(cat "./lite_cnacc_data.tmp"))
    lite_gfwlist_data=($(cat "./lite_gfwlist_data.tmp"))

    # 删除临时文件
    rm -f ./gfwlist_decoded.tmp ./gfwlist_normal.tmp

    # 删除临时文件中的空行
    sed -i '/^$/d' ./cnacc_data.tmp ./gfwlist_data.tmp ./lite_cnacc_data.tmp ./lite_gfwlist_data.tmp
}
# Generate Rules
function GenerateRules() {
    function FileName() {
        if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "whiteblack" ]; then
            generate_temp="black"
        elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "blackwhite" ]; then
            generate_temp="white"
        else
            generate_temp="debug"
        fi
        if [ "${software_name}" == "adguardhome" ] || [ "${software_name}" == "adguardhome_new" ] || [ "${software_name}" == "domain" ]; then
            file_extension="txt"
        elif [ "${software_name}" == "bind9" ] || [ "${software_name}" == "dnsmasq" ] || [ "${software_name}" == "smartdns" ] || [ "${software_name}" == "smartdns-domain-rules" ] || [ "${software_name}" == "unbound" ]; then
            file_extension="conf"
        else
            file_extension="dev"
        fi
        if [ ! -d "./output/dns-${software_name}" ]; then
            mkdir -p "./output/dns-${software_name}"
        fi
        file_name="${generate_temp}list_${generate_mode}.${file_extension}"
        file_path="./output/dns-${software_name}/${file_name}"
    }
    function GenerateDefaultUpstream() {
        case ${software_name} in
        adguardhome|adguardhome_new)
            if [ "${generate_mode}" == "full" ] || [ "${generate_mode}" == "lite" ]; then
                if [ "${generate_file}" == "blackwhite" ]; then
                    for foreign_dns_task in "${!foreign_dns[@]}"; do
                        echo "${foreign_dns[$foreign_dns_task]}" >>"${file_path}"
                    done
                elif [ "${generate_file}" == "whiteblack" ]; then
                    for domestic_dns_task in "${!domestic_dns[@]}"; do
                        echo "${domestic_dns[$domestic_dns_task]}" >>"${file_path}"
                    done
                fi
            else
                if [ "${generate_file}" == "black" ]; then
                    for domestic_dns_task in "${!domestic_dns[@]}"; do
                        echo "${domestic_dns[$domestic_dns_task]}" >>"${file_path}"
                    done
                elif [ "${generate_file}" == "white" ]; then
                    for foreign_dns_task in "${!foreign_dns[@]}"; do
                        echo "${foreign_dns[$foreign_dns_task]}" >>"${file_path}"
                    done
                fi
            fi
            ;;
        *)
            exit 1
            ;;
        esac
    }
    case ${software_name} in
    adguardhome)
        domestic_dns=(
            $(for protocol in tcp udp; do echo "${protocol}://dns.alidns.com:53"; done)
            $(for protocol in tcp udp; do echo "${protocol}://223.5.5.5:53"; done)
            $(for protocol in tcp udp; do echo "${protocol}://223.6.6.6:53"; done)
            $(for protocol in tcp udp; do echo "${protocol}://114.114.114.114:53"; done)
            $(for protocol in tcp udp; do echo "${protocol}://114.114.115.115:53"; done)
            $(for protocol in tls quic; do echo "${protocol}://dns.alidns.com:853"; done)
            $(for protocol in https h3; do echo "${protocol}://dns.alidns.com/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://223.5.5.5/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://223.6.6.6/dns-query"; done)
            $(for protocol in tls quic; do echo "${protocol}://223.5.5.5:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://223.6.6.6:853"; done)
            "https://doh-pure.onedns.net/dns-query"
            "https://doh.pub/dns-query"
            "https://sm2.doh.pub/dns-query"
            "https://1.12.12.12/dns-query"
            "https://120.53.53.53/dns-query"
            "tls://dot-pure.onedns.net:853"
            "tls://dot.pub:853"
            "tls://1.12.12.12:853"
            "tls://120.53.53.53:853"
        )
        foreign_dns=(
            $(for protocol in https h3; do echo "${protocol}://firefox.dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://anycast.dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://doh3.dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://dns-unfiltered.adguard.com/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://unfiltered.adguard-dns.com/dns-query"; done)
            $(for protocol in https h3; do
                for port in 443 2083 2053 2087 2096 8443; do
                   echo "${protocol}://1dot1dot1dot1.cloudflare-dns.com:${port}/dns-query"
                  done
            done)
            $(for protocol in https h3; do
                for port in 443 2083 2053 2087 2096 8443; do
                    echo "${protocol}://mozilla.cloudflare-dns.com:${port}/dns-query"
                done
            done)
            $(for protocol in https h3; do
                for port in 443 2083 2053 2087 2096 8443; do
                    echo "${protocol}://chrome.cloudflare-dns.com:${port}/dns-query"
                done
            done)
            $(for protocol in https h3; do
                for port in 443 2083 2053 2087 2096 8443; do
                    echo "${protocol}://dns.cloudflare-dns.com:${port}/dns-query"
                done
            done)
            $(for protocol in https h3; do
                for port in 443 2083 2053 2087 2096 8443; do
                    echo "${protocol}://e5aehtlc5e.cloudflare-dns.com:${port}/dns-query"
                done
            done)
            $(for protocol in https h3; do
                for port in 443 2083 2053 2087 2096 8443; do
                    echo "${protocol}://sepfvn6g5a.cloudflare-dns.com:${port}/dns-query"
                done
            done)
            "https://77.88.8.8:443/dns-query"
            "https://doh.opendns.com/dns-query"
            "https://dns.google/dns-query"
            "https://dns.google.com/dns-query"
            "https://dns12.quad9.net/dns-query"
            "https://dns.twnic.tw/dns-query"
            $(for protocol in tls quic; do echo "${protocol}://anycast.dns.nextdns.io:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://dns-unfiltered.adguard.com:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://dns.nextdns.io:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://doh3.dns.nextdns.io:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://unfiltered.adguard-dns.com:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://dns.google:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://dns.google.com:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://1dot1dot1dot1.cloudflare-dns.com:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://dns12.quad9.net:853"; done)
            "tls://dns.twnic.tw:853"
            "tls://common.dot.dns.yandex.net:853"
        )

        function GenerateRulesHeader() {
            echo -n "[/" >>"${file_path}"
        }
        function GenerateRulesBody() {
            if [ "${generate_mode}" == "full" ] || [ "${generate_mode}" == "full_combine" ]; then
                if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                    for cnacc_data_task in "${!cnacc_data[@]}"; do
                        echo -n "${cnacc_data[$cnacc_data_task]}/" >>"${file_path}"
                    done
                elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                    for gfwlist_data_task in "${!gfwlist_data[@]}"; do
                        echo -n "${gfwlist_data[$gfwlist_data_task]}/" >>"${file_path}"
                    done
                fi
            elif [ "${generate_mode}" == "lite" ] || [ "${generate_mode}" == "lite_combine" ]; then
                # 精简版数据处理
                if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                    for lite_cnacc_data_task in "${!lite_cnacc_data[@]}"; do
                        echo -n "${lite_cnacc_data[$lite_cnacc_data_task]}/" >>"${file_path}"
                    done
                elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                    for lite_gfwlist_data_task in "${!lite_gfwlist_data[@]}"; do
                        echo -n "${lite_gfwlist_data[$lite_gfwlist_data_task]}/" >>"${file_path}"
                    done
                fi
            fi
        }
        function GenerateRulesFooter() {
            if [ "${dns_mode}" == "default" ]; then
                echo -e "]#" >>"${file_path}"
            elif [ "${dns_mode}" == "domestic" ]; then
                echo -e "]${domestic_dns[domestic_dns_task]}" >>"${file_path}"
            elif [ "${dns_mode}" == "foreign" ]; then
                echo -e "]${foreign_dns[foreign_dns_task]}" >>"${file_path}"
            fi
        }
        function GenerateRulesProcess() {
            GenerateRulesHeader
            GenerateRulesBody
            GenerateRulesFooter
        }
        if [ "${dns_mode}" == "default" ]; then
            FileName && GenerateDefaultUpstream && GenerateRulesProcess
        elif [ "${dns_mode}" == "domestic" ]; then
            FileName && GenerateDefaultUpstream && for domestic_dns_task in "${!domestic_dns[@]}"; do
                GenerateRulesProcess
            done
        elif [ "${dns_mode}" == "foreign" ]; then
            FileName && GenerateDefaultUpstream && for foreign_dns_task in "${!foreign_dns[@]}"; do
                GenerateRulesProcess
            done
        fi
        ;;
    adguardhome_new)
        domestic_dns=(
            $(for protocol in tcp udp; do echo "${protocol}://dns.alidns.com:53"; done)
            $(for protocol in tcp udp; do echo "${protocol}://223.5.5.5:53"; done)
            $(for protocol in tcp udp; do echo "${protocol}://223.6.6.6:53"; done)
            $(for protocol in tcp udp; do echo "${protocol}://114.114.114.114:53"; done)
            $(for protocol in tcp udp; do echo "${protocol}://114.114.115.115:53"; done)
            $(for protocol in tls quic; do echo "${protocol}://dns.alidns.com:853"; done)
            $(for protocol in https h3; do echo "${protocol}://dns.alidns.com/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://223.5.5.5/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://223.6.6.6/dns-query"; done)
            $(for protocol in tls quic; do echo "${protocol}://223.5.5.5:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://223.6.6.6:853"; done)
            "https://doh-pure.onedns.net/dns-query"
            "https://doh.pub/dns-query"
            "https://sm2.doh.pub/dns-query"
            "https://1.12.12.12/dns-query"
            "https://120.53.53.53/dns-query"
            "tls://dot-pure.onedns.net:853"
            "tls://dot.pub:853"
            "tls://1.12.12.12:853"
            "tls://120.53.53.53:853"
        )
        foreign_dns=(
            $(for protocol in https h3; do echo "${protocol}://firefox.dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://anycast.dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://doh3.dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://dns-unfiltered.adguard.com/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://unfiltered.adguard-dns.com/dns-query"; done)
            $(for protocol in https h3; do
                for port in 443 2083 2053 2087 2096 8443; do
                   echo "${protocol}://1dot1dot1dot1.cloudflare-dns.com:${port}/dns-query"
                  done
            done)
            $(for protocol in https h3; do
                for port in 443 2083 2053 2087 2096 8443; do
                    echo "${protocol}://mozilla.cloudflare-dns.com:${port}/dns-query"
                done
            done)
            $(for protocol in https h3; do
                for port in 443 2083 2053 2087 2096 8443; do
                    echo "${protocol}://chrome.cloudflare-dns.com:${port}/dns-query"
                done
            done)
            $(for protocol in https h3; do
                for port in 443 2083 2053 2087 2096 8443; do
                    echo "${protocol}://dns.cloudflare-dns.com:${port}/dns-query"
                done
            done)
            $(for protocol in https h3; do
                for port in 443 2083 2053 2087 2096 8443; do
                    echo "${protocol}://e5aehtlc5e.cloudflare-dns.com:${port}/dns-query"
                done
            done)
            $(for protocol in https h3; do
                for port in 443 2083 2053 2087 2096 8443; do
                    echo "${protocol}://sepfvn6g5a.cloudflare-dns.com:${port}/dns-query"
                done
            done)
            "https://77.88.8.8:443/dns-query"
            "https://doh.opendns.com/dns-query"
            "https://dns.google/dns-query"
            "https://dns.google.com/dns-query"
            "https://dns12.quad9.net/dns-query"
            "https://dns.twnic.tw/dns-query"
            $(for protocol in tls quic; do echo "${protocol}://anycast.dns.nextdns.io:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://dns-unfiltered.adguard.com:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://dns.nextdns.io:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://doh3.dns.nextdns.io:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://unfiltered.adguard-dns.com:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://dns.google:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://dns.google.com:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://1dot1dot1dot1.cloudflare-dns.com:853"; done)
            $(for protocol in tls quic; do echo "${protocol}://dns12.quad9.net:853"; done)
            "tls://dns.twnic.tw:853"
            "tls://common.dot.dns.yandex.net:853"
        )

        function GenerateRulesHeader() {
            echo -n "[/" >> "${file_path}"
        }
        function GenerateRulesBody() {
            if [ "${generate_mode}" == "full" ] || [ "${generate_mode}" == "full_combine" ]; then
                if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                    for cnacc_data_task in "${!cnacc_data[@]}"; do
                        echo -n "${cnacc_data[$cnacc_data_task]}/" >> "${file_path}"
                    done
                elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                    for gfwlist_data_task in "${!gfwlist_data[@]}"; do
                        echo -n "${gfwlist_data[$gfwlist_data_task]}/" >> "${file_path}"
                    done
                fi
            elif [ "${generate_mode}" == "lite" ] || [ "${generate_mode}" == "lite_combine" ]; then
                # 精简版数据处理
                if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                    for lite_cnacc_data_task in "${!lite_cnacc_data[@]}"; do
                        echo -n "${lite_cnacc_data[$lite_cnacc_data_task]}/" >> "${file_path}"
                    done
                elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                    for lite_gfwlist_data_task in "${!lite_gfwlist_data[@]}"; do
                        echo -n "${lite_gfwlist_data[$lite_gfwlist_data_task]}/" >> "${file_path}"
                    done
                fi
            fi
        }
        function GenerateRulesFooter() {
            if [ "${dns_mode}" == "default" ]; then
                echo -e "]#" >> "${file_path}"
            elif [ "${dns_mode}" == "domestic" ]; then
                echo -e "]${domestic_dns[*]}" >> "${file_path}"
            elif [ "${dns_mode}" == "foreign" ]; then
                echo -e "]${foreign_dns[*]}" >> "${file_path}"
            fi
        }
        function GenerateRulesProcess() {
            GenerateRulesHeader
            GenerateRulesBody
            GenerateRulesFooter
        }
        if [ "${dns_mode}" == "default" ]; then
            FileName && GenerateDefaultUpstream && GenerateRulesProcess
        elif [ "${dns_mode}" == "domestic" ]; then
            FileName && GenerateDefaultUpstream && GenerateRulesProcess
        elif [ "${dns_mode}" == "foreign" ]; then
            FileName && GenerateDefaultUpstream && GenerateRulesProcess
        fi
        ;;
    bind9)
        domestic_dns=(
            "119.29.29.29 port 53"
            "223.5.5.5 port 53"
            "223.6.6.6 port 53"
            "101.226.4.6 port 53"
            "123.125.81.6 port 53"
            "114.114.114.114 port 53"
            "114.114.115.115 port 53"
            "117.50.11.11 port 53"
            "52.80.66.66 port 53"
        )
        foreign_dns=(
            "208.67.222.222 port 53"
            "8.8.4.4 port 53"
            "8.8.8.8 port 53"
            "1.1.1.1 port 53"
            "1.0.0.1 port 53"
            "9.9.9.10 port 53"
            "94.140.14.140 port 53"
            "94.140.14.141 port 53"
            "74.82.42.42 prot 53"
            "185.222.222.222 prot 53"
        )
        if [ "${generate_mode}" == "full" ]; then
            if [ "${generate_file}" == "black" ]; then
                FileName && for gfwlist_data_task in "${!gfwlist_data[@]}"; do
                    echo -n "zone \"${gfwlist_data[$gfwlist_data_task]}.\" {type forward; forwarders { " >>"${file_path}"
                    for foreign_dns_task in "${!foreign_dns[@]}"; do
                        echo -n "${foreign_dns[$foreign_dns_task]}; " >>"${file_path}"
                    done
                    echo "}; };" >>"${file_path}"
                done
            elif [ "${generate_file}" == "white" ]; then
                FileName && for cnacc_data_task in "${!cnacc_data[@]}"; do
                    echo -n "zone \"${cnacc_data[$cnacc_data_task]}.\" {type forward; forwarders { " >>"${file_path}"
                    for domestic_dns_task in "${!domestic_dns[@]}"; do
                        echo -n "${domestic_dns[$domestic_dns_task]}; " >>"${file_path}"
                    done
                    echo "}; };" >>"${file_path}"
                done
            fi
        fi
        ;;
    dnsmasq)
        domestic_dns=(
            "119.29.29.29#53"
            "223.5.5.5#53"
            "223.6.6.6#53"
            "101.226.4.6#53"
            "123.125.81.6#53"
            "114.114.114.114#53"
            "114.114.115.115#53"
            "117.50.10.10#53"
            "52.80.52.52#53"
        )
        foreign_dns=(
            "208.67.222.222#53"
            "8.8.4.4#53"
            "8.8.8.8#53"
            "1.1.1.1#53"
            "1.0.0.1#53"
            "9.9.9.10#53"
            "94.140.14.140#53"
            "94.140.14.141#53"
            "74.82.42.42#53"
            "185.222.222.222#53"
        )
        if [ "${generate_mode}" == "full" ]; then
            if [ "${generate_file}" == "black" ]; then
                FileName && for gfwlist_data_task in "${!gfwlist_data[@]}"; do
                    for foreign_dns_task in "${!foreign_dns[@]}"; do
                        echo "server=/${gfwlist_data[$gfwlist_data_task]}/${foreign_dns[$foreign_dns_task]}" >>"${file_path}"
                    done
                done
            elif [ "${generate_file}" == "white" ]; then
                FileName && for cnacc_data_task in "${!cnacc_data[@]}"; do
                    for domestic_dns_task in "${!domestic_dns[@]}"; do
                        echo "server=/${cnacc_data[$cnacc_data_task]}/${domestic_dns[$domestic_dns_task]}" >>"${file_path}"
                    done
                done
            fi
        fi
        ;;
    domain)
        if [ "${generate_mode}" == "full" ]; then
            if [ "${generate_file}" == "black" ]; then
                FileName && for gfwlist_data_task in "${!gfwlist_data[@]}"; do
                    echo "${gfwlist_data[$gfwlist_data_task]}" >>"${file_path}"
                done
            elif [ "${generate_file}" == "white" ]; then
                FileName && for cnacc_data_task in "${!cnacc_data[@]}"; do
                    echo "${cnacc_data[$cnacc_data_task]}" >>"${file_path}"
                done
            fi
        elif [ "${generate_mode}" == "lite" ]; then
            if [ "${generate_file}" == "black" ]; then
                FileName && for lite_gfwlist_data_task in "${!lite_gfwlist_data[@]}"; do
                    echo "${lite_gfwlist_data[$lite_gfwlist_data_task]}" >>"${file_path}"
                done
            elif [ "${generate_file}" == "white" ]; then
                FileName && for lite_cnacc_data_task in "${!lite_cnacc_data[@]}"; do
                    echo "${lite_cnacc_data[$lite_cnacc_data_task]}" >>"${file_path}"
                done
            fi
        fi
        ;;
    smartdns)
        if [ "${generate_mode}" == "full" ]; then
            if [ "${generate_file}" == "black" ]; then
                FileName && for gfwlist_data_task in "${!gfwlist_data[@]}"; do
                    echo "nameserver /${gfwlist_data[$gfwlist_data_task]}/${foreign_group:-foreign}" >>"${file_path}"
                done
            elif [ "${generate_file}" == "white" ]; then
                FileName && for cnacc_data_task in "${!cnacc_data[@]}"; do
                    echo "nameserver /${cnacc_data[$cnacc_data_task]}/${domestic_group:-domestic}" >>"${file_path}"
                done
            fi
        elif [ "${generate_mode}" == "lite" ]; then
            if [ "${generate_file}" == "black" ]; then
                FileName && for lite_gfwlist_data_task in "${!lite_gfwlist_data[@]}"; do
                    echo "nameserver /${lite_gfwlist_data[$lite_gfwlist_data_task]}/${foreign_group:-foreign}" >>"${file_path}"
                done
            elif [ "${generate_file}" == "white" ]; then
                FileName && for lite_cnacc_data_task in "${!lite_cnacc_data[@]}"; do
                    echo "nameserver /${lite_cnacc_data[$lite_cnacc_data_task]}/${domestic_group:-domestic}" >>"${file_path}"
                done
            fi
        fi
        ;;
    smartdns-domain-rules)
        if [ "${generate_mode}" == "full" ]; then
            if [ "${generate_file}" == "black" ]; then
                FileName && for gfwlist_data_task in "${!gfwlist_data[@]}"; do
                    echo "domain-rules -speed-check-mode ping,tcp:80 -nameserver /${gfwlist_data[$gfwlist_data_task]}/${foreign_group:-foreign}" >>"${file_path}"
                done
            elif [ "${generate_file}" == "white" ]; then
                FileName && for cnacc_data_task in "${!cnacc_data[@]}"; do
                    echo "domain-rules -speed-check-mode ping,tcp:80 -nameserver /${cnacc_data[$cnacc_data_task]}/${domestic_group:-domestic}" >>"${file_path}"
                done
            fi
        elif [ "${generate_mode}" == "lite" ]; then
            if [ "${generate_file}" == "black" ]; then
                FileName && for lite_gfwlist_data_task in "${!lite_gfwlist_data[@]}"; do
                    echo "domain-rules -speed-check-mode ping,tcp:80 -nameserver /${lite_gfwlist_data[$lite_gfwlist_data_task]}/${foreign_group:-foreign}" >>"${file_path}"
                done
            elif [ "${generate_file}" == "white" ]; then
                FileName && for lite_cnacc_data_task in "${!lite_cnacc_data[@]}"; do
                    echo "domain-rules -speed-check-mode ping,tcp:80 -nameserver /${lite_cnacc_data[$lite_cnacc_data_task]}/${domestic_group:-domestic}" >>"${file_path}"
                done
            fi
        fi
        ;;

    unbound)
        domestic_dns=(
            "223.5.5.5@853"
            "223.6.6.6@853"
            "2400:3200::1@853"
            "2400:3200:baba::1@853"
            "1.12.12.12@853"
            "120.53.53.53@853"
            "119.29.29.29@53"
            "2402:4e00::@53"
            "114.114.114.114@53"
            "114.114.115.115@53"
            "117.50.10.10@53"
            "52.80.52.52@53"
            "2400:7fc0:849e:200::8@53"
            "2404:c2c0:85d8:901::8@53"
        )
        foreign_dns=(
            "8.8.4.4@853"
            "8.8.8.8@853"
            "2001:4860:4860::8888@853"
            "2001:4860:4860::8844@853"
            "1.1.1.1@853"
            "1.0.0.1@853"
            "2606:4700:4700::1111@853"
            "2606:4700:4700::1001@853"
            "9.9.9.12@853"
            "149.112.112.12@853"
            "2620:fe::12@853"
            "2620:fe::fe:12@853"
            "94.140.14.140@853"
            "94.140.14.141@853"
            "2a10:50c0::1:ff@853"
            "2a10:50c0::2:ff@853"
            "209.244.0.3@53"
            "209.244.0.4@53"
            "4.2.2.1@53"
            "4.2.2.2@53"
            "4.2.2.3@53"
            "4.2.2.4@53"
            "4.2.2.5@53"
            "4.2.2.6@53"
        )
        forward_ssl_tls_upstream="yes"
        function GenerateRulesHeader() {
            echo "forward-zone:" >>"${file_path}"
        }
        function GenerateRulesFooter() {
            if [ "${dns_mode}" == "domestic" ]; then
                for domestic_dns_task in "${!domestic_dns[@]}"; do
                    echo "    forward-addr: \"${domestic_dns[$domestic_dns_task]}\"" >>"${file_path}"
                done
            elif [ "${dns_mode}" == "foreign" ]; then
                for foreign_dns_task in "${!foreign_dns[@]}"; do
                    echo "    forward-addr: \"${foreign_dns[$foreign_dns_task]}\"" >>"${file_path}"
                done
            fi
            echo "    forward-first: \"yes\"" >>"${file_path}"
            echo "    forward-no-cache: \"yes\"" >>"${file_path}"
            echo "    forward-ssl-upstream: \"${forward_ssl_tls_upstream}\"" >>"${file_path}"
            echo "    forward-tls-upstream: \"${forward_ssl_tls_upstream}\"" >>"${file_path}"
        }
        if [ "${generate_mode}" == "full" ]; then
            if [ "${generate_file}" == "black" ]; then
                FileName && for gfwlist_data_task in "${!gfwlist_data[@]}"; do
                    GenerateRulesHeader && echo "    name: \"${gfwlist_data[$gfwlist_data_task]}.\"" >>"${file_path}" && GenerateRulesFooter
                done
            elif [ "${generate_file}" == "white" ]; then
                FileName && for cnacc_data_task in "${!cnacc_data[@]}"; do
                    GenerateRulesHeader && echo "    name: \"${cnacc_data[$cnacc_data_task]}.\"" >>"${file_path}" && GenerateRulesFooter
                done
            fi
        fi
        ;;
    *)
        exit 1
        ;;
    esac
}
# Output Data
function OutputData() {
    echo -e "Generating output..."

    # AdGuard Home
    echo -e "AdGuard Home"
    GenerateRulesForSoftware "adguardhome" "full_combine full_split_combine" "black white blackwhite whiteblack" "dns_mode='default'"
    GenerateRulesForSoftware "adguardhome" "full lite" "blackwhite whiteblack" "dns_mode='domestic'"
    GenerateRulesForSoftware "adguardhome" "full lite" "whiteblack" "dns_mode='foreign'"

    # AdGuard Home (New)
    echo -e "AdGuard Home_new"
    GenerateRulesForSoftware "adguardhome_new" "full_combine full_split_combine" "black white blackwhite whiteblack" "dns_mode='default'"
    GenerateRulesForSoftware "adguardhome_new" "full lite" "blackwhite whiteblack" "dns_mode='domestic'"
    GenerateRulesForSoftware "adguardhome_new" "full lite" "whiteblack" "dns_mode='foreign'"

    # Bind9
    echo -e "Bind9"
    GenerateRulesForSoftware "bind9" "full" "black white"

    # DNSMasq
    echo -e "DNSMasq"
    GenerateRulesForSoftware "dnsmasq" "full" "black white"

    # Domain
    GenerateRulesForSoftware "domain" "full lite" "black white"

    # SmartDNS
    echo -e "SmartDNS"
    GenerateRulesForSoftware "smartdns" "full lite" "black white" "foreign_group='foreign'; domestic_group='domestic'"

    # SmartDNS Domain Rules
    echo -e "Smartdns-domain-rules"
    GenerateRulesForSoftware "smartdns-domain-rules" "full lite" "black white" "foreign_group='foreign'; domestic_group='domestic'"

    # Unbound
    echo -e "Unbound"
    GenerateRulesForSoftware "unbound" "full" "black white" "dns_mode='foreign'; dns_mode='domestic'"

    # Move files
    MoveGeneratedFiles
}

# Function to generate rules for a specific software
function GenerateRulesForSoftware() {
    local software=$1
    local modes=$2
    local files=$3
    local extra_params=$4

    for mode in ${modes}; do
        for file in ${files}; do
            software_name="${software}"
            generate_file="${file}"
            generate_mode="${mode}"
            eval "${extra_params}" # 使用 eval 执行额外参数
            GenerateRules
        done
    done
}

# Function to move generated files
function MoveGeneratedFiles() {
    local dest="./output"
    mkdir -p "${dest}"
    for type in adguardhome adguardhome_new bind9 unbound dnsmasq domain smartdns smartdns-domain-rules; do
        local src="${dest}/dns-${type}" # 优化路径定义
        mkdir -p "${src}" # 确保目录存在
        case ${type} in
            adguardhome|adguardhome_new)
                for file in "${src}/blacklist_full.txt" "${src}/whitelist_full.txt"; do
                    if [ -f "${file}" ]; then
                        mv "${file}" "${dest}/dnshosts-all-${type}-$(basename "${file}")" 2>/dev/null
                    fi
                done
                ;;
            bind9|unbound|dnsmasq)
                for file in "${src}/blacklist_full.conf" "${src}/whitelist_full.conf"; do
                    if [ -f "${file}" ]; then
                        mv "${file}" "${dest}/dnshosts-all-${type}-$(basename "${file}")" 2>/dev/null
                    fi
                done
                ;;
            domain)
                for file in "${src}/blacklist_full.txt" "${src}/blacklist_lite.txt" "${src}/whitelist_full.txt" "${src}/whitelist_lite.txt"; do
                    if [ -f "${file}" ]; then
                        mv "${file}" "${dest}/dnshosts-all-${type}-$(basename "${file}")" 2>/dev/null
                    fi
                done
                ;;
            smartdns*)
                for file in "${src}/blacklist_full.conf" "${src}/blacklist_lite.conf" "${src}/whitelist_full.conf" "${src}/whitelist_lite.conf"; do
                    if [ -f "${file}" ]; then
                        mv "${file}" "${dest}/dnshosts-all-${type}-$(basename "${file}")" 2>/dev/null
                    fi
                done
                ;;
        esac
    done
}

## Process
# Call GetData
GetData
# Call AnalyseData
AnalyseData
# Call OutputData
OutputData
