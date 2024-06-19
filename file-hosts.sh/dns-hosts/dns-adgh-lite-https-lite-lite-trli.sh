function GetData() {
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
        "https://raw.githubusercontent.com/MoeKing/gfwlist/main/gfwlist.txt"
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
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/fiberparsed"
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
        "https://raw.githubusercontent.com/hufilter/hufilter/master/hufilter-dns.txt"
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/ad-block-YouTube-Project.txt"
    )
    gfwlist2agh_modify=(
        "https://raw.githubusercontent.com/hezhijie0327/GFWList2AGH/source/data/data_modify.txt"
        "https://raw.githubusercontent.com/Atroc-X/GFWList-AGH/source/data/data_modify.txt"
        "https://raw.githubusercontent.com/jimmyshjj/GFWList2AGH/source/data/data_modify.txt"
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
    cnacc_data=($(domain_regex="^(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$" && lite_domain_regex="^([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$" && cat "./gfwlist2agh_modify.tmp" | grep -v "\#" | grep "\(\@\%\@\)\|\(\@\%\!\)\|\(\!\&\@\)\|\(\@\@\@\)" | tr -d "\!\%\&\(\)\*\@" | grep -E "${domain_regex}" | sort | uniq >"./cnacc_addition.tmp" && cat "./gfwlist2agh_modify.tmp" | grep -v "\#" | grep "\(\!\%\!\)\|\(\@\&\!\)\|\(\!\%\@\)\|\(\!\!\!\)" | tr -d "\!\%\&\(\)\*\@" | grep -E "${domain_regex}" | sort | uniq >"./cnacc_subtraction.tmp" && cat "./gfwlist2agh_modify.tmp" | grep -v "\#" | grep "\(\*\%\*\)\|\(\*\*\*\)" | tr -d "\!\%\&\(\)\*\@" | grep -E "${domain_regex}" | xargs | sed "s/\ /\|/g" | sort | uniq >"./cnacc_exclusion.tmp" && cat "./gfwlist2agh_modify.tmp" | grep -v "\#" | grep "\(\*\%\*\)\|\(\*\*\*\)" | tr -d "\!\%\&\(\)\*\@" | grep -E "${lite_domain_regex}" | xargs | sed "s/\ /\|/g" | sort | uniq >"./lite_cnacc_exclusion.tmp" && cat "./gfwlist2agh_modify.tmp" | grep -v "\#" | grep "\(\!\%\*\)\|\(\!\*\*\)" | tr -d "\!\%\&\(\)\*\@" | grep -E "${domain_regex}" | xargs | sed "s/\ /\|/g" | sort | uniq >"./cnacc_keyword.tmp" && cat "./gfwlist2agh_modify.tmp" | grep -v "\#" | grep "\(\!\%\*\)\|\(\!\*\*\)" | tr -d "\!\%\&\(\)\*\@" | grep -E "${lite_domain_regex}" | xargs | sed "s/\ /\|/g" | sort | uniq >"./lite_cnacc_keyword.tmp" && cat "./gfwlist2agh_modify.tmp" | grep -v "\#" | grep "\(\@\&\@\)\|\(\@\&\!\)\|\(\!\%\@\)\|\(\@\@\@\)" | tr -d "\!\%\&\(\)\*\@" | grep -E "${domain_regex}" | sort | uniq >"./gfwlist_addition.tmp" && cat "./gfwlist2agh_modify.tmp" | grep -v "\#" | grep "\(\!\&\!\)\|\(\@\%\!\)\|\(\!\&\@\)\|\(\!\!\!\)" | tr -d "\!\%\&\(\)\*\@" | grep -E "${domain_regex}" | sort | uniq >"./gfwlist_subtraction.tmp" && cat "./gfwlist2agh_modify.tmp" | grep -v "\#" | grep "\(\*\&\*\)\|\(\*\*\*\)" | tr -d "\!\%\&\(\)\*\@" | grep -E "${domain_regex}" | xargs | sed "s/\ /\|/g" | sort | uniq >"./gfwlist_exclusion.tmp" && cat "./gfwlist2agh_modify.tmp" | grep -v "\#" | grep "\(\*\&\*\)\|\(\*\*\*\)" | tr -d "\!\%\&\(\)\*\@" | grep -E "${lite_domain_regex}" | xargs | sed "s/\ /\|/g" | sort | uniq >"./lite_gfwlist_exclusion.tmp" && cat "./gfwlist2agh_modify.tmp" | grep -v "\#" | grep "\(\!\&\*\)\|\(\!\*\*\)" | tr -d "\!\%\&\(\)\*\@" | grep -E "${domain_regex}" | xargs | sed "s/\ /\|/g" | sort | uniq >"./gfwlist_keyword.tmp" && cat "./gfwlist2agh_modify.tmp" | grep -v "\#" | grep "\(\!\&\*\)\|\(\!\*\*\)" | tr -d "\!\%\&\(\)\*\@" | grep -E "${lite_domain_regex}" | xargs | sed "s/\ /\|/g" | sort | uniq >"./lite_gfwlist_keyword.tmp" && cat "./cnacc_addition.tmp" | grep -E "${lite_domain_regex}" | sort | uniq >"./lite_cnacc_addition.tmp" && cat "./gfwlist_addition.tmp" | grep -E "${lite_domain_regex}" | sort | uniq >"./lite_gfwlist_addition.tmp" && cat "./cnacc_trusted.tmp" | sed "s/\/114\.114\.114\.114//g;s/server\=\///g" | tr "A-Z" "a-z" | grep -E "${domain_regex}" | sort | uniq >"./cnacc_trust.tmp" && cat "./cnacc_trust.tmp" | grep -E "${lite_domain_regex}" | sort | uniq >"./lite_cnacc_trust.tmp" && cat "./cnacc_domain.tmp" | sed "s/domain\://g;s/full\://g" | tr "A-Z" "a-z" | grep -E "${domain_regex}" | sort | uniq >"./cnacc_checklist.tmp" && cat "./gfwlist_base64.tmp" "./gfwlist_domain.tmp" | sed "s/domain\://g;s/full\://g;s/http\:\/\///g;s/https\:\/\///g" | tr -d "|" | tr "A-Z" "a-z" | grep -E "${domain_regex}" | sort | uniq >"./gfwlist_checklist.tmp" && cat "./cnacc_checklist.tmp" | rev | cut -d "." -f 1,2 | rev | sort | uniq >"./lite_cnacc_checklist.tmp" && cat "./gfwlist_checklist.tmp" | rev | cut -d "." -f 1,2 | rev | sort | uniq >"./lite_gfwlist_checklist.tmp" && awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' "./cnacc_checklist.tmp" "./gfwlist_checklist.tmp" >"./gfwlist_raw.tmp" && awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' "./gfwlist_checklist.tmp" "./cnacc_checklist.tmp" | grep -Ev "(\.($(cat './cnacc_exclusion.tmp'))$)|(^$(cat './cnacc_exclusion.tmp')$)|($(cat './cnacc_keyword.tmp'))" >"./cnacc_raw.tmp" && awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' "./lite_cnacc_checklist.tmp" "./lite_gfwlist_checklist.tmp" >"./lite_gfwlist_raw.tmp" && awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' "./lite_gfwlist_checklist.tmp" "./lite_cnacc_checklist.tmp" | grep -Ev "(\.($(cat './lite_cnacc_exclusion.tmp'))$)|(^$(cat './lite_cnacc_exclusion.tmp')$)|($(cat './lite_cnacc_keyword.tmp'))" >"./lite_cnacc_raw.tmp" && awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' "./cnacc_trust.tmp" "./gfwlist_raw.tmp" | grep -Ev "(\.($(cat './gfwlist_exclusion.tmp'))$)|(^$(cat './gfwlist_exclusion.tmp')$)|($(cat './gfwlist_keyword.tmp'))" >"./gfwlist_raw_new.tmp" && awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' "./cnacc_trust.tmp" "./lite_gfwlist_raw.tmp" | grep -Ev "(\.($(cat './lite_gfwlist_exclusion.tmp'))$)|(^$(cat './lite_gfwlist_exclusion.tmp')$)|($(cat './lite_gfwlist_keyword.tmp'))" >"./lite_gfwlist_raw_new.tmp" && cat "./cnacc_raw.tmp" "./lite_cnacc_raw.tmp" "./cnacc_addition.tmp" "./lite_cnacc_addition.tmp" "./cnacc_trust.tmp" "./lite_cnacc_trust.tmp" | sort | uniq >"./cnacc_added.tmp" && cat "./gfwlist_raw_new.tmp" "./lite_gfwlist_raw_new.tmp" "./gfwlist_addition.tmp" "./lite_gfwlist_addition.tmp" | sort | uniq >"./gfwlist_added.tmp" && cat "./lite_cnacc_raw.tmp" "./lite_cnacc_addition.tmp" "./lite_cnacc_trust.tmp" | sort | uniq >"./lite_cnacc_added.tmp" && cat "./lite_gfwlist_raw_new.tmp" "./lite_gfwlist_addition.tmp" | sort | uniq >"./lite_gfwlist_added.tmp" && awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' "./cnacc_subtraction.tmp" "./cnacc_added.tmp" >"./cnacc_data.tmp" && awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' "./gfwlist_subtraction.tmp" "./gfwlist_added.tmp" >"./gfwlist_data.tmp" && awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' "./cnacc_subtraction.tmp" "./lite_cnacc_added.tmp" >"./lite_cnacc_data.tmp" && awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' "./gfwlist_subtraction.tmp" "./lite_gfwlist_added.tmp" >"./lite_gfwlist_data.tmp" && cat "./cnacc_data.tmp" "./lite_cnacc_data.tmp" | sort | uniq | awk "{ print $2 }"))
    gfwlist_data=($(cat "./gfwlist_data.tmp" "./lite_gfwlist_data.tmp" | sort | uniq | awk "{ print $2 }"))
    lite_cnacc_data=($(cat "./lite_cnacc_data.tmp" | sort | uniq | awk "{ print $2 }"))
    lite_gfwlist_data=($(cat "./lite_gfwlist_data.tmp" | sort | uniq | awk "{ print $2 }"))
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
        else
            file_extension="dev"
        fi
        if [ ! -d "../dns-${software_name}" ]; then
            mkdir "../dns-${software_name}"
        fi
        file_name="${generate_temp}list_${generate_mode}.${file_extension}"
        file_path="../dns-${software_name}/${file_name}"
    }
    function GenerateDefaultUpstream() {
        case ${software_name} in
        adguardhome)
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
        adguardhome_new)
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
            "https://dns.ipv6dns.com/dns-query"
            "https://doh-pure.onedns.net/dns-query"
            "https://dns.alidns.com/dns-query"
            "https://doh.pub/dns-query"
        )
        foreign_dns=(
            "tcp://vpn:6000"
            "udp://vpn:6000"
            "tcp://vpn:60001"
            "udp://vpn:60001"
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
            "https://dns.ipv6dns.com/dns-query"
            "https://doh-pure.onedns.net/dns-query"
            "https://dns.alidns.com/dns-query"
            "https://doh.pub/dns-query"
        )
        foreign_dns=(
            "tcp://vpn:6000"
            "udp://vpn:6000"
            "tcp://vpn:60001"
            "udp://vpn:60001"
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
    *)
        exit 1
        ;;
    esac
}
# Output Data
function OutputData() {
    ## AdGuard Home
    echo -e "AdGuard Home"
    software_name="adguardhome" && generate_file="black" && generate_mode="full_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome" && generate_file="black" && generate_mode="full_split_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome" && generate_file="white" && generate_mode="full_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome" && generate_file="white" && generate_mode="full_split_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome" && generate_file="blackwhite" && generate_mode="full_combine" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome" && generate_file="blackwhite" && generate_mode="full_split_combine" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome" && generate_file="whiteblack" && generate_mode="full_combine" && dns_mode="foreign" && GenerateRules
    software_name="adguardhome" && generate_file="whiteblack" && generate_mode="full_split_combine" && dns_mode="foreign" && GenerateRules
    software_name="adguardhome" && generate_file="blackwhite" && generate_mode="full" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome" && generate_file="blackwhite" && generate_mode="lite" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome" && generate_file="whiteblack" && generate_mode="full" && dns_mode="foreign" && GenerateRules
    software_name="adguardhome" && generate_file="whiteblack" && generate_mode="lite" && dns_mode="foreign" && GenerateRules
    ## AdGuard Home (New)
    echo -e "AdGuard Home_new"
    software_name="adguardhome_new" && generate_file="black" && generate_mode="full_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome_new" && generate_file="black" && generate_mode="full_split_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome_new" && generate_file="white" && generate_mode="full_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome_new" && generate_file="white" && generate_mode="full_split_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome_new" && generate_file="blackwhite" && generate_mode="full_combine" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome_new" && generate_file="blackwhite" && generate_mode="full_split_combine" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome_new" && generate_file="whiteblack" && generate_mode="full_combine" && dns_mode="foreign" && GenerateRules
    software_name="adguardhome_new" && generate_file="whiteblack" && generate_mode="full_split_combine" && dns_mode="foreign" && GenerateRules
    software_name="adguardhome_new" && generate_file="blackwhite" && generate_mode="full" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome_new" && generate_file="blackwhite" && generate_mode="lite" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome_new" && generate_file="whiteblack" && generate_mode="full" && dns_mode="foreign" && GenerateRules
    software_name="adguardhome_new" && generate_file="whiteblack" && generate_mode="lite" && dns_mode="foreign" && GenerateRules
}
## Process
# Call GetData
GetData
# Call AnalyseData
AnalyseData
# Call OutputData
OutputData
