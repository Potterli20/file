#!/usr/bin/env bash
# =============================================================================
# pac.sh - 多格式PAC列表生成脚本
# =============================================================================
# 功能描述：生成多种代理工具的PAC列表
# 支持格式：AutoProxy、Clash、Clash Premium、Shadowrocket、Surge、Quantumult、v2rayA、v2rayN
# 输出文件：listpac_{china|gfwlist}_{format}.{ext}
# 依赖：wget/curl、sed、grep、sort、awk、base64、mktemp
# 用法：bash pac.sh
# =============================================================================

set -euo pipefail

# 引入公共工具库
source "$(dirname "$0")/common_utils.sh"

# ==================== 配置区域 ====================

# 数据源URL配置
china_domain_urls=(
    "https://github.com/Potterli20/file/releases/download/dns-hosts-adgh-pro/dnshosts-adgh-pro-adguardhome-blacklist_full_combine.txt"
)
gfwlist_domain_urls=(
    "https://github.com/Potterli20/file/releases/download/dns-hosts-adgh-pro/dnshosts-adgh-pro-adguardhome-whitelist_full_combine.txt"
)

# 元数据配置
listpac_homepage="https://file.trli.club:2083/pac/"
listpac_expires="24 hours (update frequency)"

# 代理工具格式配置（格式名 => "扩展名|首行内容"）
# 首行内容为空表示无特殊首行
declare -A proxy_formats=(
    ["autoproxy"]="txt|[AutoProxy 0.2.9]"
    ["clash"]="yaml|payload:"
    ["clash_premium"]="yaml|payload:"
    ["shadowrocket"]="conf|#"
    ["surge"]="yaml|#"
    ["quantumult"]="yaml|#"
    ["v2raya"]="txt|#"
    ["v2rayn"]="txt|#"
)

# Shadowrocket [General] 配置
shadowrocket_general_config=(
    "bypass-system = true"
    "bypass-tun = 10.0.0.0/8, 127.0.0.0/8, 169.254.0.0/16, 172.16.0.0/12, 192.0.0.0/24, 192.0.2.0/24, 192.88.99.0/24, 192.168.0.0/16, 198.18.0.0/15, 198.51.100.0/24, 203.0.113.0/24, 224.0.0.0/4, 240.0.0.0/4, 255.255.255.255/32"
    "dns-server = https://dns.alidns.com/dns-query, https://dns.google/dns-query, https://doh.pub/dns-query,https://1dot1dot1dot1.cloudflare-dns.com/dns-query, https://doh.opendns.com/dns-query, https://odoh.cloudflare-dns.com/dns-query, https://doh.dns.sb/dns-query, https://dns-unfiltered.adguard.com/dns-query,"
    "ipv6 = true"
    "skip-proxy = 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, localhost, *.local"
)

# Shadowrocket URL Rewrite 规则
shadowrocket_rewrite_rules=(
    "DOMAIN-SET,https://file.trli.club:2083/ad-hosts/ad-hosts-pro/ad-shadowrocket.list"
    "[URL Rewrite]"
    "#all"
    "^https?:\/\/(\w+\.)?(adclick|ads([0-9]+)?|adx|adserver|adformat|analysis|analytics|banners?|click|counter|delivery|log|log-?\w+?|pagead|stat|stats|statis|trace|track|tracking|uniad)\.\w+\.(com|cn|org|info|io|net|vn|com.vn)"
    "#facebook"
    "^https?://graph.facebook.com/.+activities"
    "^https?://graph.facebook.com/.+advertiser_id="
    "^https?://graph.facebook.com/.+events"
    "^https?://graph.facebook.com/.+skadnetwork"
    "^https?://graph.facebook.com/network_ads_common"
    "^https?:\/\/.+\.facebook\.com\/adnw_logging"
    "^https?:\/\/.+\.facebook\.com\/adnw_sync"
    "^https?:\/\/connect\.facebook\.net\/en_US\/fbadnw\.js _ REJECT"
    "#nhaccuatui"
    "^https?://graph.nhaccuatui.com/.+ads"
    "^https?://graph.nhaccuatui.com/.+logs"
    "^https?://graph.nhaccuatui.com/.+deviceinfo"
    "#spotify"
    "^https?://spclient.wg.spotify.com/ad-logic"
    "^https?://spclient.wg.spotify.com/ads"
    "^https?://spclient.wg.spotify.com/.+ad_slot"
    "^https?://spclient.wg.spotify.com/.+banners"
    "^https?://spclient.wg.spotify.com/.+crashlytics"
    "^https?://spclient.wg.spotify.com/.+doubleclick"
    "^https?://spclient.wg.spotify.com/.+enabled-tracks"
    "^https?://spclient.wg.spotify.com/.+event"
    "^https?://spclient.wg.spotify.com/.+promoted"
    "^https?://spclient.wg.spotify.com/.+sponsored"
    "#google"
    "#^https?:\/\/.+\.googlevideo\.com\/.+ctier"
    "^https?:\/\/.+\.googlevideo\.com\/.+oad="
    "^https?:\/\/.+\.googlevideo\.com\/.+owc="
    "^https?:\/\/.+\.googlevideo\.com\/ptracking"
    "^https?:\/\/.+\.googlevideo\.com\/videogoodput"
    "^https?:\/\/[\s\S]*\.googlevideo\.com\/.+&(oad|ctier) _ REJECT"
    "^https?:\/\/.+\.youtube\.com\/.+adformat"
    "^https?:\/\/.+\.youtube\.com\/.+get_ads"
    "^https?:\/\/.+\.youtube\.com\/api\/stats\/ads"
    "^https?:\/\/.+\.youtube\.com\/api\/stats\/atr"
    "^https?:\/\/.+\.youtube\.com\/api\/stats\/qoe"
    "^https?:\/\/.+\.youtube\.com\/csi_204"
    "^https?:\/\/.+\.youtube\.com\/error_204"
    "^https?:\/\/.+\.youtube\.com\/gen_204"
    "^https?:\/\/.+\.youtube\.com\/generate_204"
    "^https?:\/\/.+\.youtube\.com\/get_midroll"
    "^https?:\/\/.+\.youtube\.com\/pagead"
    "^https?:\/\/.+\.youtube\.com\/pcs\/activeview"
    "^https?:\/\/.+\.youtube\.com\/ptracking"
    "^https?:\/\/.+\.googleapis.com/.+ad_break"
    "^https?:\/\/.+\.googleapis.com/.+log_event"
    "^https?:\/\/.+\.googleapis.com/adsmeasurement"
    "^https?:\/\/[\w-]+\.googlevideo\.com\/.+&(oad|ctier) _ REJECT"
    "^https?:\/\/(www|s)\.youtube\.com\/api\/stats\/ads _ REJECT"
    "^https?:\/\/(www|s)\.youtube\.com\/api\/stats\/qoe _ REJECT"
    "^https?:\/\/(www|s)\.youtube\.com\/(pagead|ptracking) _ REJECT"
    "^https?:\/\/\s.youtube.com/api/stats/qoe?.*adformat= _ REJECT"
    "^https?:\/\/.+\.googlesyndication\.com\/pagead\/ _ REJECT"
    "^https?:\/\/youtubei\.googleapis\.com\/youtubei\/v1\/att\/ _ REJECT"
    "^https?:\/\/youtubei\.googleapis\.com\/youtubei\/v1\/log_event\/ _ REJECT"
    "#tiktok"
    "^https?:\/\/.+\.tiktokv\.com\/.+stats"
    "^https?:\/\/.+\.tiktokv\.com\/api\/ad"
    "^https?:\/\/.+\.musical\.ly\/.+stats"
    "^https?:\/\/.+\.musical\.ly\/api\/ad"
    "^https?:\/\/.+\.snssdk\.com\/.+app_log"
    "^https?:\/\/.+\.snssdk\.com\/.+promotion"
    "^https?:\/\/.+\.snssdk\.com\/.+report"
    "^https?:\/\/.+\.snssdk\.com\/.+stats"
    "^https?:\/\/.+\.snssdk\.com\/api\/ad"
    "^https?:\/\/.+\.snssdk\.com\/monitor"
    "^https?:\/\/.+\.amemv\.com\/.+app_log"
    "^https?:\/\/.+\.amemv\.com\/.+report"
    "^https?:\/\/.+\.amemv\.com\/.+stats"
    "^https?:\/\/.+\.amemv\.com\/api\/ad"
    "^https?:\/\/.+?\.(musical|snssdk|tiktokv)\.(com|ly)\/(api|motor)\/ad\/ _ REJECT"
    "^https?:\/\/api\d?\.tiktokv\.com\/api\/ad\/ _ REJECT"
    "^https?:\/\/[\w-]+\.(amemv|musical|snssdk|tiktokv)\.(com|ly)\/(api|motor)\/ad\/ _ REJECT"
    "^https?:\/\/api\d?\.musical\.ly\/api\/ad\/ _ REJECT"
    "^https?:\/\/.+?\.(musical|snssdk)\.(com|ly)\/(api|motor)\/ad\/ _ REJECT"
    "^https?:\/\/.+?\.(snssdk|amemv)\.com\/api\/ad\/ _ REJECT"
    "^https?:\/\/frontier\.snssdk\.com\/ _ REJECT"
    "^https?:\/\/aweme\.snssdk\.com\/aweme\/v1\/aweme\/stats\/ _ REJECT"
    "^https?:\/\/aweme\.snssdk\.com\/aweme\/v1\/device\/update\/ _ REJECT"
    "^https?:\/\/aweme\.snssdk\.com\/aweme\/v1\/screen\/ad\/ _ REJECT"
    "^https?:\/\/aweme\.snssdk\.com\/service\/1\/app_logout\/ _ REJECT"
    "^https?:\/\/aweme\.snssdk\.com\/service\/2\/app_log _ REJECT"
    "^https?:\/\/[\w-]+\.snssdk\.com\/.+_ad\/ _ REJECT"
    "^https?:\/\/[\s\S]*\.snssdk\.com\/api\/ad\/ _ REJECT"
    "^https?:\/\/.+?\.snssdk\.com\/motor\/operation\/activity\/display\/config\/V2\/ _ REJECT"
    "# Redirect Google Search Service"
    "^https?:\/\/(www.)?(g|google)\.cn https://www.google.com 302"
    "# Redirect Google Maps Service"
    "^https?:\/\/(ditu|maps).google\.cn https://maps.google.com 302"
    "#taobao"
    "^https?:\/\/acs\.m\.taobao\.com\/gw\/mtop\.alibaba\.advertisementservice\.getadv _ REJECT"
    "^https?:\/\/acs\.m\.taobao\.com\/gw\/mtop\.alimusic\.common\.mobileservice\.startinit\/ _ REJECT"
    "^https?:\/\/acs\.m\.taobao\.com\/gw\/mtop\.film\.mtopadvertiseapi\.queryadvertise\/ _ REJECT"
    "^https?:\/\/acs\.m\.taobao\.com\/gw\/mtop\.o2o\.ad\.gateway\.get\/ _ REJECT"
    "^https?:\/\/acs\.m\.taobao\.com\/gw\/mtop\.taobao\.idle\.home\.welcome\/ _ REJECT"
    "^https?:\/\/acs\.m\.taobao\.com\/gw\/mtop\.trip\.activity\.querytmsresources\/ _ REJECT"
    "#jd"
    "^https?:\/\/(bdsp-x|dsp-x)\.jd\.com\/adx\/ _ REJECT"
    "^https?:\/\/(bdsp-x|dsp-x)\.jd\.com\/adx\/ _ REJECT"
    "^https?:\/\/api\.m\.jd\.com\/openUpgrade _ REJECT"
    "^https?:\/\/bdsp-x\.jd\.com\/adx\/ _ REJECT"
    "^https?:\/\/img\d+\.360buyimg\.com\/jddjadvertise\/ _ REJECT"
    "^https?:\/\/ms\.jr\.jd\.com\/gw\/generic\/aladdin\/(new)?na\/m\/getLoadingPicture _ REJECT"
    "^https?:\/\/ms\.jr\.jd\.com\/gw\/generic\/base\/(new)?na\/m\/adInfo _ REJECT"
    "# Redirect False to True"
    "# > IGN China to IGN Global"
    "^https?:\/\/(www.)?ign\.xn--fiqs8s\/ http://cn.ign.com/ccpref/us 302"
    "# AbeamTV _ api.abema.io"
    "^https?:\/\/api\.abema\.io\/v\d\/ip\/check _ REJECT"
    "# bilibili Intl"
    "(^https?:\/\/app\.biliintl\.com\/intl\/.+)(&s_locale=zh-Hans_[A-Z]{2})(.+) $1&s_locale=en-US_US$3 302"
    "(^https?:\/\/app\.biliintl\.com\/intl\/.+)(&sim_code=\d+)(.+) $1$3 302"
    "# AICoin"
    "^http:\/\/(www.)?aicoin\.cn\/$ https://www.aicoin.cn/?long_lives_aicoin=%22live%22 302"
    "# tiktokv"
    "(?<=_region=)CN(?=&) TW 307"
    "(?<=&mcc_mnc=)4 2 307"
    "^(https?:\/\/(tnc|dm)[\w-]+\.\w+\.com\/.+)(\?)(.+) $1$3 302"
    "(^https?:\/\/*\.\w{4}okv.com\/.+&.+)(\d{2}\.3\.\d)(.+) $118.0$3 302"
    "[MITM]"
    "enable = true"
    "hostname = *.tiktokv.com,*.byteoversea.com,*.tik-tokapi.com,*.googlevideo.com,app.biliintl.com,www.cocomanhua.com,www.ohmanhua.com,*.tiktokcdn.com,*.ipstatp.com,*.snapkit.com,*.appsflyer.com,*.googleapis.com,raph.nhaccuatui.com, spclient.wg.spotify.com,*.youtube.com,*.youtu.be,*googleapis.com"
)

# ==================== 配置结束 ====================

# =============================================================================
# 数据获取与分析
# =============================================================================

# 下载数据源文件
# 参数: $1 - 输出目录路径
get_data() {
    local output_dir="$1"
    local china_file="$output_dir/china_domain.tmp"
    local gfwlist_file="$output_dir/gfwlist_domain.tmp"

    log_info "开始下载数据源..."
    if ! download_url "${china_domain_urls[0]}" "$china_file"; then
        log_error "下载china_domain数据失败"
        exit 1
    fi
    if ! download_url "${gfwlist_domain_urls[0]}" "$gfwlist_file"; then
        log_error "下载gfwlist_domain数据失败"
        exit 1
    fi
    log_info "数据源下载完成"
}

# 分析数据，提取域名列表
# 参数: $1 - 输入目录路径
# 输出: 填充 china_data 和 gfwlist_data 数组
analyse_data() {
    local input_dir="$1"
    local china_file="$input_dir/china_domain.tmp"
    local gfwlist_file="$input_dir/gfwlist_domain.tmp"

    log_info "分析数据..."

    if [ ! -s "$china_file" ]; then
        log_warn "china_domain数据文件为空"
    fi
    if [ ! -s "$gfwlist_file" ]; then
        log_warn "gfwlist_domain数据文件为空"
    fi

    china_data=($(cat "$china_file" | sed "1,15d;s/\[\///g;s/\/\]//g;s/\//\n/g" | sed 's/[ ]*//g' | sed '/^$/d' | sort | uniq | awk "{ print $2 }"))
    gfwlist_data=($(cat "$gfwlist_file" | sed "1,25d;s/\[\///g;s/\/\]//g;s/\//\n/g" | sed 's/[ ]*//g' | sed '/^$/d' | sort | uniq | awk "{ print $2 }"))

    log_info "数据分析完成: china=${#china_data[@]} domains, gfwlist=${#gfwlist_data[@]} domains"
}

# =============================================================================
# 格式生成函数
# =============================================================================

# 生成头部信息
# 参数: $1 - 格式名, $2 - 列表类型(china/gfwlist), $3 - 输出目录
generate_header() {
    local format="$1"
    local list_type="$2"
    local output_dir="$3"
    local ext="${proxy_formats[$format]%%|*}"
    local first_line="${proxy_formats[$format]#*|}"
    local output_file="$output_dir/listpac_${list_type}_${format}.${ext}"

    # 计算元数据
    local checksum title time_updated
    checksum=$(TZ=UTC-8 date "+%s" | base64)
    if [ "$list_type" == "china" ]; then
        title="Trli's ChinaList"
    elif [ "$list_type" == "gfwlist" ]; then
        title="Trli's GFWList"
    else
        log_error "无效的列表类型: $list_type"
        exit 1
    fi
    time_updated=$(TZ=UTC-8 date -d @$(echo "${checksum}" | base64 -d) "+%Y-%m-%dT%H:%M:%S%:z")

    # 写入头部（根据格式差异）
    case "$format" in
        autoproxy)
            echo "$first_line" > "$output_file"
            echo "! Checksum: ${checksum}" >> "$output_file"
            echo "! Title: ${title} for Auto Proxy" >> "$output_file"
            echo "! TimeUpdated: ${time_updated}" >> "$output_file"
            echo "! Expires: ${listpac_expires}" >> "$output_file"
            echo "! Homepage: ${listpac_homepage}" >> "$output_file"
            ;;
        clash)
            echo "$first_line" > "$output_file"
            echo "# Checksum: ${checksum}" >> "$output_file"
            echo "# Title: ${title} for Clash" >> "$output_file"
            echo "# TimeUpdated: ${time_updated}" >> "$output_file"
            echo "# Expires: ${listpac_expires}" >> "$output_file"
            echo "# Homepage: ${listpac_homepage}" >> "$output_file"
            ;;
        clash_premium)
            echo "$first_line" > "$output_file"
            echo "# Checksum: ${checksum}" >> "$output_file"
            echo "# Title: ${title} for Clash Premium" >> "$output_file"
            echo "# TimeUpdated: ${time_updated}" >> "$output_file"
            echo "# Expires: ${listpac_expires}" >> "$output_file"
            echo "# Homepage: ${listpac_homepage}" >> "$output_file"
            ;;
        shadowrocket)
            echo "# Checksum: ${checksum}" > "$output_file"
            echo "# Title: ${title} for Shadowrocket" >> "$output_file"
            echo "# TimeUpdated: ${time_updated}" >> "$output_file"
            echo "# Expires: ${listpac_expires}" >> "$output_file"
            echo "# Homepage: ${listpac_homepage}" >> "$output_file"
            echo "[General]" >> "$output_file"
            local general_line
            for general_line in "${shadowrocket_general_config[@]}"; do
                echo "$general_line" >> "$output_file"
            done
            echo "[Rule]" >> "$output_file"
            ;;
        surge)
            echo "# Checksum: ${checksum}" > "$output_file"
            echo "# Title: ${title} for Surge" >> "$output_file"
            echo "# TimeUpdated: ${time_updated}" >> "$output_file"
            echo "# Expires: ${listpac_expires}" >> "$output_file"
            echo "# Homepage: ${listpac_homepage}" >> "$output_file"
            ;;
        quantumult)
            echo "# Checksum: ${checksum}" > "$output_file"
            echo "# Title: ${title} for Quantumult" >> "$output_file"
            echo "# TimeUpdated: ${time_updated}" >> "$output_file"
            echo "# Expires: ${listpac_expires}" >> "$output_file"
            echo "# Homepage: ${listpac_homepage}" >> "$output_file"
            ;;
        v2raya)
            echo "# Checksum: ${checksum}" > "$output_file"
            echo "# Title: ${title} for v2rayA" >> "$output_file"
            echo "# TimeUpdated: ${time_updated}" >> "$output_file"
            echo "# Expires: ${listpac_expires}" >> "$output_file"
            echo "# Homepage: ${listpac_homepage}" >> "$output_file"
            echo -n "domain(" >> "$output_file"
            ;;
        v2rayn)
            echo "# Checksum: ${checksum}" > "$output_file"
            echo "# Title: ${title} for v2rayN" >> "$output_file"
            echo "# TimeUpdated: ${time_updated}" >> "$output_file"
            echo "# Expires: ${listpac_expires}" >> "$output_file"
            echo "# Homepage: ${listpac_homepage}" >> "$output_file"
            ;;
    esac
}

# 生成体部（域名规则行）
# 参数: $1 - 格式名, $2 - 列表类型, $3 - 域名数组名, $4 - 输出目录
generate_body() {
    local format="$1"
    local list_type="$2"
    local -n domains=$3
    local output_dir="$4"
    local ext="${proxy_formats[$format]%%|*}"
    local output_file="$output_dir/listpac_${list_type}_${format}.${ext}"
    local domain

    for domain in "${domains[@]}"; do
        case "$format" in
            autoproxy)
                if [ "$list_type" == "china" ]; then
                    echo "@@||${domain}^" >> "$output_file"
                else
                    echo "||${domain}^" >> "$output_file"
                fi
                ;;
            clash)
                echo "  - DOMAIN-SUFFIX,${domain}" >> "$output_file"
                ;;
            clash_premium)
                echo "  - '+.${domain}'" >> "$output_file"
                ;;
            shadowrocket|surge|quantumult)
                if [ "$list_type" == "china" ]; then
                    echo "DOMAIN-SUFFIX,${domain},DIRECT" >> "$output_file"
                else
                    echo "DOMAIN-SUFFIX,${domain},PROXY" >> "$output_file"
                fi
                ;;
            v2raya)
                echo -n "domain:${domain}," >> "$output_file"
                ;;
            v2rayn)
                echo "domain:${domain}," >> "$output_file"
                ;;
        esac
    done
}

# 生成尾部信息
# 参数: $1 - 格式名, $2 - 列表类型, $3 - 输出目录
generate_footer() {
    local format="$1"
    local list_type="$2"
    local output_dir="$3"
    local ext="${proxy_formats[$format]%%|*}"
    local output_file="$output_dir/listpac_${list_type}_${format}.${ext}"

    case "$format" in
        shadowrocket)
            local rule
            for rule in "${shadowrocket_rewrite_rules[@]}"; do
                echo "$rule" >> "$output_file"
            done
            ;;
        v2raya)
            if [ "$list_type" == "china" ]; then
                echo -n ")->direct" >> "$output_file"
            else
                echo -n ")->proxy" >> "$output_file"
            fi
            sed -i 's/,)/)/g' "$output_file"
            ;;
    esac
}

# =============================================================================
# 编码与输出
# =============================================================================

# 对AutoProxy格式进行Base64编码
# 参数: $1 - 列表类型, $2 - 输出目录
encode_data() {
    local list_type="$1"
    local output_dir="$2"
    local output_file="$output_dir/listpac_${list_type}_autoproxy.txt"

    if [ -f "$output_file" ]; then
        cat "$output_file" | base64 > "${output_file}.base64"
        mv "${output_file}.base64" "$output_file"
        log_info "AutoProxy ${list_type} Base64编码完成"
    fi
}

# 为指定列表类型生成所有格式的PAC文件
# 参数: $1 - 列表类型(china/gfwlist), $2 - 域名数组名, $3 - 输出目录
output_data_for_type() {
    local list_type="$1"
    local -n domains=$2
    local output_dir="$3"
    local format

    log_info "开始生成 ${list_type} 列表..."

    for format in "${!proxy_formats[@]}"; do
        generate_header "$format" "$list_type" "$output_dir"
        generate_body "$format" "$list_type" "domains" "$output_dir"
        generate_footer "$format" "$list_type" "$output_dir"
        log_info "  ${format} 格式生成完成"
    done

    encode_data "$list_type" "$output_dir"
    log_info "${list_type} 列表生成完成"
}

# =============================================================================
# 主处理逻辑
# =============================================================================

main() {
    log_info "pac.sh 脚本启动"

    # 注册清理trap
    register_cleanup_trap

    # 创建临时工作目录
    local temp_dir
    create_temp_dir "pac_work"
    temp_dir="$_LAST_TEMP_RESULT"

    # 下载数据
    get_data "$temp_dir"

    # 分析数据
    analyse_data "$temp_dir"

    # 生成输出文件（输出到脚本所在目录）
    local script_dir
    script_dir="$(dirname "$0")"

    output_data_for_type "china" "china_data" "$script_dir"
    output_data_for_type "gfwlist" "gfwlist_data" "$script_dir"

    log_info "pac.sh 脚本执行完成"
}

main
