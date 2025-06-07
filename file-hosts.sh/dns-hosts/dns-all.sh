#!/bin/bash
# Get Data
function GetData() {
    # 添加URL转换函数
    function convert_github_url() {
        local url="$1"
        # 直接使用可靠的镜像，不做检测
        if [[ "$url" == *"raw.githubusercontent.com"* ]]; then
            echo "https://gh-proxy.com/https://raw.githubusercontent.com${url#*raw.githubusercontent.com}"
        elif [[ "$url" == *"github.com"* ]]; then
            echo "https://gh-proxy.com/https://github.com${url#*github.com}"
        else
            echo "$url"
        fi
    }

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
        "https://raw.githubusercontent.com/v2fly/domain-list-community/release/tld-cn.txt" 
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/ChinaMax/ChinaMax_Domain.list"
        "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/ChinaDomain.list" 
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
    # 创建临时目录并进入
    echo "=== Starting Download Process ==="
    echo "Creating temporary directory..."
    rm -rf ./gfwlist2* ./Temp && mkdir -p ./Temp && cd ./Temp || exit 1
    echo "Temporary directory created"
    
    # 下载函数
    download_file() {
        local url="$1"
        local output="$2"
        local processor="$3"
        
        echo "Downloading: $url"
        if curl -s -f --connect-timeout 15 "$url" | eval "$processor" >> "$output"; then
            echo "✓ Download successful"
            return 0
        else
            echo "✗ Download failed"
            return 1
        fi
    }

    # 初始化所有计数器
    total_downloads=$((${#cnacc_domain[@]} + ${#cnacc_trusted[@]} + ${#gfwlist_base64[@]} + ${#gfwlist_domain[@]} + ${#gfwlist2agh_modify[@]}))
    current_download=0
    success_count=0
    
    # 通用下载函数
    download_with_progress() {
        local url="$1"
        local output="$2"
        local processor="$3"
        local max_retries=3
        local retry_count=0
        
        while [ $retry_count -lt $max_retries ]; do
            # 转换URL并获取最快的镜像
            local converted_url=$(convert_github_url "$url")
            current_download=$((current_download + 1))
            printf "\rDownloading [%3d/%3d] %s (Attempt %d/%d)" $current_download $total_downloads "$converted_url" $((retry_count + 1)) $max_retries
            
            if curl -s -f --connect-timeout 10 --max-time 30 "$converted_url" | eval "$processor" >> "$output"; then
                printf "\r✓ Download successful: [%3d/%3d]\n" $current_download $total_downloads
                success_count=$((success_count + 1))
                return 0
            else
                printf "\r✗ Download failed: [%3d/%3d] - Retrying...\n" $current_download $total_downloads
                retry_count=$((retry_count + 1))
                sleep 2
            fi
        done
        
        printf "\r✗ All download attempts failed for: %s\n" "$url"
        return 1
    }

    # 下载前初始化计数器
    total_all_downloads=$((${#cnacc_domain[@]} + ${#cnacc_trusted[@]} + ${#gfwlist_base64[@]} + ${#gfwlist_domain[@]} + ${#gfwlist2agh_modify[@]}))
    current_download=0
    success_count=0
    download_failed=0

    # CNACC Domain 下载
    echo "=== Downloading CNACC Files ==="
    echo "Processing ${#cnacc_domain[@]} domain files..."
    for url in "${cnacc_domain[@]}"; do
        download_with_progress "$url" "./cnacc_domain.tmp" "sed 's/^\.//g'"
    done

    # CNACC Trusted 下载 
    echo -e "\n=== Downloading CNACC Trusted Files ==="
    echo "Processing ${#cnacc_trusted[@]} trusted files..."
    for url in "${cnacc_trusted[@]}"; do
        download_with_progress "$url" "./cnacc_trusted.tmp" "sed 's/\/114\.114\.114\.114//g;s/server=\///g'"
    done

    # GFWList Base64 下载
    echo -e "\n=== Downloading GFWList Base64 Files ==="
    echo "Processing ${#gfwlist_base64[@]} files..."
    for url in "${gfwlist_base64[@]}"; do
        temp_file="./gfwlist_base64_$(date +%s%N).tmp"
        current_download=$((current_download + 1))
        printf "Downloading [%3d/%3d] %s\n" $current_download $total_all_downloads "$url"
        
        if curl -s -f --connect-timeout 15 "$url" > "$temp_file" && \
           base64 -d "$temp_file" > "${temp_file}.decoded" 2>/dev/null; then
            success_count=$((success_count + 1))
            printf "✓ Base64 decode successful\n"
            
            # 处理解码后的内容
            cat "${temp_file}.decoded" | \
                grep -v '^!' | grep -v '^\[AutoProxy' | grep -v '^@@' | \
                sed -e 's#^//*#/#' \
                    -e 's/^||//' -e 's/^|//' \
                    -e 's/^https\?:\/\///' -e 's/\/.*$//' \
                    -e 's/\*.//g' -e 's/^\.//g' \
                    -e 's/^*\.//' -e 's/[[:space:]]*$//g' | \
                grep -E '^[a-zA-Z0-9][a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' | \
                sort -u >> ./gfwlist_base64.tmp
        else
            printf "✗ Download or decode failed\n"
            download_failed=1
        fi
        rm -f "$temp_file" "${temp_file}.decoded"
    done

    # GFWList Domain 下载
    echo -e "\n=== Downloading GFWList Domain Files ==="
    echo "Processing ${#gfwlist_domain[@]} files..."
    
    for gfwlist_domain_task in "${!gfwlist_domain[@]}"; do
        current_all_download=$((current_all_download + 1))
        printf "Downloading [%3d/%3d]\n" $current_all_download $total_all_downloads
        printf "%s\n" "${gfwlist_domain[$gfwlist_domain_task]}"
        
        if curl -s -f --connect-timeout 15 "${gfwlist_domain[$gfwlist_domain_task]}" | sed "s/^\.//g" >> ./gfwlist_domain.tmp; then
            printf "✓ Download successful\n"
            success_count=$((success_count + 1))
        else
            printf "✗ Download failed\n"
            download_failed=1
        fi
    done
    
    for gfwlist2agh_modify_task in "${!gfwlist2agh_modify[@]}"; do
        if ! curl -s --connect-timeout 15 "${gfwlist2agh_modify[$gfwlist2agh_modify_task]}" >> ./gfwlist2agh_modify.tmp; then
            echo "Error: Failed to download ${gfwlist2agh_modify[$gfwlist2agh_modify_task]}"
            download_failed=1
        fi
    done
    
    # 文件验证改进
    verify_file() {
        local file="$1"
        local min_size="${2:-100}"
        
        if [ ! -f "$file" ] || [ ! -s "$file" ]; then
            echo "Error: $file is empty or missing"
            touch "$file" # 创建空文件以防止后续错误
            return 1
        fi
        
        local size=$(wc -c < "$file")
        echo "File $file exists with size: $size bytes"
        if [ "$size" -lt "$min_size" ]; then
            echo "Warning: File is smaller than expected ($size < $min_size bytes)"
            return 1
        fi
        return 0
    }

    # 验证所有生成的文件
    echo -e "\nVerifying downloaded files..."
    local failed=0
    for file in cnacc_domain.tmp cnacc_trusted.tmp gfwlist_base64.tmp gfwlist_domain.tmp; do
        if ! verify_file "./$file"; then
            failed=1
        fi
    done

    if [ $failed -eq 1 ] || [ $download_failed -eq 1 ]; then
        echo "Error: Some downloads or validations failed"
        echo "Download statistics:"
        echo "Total attempted: $download_count"
        echo "Successful: $success_count"
        echo "Failed: $((download_count - success_count))"
        exit 1
    fi

    # 显示最终统计
    echo -e "\nDownload Summary:"
    echo "Total attempted: $total_all_downloads"
    echo "Successfully downloaded: $success_count"
    echo "Failed: $((total_all_downloads - success_count))"
}

# Analyse Data
function AnalyseData() {
    echo "Starting data analysis..."
    
    # 首先确保所有必需的文件存在
    for file in gfwlist2agh_modify.tmp cnacc_domain.tmp gfwlist_base64.tmp gfwlist_domain.tmp; do
        if [ ! -f "./${file}" ]; then
            echo "Error: Required file ${file} not found"
            exit 1
        fi
        echo "Found required file: ${file} ($(wc -l < "./${file}") lines)"
    done

    # 初始化所有输出文件
    touch ./cnacc_data.tmp ./gfwlist_data.tmp ./lite_cnacc_data.tmp ./lite_gfwlist_data.tmp
    
    echo "Processing domain data..."
    
    # 分步处理数据以便调试
    echo "Step 1: Processing cnacc data..."
    cnacc_data=($(
        domain_regex="^(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$"
        lite_domain_regex="^([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$"
        
        # 处理 cnacc 数据
        cat "./cnacc_domain.tmp" | sed 's/domain://g;s/full://g' | tr 'A-Z' 'a-z' | grep -E "${domain_regex}" | sort | uniq > "./cnacc_processed.tmp"
        cat "./cnacc_trusted.tmp" | sed 's/\/114\.114\.114\.114//g;s/server=\///g' | tr 'A-Z' 'a-z' | grep -E "${domain_regex}" | sort | uniq > "./cnacc_trust_processed.tmp"
        
        # 合并并去重
        cat "./cnacc_processed.tmp" "./cnacc_trust_processed.tmp" | sort | uniq > "./cnacc_combined.tmp"
        
        # 应用排除规则
        if [ -s "./cnacc_exclusion.tmp" ]; then
            grep -Ev "(\.($(cat './cnacc_exclusion.tmp'))$)|(^$(cat './cnacc_exclusion.tmp')$)" "./cnacc_combined.tmp"
        else
            cat "./cnacc_combined.tmp"
        fi
    ))
    
    echo "CNACC data count: ${#cnacc_data[@]}"
    
    echo "Step 2: Processing gfwlist data..."
    gfwlist_data=($(
        # 处理 gfwlist 数据
        cat "./gfwlist_base64.tmp" "./gfwlist_domain.tmp" | \
        sed 's/domain://g;s/full://g;s/http:\/\///g;s/https:\/\///g' | \
        tr -d "|" | tr 'A-Z' 'a-z' | grep -E "${domain_regex}" | \
        sort | uniq > "./gfwlist_processed.tmp"
        
        # 应用排除规则
        if [ -s "./gfwlist_exclusion.tmp" ]; then
            grep -Ev "(\.($(cat './gfwlist_exclusion.tmp'))$)|(^$(cat './gfwlist_exclusion.tmp')$)" "./gfwlist_processed.tmp"
        else
            cat "./gfwlist_processed.tmp"
        fi
    ))
    
    echo "GFWList data count: ${#gfwlist_data[@]}"
    
    # 检查数据是否为空
    if [ ${#cnacc_data[@]} -eq 0 ] || [ ${#gfwlist_data[@]} -eq 0 ]; then
        echo "Error: No data processed."
        echo "cnacc_data size: ${#cnacc_data[@]}"
        echo "gfwlist_data size: ${#gfwlist_data[@]}"
        echo "Debug information:"
        echo "Contents of temporary files:"
        for tmp in *processed.tmp; do
            echo "=== First 10 lines of ${tmp} ==="
            head -n 10 "${tmp}"
        done
        exit 1
    fi
    
    # 初始化 lite 版本的数据
    lite_cnacc_data=($(echo "${cnacc_data[@]}" | tr ' ' '\n' | rev | cut -d "." -f 1,2 | rev | sort -u))
    lite_gfwlist_data=($(echo "${gfwlist_data[@]}" | tr ' ' '\n' | rev | cut -d "." -f 1,2 | rev | sort -u))
    
    echo "Data analysis completed successfully"
    echo "cnacc_data entries: ${#cnacc_data[@]}"
    echo "gfwlist_data entries: ${#gfwlist_data[@]}"
    echo "lite_cnacc_data entries: ${#lite_cnacc_data[@]}"
    echo "lite_gfwlist_data entries: ${#lite_gfwlist_data[@]}"
    
    echo "Step 1: Processing cnacc data..."
    # 添加中国TLD验证
    cn_tlds=(
        "cn"
        "中国"
        "公司"
        "网络"
        "com.cn"
        "net.cn"
        "org.cn"
        "gov.cn"
        "edu.cn"
        "ac.cn"
        "mil.cn"
    )
    
    # 创建临时验证文件
    echo "Verifying China TLD coverage..."
    for tld in "${cn_tlds[@]}"; do
        # 确保TLD在处理后的数据中
        if ! grep -q "\.${tld}$" "./cnacc_processed.tmp"; then
            echo "Adding missing TLD: ${tld}"
            echo "${tld}" >> "./cnacc_processed.tmp"
        fi
    done
    
    # 关键域名验证列表
    important_domains=(
        "baidu.com"
        "qq.com"
        "163.com"
        "taobao.com"
        "tmall.com"
        "jd.com"
        "weixin.com"
        "alipay.com"
        "alibaba.com"
        "alicdn.com"
        "aliyun.com"
        "tencent.com"
        "weibo.com"
        "sina.com.cn"
        "sohu.com"
        "youku.com"
        "iqiyi.com"
    )
    
    # 验证重要域名
    echo "Verifying important Chinese domains..."
    for domain in "${important_domains[@]}"; do
        if ! grep -q "^${domain}$" "./cnacc_processed.tmp"; then
            echo "Adding missing domain: ${domain}"
            echo "${domain}" >> "./cnacc_processed.tmp"
        fi
    done
}

# Generate Rules
function GenerateRules() {
    echo "=== Starting Rules Generation ==="
    
    function FileName() {
        echo "Setting up file naming..."
        if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "whiteblack" ]; then
            generate_temp="black"
        elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "blackwhite" ]; then
            generate_temp="white"
        else
            generate_temp="debug"
        fi
        if [ "${software_name}" == "adguardhome" ] || [ "${software_name}" == "adguardhome_new" ] || [ "${software_name}" == "domain" ]; then
            file_extension="txt"
        elif [ "${software_name}" == "bind9" ] || [ "${software_name}" == "dnsmasq" ] || [ "${software_name}" == "smartdns" ] || [ "${software_name}" == "unbound" ]; then
            file_extension="conf"
        else
            file_extension="dev"
        fi
        if [ ! -d "../gfwlist2${software_name}" ]; then
            mkdir "../gfwlist2${software_name}"
        fi
        file_name="${generate_temp}list_${generate_mode}.${file_extension}"
        file_path="../gfwlist2${software_name}/${file_name}"
        echo "File path set to: ${file_path}"
    }
    function GenerateDefaultUpstream() {
        echo "Generating default upstream configuration..."
        case ${software_name} in
            adguardhome)
                if [ "${generate_mode}" == "full" ] || [ "${generate_mode}" == "lite" ]; then
                    if [ "${generate_file}" == "blackwhite" ]; then
                        for foreign_dns_task in "${!foreign_dns[@]}"; do
                            echo "${foreign_dns[$foreign_dns_task]}" >> "${file_path}"
                        done
                    elif [ "${generate_file}" == "whiteblack" ]; then
                        for domestic_dns_task in "${!domestic_dns[@]}"; do
                            echo "${domestic_dns[$domestic_dns_task]}" >> "${file_path}"
                        done
                    fi
                else
                    if [ "${generate_file}" == "black" ]; then
                        for domestic_dns_task in "${!domestic_dns[@]}"; do
                            echo "${domestic_dns[$domestic_dns_task]}" >> "${file_path}"
                        done
                    elif [ "${generate_file}" == "white" ]; then
                        for foreign_dns_task in "${!foreign_dns[@]}"; do
                            echo "${foreign_dns[$foreign_dns_task]}" >> "${file_path}"
                        done
                    fi
                fi
            ;;
            adguardhome_new)
                if [ "${generate_mode}" == "full" ] || [ "${generate_mode}" == "lite" ]; then
                    if [ "${generate_file}" == "blackwhite" ]; then
                        for foreign_dns_task in "${!foreign_dns[@]}"; do
                            echo "${foreign_dns[$foreign_dns_task]}" >> "${file_path}"
                        done
                    elif [ "${generate_file}" == "whiteblack" ]; then
                        for domestic_dns_task in "${!domestic_dns[@]}"; do
                            echo "${domestic_dns[$domestic_dns_task]}" >> "${file_path}"
                        done
                    fi
                else
                    if [ "${generate_file}" == "black" ]; then
                        for domestic_dns_task in "${!domestic_dns[@]}"; do
                            echo "${domestic_dns[$domestic_dns_task]}" >> "${file_path}"
                        done
                    elif [ "${generate_file}" == "white" ]; then
                        for foreign_dns_task in "${!foreign_dns[@]}"; do
                            echo "${foreign_dns[$foreign_dns_task]}" >> "${file_path}"
                        done
                    fi
                fi
            ;;
            *)
                exit 1
            ;;
        esac
        echo "Upstream configuration completed"
    }
    case ${software_name} in
        adguardhome)
            echo "Generating rules for AdGuard Home..."
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
            "180.76.76.76"
            )
            foreign_dns=(
            $(for protocol in https h3; do echo "${protocol}://firefox.dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://anycast.dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://doh3.dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://dns-unfiltered.adguard.com/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://unfiltered.adguard-dns.com/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://dns.google/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://dns.google.com/dns-query"; done)
            # Cloudflare Instances
            $(for id in "e5aehtlc5e" "sepfvn6g5a" "1dot1dot1dot1" "mozilla" "chrome" "dns"; do
                    for port in 443 2083 2053 2087 2096 8443; do
                        for protocol in https h3; do
                 echo "${protocol}://${id}.cloudflare-dns.com:${port}/dns-query" 
                    done
                done
            done
            )
            # DoT/DoQ Servers
            $(for protocol in tls quic; do
                echo "${protocol}://dns.google:853"
                echo "${protocol}://dns.google.com:853"
                echo "${protocol}://dns.adguard.com:853"
                echo "${protocol}://dns-unfiltered.adguard.com:853"
                echo "${protocol}://unfiltered.adguard-dns.com:853"
                echo "${protocol}://anycast.dns.nextdns.io:853"
                echo "${protocol}://dns.nextdns.io:853"
                echo "${protocol}://doh3.dns.nextdns.io:853"
            done )
            "https://77.88.8.8:443/dns-query"
            "https://doh.opendns.com/dns-query"
            "https://dns12.quad9.net/dns-query"
            "https://dns.twnic.tw/dns-query"
            "tls://dns.twnic.tw:853"
            "tls://common.dot.dns.yandex.net:853"
            "tls://1dot1dot1dot1.cloudflare-dns.com:853"
            "tls://dns12.quad9.net:853"
            )
            function GenerateRulesHeader() {
                echo -n "[/" >> "${file_path}"
            }
            function GenerateRulesBody() {
                # 创建临时文件
                local tmp_file="${file_path}.tmp"
                local filtered_file="${file_path}.filtered"
                
                # 域名验证正则表达式
                local domain_regex="^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\.[a-zA-Z]{2,}$"
                
                if [ "${generate_mode}" == "full" ] || [ "${generate_mode}" == "full_combine" ]; then
                    if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                        # 使用换行符分隔域名写入临时文件，同时进行过滤
                        printf '%s\n' "${cnacc_data[@]}" | \
                        grep -v '^0\.0\.0\.0$' | \
                        grep -v '^[/#]' | \
                        grep -v '\$' | \
                        grep -E "${domain_regex}" > "${tmp_file}"
                    elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                        printf '%s\n' "${gfwlist_data[@]}" | \
                        grep -v '^0\.0\.0\.0$' | \
                        grep -v '^[/#]' | \
                        grep -v '\$' | \
                        grep -E "${domain_regex}" > "${tmp_file}"
                    fi
                elif [ "${generate_mode}" == "lite" ] || [ "${generate_mode}" == "lite_combine" ]; then
                    if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                        printf '%s\n' "${lite_cnacc_data[@]}" | \
                        grep -v '^0\.0\.0\.0$' | \
                        grep -v '^[/#]' | \
                        grep -v '\$' | \
                        grep -E "${domain_regex}" > "${tmp_file}"
                    elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                        printf '%s\n' "${lite_gfwlist_data[@]}" | \
                        grep -v '^0\.0\.0\.0$' | \
                        grep -v '^[/#]' | \
                        grep -v '\$' | \
                        grep -E "${domain_regex}" > "${tmp_file}"
                    fi
                fi

                # 如果文件存在且非空，则处理
                if [ -f "${tmp_file}" ] && [ -s "${tmp_file}" ]; then
                    # 过滤掉无效行和格式化
                    grep -v '^\s*$' "${tmp_file}" | \
                    sed 's/[[:space:]]*$//' | \
                    sed 's/^[[:space:]]*//' | \
                    sort -u > "${filtered_file}"
                    
                    # 将处理后的文件内容转换为所需格式并追加到目标文件
                    tr '\n' '/' < "${filtered_file}" >> "${file_path}"
                    
                    # 清理临时文件
                    rm -f "${tmp_file}" "${filtered_file}"
                fi
            }
            function GenerateRulesFooter() {
                if [ "${dns_mode}" == "default" ]; then
                    echo "]#" >> "${file_path}"
                elif [ "${dns_mode}" == "domestic" ]; then
                    echo "]${domestic_dns[domestic_dns_task]}" >> "${file_path}"
                elif [ "${dns_mode}" == "foreign" ]; then
                    echo "]${foreign_dns[foreign_dns_task]}" >> "${file_path}"
                fi
            }
            # 添加全局进度计数器
            current_rules_count=0
            total_rules_count=32  # 总规则生成数量

            function GenerateRulesProcess() {
                # 重置局部进度计数
                local total_steps=3
                local current_step=0
                
                # 执行规则生成步骤
                current_step=$((current_step + 1))
                GenerateRulesHeader
                
                current_step=$((current_step + 1))
                GenerateRulesBody
                
                current_step=$((current_step + 1))
                GenerateRulesFooter
                
                # 更新全局进度
                current_rules_count=$((current_rules_count + 1))
                
                # 每处理5个规则或最后一个规则时显示进度
                if ((current_rules_count % 5 == 0)) || [ ${current_rules_count} -eq ${total_rules_count} ]; then
                    # 确保进度不超过100%
                    local display_count=$((current_rules_count > total_rules_count ? total_rules_count : current_rules_count))
                    ShowProgress $display_count $total_rules_count "Processing rules $display_count of $total_rules_count"
                fi
            }
            
            if [ "${dns_mode}" == "default" ]; then
                FileName && GenerateDefaultUpstream
                current_rules_count=0  # 重置计数器
                GenerateRulesProcess
            elif [ "${dns_mode}" == "domestic" ]; then
                FileName && GenerateDefaultUpstream
                current_rules_count=0  # 重置计数器
                total_rules_count=${#domestic_dns[@]}  # 更新总数为实际DNS服务器数量
                for domestic_dns_task in "${!domestic_dns[@]}"; do
                    GenerateRulesProcess
                done
            elif [ "${dns_mode}" == "foreign" ]; then
                FileName && GenerateDefaultUpstream
                current_rules_count=0  # 重置计数器
                total_rules_count=${#foreign_dns[@]}  # 更新总数为实际DNS服务器数量
                for foreign_dns_task in "${!foreign_dns[@]}"; do
                    GenerateRulesProcess
                done
            fi
            echo "AdGuard Home rules generation completed"
        ;;
        adguardhome_new)
            echo "Generating rules for AdGuard Home (New)..."
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
            "180.76.76.76"
            )
            foreign_dns=(
            $(for protocol in https h3; do echo "${protocol}://firefox.dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://anycast.dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://doh3.dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://dns.nextdns.io/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://dns-unfiltered.adguard.com/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://unfiltered.adguard-dns.com/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://dns.google/dns-query"; done)
            $(for protocol in https h3; do echo "${protocol}://dns.google.com/dns-query"; done)
            # Cloudflare Instances
            $(for id in "e5aehtlc5e" "sepfvn6g5a" "1dot1dot1dot1" "mozilla" "chrome" "dns"; do
                    for port in 443 2083 2053 2087 2096 8443; do
                        for protocol in https h3; do
                 echo "${protocol}://${id}.cloudflare-dns.com:${port}/dns-query" 
                    done
                done
            done
            )            
            # DoT/DoQ Servers
            $(for protocol in tls quic; do
                echo "${protocol}://dns.google:853"
                echo "${protocol}://dns.google.com:853"
                echo "${protocol}://dns.adguard.com:853"
                echo "${protocol}://dns-unfiltered.adguard.com:853"
                echo "${protocol}://unfiltered.adguard-dns.com:853"
                echo "${protocol}://anycast.dns.nextdns.io:853"
                echo "${protocol}://dns.nextdns.io:853"
                echo "${protocol}://doh3.dns.nextdns.io:853"
            done )
            "https://77.88.8.8:443/dns-query"
            "https://doh.opendns.com/dns-query"
            "https://dns12.quad9.net/dns-query"
            "https://dns.twnic.tw/dns-query"
            "tls://dns.twnic.tw:853"
            "tls://common.dot.dns.yandex.net:853"
            "tls://1dot1dot1dot1.cloudflare-dns.com:853"
            "tls://dns12.quad9.net:853"
            )
            function GenerateRulesHeader() {
                echo -n "[/" >> "${file_path}"
            }
            function GenerateRulesBody() {
                # 创建临时文件
                local tmp_file="${file_path}.tmp"
                local filtered_file="${file_path}.filtered"
                
                # 域名验证正则表达式
                local domain_regex="^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\.[a-zA-Z]{2,}$"
                
                if [ "${generate_mode}" == "full" ] || [ "${generate_mode}" == "full_combine" ]; then
                    if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                        # 使用换行符分隔域名写入临时文件，同时进行过滤
                        printf '%s\n' "${cnacc_data[@]}" | \
                        grep -v '^0\.0\.0\.0$' | \
                        grep -v '^[/#]' | \
                        grep -v '\$' | \
                        grep -E "${domain_regex}" > "${tmp_file}"
                    elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                        printf '%s\n' "${gfwlist_data[@]}" | \
                        grep -v '^0\.0\.0\.0$' | \
                        grep -v '^[/#]' | \
                        grep -v '\$' | \
                        grep -E "${domain_regex}" > "${tmp_file}"
                    fi
                elif [ "${generate_mode}" == "lite" ] || [ "${generate_mode}" == "lite_combine" ]; then
                    if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                        printf '%s\n' "${lite_cnacc_data[@]}" | \
                        grep -v '^0\.0\.0\.0$' | \
                        grep -v '^[/#]' | \
                        grep -v '\$' | \
                        grep -E "${domain_regex}" > "${tmp_file}"
                    elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "whiteblack" ]; then
                        printf '%s\n' "${lite_gfwlist_data[@]}" | \
                        grep -v '^0\.0\.0\.0$' | \
                        grep -v '^[/#]' | \
                        grep -v '\$' | \
                        grep -E "${domain_regex}" > "${tmp_file}"
                    fi
                fi

                # 如果文件存在且非空，则处理
                if [ -f "${tmp_file}" ] && [ -s "${tmp_file}" ]; then
                    # 过滤掉无效行和格式化
                    grep -v '^\s*$' "${tmp_file}" | \
                    sed 's/[[:space:]]*$//' | \
                    sed 's/^[[:space:]]*//' | \
                    sort -u > "${filtered_file}"
                    
                    # 将处理后的文件内容转换为所需格式并追加到目标文件
                    tr '\n' '/' < "${filtered_file}" >> "${file_path}"
                    
                    # 清理临时文件
                    rm -f "${tmp_file}" "${filtered_file}"
                fi
            }
            function GenerateRulesFooter() {
                if [ "${dns_mode}" == "default" ]; then
                    echo "]#" >> "${file_path}"
                elif [ "${dns_mode}" == "domestic" ]; then
                    echo "]${domestic_dns[domestic_dns_task]}" >> "${file_path}"
                elif [ "${dns_mode}" == "foreign" ]; then
                    echo "]${foreign_dns[foreign_dns_task]}" >> "${file_path}"
                fi
            }
            function GenerateRulesProcess() {
                # 局部步骤进度
                local total_steps=3
                local current_step=0
                
                echo "Processing rules..."
                
                # 更新全局进度
                current_rules_count=$((current_rules_count + 1))
                
                # 执行规则生成步骤
                GenerateRulesHeader
                GenerateRulesBody
                GenerateRulesFooter
                
                # 只在特定间隔显示进度
                if ((current_rules_count % 5 == 0)) || [ ${current_rules_count} -eq ${total_rules_count} ]; then
                    ShowProgress $current_rules_count $total_rules_count "Processing rules $current_rules_count of $total_rules_count"
                fi
            }
            if [ "${dns_mode}" == "default" ]; then
                FileName && GenerateDefaultUpstream && GenerateRulesProcess
            elif [ "${dns_mode}" == "domestic" ]; then
                FileName && GenerateDefaultUpstream && GenerateRulesProcess
            elif [ "${dns_mode}" == "foreign" ]; then
                FileName && GenerateDefaultUpstream && GenerateRulesProcess
            fi
            echo "AdGuard Home (New) rules generation completed"
        ;;
        bind9)
            echo "Generating rules for Bind9..."
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
            "74.82.42.42 port 53"
            "185.222.222.222 port 53"
        )
            if [ "${generate_mode}" == "full" ]; then
                if [ "${generate_file}" == "black" ]; then
                    FileName && for gfwlist_data_task in "${!gfwlist_data[@]}"; do
                        echo -n "zone \"${gfwlist_data[$gfwlist_data_task]}.\" {type forward; forwarders { " >> "${file_path}"
                        for foreign_dns_task in "${!foreign_dns[@]}"; do
                            echo -n "${foreign_dns[$foreign_dns_task]}; " >> "${file_path}"
                        done
                        echo "}; };" >> "${file_path}"
                    done
                elif [ "${generate_file}" == "white" ]; then
                    FileName && for cnacc_data_task in "${!cnacc_data[@]}"; do
                        echo -n "zone \"${cnacc_data[$cnacc_data_task]}.\" {type forward; forwarders { " >> "${file_path}"
                        for domestic_dns_task in "${!domestic_dns[@]}"; do
                            echo -n "${domestic_dns[$domestic_dns_task]}; " >> "${file_path}"
                        done
                        echo "}; };" >> "${file_path}"
                    done
                fi
            elif [ "${generate_mode}" == "lite" ]; then
                if [ "${generate_file}" == "black" ]; then
                    FileName && for lite_gfwlist_data_task in "${!lite_gfwlist_data[@]}"; do
                        echo -n "zone \"${lite_gfwlist_data[$lite_gfwlist_data_task]}.\" {type forward; forwarders { " >> "${file_path}"
                        for foreign_dns_task in "${!foreign_dns[@]}"; do
                            echo -n "${foreign_dns[$foreign_dns_task]}; " >> "${file_path}"
                        done
                        echo "}; };" >> "${file_path}"
                    done
                elif [ "${generate_file}" == "white" ]; then
                    FileName && for lite_cnacc_data_task in "${!lite_cnacc_data[@]}"; do
                        echo -n "zone \"${lite_cnacc_data[$lite_cnacc_data_task]}.\" {type forward; forwarders { " >> "${file_path}"
                        for domestic_dns_task in "${!domestic_dns[@]}"; do
                            echo -n "${domestic_dns[$domestic_dns_task]}; " >> "${file_path}"
                        done
                        echo "}; };" >> "${file_path}"
                    done
                fi
            fi
            echo "Bind9 rules generation completed"
        ;;
        dnsmasq)
            echo "Generating rules for DNSMasq..."
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
                            echo "server=/${gfwlist_data[$gfwlist_data_task]}/${foreign_dns[$foreign_dns_task]}" >> "${file_path}"
                        done
                    done
                elif [ "${generate_file}" == "white" ]; then
                    FileName && for cnacc_data_task in "${!cnacc_data[@]}"; do
                        for domestic_dns_task in "${!domestic_dns[@]}"; do
                            echo "server=/${cnacc_data[$cnacc_data_task]}/${domestic_dns[$domestic_dns_task]}" >> "${file_path}"
                        done
                    done
                fi
            elif [ "${generate_mode}" == "lite" ]; then
                if [ "${generate_file}" == "black" ]; then
                    FileName && for lite_gfwlist_data_task in "${!lite_gfwlist_data[@]}"; do
                        for foreign_dns_task in "${!foreign_dns[@]}"; do
                            echo "server=/${lite_gfwlist_data[$lite_gfwlist_data_task]}/${foreign_dns[$foreign_dns_task]}" >> "${file_path}"
                        done
                    done
                elif [ "${generate_file}" == "white" ]; then
                    FileName && for lite_cnacc_data_task in "${!lite_cnacc_data[@]}"; do
                        for domestic_dns_task in "${!domestic_dns[@]}"; do
                            echo "server=/${lite_cnacc_data[$lite_cnacc_data_task]}/${domestic_dns[$domestic_dns_task]}" >> "${file_path}"
                        done
                    done
                fi
            fi
            echo "DNSMasq rules generation completed"
        ;;
        domain)
            echo "Generating rules for Domain..."
            if [ "${generate_mode}" == "full" ]; then
                if [ "${generate_file}" == "black" ]; then
                    FileName && for gfwlist_data_task in "${!gfwlist_data[@]}"; do
                        echo "${gfwlist_data[$gfwlist_data_task]}" >> "${file_path}"
                    done
                elif [ "${generate_file}" == "white" ]; then
                    FileName && for cnacc_data_task in "${!cnacc_data[@]}"; do
                        echo "${cnacc_data[$cnacc_data_task]}" >> "${file_path}"
                    done
                fi
            elif [ "${generate_mode}" == "lite" ]; then
                if [ "${generate_file}" == "black" ]; then
                    FileName && for lite_gfwlist_data_task in "${!lite_gfwlist_data[@]}"; do
                        echo "${lite_gfwlist_data[$lite_gfwlist_data_task]}" >> "${file_path}"
                    done
                elif [ "${generate_file}" == "white" ]; then
                    FileName && for lite_cnacc_data_task in "${!lite_cnacc_data[@]}"; do
                        echo "${lite_cnacc_data[$lite_cnacc_data_task]}" >> "${file_path}"
                    done
                fi
            fi
            echo "Domain rules generation completed"
        ;;
        smartdns)
            echo "Generating rules for SmartDNS..."
            if [ "${generate_mode}" == "full" ]; then
                if [ "${generate_file}" == "black" ]; then
                    FileName && for gfwlist_data_task in "${!gfwlist_data[@]}"; do
                        echo "nameserver /${gfwlist_data[$gfwlist_data_task]}/${foreign_group:-foreign}" >> "${file_path}"
                    done
                elif [ "${generate_file}" == "white" ]; then
                    FileName && for cnacc_data_task in "${!cnacc_data[@]}"; do
                        echo "nameserver /${cnacc_data[$cnacc_data_task]}/${domestic_group:-domestic}" >> "${file_path}"
                    done
                fi
            elif [ "${generate_mode}" == "lite" ]; then
                if [ "${generate_file}" == "black" ]; then
                    FileName && for lite_gfwlist_data_task in "${!lite_gfwlist_data[@]}"; do
                        echo "nameserver /${lite_gfwlist_data[$lite_gfwlist_data_task]}/${foreign_group:-foreign}" >> "${file_path}"
                    done
                elif [ "${generate_file}" == "white" ]; then
                    FileName && for lite_cnacc_data_task in "${!lite_cnacc_data[@]}"; do
                        echo "nameserver /${lite_cnacc_data[$lite_cnacc_data_task]}/${domestic_group:-domestic}" >> "${file_path}"
                    done
                fi
            fi
            echo "SmartDNS rules generation completed"
        ;;
        unbound)
            echo "Generating rules for Unbound..."
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
                echo "forward-zone:" >> "${file_path}"
            }
            function GenerateRulesFooter() {
                if [ "${dns_mode}" == "domestic" ]; then
                    for domestic_dns_task in "${!domestic_dns[@]}"; do
                        echo "    forward-addr: \"${domestic_dns[$domestic_dns_task]}\"" >> "${file_path}"
                    done
                elif [ "${dns_mode}" == "foreign" ]; then
                    for foreign_dns_task in "${!foreign_dns[@]}"; do
                        echo "    forward-addr: \"${foreign_dns[$foreign_dns_task]}\"" >> "${file_path}"
                    done
                fi
                echo "    forward-first: \"yes\"" >> "${file_path}"
                echo "    forward-no-cache: \"yes\"" >> "${file_path}"
                echo "    forward-ssl-upstream: \"${forward_ssl_tls_upstream}\"" >> "${file_path}"
                echo "    forward-tls-upstream: \"${forward_ssl_tls_upstream}\"" >> "${file_path}"
            }
            if [ "${generate_mode}" == "full" ]; then
                if [ "${generate_file}" == "black" ]; then
                    FileName && for gfwlist_data_task in "${!gfwlist_data[@]}"; do
                        GenerateRulesHeader && echo "    name: \"${gfwlist_data[$gfwlist_data_task]}.\"" >> "${file_path}" && GenerateRulesFooter
                    done
                elif [ "${generate_file}" == "white" ]; then
                    FileName && for cnacc_data_task in "${!cnacc_data[@]}"; do
                        GenerateRulesHeader && echo "    name: \"${cnacc_data[$cnacc_data_task]}.\"" >> "${file_path}" && GenerateRulesFooter
                    done
                fi
            elif [ "${generate_mode}" == "lite" ]; then
                if [ "${generate_file}" == "black" ]; then
                    FileName && for lite_gfwlist_data_task in "${!lite_gfwlist_data[@]}"; do
                        GenerateRulesHeader && echo "    name: \"${lite_gfwlist_data[$lite_gfwlist_data_task]}.\"" >> "${file_path}" && GenerateRulesFooter
                    done
                elif [ "${generate_file}" == "white" ]; then
                    FileName && for lite_cnacc_data_task in "${!lite_cnacc_data[@]}"; do
                        GenerateRulesHeader && echo "    name: \"${lite_cnacc_data[$lite_cnacc_data_task]}.\"" >> "${file_path}" && GenerateRulesFooter
                    done
                fi
            fi
            echo "Unbound rules generation completed"
        ;;
        *)
            echo "Error: Unknown software type: ${software_name}"
            exit 1
    esac
    echo "=== Rules Generation Completed ==="
}
# Output Data
function OutputData() {
    echo "=== Starting Rules Output ==="
    echo "Generating rules for all DNS software types..."
    
    # AdGuard Home
    echo "Processing AdGuard Home configurations..."
    software_name="adguardhome" && generate_file="black" && generate_mode="full_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome" && generate_file="black" && generate_mode="lite_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome" && generate_file="white" && generate_mode="full_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome" && generate_file="white" && generate_mode="lite_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome" && generate_file="blackwhite" && generate_mode="full_combine" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome" && generate_file="blackwhite" && generate_mode="lite_combine" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome" && generate_file="whiteblack" && generate_mode="full_combine" && dns_mode="foreign" && GenerateRules
    software_name="adguardhome" && generate_file="whiteblack" && generate_mode="lite_combine" && dns_mode="foreign" && GenerateRules
    software_name="adguardhome" && generate_file="blackwhite" && generate_mode="full" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome" && generate_file="blackwhite" && generate_mode="lite" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome" && generate_file="whiteblack" && generate_mode="full" && dns_mode="foreign" && GenerateRules
    software_name="adguardhome" && generate_file="whiteblack" && generate_mode="lite" && dns_mode="foreign" && GenerateRules
    echo "AdGuard Home configurations completed"
    
    # AdGuard Home (New)
    echo "Processing AdGuard Home (New) configurations..."
    software_name="adguardhome_new" && generate_file="black" && generate_mode="full_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome_new" && generate_file="black" && generate_mode="lite_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome_new" && generate_file="white" && generate_mode="full_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome_new" && generate_file="white" && generate_mode="lite_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome_new" && generate_file="blackwhite" && generate_mode="full_combine" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome_new" && generate_file="blackwhite" && generate_mode="lite_combine" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome_new" && generate_file="whiteblack" && generate_mode="full_combine" && dns_mode="foreign" && GenerateRules
    software_name="adguardhome_new" && generate_file="whiteblack" && generate_mode="lite_combine" && dns_mode="foreign" && GenerateRules
    software_name="adguardhome_new" && generate_file="blackwhite" && generate_mode="full" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome_new" && generate_file="blackwhite" && generate_mode="lite" && dns_mode="domestic" && GenerateRules
    software_name="adguardhome_new" && generate_file="whiteblack" && generate_mode="full" && dns_mode="foreign" && GenerateRules
    software_name="adguardhome_new" && generate_file="whiteblack" && generate_mode="lite" && dns_mode="foreign" && GenerateRules
    echo "AdGuard Home (New) configurations completed"
    
    # Bind9
    echo "Processing Bind9 configurations..."
    software_name="bind9" && generate_file="black" && generate_mode="full" && GenerateRules
    software_name="bind9" && generate_file="black" && generate_mode="lite" && GenerateRules
    software_name="bind9" && generate_file="white" && generate_mode="full" && GenerateRules
    software_name="bind9" && generate_file="white" && generate_mode="lite" && GenerateRules
    echo "Bind9 configurations completed"
    
    # DNSMasq
    echo "Processing DNSMasq configurations..."
    software_name="dnsmasq" && generate_file="black" && generate_mode="full" && GenerateRules
    software_name="dnsmasq" && generate_file="black" && generate_mode="lite" && GenerateRules
    software_name="dnsmasq" && generate_file="white" && generate_mode="full" && GenerateRules
    software_name="dnsmasq" && generate_file="white" && generate_mode="lite" && GenerateRules
    echo "DNSMasq configurations completed"
    
    # Domain
    echo "Processing Domain configurations..."
    software_name="domain" && generate_file="black" && generate_mode="full" && GenerateRules
    software_name="adguardhome" && generate_file="white" && generate_mode="lite_combine" && dns_mode="default" && GenerateRules
    software_name="adguardhome" && generate_file="blackwhite" && generate_mode="full_combine" && dns_mode="domestic" && GenerateRules
    software_name="domain" && generate_file="white" && generate_mode="lite" && GenerateRules
    echo "Domain configurations completed"
    
    # SmartDNS
    echo "Processing SmartDNS configurations..."
    software_name="smartdns" && generate_file="black" && generate_mode="full" && foreign_group="foreign" && GenerateRules
    software_name="smartdns" && generate_file="black" && generate_mode="lite" && foreign_group="foreign" && GenerateRules
    software_name="smartdns" && generate_file="white" && generate_mode="full" && domestic_group="domestic" && GenerateRules
    software_name="smartdns" && generate_file="white" && generate_mode="lite" && domestic_group="domestic" && GenerateRules
    echo "SmartDNS configurations completed"
    
    # Unbound
    echo "Processing Unbound configurations..."
    software_name="unbound" && generate_file="black" && generate_mode="full" && dns_mode="foreign" && GenerateRules
    software_name="unbound" && generate_file="black" && generate_mode="lite" && dns_mode="foreign" && GenerateRules
    software_name="unbound" && generate_file="white" && generate_mode="full" && dns_mode="domestic" && GenerateRules
    software_name="unbound" && generate_file="white" && generate_mode="lite" && dns_mode="domestic" && GenerateRules
    echo "Unbound configurations completed"
    
    echo "Cleaning up temporary directory..."
    cd .. && rm -rf ./Temp
    echo "=== Rules Output Completed ==="
}
function MoveGeneratedFiles() {
    echo "Starting MoveGeneratedFiles..."
    
    # 设置基础路径
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local dest="${script_dir}/hosts-dns"
    
    echo "Script directory: ${script_dir}"
    echo "Destination directory: ${dest}"
    
    # 检查并创建目标目录
    if ! mkdir -p "${dest}"; then
        echo "Error: Failed to create directory: ${dest}"
        return 1
    fi
    echo "Created/Verified directory: ${dest}"
    
    # 检查源文件目录是否存在
    local missing_dirs=0
    for type in adguardhome adguardhome_new bind9 unbound dnsmasq domain smartdns; do
        local src_dir="./gfwlist2${type}"
        if [ ! -d "${src_dir}" ]; then
            echo "Error: Source directory not found: ${src_dir}"
            missing_dirs=$((missing_dirs + 1))
            continue
        fi
        
        echo "Processing ${type} files from ${src_dir}..."
        local files_copied=0
        
        case ${type} in
            adguardhome|adguardhome_new|domain)
                while IFS= read -r -d '' file; do
                    cp -v "${file}" "${dest}/dnshosts-all-${type}-$(basename "${file}")"
                    files_copied=$((files_copied + 1))
                done < <(find "${src_dir}" -type f \( -name "blacklist_*.txt" -o -name "whitelist_*.txt" \) -print0)
                ;;
            bind9|unbound|dnsmasq|smartdns)
                while IFS= read -r -d '' file; do
                    cp -v "${file}" "${dest}/dnshosts-all-${type}-$(basename "${file}")"
                    files_copied=$((files_copied + 1))
                done < <(find "${src_dir}" -type f \( -name "blacklist_*.conf" -o -name "whitelist_*.conf" \) -print0)
                ;;
        esac
        
        echo "Copied ${files_copied} files for ${type}"
        
        # 清理源目录
        if [ ${files_copied} -gt 0 ]; then
            rm -rf "${src_dir}" && echo "Cleaned up ${src_dir}"
        fi
    done
    
    # 验证结果
    echo "Verifying generated files in ${dest}:"
    if ! find "${dest}" -type f -ls; then
        echo "Warning: No files found in destination directory"
    fi
    
    # 报告总体状态
    if [ ${missing_dirs} -gt 0 ]; then
        echo "Warning: ${missing_dirs} source directories were missing"
    else
        echo "All source directories were processed successfully"
    fi
}

function ShowProgress() {
    local current=$1
    local total=$2
    local message="${3:-}"
    local width=50
    local progress=$((current * width / total))
    local percentage=$((current * 100 / total))
    
    # 清除当前行
    printf "\033[2K"
    
    # 显示进度条在新行
    printf "\nProgress: ["
    for ((i=0; i<width; i++)); do
        if [ $i -lt $progress ]; then
            printf "="
        else
            printf " "
        fi
    done
    printf "] %3d%% (%d/%d)" "$percentage" "$current" "$total"
    
    # 如果有额外消息则显示
    if [ -n "$message" ]; then
        printf "\n%s" "$message"
    fi
}

## Process
echo "=== Starting DNS List Generation Process ==="
total_main_steps=4
current_main_step=0

echo "Step 1: Getting Data..."
current_main_step=$((current_main_step + 1))
GetData
ShowProgress $current_main_step $total_main_steps
echo "Data retrieval completed."

echo "Step 2: Analyzing Data..."
current_main_step=$((current_main_step + 1))
AnalyseData
ShowProgress $current_main_step $total_main_steps
echo "Data analysis completed."

echo "Step 3: Generating Rules..."
current_main_step=$((current_main_step + 1))
OutputData
ShowProgress $current_main_step $total_main_steps
echo "Rules generation completed."

echo "Step 4: Moving Generated Files..."
current_main_step=$((current_main_step + 1))
MoveGeneratedFiles
ShowProgress $current_main_step $total_main_steps
echo -e "\nFile movement completed."

echo "=== Process Completed Successfully ==="
