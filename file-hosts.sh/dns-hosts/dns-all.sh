#!/bin/bash

# 时间统计相关变量和函数
START_TIME=$(date +%s)
declare -A STEP_TIMES

function time_taken() {
    local end_time=$(date +%s)
    local start_time=$1
    local duration=$((end_time - start_time))
    echo "$((duration / 60))分 $((duration % 60))秒"
}

function record_step_time() {
    local step_name=$1
    local start_time=$2
    local end_time=$(date +%s)
    STEP_TIMES["$step_name"]=$((end_time - start_time))
}

function print_step_time() {
    local step_name=$1
    local duration=${STEP_TIMES["$step_name"]}
    echo "步骤 '$step_name' 耗时: $((duration / 60))分 $((duration % 60))秒"
}

# 高效并发下载函数，限制最大并发数
function parallel_download() {
    local urls=("${!1}")
    local outfile="$2"
    local filter_cmd="$3"
    local max_jobs=$(nproc)  # 可根据机器性能调整

    # 修正xargs参数，只用-P和-I，不用-n1
    printf "%s\n" "${urls[@]}" | xargs -P $max_jobs -I{} bash -c '
        url="{}"
        tmpf=$(mktemp)
        if curl -s -f --connect-timeout 10 --max-time 30 "$url" -o "$tmpf"; then
            cat "$tmpf" | '"$filter_cmd"' >> "'"$outfile"'"
            echo "OK $url" >> ../download_status.log
        else
            echo "FAIL $url" >> ../download_status.log
        fi
        rm -f "$tmpf"
    '
}

# Get Data
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
    # 清理旧临时目录
    rm -rf ./gfwlist2* ./Temp
    mkdir -p ./Temp && cd ./Temp || exit 1
    echo "Temporary directory created"

    # 初始化状态日志
    : > ../download_status.log

    # 确保所有输出目录存在，避免后续写入失败
    for type in adguardhome adguardhome_new bind9 unbound dnsmasq domain smartdns ikuai; do
        mkdir -p "../gfwlist2${type}"
    done

    # 并行下载所有文件
    parallel_download cnacc_domain[@] "./cnacc_domain.tmp" "sed 's/^\.//g'"
    parallel_download cnacc_trusted[@] "./cnacc_trusted.tmp" "sed 's/\/114\.114\.114\.114//g;s/server=\///g'"
    parallel_download gfwlist_domain[@] "./gfwlist_domain.tmp" "sed 's/^\.//g'"
    parallel_download gfwlist2agh_modify[@] "./gfwlist2agh_modify.tmp" "cat"

    # gfwlist_base64并行下载和解码（限制并发数）
    printf "%s\n" "${gfwlist_base64[@]}" | xargs -P $(nproc) -I{} bash -c '
        url="{}"
        temp_file=$(mktemp ./gfwlist_base64_XXXXXX.tmp)
        decoded_file="${temp_file}.decoded"
        if curl -s -f --connect-timeout 10 --max-time 30 "$url" -o "$temp_file"; then
            # 自动检测base64参数
            if base64 --help 2>&1 | grep -q -- "-d"; then
                BASE64_DECODE_OPT="-d"
            else
                BASE64_DECODE_OPT="-D"
            fi
            if base64 $BASE64_DECODE_OPT "$temp_file" > "$decoded_file" 2>/dev/null; then
                grep -v "^!" "$decoded_file" | grep -v "^\[AutoProxy" | grep -v "^@@" | \
                    sed -e "s#^//*#/#" \
                        -e "s/^||//" -e "s/^|//" \
                        -e "s/^https\?:\/\///" -e "s/\/.*$//" \
                        -e "s/\*.//g" -e "s/^\.//g" \
                        -e "s/^*\.//" -e "s/[[:space:]]*$//g" | \
                    grep -E "^[a-zA-Z0-9][a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" | \
                    LC_ALL=C sort -u >> ./gfwlist_base64.tmp
                echo "OK $url" >> ../download_status.log
            else
                echo "FAIL $url" >> ../download_status.log
            fi
        else
            echo "FAIL $url" >> ../download_status.log
        fi
        rm -f "$temp_file" "$decoded_file"
    '

    wait # 等待所有并行下载完成

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

    # 检查所有生成的文件是否存在并包含数据
    echo -e "\nVerifying downloaded files..."
    local failed=0
    for file in cnacc_domain.tmp cnacc_trusted.tmp gfwlist_base64.tmp gfwlist_domain.tmp gfwlist2agh_modify.tmp; do # Added gfwlist2agh_modify.tmp here
        if ! [ -f "$file" ] || ! [ -s "$file" ]; then
            echo "Error: $file is missing or empty"
            failed=1
        else
            echo "✓ $file exists and contains data"
        fi
    done

    if [ $failed -eq 1 ]; then
        echo "Debug information:"
        echo "Current directory: $(pwd)"
        echo "Contents of current directory:"
        ls -la

        echo -e "\nAttempting to create missing files..."
        for file in cnacc_domain.tmp cnacc_trusted.tmp gfwlist_base64.tmp gfwlist_domain.tmp gfwlist2agh_modify.tmp; do # Added gfwlist2agh_modify.tmp here
            if ! [ -f "$file" ]; then
                touch "$file"
                echo "Created empty file: $file"
            fi
        done

        echo -e "\nChecking file contents:"
        for file in *.tmp; do
            if [ -f "$file" ]; then
                echo "=== First 10 lines of $file ==="
                head -n 10 "$file" 2>/dev/null || echo "No content in $file"
            fi
        done
        exit 1
    fi

    # 显示最终统计
    # Note: total_all_downloads and success_count are not calculated in this script
    # echo -e "\nDownload Summary:"
    # echo "Total attempted: $total_all_downloads"
    # echo "Successfully downloaded: $success_count"
    # echo "Failed: $((total_all_downloads - success_count))"
}

# Analyse Data
function AnalyseData() {
    echo "Starting data analysis..."

    # Ensure required input files from GetData exist
    for file in cnacc_domain.tmp cnacc_trusted.tmp gfwlist_base64.tmp gfwlist_domain.tmp gfwlist2agh_modify.tmp; do # Added gfwlist2agh_modify.tmp here
        if [ ! -f "./${file}" ]; then
            echo "Error: Required input file ${file} not found. Please check download step."
            exit 1
        fi
        echo "Found required input file: ${file} ($(wc -l < "./${file}") lines)"
    done

    # Define regexes
    local domain_regex="^(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$"
    # lite_domain_regex is not used in the file processing, only the cut command is used

    # Process cnacc data and write to cnacc_combined.tmp
    echo "Step 1: Processing cnacc data..."
    cat "./cnacc_domain.tmp" | sed 's/domain://g;s/full://g' | tr 'A-Z' 'a-z' | grep -E "${domain_regex}" | LC_ALL=C sort | uniq > "./cnacc_processed.tmp"
    cat "./cnacc_trusted.tmp" | sed 's/\/114\.114\.114\.114//g;s/server=\///g' | tr 'A-Z' 'a-z' | grep -E "${domain_regex}" | LC_ALL=C sort | uniq > "./cnacc_trust_processed.tmp"
    cat "./cnacc_processed.tmp" "./cnacc_trust_processed.tmp" | LC_ALL=C sort | uniq > "./cnacc_combined.tmp"

    # Apply cnacc exclusion rules (if file exists)
    if [ -s "./cnacc_exclusion.tmp" ]; then
        grep -Ev "(\.($(cat './cnacc_exclusion.tmp'))$)|(^$(cat './cnacc_exclusion.tmp')$)" "./cnacc_combined.tmp" > "./cnacc_combined.tmp.filtered"
        mv "./cnacc_combined.tmp.filtered" "./cnacc_combined.tmp"
    fi

    echo "Processed CNACC data written to ./cnacc_combined.tmp ($(wc -l < "./cnacc_combined.tmp") lines)"

    # Process gfwlist data and write to gfwlist_processed.tmp
    echo "Step 2: Processing gfwlist data..."
    cat "./gfwlist_base64.tmp" "./gfwlist_domain.tmp" | \
    sed 's/domain://g;s/full://g;s/http:\/\///g;s/https:\/\///g' | \
    tr -d "|" | tr 'A-Z' 'a-z' | grep -E "${domain_regex}" | \
    LC_ALL=C sort | uniq > "./gfwlist_processed.tmp"

    # Apply gfwlist exclusion rules (if file exists)
    if [ -s "./gfwlist_exclusion.tmp" ]; then
        grep -Ev "(\.($(cat './gfwlist_exclusion.tmp'))$)|(^$(cat './gfwlist_exclusion.tmp')$)" "./gfwlist_processed.tmp" > "./gfwlist_processed.tmp.filtered"
        mv "./gfwlist_processed.tmp.filtered" "./gfwlist_processed.tmp"
    fi
    echo "Processed GFWList data written to ./gfwlist_processed.tmp ($(wc -l < "./gfwlist_processed.tmp") lines)"

    # Check if processed files are empty
    if [ ! -s "./cnacc_combined.tmp" ] || [ ! -s "./gfwlist_processed.tmp" ]; then
        echo "Error: Processed data files are empty."
        echo "./cnacc_combined.tmp size: $(wc -l < "./cnacc_combined.tmp") lines"
        echo "./gfwlist_processed.tmp size: $(wc -l < "./gfwlist_processed.tmp") lines"
        echo "Debug information:"
        echo "Contents of temporary files:"
        for tmp in *processed.tmp *combined.tmp; do
            echo "=== First 10 lines of ${tmp} ==="
            head -n 10 "${tmp}" 2>/dev/null || echo "No content in ${tmp}"
        done
        exit 1
    fi

    # Generate lite versions from processed files
    echo "Generating lite versions..."
    cat "./cnacc_combined.tmp" | rev | cut -d "." -f 1,2 | rev | sort -u > "./lite_cnacc_processed.tmp"
    cat "./gfwlist_processed.tmp" | rev | cut -d "." -f 1,2 | rev | sort -u > "./lite_gfwlist_processed.tmp"

    echo "Data analysis completed successfully"
    echo "Full CNACC entries: $(wc -l < "./cnacc_combined.tmp")"
    echo "Full GFWList entries: $(wc -l < "./gfwlist_processed.tmp")"
    echo "Lite CNACC entries: $(wc -l < "./lite_cnacc_processed.tmp")"
    echo "Lite GFWList entries: $(wc -l < "./lite_gfwlist_processed.tmp")"

    # Add China TLDs (append to combined processed file)
    echo "Verifying China TLD coverage..."
    local cn_tlds=(
        ".cn" ".中国" ".公司" ".网络" ".com.cn" ".net.cn" ".org.cn" ".gov.cn" ".edu.cn" ".ac.cn" ".mil.cn"
    )
    for tld in "${cn_tlds[@]}"; do
        if ! grep -q "\.${tld}$" "./cnacc_combined.tmp"; then
            echo "Adding missing TLD: ${tld}"
            echo "${tld}" >> "./cnacc_combined.tmp"
        fi
    done
    # Re-sort and uniq after adding TLDs
    LC_ALL=C sort -u "./cnacc_combined.tmp" -o "./cnacc_combined.tmp"


    # Verify important Chinese domains (append to combined processed file)
    echo "Verifying important Chinese domains..."
    local important_domains=(
        "baidu.com" "qq.com" "163.com" "taobao.com" "tmall.com" "jd.com" "weixin.com" "alipay.com" "alibaba.com" "alicdn.com" "aliyun.com" "tencent.com" "weibo.com" "sina.com.cn" "sohu.com" "youku.com" "iqiyi.com"
    )
    for domain in "${important_domains[@]}"; do
        if ! grep -q "^${domain}$" "./cnacc_combined.tmp"; then
            echo "Adding missing domain: ${domain}"
            echo "${domain}" >> "./cnacc_combined.tmp"
        fi
    done
    # Re-sort and uniq after adding domains
    LC_ALL=C sort -u "./cnacc_combined.tmp" -o "./cnacc_combined.tmp"

    echo "Final CNACC entries after verification: $(wc -l < "./cnacc_combined.tmp")"
}
# Generate Rules
function GenerateRules() {
    local software_name="$1"
    local generate_file="$2"
    local generate_mode="$3"
    local dns_mode="$4" # Used for AdGuardHome/Unbound footer, and SmartDNS group name

    echo "=== Starting Rules Generation for ${software_name} (${generate_file}, ${generate_mode}, ${dns_mode}) ==="

    function FileName() {
        # echo "Setting up file naming..." # Removed verbose output
        local temp_generate_file="${generate_file}"
        if [ "${temp_generate_file}" == "blackwhite" ]; then
            temp_generate_file="black" # Use 'black' prefix for blackwhite list (GFWList domains)
        elif [ "${temp_generate_file}" == "whiteblack" ]; then
            temp_generate_file="white" # Use 'white' prefix for whiteblack list (CNACC domains)
        fi

        local file_extension="dev"
        case "${software_name}" in
            adguardhome|adguardhome_new|domain|ikuai)
                file_extension="txt"
            ;;
            bind9|dnsmasq|smartdns|unbound)
                file_extension="conf"
            ;;
        esac

        local dir="../gfwlist2${software_name}"
        mkdir -p "$dir" # Ensure directory exists

        # Construct file name based on parameters
        file_name="${temp_generate_file}list_${generate_mode}"
        # Add dns_mode to filename for AGH/AGH_new/Unbound if not default, as they might differ
        if { [ "${software_name}" == "adguardhome" ] || [ "${software_name}" == "adguardhome_new" ] || [ "${software_name}" == "unbound" ]; } && [ "${dns_mode}" != "default" ]; then
             file_name="${file_name}_${dns_mode}"
        fi
         # Add dns_mode to filename for SmartDNS
        if [ "${software_name}" == "smartdns" ]; then
             file_name="${file_name}_${dns_mode}"
        fi


        file_path="${dir}/${file_name}.${file_extension}"

        echo "File path set to: ${file_path}"
        # Clear the file before writing
        : > "${file_path}"
    }

    # Determine source file based on generate_file and generate_mode
    local source_file=""
    if [ "${generate_mode}" == "full" ] || [ "${generate_mode}" == "full_combine" ]; then
        if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "whiteblack" ]; then # whiteblack uses CNACC domains
            source_file="./cnacc_combined.tmp"
        elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "blackwhite" ]; then # blackwhite uses GFWList domains
            source_file="./gfwlist_processed.tmp"
        fi
    elif [ "${generate_mode}" == "lite" ] || [ "${generate_mode}" == "lite_combine" ]; then
        if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "whiteblack" ]; then # whiteblack uses CNACC domains
            source_file="./lite_cnacc_processed.tmp"
        elif [ "${generate_file}" == "white" ] || [ "${generate_file}" == "blackwhite" ]; then # blackwhite uses GFWList domains
            source_file="./lite_gfwlist_processed.tmp"
        fi
    fi

    if [ ! -f "$source_file" ]; then
        echo "Error: Source file not found for rule generation: ${source_file}"
        return 1 # Use return instead of exit to allow other generations to continue
    fi
    echo "Reading domains from: ${source_file}"

    # DNS server lists (defined here as they are used per software type)
    # Note: domestic_dns and foreign_dns are primarily used for AdGuard Home/AdGuard Home New rule footers.
    local adgh_domestic_dns=(
        "tcp://dns.alidns.com" "udp://dns.alidns.com" "tcp://223.5.5.5" "udp://223.5.5.5" "tcp://223.6.6.6" "udp://223.6.6.6" "tcp://2400:3200::1" "udp://2400:3200::1" "tcp://2400:3200:baba::1" "udp://2400:3200:baba::1" "tcp://114.114.114.114" "udp://114.114.114.114" "tcp://114.114.115.115" "udp://114.114.115.115" "tls://dns.alidns.com:853" "https://dns.alidns.com/dns-query" "h3://dns.alidns.com/dns-query" "https://223.5.5.5/dns-query" "h3://223.5.5.5/dns-query" "https://223.6.6.6/dns-query" "h3://223.6.6.6/dns-query" "tls://223.5.5.5:853" "quic://223.5.5.5:853" "tls://223.6.6.6:853" "quic://223.6.6.6:853" "https://2400:3200::1/dns-query" "h3://2400:3200::1/dns-query" "https://2400:3200:baba::1/dns-query" "h3://2400:3200:baba::1/dns-query" "tls://2400:3200::1:853" "quic://2400:3200::1:853" "tls://2400:3200:baba::1:853" "quic://2400:3200:baba::1:853" "tcp://119.29.29.29" "udp://119.29.29.29" "tcp://2402:4e00::" "udp://2402:4e00::" "tcp://2402:4e00:1::" "udp://2402:4e00:1::" "https://doh-pure.onedns.net/dns-query" "https://doh.pub/dns-query" "https://sm2.doh.pub/dns-query" "https://1.12.12.12/dns-query" "https://120.53.53.53/dns-query" "tls://dot-pure.onedns.net:853" "tls://dot.pub:853" "tls://1.12.12.12:853" "tls://120.53.53.53:853" "180.76.76.76" "tcp://71.131.215.228" "udp://71.131.215.228" "tcp://117.50.0.88" "udp://117.50.0.88" "tcp://52.80.53.83" "udp://52.80.53.83" "tcp://52.80.59.89" "udp://52.80.59.89" "tcp://113.31.119.88" "udp://113.31.119.88" "tcp://52.81.114.158" "udp://52.81.114.158" "tcp://42.240.136.88" "udp://42.240.136.88" "tcp://2400:7fc0:849e:200:62fd:1de3:1c90:1" "udp://2400:7fc0:849e:200:62fd:1de3:1c90:1" "tcp://22400:7fc0:849e:200:62fd:1de3:1c90:2" "udp://22400:7fc0:849e:200:62fd:1de3:1c90:2"
    )
    local adgh_foreign_dns=(
        "https://firefox.dns.nextdns.io/dns-query" "h3://firefox.dns.nextdns.io/dns-query" "https://anycast.dns.nextdns.io/dns-query" "h3://anycast.dns.nextdns.io/dns-query" "https://doh3.dns.nextdns.io/dns-query" "h3://doh3.dns.nextdns.io/dns-query" "https://dns.nextdns.io/dns-query" "h3://dns.nextdns.io/dns-query" "https://dns-unfiltered.adguard.com/dns-query" "h3://dns-unfiltered.adguard.com/dns-query" "https://unfiltered.adguard-dns.com/dns-query" "h3://unfiltered.adguard-dns.com/dns-query" "https://dns.google/dns-query" "h3://dns.google/dns-query" "https://dns.google.com/dns-query" "h3://dns.google.com/dns-query" "https://e5aehtlc5e.cloudflare-dns.com/dns-query" "h3://e5aehtlc5e.cloudflare-dns.com/dns-query" "https://sepfvn6g5a.cloudflare-dns.com/dns-query" "h3://sepfvn6g5a.cloudflare-dns.com/dns-query" "https://1dot1dot1dot1.cloudflare-dns.com/dns-query" "h3://1dot1dot1dot1.cloudflare-dns.com/dns-query" "https://mozilla.cloudflare-dns.com/dns-query" "h3://mozilla.cloudflare-dns.com/dns-query" "https://chrome.cloudflare-dns.com/dns-query" "h3://chrome.cloudflare-dns.com/dns-query" "https://dns.cloudflare-dns.com/dns-query" "h3://dns.cloudflare-dns.com/dns-query" "tls://dns.google:853" "quic://dns.google:853" "tls://dns.google.com:853" "quic://dns.google.com:853" "tls://dns.adguard.com:853" "quic://dns.adguard.com:853" "tls://dns-unfiltered.adguard.com:853" "quic://dns-unfiltered.adguard.com:853" "tls://unfiltered.adguard-dns.com:853" "quic://unfiltered.adguard-dns.com:853" "tls://anycast.dns.nextdns.io:853" "quic://anycast.dns.nextdns.io:853" "tls://dns.nextdns.io:853" "quic://dns.nextdns.io:853" "tls://doh3.dns.nextdns.io:853" "quic://doh3.dns.nextdns.io:853" "https://77.88.8.8:443/dns-query" "https://doh.opendns.com/dns-query" "https://dns12.quad9.net/dns-query" "https://dns.twnic.tw/dns-query" "tls://dns.twnic.tw:853" "tls://common.dot.dns.yandex.net:853" "tls://1dot1dot1dot1.cloudflare-dns.com:853" "tls://dns12.quad9.net:853"
    )
    local bind9_domestic_addrs=(
        "119.29.29.29 port 53" "223.5.5.5 port 53" "223.6.6.6 port 53" "101.226.4.6 port 53" "123.125.81.6 port 53" "114.114.114.114 port 53" "114.114.115.115 port 53" "117.50.11.11 port 53" "52.80.66.66 port 53"
    )
    local bind9_foreign_addrs=(
        "208.67.222.222 port 53" "8.8.4.4 port 53" "8.8.8.8 port 53" "1.1.1.1 port 53" "1.0.0.1 port 53" "9.9.9.10 port 53" "94.140.14.140 port 53" "94.140.14.141 port 53" "74.82.42.42 port 53" "185.222.222.222 port 53"
    )
    local dnsmasq_domestic_addrs=(
        "119.29.29.29#53" "223.5.5.5#53" "223.6.6.6#53" "101.226.4.6#53" "123.125.81.6#53" "114.114.114.114#53" "114.114.115.115#53" "117.50.10.10#53" "52.80.52.52#53"
    )
    local dnsmasq_foreign_addrs=(
        "208.67.222.222#53" "8.8.4.4#53" "8.8.8.8#53" "1.1.1.1#53" "1.0.0.1#53" "9.9.9.10#53" "94.140.14.140#53" "94.140.14.141#53" "74.82.42.42#53" "185.222.222.222#53"
    )
     local unbound_domestic_addrs=(
        "223.5.5.5@853" "223.6.6.6@853" "2400:3200::1@853" "2400:3200:baba::1@853" "1.12.12.12@853" "120.53.53.53@853" "119.29.29.29@53" "2402:4e00::@53" "114.114.114.114@53" "114.114.115.115@53" "117.50.10.10@53" "52.80.52.52@53" "2400:7fc0:849e:200::8@53" "2404:c2c0:85d8:901::8@53"
    )
    local unbound_foreign_addrs=(
        "8.8.4.4@853" "8.8.8.8@853" "2001:4860:4860::8888@853" "2001:4860:4860::8844@853" "1.1.1.1@853" "1.0.0.1@853" "2606:4700:4700::1111@853" "2606:4700:4700::1001@853" "9.9.9.12@853" "149.112.112.12@853" "2620:fe::12@853" "2620:fe::fe:12@853" "94.140.14.140@853" "94.140.14.141@853" "2a10:50c0::1:ff@853" "2a10:50c0::2:ff@853" "209.244.0.3@53" "209.244.0.4@53" "4.2.2.1@53" "4.2.2.2@53" "4.2.2.3@53" "4.2.2.4@53" "4.2.2.5@53" "4.2.2.6@53"
    )


    case ${software_name} in
        adguardhome|adguardhome_new)
            FileName # Sets file_path and clears the file

            # AdGuard Home format: [/domain1/domain2/...]upstream
            echo -n "[/" >> "${file_path}"

            # Read domains line by line and append with /
            local domain_count=0
            while IFS= read -r domain; do
                 # Basic domain validation
                if [[ -n "$domain" ]] && [[ "$domain" =~ ^[a-zA-Z0-9][a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
                    echo -n "${domain}/" >> "${file_path}"
                    domain_count=$((domain_count + 1))
                fi
            done < "${source_file}"

            # Add the footer based on dns_mode
            if [ "${dns_mode}" == "default" ]; then
                echo "]#" >> "${file_path}"
            elif [ "${dns_mode}" == "domestic" ]; then
                # Use all domestic DNS servers for the footer, comma-separated
                local upstreams=""
                for dns in "${adgh_domestic_dns[@]}"; do
                    upstreams+="${dns},"
                done
                upstreams="${upstreams%,}" # Remove trailing comma
                echo "]${upstreams}" >> "${file_path}"
            elif [ "${dns_mode}" == "foreign" ]; then
                # Use all foreign DNS servers for the footer, comma-separated
                local upstreams=""
                for dns in "${adgh_foreign_dns[@]}"; do
                    upstreams+="${dns},"
                done
                upstreams="${upstreams%,}" # Remove trailing comma
                echo "]${upstreams}" >> "${file_path}"
            fi
            echo "Generated ${file_path} with ${domain_count} domains."
        ;;
        bind9)
            FileName # Sets file_path and clears the file

            local bind9_forwarders=""
            if [ "${generate_file}" == "black" ]; then
                 bind9_forwarders=("${bind9_foreign_addrs[@]}")
            elif [ "${generate_file}" == "white" ]; then
                 bind9_forwarders=("${bind9_domestic_addrs[@]}")
            fi

            local forwarders_string=""
            for dns in "${bind9_forwarders[@]}"; do
                forwarders_string+="${dns}; "
            done
            forwarders_string="${forwarders_string%; }" # Remove trailing space and semicolon

            # Read domains line by line from source_file
            local domain_count=0
            while IFS= read -r domain; do
                # Validate domain format for Bind9
                if [[ -n "$domain" ]] && [[ "$domain" =~ ^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\.[a-zA-Z]{2,}$ ]] && [[ ! "$domain" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                    echo "zone \"${domain}.\" {type forward; forwarders { ${forwarders_string} }; };" >> "${file_path}"
                    domain_count=$((domain_count + 1))
                fi
            done < "${source_file}"
            echo "Generated ${file_path} with ${domain_count} domains."
        ;;
        dnsmasq)
            FileName # Sets file_path and clears the file

            local dnsmasq_servers=()
            if [ "${generate_file}" == "black" ]; then
                 dnsmasq_servers=("${dnsmasq_foreign_addrs[@]}")
            elif [ "${generate_file}" == "white" ]; then
                 dnsmasq_servers=("${dnsmasq_domestic_addrs[@]}")
            fi

            # Read domains line by line from source_file
            local domain_count=0
            while IFS= read -r domain; do
                # Validate domain format for DNSMasq
                 if [[ -n "$domain" ]] && [[ "$domain" =~ ^[a-zA-Z0-9][a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]] && [[ ! "$domain" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] && [[ ! "$domain" =~ [\/\|\$#@\!\%\^\&\*\(\)\+\=\{\}\[\]\:\"\'\<\>\?\~\`] ]]; then
                    for dns in "${dnsmasq_servers[@]}"; do
                        echo "server=/${domain}/${dns}" >> "${file_path}"
                    done
                    domain_count=$((domain_count + 1))
                fi
            done < "${source_file}"
            echo "Generated ${file_path} with ${domain_count} domains."
        ;;
        domain)
            FileName # Sets file_path and clears the file
            # Domain format is just a list of domains, copy directly
            local domain_count=$(wc -l < "${source_file}")
            cat "${source_file}" >> "${file_path}"
            echo "Generated ${file_path} with ${domain_count} domains."
        ;;
        smartdns)
            FileName # Sets file_path and clears the file

            local smartdns_group=""
            if [ "${generate_file}" == "black" ]; then
                 smartdns_group="foreign"
            elif [ "${generate_file}" == "white" ]; then
                 smartdns_group="domestic"
            fi

            # Read domains line by line from source_file
            local domain_count=0
            while IFS= read -r domain; do
                 # SmartDNS format is nameserver /domain/group
                 # Validate domain format for SmartDNS
                if [[ -n "$domain" ]] && [[ "$domain" =~ ^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\.[a-zA-Z]{2,}$ ]] && [[ ! "$domain" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] && [[ "${#domain}" -le 253 ]] && [[ ! "$domain" =~ ^[0-9]+$ ]]; then
                    echo "nameserver /${domain}/${smartdns_group}" >> "${file_path}"
                    domain_count=$((domain_count + 1))
                fi
            done < "${source_file}"
            echo "Generated ${file_path} with ${domain_count} domains."
        ;;
        unbound)
            FileName # Sets file_path and clears the file

            local unbound_addrs=()
            if [ "${generate_file}" == "black" ]; then
                 unbound_addrs=("${unbound_foreign_addrs[@]}")
            elif [ "${generate_file}" == "white" ]; then
                 unbound_addrs=("${unbound_domestic_addrs[@]}")
            fi

            local forward_addrs_string=""
            for dns in "${unbound_addrs[@]}"; do
                forward_addrs_string+="    forward-addr: ${dns}\n"
            done
            # Remove trailing newline
            forward_addrs_string="${forward_addrs_string%\\n}"

            # Read domains line by line from source_file
            local domain_count=0
            while IFS= read -r domain; do
                # Validate domain format for Unbound
                if [[ -n "$domain" ]] && [[ "$domain" =~ ^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\.[a-zA-Z]{2,}$ ]] && [[ ! "$domain" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] && [[ "${#domain}" -le 253 ]] && [[ ! "$domain" =~ [\/\|\$#@\!\%\^\&\*\(\)\+\=\{\}\[\]\:\"\'\<\>\?\~\`] ]]; then
                    echo "forward-zone:" >> "${file_path}"
                    echo "    name: \"${domain}.\"" >> "${file_path}" # Unbound name needs quotes and trailing dot
                    echo -e "${forward_addrs_string}" >> "${file_path}"
                    echo "    forward-first: yes" >> "${file_path}"
                    echo "    forward-no-cache: yes" >> "${file_path}"
                    echo "    forward-ssl-upstream: yes" >> "${file_path}" # Using 'yes' directly as per original intent
                    echo "    forward-tls-upstream: yes" >> "${file_path}" # Using 'yes' directly as per original intent
                    echo "" >> "${file_path}" # Add a blank line for readability
                    domain_count=$((domain_count + 1))
                fi
            done < "${source_file}"
            echo "Generated ${file_path} with ${domain_count} domains."
        ;;
        ikuai)
            FileName # Sets file_path and clears the file

            echo "[GLOBAL_BYPASS_ROUTE]" > "${file_path}"
            echo "# Generated for iKuai ${generate_mode} ${generate_file}list" >> "${file_path}" # More specific comment

            # Read domains line by line from source_file
            local domain_count=0
            while IFS= read -r domain; do
                 # iKuai format is bypass_route_domain=domain
                 # Validate domain format for iKuai
                if [[ -n "$domain" ]] && [[ "$domain" =~ ^[a-zA-Z0-9][a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
                    echo "bypass_route_domain=${domain}" >> "${file_path}"
                    domain_count=$((domain_count + 1))
                fi
            done < "${source_file}"
            echo "Generated ${file_path} with ${domain_count} domains."
        ;;

        *)
            echo "Error: Unknown software type: ${software_name}"
            return 1
    esac
    echo "=== Rules Generation Completed for ${software_name} (${generate_file}, ${generate_mode}, ${dns_mode}) ==="
}
# Output Data
function OutputData() {
    echo "=== 开始输出规则 ==="
    echo "正在为所有DNS软件类型生成规则..."

    # 预先创建所有输出目录，避免并发时目录不存在
    for type in adguardhome adguardhome_new bind9 unbound dnsmasq domain smartdns ikuai; do
        mkdir -p "./gfwlist2${type}"
    done

    # List all combinations to generate
    # Note: AGH/AGH_new/Unbound/SmartDNS now generate one file per (file_type, mode, dns_mode) combination
    local combinations=(
        "adguardhome black full_combine default"
        "adguardhome black lite_combine default"
        "adguardhome white full_combine default"
        "adguardhome white lite_combine default"
        "adguardhome black full domestic" # Simplified AGH domestic/foreign
        "adguardhome black lite domestic"
        "adguardhome white full foreign"
        "adguardhome white lite foreign"

        "adguardhome_new black full_combine default"
        "adguardhome_new black lite_combine default"
        "adguardhome_new white full_combine default"
        "adguardhome_new white lite_combine default"
        "adguardhome_new black full domestic" # Simplified AGH_new domestic/foreign
        "adguardhome_new black lite domestic"
        "adguardhome_new white full foreign"
        "adguardhome_new white lite foreign"

        "bind9 black full default" # Added default dns_mode for consistency, though not used in Bind9 logic
        "bind9 black lite default"
        "bind9 white full default"
        "bind9 white lite default"

        "dnsmasq black full default" # Added default dns_mode
        "dnsmasq black lite default"
        "dnsmasq white full default"
        "dnsmasq white lite default"

        "domain black full default" # Added default dns_mode
        "domain black lite default"
        "domain white full default"
        "domain white lite default"

        "smartdns black full foreign" # SmartDNS uses dns_mode for group name
        "smartdns black lite foreign"
        "smartdns white full domestic"
        "smartdns white lite domestic"

        "unbound black full foreign"
        "unbound black lite foreign"
        "unbound white full domestic"
        "unbound white lite domestic"

        "ikuai black full default" # Added default dns_mode
        "ikuai black lite default"
        "ikuai white full default"
        "ikuai white lite default"
    )

    local total_generations=${#combinations[@]}
    local current_generation=0

    for combo in "${combinations[@]}"; do
        read -r software_name generate_file generate_mode dns_mode <<< "$combo"
        current_generation=$((current_generation + 1))
        echo "Generating: ${software_name} ${generate_file} ${generate_mode} ${dns_mode} (${current_generation}/${total_generations})"
        # Pass parameters to GenerateRules
        GenerateRules "$software_name" "$generate_file" "$generate_mode" "$dns_mode"
        # Update progress bar after each generation
        PrettyProgressBar $current_generation $total_generations "生成规则" "生成中" "${software_name} ${generate_file} ${generate_mode}"
    done

    echo -e "\n正在清理临时目录..."
    cd .. && rm -rf ./Temp
    echo "=== 规则输出完成 ==="
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

    # 检查源文件目录是否存在并移动文件
    local missing_dirs=0
    for type in adguardhome adguardhome_new bind9 unbound dnsmasq domain smartdns ikuai; do
        local src_dir="./gfwlist2${type}"
        if [ ! -d "${src_dir}" ]; then
            echo "Warning: Source directory not found: ${src_dir}"
            missing_dirs=$((missing_dirs + 1))
            continue
        fi

        echo "Processing ${type} files from ${src_dir}..."
        local files_copied=0

        # Use find to get files and mv them
        find "${src_dir}" -type f \( -name "*.txt" -o -name "*.conf" \) -print0 | while IFS= read -r -d '' file; do
             # Construct new filename: dnshosts-all-softwaretype-originalfilename
            local original_filename=$(basename "${file}")
            local new_filename="dnshosts-all-${type}-${original_filename}"
            echo "Moving ${file} to ${dest}/${new_filename}"
            if mv "${file}" "${dest}/${new_filename}"; then
                files_copied=$((files_copied + 1))
            else
                echo "Error moving ${file}"
            fi
        done

        echo "Moved ${files_copied} files for ${type}"

        # 清理源目录 (只有在成功移动文件后才清理)
        if [ ${files_copied} -gt 0 ]; then
            # Check if directory is empty before removing
            if [ -z "$(ls -A "${src_dir}")" ]; then
                rm -rf "${src_dir}" && echo "Cleaned up ${src_dir}"
            else
                 echo "Warning: ${src_dir} is not empty after moving files, skipping cleanup."
            fi
        fi
    done

    # Verify results
    echo "Verifying generated files in ${dest}:"
    if ! find "${dest}" -maxdepth 1 -type f -ls; then # Limit depth to avoid listing files in subdirs if any
        echo "Warning: No files found in destination directory"
    fi

    # Report overall status
    if [ ${missing_dirs} -gt 0 ]; then
        echo "Warning: ${missing_dirs} source directories were missing"
    else
        echo "All source directories were processed successfully"
    fi

    # === 新增：对每个文件单独并行压缩（不归档） ===
    echo "Compressing each generated file in ${dest} (parallel, no archive)..."
    local compress_cmd=""
    local ext=""
    if command -v pigz >/dev/null 2>&1; then
        compress_cmd="pigz -k -f"
        ext="gz"
    elif command -v lzop >/dev/null 2>&1; then
        compress_cmd="lzop -f -k"
        ext="lzo"
    elif command -v zstd >/dev/null 2>&1; then
        compress_cmd="zstd -T0 -f -k"
        ext="zst"
    elif command -v gzip >/dev/null 2>&1; then
        compress_cmd="gzip -k -f"
        ext="gz"
    else
        echo "No fast compression tool found (pigz, lzop, zstd, gzip), skipping compression."
        return
    fi

    local pids=()
    # Find files that are not already compressed with the chosen extension
    find "${dest}" -maxdepth 1 -type f ! -name "*.${ext}" -print0 | while IFS= read -r -d '' f; do
        # Check if the file exists (find might return deleted files)
        [ -f "$f" ] || continue
        echo "Compressing $f ..."
        # Run compression in background
        ($compress_cmd "$f" && echo "Compressed: $f -> $f.$ext" && du -h "$f.$ext") &
        pids+=($!) # Collect PID
    done

    local total_attempted=${#pids[@]} # Count based on collected PIDs

    # 等待所有压缩任务完成
    local completed_count=0
    for pid in "${pids[@]}"; do
        wait "$pid"
        completed_count=$((completed_count+1))
        # Optional: Update a simple progress for compression
        # echo -n "Compression progress: ${completed_count}/${total_attempted} files done." $'\r'
    done
    # echo "" # Newline after compression progress

    echo "Compression completed, total files attempted: $total_attempted, completed: $completed_count"
}

function PrettyProgressBar() {
    local current=$1
    local total=$2
    local message="${3:-}"
    local status="${4:-}"
    local extra_info="${5:-}" # Added extra info parameter
    local width=48
    local percent=$((current * 100 / total))
    local progress=$((current * width / total))
    local bar=""
    # 判断是否禁用颜色
    local use_color=1
    # --- 新增: 检测WSL环境自动禁用颜色 ---
    if grep -qi microsoft /proc/version 2>/dev/null || [ -n "$WSLENV" ]; then
        NO_COLOR=1
    fi
    if [ -n "$NO_COLOR" ]; then
        use_color=0
    fi

    # 颜色定义
    local green="\033[0;32m"
    local yellow="\033[1;33m"
    local blue="\033[1;34m"
    local magenta="\033[1;35m"
    local cyan="\033[1;36m"
    local reset="\033[0m"
    if [ $use_color -eq 0 ]; then
        green=""
        yellow=""
        blue=""
        magenta=""
        cyan=""
        reset=""
    fi

    # 兼容WSL/终端，使用#代替█
    local bar_char="#"

    for ((i=0; i<width; i++)); do
        if [ $i -lt $progress ]; then
            bar="${bar}${green}${bar_char}${reset}"
        else
            bar="${bar} "
        fi
    done

    # 状态颜色
    local status_color="$cyan"
    if [[ "$status" == "完成" || "$status" == "Done" ]]; then
        status_color="$green"
    elif [[ "$status" == "失败" || "$status" == "Fail" ]]; then
        status_color="$yellow"
    elif [[ "$status" == "下载中" || "$status" == "Downloading" ]]; then
        status_color="$blue"
    elif [[ "$status" == "分析中" || "$status" == "Analyzing" ]]; then
        status_color="$magenta"
    elif [[ "$status" == "生成中" || "$status" == "Generating" ]]; then
        status_color="$yellow"
    elif [[ "$status" == "移动中" || "$status" == "Moving" ]]; then
        status_color="$cyan"
    fi


    # 清空当前行再输出进度条，避免残留
    printf "\r\033[K"
    printf "${blue}[%s]${reset} %3d%% (%d/%d) ${status_color}%s${reset} %s %s" "$bar" "$percent" "$current" "$total" "$status" "$message" "$extra_info"

    # 完成时换行
    if [ "$current" -eq "$total" ]; then
        printf "\n"
    fi
}

## Process
echo "=== Starting DNS List Generation Process ==="
total_main_steps=4
current_main_step=0

echo "Step 1: Getting Data..."
current_main_step=$((current_main_step + 1))
step1_start=$(date +%s)
GetData
record_step_time "获取数据" $step1_start
PrettyProgressBar $current_main_step $total_main_steps "获取数据" "下载中"
print_step_time "获取数据"
echo "Data retrieval completed."

echo "Step 2: Analyzing Data..."
current_main_step=$((current_main_step + 1))
step2_start=$(date +%s)
AnalyseData
record_step_time "分析数据" $step2_start
PrettyProgressBar $current_main_step $total_main_steps "分析数据" "分析中"
print_step_time "分析数据"
echo "Data analysis completed."

echo "Step 3: Generating Rules..."
current_main_step=$((current_main_step +  1))
step3_start=$(date +%s)
# OutputData now manages its own progress bar
OutputData
record_step_time "生成规则" $step3_start
# PrettyProgressBar for step 3 is handled inside OutputData
print_step_time "生成规则"
echo "Rules generation completed."

echo "Step 4: Moving Generated Files..."
current_main_step=$((current_main_step + 1))
step4_start=$(date +%s)
# MoveGeneratedFiles now includes compression and manages its own progress/output
MoveGeneratedFiles
record_step_time "移动文件" $step4_start
# PrettyProgressBar for step 4 is handled inside MoveGeneratedFiles (or simplified)
print_step_time "移动文件"
echo -e "\nFile movement and compression completed."

# 显示总耗时
echo "=== Process Completed Successfully ==="
echo "总耗时: $(time_taken $START_TIME)"