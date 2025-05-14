function GetData() {
    echo -e "GetData running..."
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
    mkdir -p ./output
    # 使用parallel并行下载
    parallel -j 8 "curl -m 10 -s -L --connect-timeout 15 {} | sed 's/^\.//g' >> ./output/cnacc_domain.tmp" ::: "${cnacc_domain[@]}"
    parallel -j 8 "curl -m 10 -s -L --connect-timeout 15 {} >> ./output/cnacc_trusted.tmp" ::: "${cnacc_trusted[@]}"  
    parallel -j 8 "curl -m 10 -s -L --connect-timeout 15 {} | base64 -d >> ./output/gfwlist_base64.tmp" ::: "${gfwlist_base64[@]}"
    parallel -j 8 "curl -m 10 -s -L --connect-timeout 15 {} | sed 's/^\.//g' >> ./output/gfwlist_domain.tmp" ::: "${gfwlist_domain[@]}"
}

# Analyse Data
function AnalyseData() {
    echo -e "AnalyseData running..."
    
    # 只保留一个正则表达式定义,移除未使用的lite_domain_regex
    domain_regex='^([a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$|^[a-zA-Z0-9]+\.(cn|org\.cn|ac\.cn|mil\.cn|net\.cn|gov\.cn|com\.cn|edu\.cn)$'
    
    # 使用临时文件存储中间结果
    tmp_dir="./output/tmp"
    mkdir -p "$tmp_dir"
    
    # 并行处理数据
    {
        # 使用grep替代mawk进行初步过滤
        grep -vE '^#' "./output/cnacc_domain.tmp" | \
        sed -E 's/^[[:space:]]*//;s/[[:space:]]*$//' | \
        sed -E 's/^(domain:|full:|\.)//g' | \
        grep -E "$domain_regex" | sort -u > "$tmp_dir/cnacc_data.tmp"

        grep -vE '^#' "./output/cnacc_trusted.tmp" | \
        sed -E 's/^server=\///;s/\/114\.114\.114\.114$//' | \
        grep -E "$domain_regex" | sort -u > "$tmp_dir/cnacc_trust.tmp"
        
        # Base64解码后再处理
        base64 -d < "./output/gfwlist_base64.tmp" 2>/dev/null | \
        grep -vE '^#' | \
        sed -E 's/^[[:space:]]*//;s/[[:space:]]*$//' | \
        sed -E 's/^(\|\||@@|\.|https?:\/\/)//g' | \
        grep -E "$domain_regex" > "$tmp_dir/gfwlist_decoded.tmp"
        
        grep -vE '^#' "./output/gfwlist_domain.tmp" | \
        sed -E 's/^(domain:|full:|https?:\/\/|\.)//g' | \
        grep -E "$domain_regex" | sort -u > "$tmp_dir/gfwlist_normal.tmp"
    } &
    wait
    
    # 合并数据
    cat "$tmp_dir/gfwlist_decoded.tmp" "$tmp_dir/gfwlist_normal.tmp" | sort -u > "./output/gfwlist_data.tmp"
    cat "$tmp_dir/cnacc_data.tmp" "$tmp_dir/cnacc_trust.tmp" | sort -u > "./output/cnacc_full.tmp"
    
    # 生成精简版 - 使用parallel结合awk进行精确处理
    {
        # 定义域名验证和提取函数
        echo '
        function is_valid_domain(domain) {
            # 过滤IP地址格式
            if(domain ~ /^[0-9.]+$/) return 0
            # 过滤非法字符
            if(domain ~ /[^a-zA-Z0-9.-]/) return 0
            # 确保有效的域名结构
            if(domain !~ /^[a-zA-Z0-9][a-zA-Z0-9.-]*\.[a-zA-Z]{2,}$/) return 1
            return 1
        }
        {
            # 分割并提取最后两级域名
            n = split($0, parts, ".")
            if(n >= 2) {
                domain = parts[n-1] "." parts[n]
                if(is_valid_domain(domain)) print domain
            }
        }' > "${tmp_dir}/domain_filter.awk"

        # 使用parallel和awk并行处理数据
        parallel --pipe -j4 "awk -f ${tmp_dir}/domain_filter.awk | sort -u" \
            < "./output/cnacc_full.tmp" > "./output/lite_cnacc_data.tmp" &

        parallel --pipe -j4 "awk -f ${tmp_dir}/domain_filter.awk | sort -u" \
            < "./output/gfwlist_data.tmp" > "./output/lite_gfwlist_data.tmp" &
    }
    wait

    # 读取到数组
    mapfile -t cnacc_data < "./output/cnacc_full.tmp"
    mapfile -t gfwlist_data < "./output/gfwlist_data.tmp"
    mapfile -t lite_cnacc_data < "./output/lite_cnacc_data.tmp"
    mapfile -t lite_gfwlist_data < "./output/lite_gfwlist_data.tmp"

    # 清理临时文件
    rm -rf "$tmp_dir"
    sed -i '/^$/d' ./output/*.tmp
}

# Generate Rules
function GenerateRules() {
    echo -e "GenerateRules running..."
    function FileName() {
        echo -e "\n=== FileName: Generating ${software_name}/${generate_temp}list_${generate_mode}.${file_extension} ==="
        echo -e "FileName running..."
        echo -e "FileName..."
        if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "whiteblack" ]; then
            generate_temp="black"
        elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "blackwhite" ]; then
            generate_temp="white"
        else
            generate_temp="debug"
        fi
        
        # 获取脚本所在目录
        local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        local base_dir="${script_dir}"   # 修正为当前目录
        
        if [ "${software_name}" == "adguardhome" ] || [ "${software_name}" == "adguardhome_new" ] || [ "${software_name}" == "domain" ]; then
            file_extension="txt"
        elif [ "${software_name}" == "bind9" ] || [ "${software_name}" == "dnsmasq" ] || [ "${software_name}" == "smartdns" ] || [ "${software_name}" == "smartdns-domain-rules" ] || [ "${software_name}" == "unbound" ]; then
            file_extension="conf"
        else
            file_extension="dev"
        fi
        
        local output_dir="${base_dir}/output/dns-${software_name}"
        mkdir -p "${output_dir}"
        
        file_name="${generate_temp}list_${generate_mode}.${file_extension}"
        file_path="${output_dir}/${file_name}"
        
        # Debug输出
        echo "Creating file: ${file_path}"
    }
    function GenerateDefaultUpstream() {
        echo -e "-> GenerateDefaultUpstream for ${software_name}"
        echo -e "GenerateDefaultUpstream running..."
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
    function GenerateRulesHeader() {
        echo -e "  + Adding header"
        echo -e "GenerateRulesHeader running..."
        echo -n "[/" >>"${file_path}"
    }
    function GenerateRulesBody() {
        echo -e "  + Adding body"
        echo -e "GenerateRulesBody running..."
        
        # 使用临时变量预先构建内容
        local content1="" content2=""
        
        if [ "${generate_mode}" == "full" ] || [ "${generate_mode}" == "full_combine" ]; then
            # 同时构建两种内容
            content1=$(printf "%s/" "${gfwlist_data[@]}")
            content2=$(printf "%s/" "${cnacc_data[@]}")
        elif [ "${generate_mode}" == "lite" ] || [ "${generate_mode}" == "lite_combine" ]; then
            # 同时构建两种精简版内容
            content1=$(printf "%s/" "${lite_gfwlist_data[@]}")
            content2=$(printf "%s/" "${lite_cnacc_data[@]}")
        fi
        
        # 根据生成类型决定写入顺序
        if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
            echo -n "$content1" >> "${file_path}"
            [ "${generate_file}" == "blackwhite" ] && echo -n "$content2" >> "${file_path}"
        elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
            echo -n "$content2" >> "${file_path}" 
            [ "${generate_file}" == "whiteblack" ] && echo -n "$content1" >> "${file_path}"
        fi
    }
    function GenerateRulesFooter() {
        echo -e "  + Adding footer"
        echo -e "GenerateRulesFooter running..."
        if [ "${dns_mode}" == "default" ]; then
            echo -e "]#" >>"${file_path}"
        elif [ "${dns_mode}" == "domestic" ]; then
            if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                echo -e "]${foreign_dns[foreign_dns_task]}" >>"${file_path}"
            elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                echo -e "]${domestic_dns[domestic_dns_task]}" >>"${file_path}"
            fi
        elif [ "${dns_mode}" == "foreign" ]; then
            if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                echo -e "]${foreign_dns[foreign_dns_task]}" >>"${file_path}"
            elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                echo -e "]${domestic_dns[domestic_dns_task]}" >>"${file_path}"
            fi
        fi
    }
    function GenerateRulesProcess() {
        echo -e "-> Generating rules"
        echo -e "GenerateRulesProcess running..."
        GenerateRulesHeader
        GenerateRulesBody
        GenerateRulesFooter
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
            echo -e "  + Adding header"
            echo -e "GenerateRulesHeader running..."
            echo -n "[/" >>"${file_path}"
        }
        function GenerateRulesBody() {
            echo -e "  + Adding body"
            echo -e "GenerateRulesBody running..."
            
            # 使用临时变量预先构建内容,避免频繁IO
            local content=""
            
            if [ "${generate_mode}" == "full" ] || [ "${generate_mode}" == "full_combine" ]; then
                if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                    # 使用数组拼接而不是逐行追加
                    content=$(printf "%s/" "${gfwlist_data[@]}")
                elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                    content=$(printf "%s/" "${cnacc_data[@]}")
                fi
            elif [ "${generate_mode}" == "lite" ] || [ "${generate_mode}" == "lite_combine" ]; then
                if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                    content=$(printf "%s/" "${lite_gfwlist_data[@]}")
                elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                    content=$(printf "%s/" "${lite_cnacc_data[@]}")
                fi
            fi
            
            # 一次性写入文件
            echo -n "$content" >> "${file_path}"
        }
        function GenerateRulesFooter() {
            echo -e "  + Adding footer"
            echo -e "GenerateRulesFooter running..."
            if [ "${dns_mode}" == "default" ]; then
                echo -e "]#" >>"${file_path}"
            elif [ "${dns_mode}" == "domestic" ]; then
                if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                    echo -e "]${foreign_dns[foreign_dns_task]}" >>"${file_path}"
                elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                    echo -e "]${domestic_dns[domestic_dns_task]}" >>"${file_path}"
                fi
            elif [ "${dns_mode}" == "foreign" ]; then
                if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                    echo -e "]${foreign_dns[foreign_dns_task]}" >>"${file_path}"
                elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                    echo -e "]${domestic_dns[domestic_dns_task]}" >>"${file_path}"
                fi
            fi
        }
        function GenerateRulesProcess() {
            echo -e "-> Generating rules"
            echo -e "GenerateRulesProcess running..."
            GenerateRulesHeader
            GenerateRulesBody
            GenerateRulesFooter
        }
        if [ "${dns_mode}" == "default" ]; then
            FileName && GenerateDefaultUpstream && GenerateRulesProcess
            # 追加特殊服务器规则
            if [ "${software_name}" == "adguardhome" ]; then
                # cnacc数据
                if [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                    for domain in "${cnacc_data[@]}"; do
                        echo "[/${domain}/]#" >>"${file_path}"
                        for dns in "${domestic_dns[@]}"; do
                            echo "[/${domain}/]${dns}" >>"${file_path}"
                            echo "[/${gfwlist_data}/]${foreign_dns}" >>"${file_path}"
                        done
                    done
                fi
                # gfwlist数据
                if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                    for domain in "${gfwlist_data[@]}"; do
                        echo "[/${domain}/]#" >>"${file_path}"
                        for dns in "${foreign_dns[@]}"; do
                            echo "[/${domain}/]${dns}" >>"${file_path}"
                            echo "[/${cnacc_data}/]${domestic_dns}" >>"${file_path}"
                        done
                    done
                fi
            elif [ "${software_name}" == "adguardhome_new" ]; then
                # cnacc数据
                if [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                    for domain in "${cnacc_data[@]}"; do
                    for dns in "${domestic_dns[@]}"; do
                        echo "[/${domain}/]#" >>"${file_path}"
                        echo -n "[/${domain}/]${dns}" >>"${file_path}"
                        echo -n "[/${gfwlist_data}/]${foreign_dns}" >>"${file_path}"
                        done
                    done
                fi
                # gfwlist数据
                if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                    for domain in "${gfwlist_data[@]}"; do
                    for dns in "${foreign_dns[@]}"; do
                        echo "[/${domain}/]#" >>"${file_path}"
                        echo -n "[/${domain}/]${dns}" >>"${file_path}"
                        echo -n "[/${cnacc_data}/]${domestic_dns}" >>"${file_path}"
                        done
                    done
                fi
            fi
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
            echo -e "  + Adding header"
            echo -e "GenerateRulesHeader running..."
            echo -n "[/" >> "${file_path}"
        }
        function GenerateRulesBody() {
            echo -e "  + Adding body"
            echo -e "GenerateRulesBody running..."
            if [ "${generate_mode}" == "full" ] || [ "${generate_mode}" == "full_combine" ]; then
                if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                    # 只生成一次gfwlist数据
                    for domain in "${gfwlist_data[@]}"; do
                        echo -n "${domain}/" >> "${file_path}"
                    done
                elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                    # 只生成一次cnacc数据
                    for domain in "${cnacc_data[@]}"; do
                        echo -n "${domain}/" >> "${file_path}"
                    done
                fi
            elif [ "${generate_mode}" == "lite" ] || [ "${generate_mode}" == "lite_combine" ]; then
                if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                    # 只生成一次精简版gfwlist数据
                    for domain in "${lite_gfwlist_data[@]}"; do
                        echo -n "${domain}/" >> "${file_path}"
                    done
                elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                    # 只生成一次精简版cnacc数据
                    for domain in "${lite_cnacc_data[@]}"; do
                        echo -n "${domain}/" >> "${file_path}"
                    done
                fi
            fi
        }
        function GenerateRulesFooter() {
            echo -e "  + Adding footer"
            echo -e "GenerateRulesFooter running..."
            if [ "${dns_mode}" == "default" ]; then
                echo -e "]#" >> "${file_path}"
            elif [ "${dns_mode}" == "domestic" ]; then
                for dns in "${domestic_dns[@]}"; do
                    echo -e "]${dns}" >> "${file_path}"
                done
            elif [ "${dns_mode}" == "foreign" ]; then
                for dns in "${foreign_dns[@]}"; do
                    echo -e "]${dns}" >> "${file_path}"
                done
            fi
        }
        function GenerateRulesProcess() {
            echo -e "-> Generating rules"
            echo -e "GenerateRulesProcess running..."
            GenerateRulesHeader
            GenerateRulesBody
            GenerateRulesFooter
            
            # 如果是组合模式，添加对应的另一组规则
            if [ "${generate_file}" == "blackwhite" ]; then
                # 为gfwlist添加国内DNS
                for domain in "${cnacc_data[@]}"; do
                    GenerateRulesHeader
                    echo -n "${domain}/" >> "${file_path}"
                    for dns in "${domestic_dns[@]}"; do
                        echo -e "]${dns}" >> "${file_path}"
                    done
                done
            elif [ "${generate_file}" == "whiteblack" ]; then
                # 为cnacc添加国外DNS
                for domain in "${gfwlist_data[@]}"; do
                    GenerateRulesHeader
                    echo -n "${domain}/" >> "${file_path}"
                    for dns in "${foreign_dns[@]}"; do
                        echo -e "]${dns}" >> "${file_path}"
                    done
                done
            fi
        }
        if [ "${dns_mode}" == "default" ]; then
            FileName && GenerateDefaultUpstream && GenerateRulesProcess
            # 追加特殊服务器规则
            if [ "${software_name}" == "adguardhome" ]; then
                # cnacc数据
                if [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                    for domain in "${cnacc_data[@]}"; do
                        echo "[/${domain}/]#" >>"${file_path}"
                        for dns in "${domestic_dns[@]}"; do
                            echo "[/${domain}/]${dns}" >>"${file_path}"
                            echo "[/${gfwlist_data}/]${foreign_dns}" >>"${file_path}"
                        done
                    done
                fi
                # gfwlist数据
                if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                    for domain in "${gfwlist_data[@]}"; do
                        echo "[/${domain}/]#" >>"${file_path}"
                        for dns in "${foreign_dns[@]}"; do
                            echo "[/${domain}/]${dns}" >>"${file_path}"
                            echo "[/${cnacc_data}/]${domestic_dns}" >>"${file_path}"
                        done
                    done
                fi
            elif [ "${software_name}" == "adguardhome_new" ]; then
                # cnacc数据
                if [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                    for domain in "${cnacc_data[@]}"; do
                    for dns in "${domestic_dns[@]}"; do
                        echo "[/${domain}/]#" >>"${file_path}"
                        echo -n "[/${domain}/]${dns}" >>"${file_path}"
                        echo -n "[/${gfwlist_data}/]${foreign_dns}" >>"${file_path}"
                        done
                    done
                fi
                # gfwlist数据
                if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                    for domain in "${gfwlist_data[@]}"; do
                    for dns in "${foreign_dns[@]}"; do
                        echo "[/${domain}/]#" >>"${file_path}"
                        echo -n "[/${domain}/]${dns}" >>"${file_path}"
                        echo -n "[/${cnacc_data}/]${domestic_dns}" >>"${file_path}"
                        done
                    done
                fi
            fi
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
            echo -e "  + Adding header"
            echo -e "GenerateRulesHeader running..."
            echo "forward-zone:" >>"${file_path}"
        }
        function GenerateRulesFooter() {
            echo -e "  + Adding footer"
            echo -e "GenerateRulesFooter running..."
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
    echo -e "OutputData running..."
    echo -e "Generating output..."

    # AdGuard Home
    echo -e "AdGuard Home"
    GenerateRulesForSoftware "adguardhome" "full_combine full_split_combine lite_combine" "black white blackwhite whiteblack" "dns_mode='default'"
    GenerateRulesForSoftware "adguardhome" "full lite" "blackwhite whiteblack" "dns_mode='domestic'"
    GenerateRulesForSoftware "adguardhome" "full lite" "whiteblack" "dns_mode='foreign'"

    # AdGuard Home (New)
    echo -e "AdGuard Home_new"
    GenerateRulesForSoftware "adguardhome_new" "full_combine full_split_combine lite_combine" "black white blackwhite whiteblack" "dns_mode='default'"
    GenerateRulesForSoftware "adguardhome_new" "full lite" "blackwhite whiteblack" "dns_mode='domestic'"
    GenerateRulesForSoftware "adguardhome_new" "full lite" "whiteblack" "dns_mode='foreign'"

    # Bind9
    echo -e "Bind9"
    GenerateRulesForSoftware "bind9" "full lite" "black white"

    # DNSMasq
    echo -e "DNSMasq"
    GenerateRulesForSoftware "dnsmasq" "full lite" "black white"

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
    GenerateRulesForSoftware "unbound" "full lite" "black white" "dns_mode='foreign'; dns_mode='domestic'"

    # Move files
    MoveGeneratedFiles

    # 立即列出所有生成的文件，便于CI日志调试
    echo "Final output files:"
    find "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/hosts-dns/output" -type f -ls
}

# Function to generate rules for a specific software
function GenerateRulesForSoftware() {
    echo -e "\n=== Processing ${1} ==="
    echo -e "GenerateRulesForSoftware running with: software=$1, modes=$2, files=$3"
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
    echo -e "MoveGeneratedFiles running..."
    # 使用绝对路径
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local base_dir="${script_dir}"   # 修正为当前目录
    local dest="${base_dir}/output"
    
    # Debug输出
    echo "Script directory: ${script_dir}"
    echo "Base directory: ${base_dir}"
    echo "Destination directory: ${dest}"
    
    # 确保目录存在并显示创建过程
    mkdir -p "${dest}" && echo "Created directory: ${dest}"
    
    for type in adguardhome adguardhome_new bind9 unbound dnsmasq domain smartdns smartdns-domain-rules; do
        local src="${dest}/dns-${type}"
        mkdir -p "${src}" && echo "Created directory: ${src}"
        
        # 添加调试信息
        echo "Processing ${type} files..."
        
        case ${type} in
            adguardhome|adguardhome_new)
                for file in "${src}"/blacklist_*.txt "${src}"/whitelist_*.txt; do
                    if [ -f "${file}" ]; then
                        cp -v "${file}" "${dest}/dnshosts-all-${type}-$(basename "${file}")"
                    else
                        echo "Warning: No matching files found for pattern: ${file}"
                    fi
                done
                ;;
            bind9|unbound|dnsmasq|smartdns*)
                for file in "${src}"/blacklist_*.conf "${src}"/whitelist_*.conf; do
                    if [ -f "${file}" ]; then
                        cp -v "${file}" "${dest}/dnshosts-all-${type}-$(basename "${file}")"
                    else
                        echo "Warning: No matching files found for pattern: ${file}"
                    fi
                done
                ;;
            domain)
                for file in "${src}"/blacklist_*.txt "${src}"/whitelist_*.txt; do
                    if [ -f "${file}" ]; then
                        cp -v "${file}" "${dest}/dnshosts-all-${type}-$(basename "${file}")"
                    else
                        echo "Warning: No matching files found for pattern: ${file}"
                    fi
                done
                ;;
        esac
    done
    
    # 列出生成的所有文件
    echo "Generated files in ${dest}:"
    find "${dest}" -type f -ls
}

## Process
# Call GetData
GetData
# Call AnalyseData
AnalyseData
# Call OutputData
OutputData
