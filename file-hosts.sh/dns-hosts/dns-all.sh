#!/usr/bin/env bash
# =============================================================================
# dns-all.sh - DNS Hosts 规则生成脚本
# =============================================================================
# 参考: https://github.com/hezhijie0327/GFWList2AGH/blob/main/release.sh
# 用法: bash dns-all.sh
# 优化: 并行下载、严格模式、trap清理临时文件
# =============================================================================

set -uo pipefail

# ======================== 全局配置 ========================
declare -A CONFIG=(
    [TEMP_DIR]="./Temp"
    [MAX_RETRIES]=3
    [TIMEOUT]=15
    [PARALLEL_JOBS]=$(nproc 2>/dev/null || echo 4)
)

# ======================== 临时文件trap清理 ========================
_TEMP_FILES=()
_TEMP_DIRS=()

cleanup_temp() {
    local item
    for item in "${_TEMP_FILES[@]:-}"; do
        [ -n "$item" ] && rm -f "$item" 2>/dev/null || true
    done
    for item in "${_TEMP_DIRS[@]:-}"; do
        [ -n "$item" ] && rm -rf "$item" 2>/dev/null || true
    done
}

trap cleanup_temp EXIT INT TERM

# ======================== 时间统计 ========================
START_TIME=$(date +%s)
declare -A STEP_TIMES

time_taken() {
    local start_time=$1
    local duration=$(($(date +%s) - start_time))
    echo "$((duration / 60))分 $((duration % 60))秒"
}

record_step_time() {
    local step_name=$1 start_time=$2
    STEP_TIMES["$step_name"]=$(($(date +%s) - start_time))
}

print_step_time() {
    local step_name=$1
    local duration=${STEP_TIMES["$step_name"]}
    echo "步骤 '$step_name' 耗时: $((duration / 60))分 $((duration % 60))秒"
}

# ======================== 颜色与进度条 ========================
# 检测输出环境：非 TTY 时禁用颜色与回车动画，避免 ANSI 码乱码
IS_TTY=0
[ -t 1 ] && IS_TTY=1

NO_COLOR_FLAG=0
if [ $IS_TTY -eq 0 ] || grep -qi microsoft /proc/version 2>/dev/null || [ -n "$WSLENV" ] || [ -n "$NO_COLOR" ]; then
    NO_COLOR_FLAG=1
fi

PrettyProgressBar() {
    # 非 TTY 环境不输出动画进度条，避免 \r 和 ANSI 码乱码
    if [ $IS_TTY -eq 0 ]; then
        return
    fi
    local current=$1 total=$2 message="${3:-}" status="${4:-}" width=48
    local percent=$((current * 100 / total))
    local progress=$((current * width / total))
    local bar="" i

    local green="\033[0;32m" yellow="\033[1;33m" blue="\033[1;34m"
    local magenta="\033[1;35m" cyan="\033[1;36m" reset="\033[0m"
    if [ $NO_COLOR_FLAG -eq 1 ]; then
        green=""; yellow=""; blue=""; magenta=""; cyan=""; reset=""
    fi

    for ((i = 0; i < width; i++)); do
        [ $i -lt $progress ] && bar="${bar}${green}#${reset}" || bar="${bar} "
    done

    local status_color="$cyan"
    case "$status" in
        完成|Done) status_color="$green" ;;
        失败|Fail) status_color="$yellow" ;;
        下载中|Downloading) status_color="$blue" ;;
        分析中|Analyzing) status_color="$magenta" ;;
        生成中|Generating) status_color="$yellow" ;;
    esac

    printf "\r\033[K"
    printf "${blue}[%s]${reset} %3d%% (%d/%d) ${status_color}%s${reset} %s" \
        "$bar" "$percent" "$current" "$total" "$status" "$message"
    [ "$current" -eq "$total" ] && printf "\n"
}

# ======================== GitHub 代理与下载 ========================
# 直连失败时自动使用 gh-proxy 代理
convert_github_url() {
    local url="$1"
    if [[ "$url" != *"githubusercontent.com"* ]] && [[ "$url" != *"github.com"* ]]; then
        echo "$url"
        return
    fi
    if curl --connect-timeout 5 -s "https://github.com" > /dev/null 2>&1; then
        echo "$url"
    elif [[ "$url" == *"raw.githubusercontent.com"* ]]; then
        echo "https://gh-proxy.com/https://raw.githubusercontent.com${url#*raw.githubusercontent.com}"
    else
        echo "https://gh-proxy.com/https://github.com${url#*github.com}"
    fi
}

# 带重试与进度的下载函数
download_with_progress() {
    local url="$1" output="$2" processor="$3"
    local max_retries=${CONFIG[MAX_RETRIES]} retry_count=0
    local converted_url
    converted_url=$(convert_github_url "$url")

    current_download=$((current_download + 1))

    while [ $retry_count -lt $max_retries ]; do
        PrettyProgressBar "$current_download" "$total_downloads" "${converted_url##*/}" "下载中"
        if curl -s -f --connect-timeout ${CONFIG[TIMEOUT]} --max-time 60 "$converted_url" | eval "$processor" >> "$output"; then
            success_count=$((success_count + 1))
            break
        fi
        retry_count=$((retry_count + 1))
        sleep 2
    done

    # 非 TTY 下直接输出纯文本结果，不使用 \r 和 ANSI 颜色
    if [ $IS_TTY -eq 0 ]; then
        if [ $retry_count -lt $max_retries ]; then
            printf "[OK] [%3d/%3d] %s\n" "$current_download" "$total_downloads" "${converted_url##*/}"
        else
            printf "[FAIL] [%3d/%3d] %s\n" "$current_download" "$total_downloads" "${converted_url##*/}"
        fi
        return
    fi

    printf "\r\033[K"
    if [ $retry_count -lt $max_retries ]; then
        printf "\033[0;32m✓ 下载成功: [%3d/%3d] %s\033[0m\n" "$current_download" "$total_downloads" "${converted_url##*/}"
    else
        printf "\033[0;31m✗ 下载失败: [%3d/%3d] %s\033[0m\n" "$current_download" "$total_downloads" "${converted_url##*/}"
    fi
}

# ======================== Get Data ========================
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
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/ChinaMax/ChinaMax_Domain.list"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/refs/heads/master/rule/Surge/China/China_All_No_Resolve.list"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/refs/heads/master/rule/Surge/DouYin/DouYin.list"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/refs/heads/master/rule/Surge/ChinaUnicom/ChinaUnicom_Resolve.list"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/refs/heads/master/rule/Surge/ChinaTelecom/ChinaTelecom.list"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/refs/heads/master/rule/Surge/ChinaMobile/ChinaMobile.list"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/refs/heads/master/rule/Surge/ChinaNoMedia/ChinaNoMedia_Domain.list"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/refs/heads/master/rule/Clash/Apple/Apple_Classical_No_Resolve.yaml"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/refs/heads/master/rule/Clash/Binance/Binance_No_Resolve.yaml"
        "https://raw.githubusercontent.com/madswaord/surgejourney/refs/heads/main/Clash/Ruleset/Binance.txt"
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/Domains/apple/Domains"
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-tld-list.txt"
        "https://raw.githubusercontent.com/v2fly/domain-list-community/release/tld-cn.txt"
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

    echo "=== 开始下载数据 ==="

    # 清理并创建临时目录
    find ./gfwlist2* -type d -exec rm -rf {} + 2>/dev/null
    rm -rf ./Temp
    mkdir -p ./Temp && cd ./Temp || exit 1

    # 初始化计数器
    total_downloads=$((${#cnacc_domain[@]} + ${#cnacc_trusted[@]} + ${#gfwlist_base64[@]} + ${#gfwlist_domain[@]} + ${#gfwlist2agh_modify[@]}))
    current_download=0
    success_count=0

    # CNACC Domain
    echo "=== 下载 CNACC Domain (${#cnacc_domain[@]}) ==="
    printf '%s\n' "${cnacc_domain[@]}" | xargs -P "${CONFIG[PARALLEL_JOBS]}" -I {} bash -c '
        url="{}"
        converted_url=$(curl --connect-timeout 5 -s "https://github.com" > /dev/null 2>&1 && echo "$url" || \
            ([[ "$url" == *"raw.githubusercontent.com"* ]] && \
            echo "https://gh-proxy.com/https://raw.githubusercontent.com${url#*raw.githubusercontent.com}" || \
            echo "https://gh-proxy.com/https://github.com${url#*github.com}"))
        curl -s -f --connect-timeout '"${CONFIG[TIMEOUT]}"' --max-time 60 "$converted_url" 2>/dev/null | sed "s/^\.//g"
    ' >> "./cnacc_domain.tmp" 2>/dev/null || true
    success_count=$((success_count + ${#cnacc_domain[@]}))

    # CNACC Trusted
    echo -e "\n=== 下载 CNACC Trusted (${#cnacc_trusted[@]}) ==="
    printf '%s\n' "${cnacc_trusted[@]}" | xargs -P "${CONFIG[PARALLEL_JOBS]}" -I {} bash -c '
        url="{}"
        converted_url=$(curl --connect-timeout 5 -s "https://github.com" > /dev/null 2>&1 && echo "$url" || \
            ([[ "$url" == *"raw.githubusercontent.com"* ]] && \
            echo "https://gh-proxy.com/https://raw.githubusercontent.com${url#*raw.githubusercontent.com}" || \
            echo "https://gh-proxy.com/https://github.com${url#*github.com}"))
        curl -s -f --connect-timeout '"${CONFIG[TIMEOUT]}"' --max-time 60 "$converted_url" 2>/dev/null | sed "s/\/114\.114\.114\.114//g;s/server=\///g"
    ' >> "./cnacc_trusted.tmp" 2>/dev/null || true
    success_count=$((success_count + ${#cnacc_trusted[@]}))

    # GFWList Base64
    echo -e "\n=== 下载 GFWList Base64 (${#gfwlist_base64[@]}) ==="
    BASE64_DECODE_OPT="-d"
    echo "dGVzdA==" | base64 -d >/dev/null 2>&1 || BASE64_DECODE_OPT="-D"

    for url in "${gfwlist_base64[@]}"; do
        local temp_file decoded_file
        temp_file=$(mktemp ./gfwlist_base64_XXXXXX.tmp)
        decoded_file="${temp_file}.decoded"

        if download_with_progress "$url" "$temp_file" "cat"; then
            if base64 $BASE64_DECODE_OPT "$temp_file" > "$decoded_file" 2>/dev/null || \
               base64 -d "$temp_file" > "$decoded_file" 2>/dev/null || \
               base64 -D "$temp_file" > "$decoded_file" 2>/dev/null; then
                grep -v '^!' "$decoded_file" | grep -v '^\[AutoProxy' | grep -v '^@@' | \
                    sed -e 's#^//*#/#' -e 's/^||//' -e 's/^|//' \
                        -e 's/^https\?:\/\///' -e 's/\/.*$//' \
                        -e 's/\*.//g' -e 's/^\.//g' \
                        -e 's/^*\.//' -e 's/[[:space:]]*$//g' | \
                    grep -E '^[a-zA-Z0-9][a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' | \
                    sort -u >> ./gfwlist_base64.tmp
            else
                echo "base64 解码失败: $url"
            fi
        fi
        rm -f "$temp_file" "$decoded_file"
    done

    # GFWList Domain
    echo -e "\n=== 下载 GFWList Domain (${#gfwlist_domain[@]}) ==="
    printf '%s\n' "${gfwlist_domain[@]}" | xargs -P "${CONFIG[PARALLEL_JOBS]}" -I {} bash -c '
        url="{}"
        converted_url=$(curl --connect-timeout 5 -s "https://github.com" > /dev/null 2>&1 && echo "$url" || \
            ([[ "$url" == *"raw.githubusercontent.com"* ]] && \
            echo "https://gh-proxy.com/https://raw.githubusercontent.com${url#*raw.githubusercontent.com}" || \
            echo "https://gh-proxy.com/https://github.com${url#*github.com}"))
        curl -s -f --connect-timeout '"${CONFIG[TIMEOUT]}"' --max-time 60 "$converted_url" 2>/dev/null | sed "s/^\.//g"
    ' >> "./gfwlist_domain.tmp" 2>/dev/null || true
    success_count=$((success_count + ${#gfwlist_domain[@]}))

    # Modify 文件
    echo -e "\n=== 下载 Modify 文件 ==="
    printf '%s\n' "${gfwlist2agh_modify[@]}" | xargs -P "${CONFIG[PARALLEL_JOBS]}" -I {} bash -c '
        url="{}"
        converted_url=$(curl --connect-timeout 5 -s "https://github.com" > /dev/null 2>&1 && echo "$url" || \
            ([[ "$url" == *"raw.githubusercontent.com"* ]] && \
            echo "https://gh-proxy.com/https://raw.githubusercontent.com${url#*raw.githubusercontent.com}" || \
            echo "https://gh-proxy.com/https://github.com${url#*github.com}"))
        curl -s -f --connect-timeout '"${CONFIG[TIMEOUT]}"' --max-time 60 "$converted_url" 2>/dev/null
    ' >> "./gfwlist2agh_modify.tmp" 2>/dev/null || true
    success_count=$((success_count + ${#gfwlist2agh_modify[@]}))

    # 文件校验
    echo -e "\n校验下载文件..."
    local failed=0
    for file in cnacc_domain.tmp cnacc_trusted.tmp gfwlist_base64.tmp gfwlist_domain.tmp gfwlist2agh_modify.tmp; do
        if [ ! -f "$file" ] || [ ! -s "$file" ]; then
            echo "Error: $file 缺失或为空"
            failed=1
            touch "$file"
        else
            echo "✓ $file 存在 ($(wc -l < "$file") 行)"
        fi
    done

    echo -e "\n下载统计: 成功 $success_count / 总计 $total_downloads"
    if [ $failed -eq 1 ]; then
        echo "警告: 部分文件下载失败，将继续处理"
    fi
    return 0
}

# ======================== Analyse Data ========================
# 对齐参考脚本 release.sh 的核心算法：
# 1. 解析 modify 文件的 marker 规则 (addition/subtraction/exclusion/keyword)
# 2. cnacc 与 gfwlist 互相去重 (冲突域名从两边移除)
# 3. 应用排除规则与关键词过滤
# 4. 应用增删规则
function AnalyseData() {
    echo "=== 开始数据分析 ==="

    local domain_regex="^(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$"
    local lite_domain_regex="^([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$"

    # ---- 解析 modify 文件 ----
    echo "解析 modify 规则..."
    local m="./gfwlist2agh_modify.tmp"
    # 确保 modify 文件存在
    [ -f "$m" ] || touch "$m"

    # cnacc 组: addition / subtraction / exclusion / keyword
    grep -v '^#' "$m" | grep '\(@%@\)\|\(@%!\)\|\(!&@\)\|\(@@@\)' | tr -d '!%&()*@' | grep -E "$domain_regex" | sort -u > "./cnacc_addition.tmp"
    grep -v '^#' "$m" | grep '\(!%!\)\|\(@&!\)\|\(!%@\)\|\(!!!\)' | tr -d '!%&()*@' | grep -E "$domain_regex" | sort -u > "./cnacc_subtraction.tmp"
    grep -v '^#' "$m" | grep '\(\*\%\*\)\|\(\*\*\*\)' | tr -d '!%&()*@' | grep -E "$domain_regex" | xargs | sed 's/ /|/g' | sort -u > "./cnacc_exclusion.tmp"
    grep -v '^#' "$m" | grep '\(\*\%\*\)\|\(\*\*\*\)' | tr -d '!%&()*@' | grep -E "$lite_domain_regex" | xargs | sed 's/ /|/g' | sort -u > "./lite_cnacc_exclusion.tmp"
    grep -v '^#' "$m" | grep '\(!\%\*\)\|\(!\*\*\)' | tr -d '!%&()*@' | grep -E "$domain_regex" | xargs | sed 's/ /|/g' | sort -u > "./cnacc_keyword.tmp"
    grep -v '^#' "$m" | grep '\(!\%\*\)\|\(!\*\*\)' | tr -d '!%&()*@' | grep -E "$lite_domain_regex" | xargs | sed 's/ /|/g' | sort -u > "./lite_cnacc_keyword.tmp"

    # gfwlist 组: addition / subtraction / exclusion / keyword
    grep -v '^#' "$m" | grep '\(@&@\)\|\(@&!\)\|\(!%@\)\|\(@@@\)' | tr -d '!%&()*@' | grep -E "$domain_regex" | sort -u > "./gfwlist_addition.tmp"
    grep -v '^#' "$m" | grep '\(!&!\)\|\(@%!\)\|\(!&@\)\|\(!!!\)' | tr -d '!%&()*@' | grep -E "$domain_regex" | sort -u > "./gfwlist_subtraction.tmp"
    grep -v '^#' "$m" | grep '\(\*\&\*\)\|\(\*\*\*\)' | tr -d '!%&()*@' | grep -E "$domain_regex" | xargs | sed 's/ /|/g' | sort -u > "./gfwlist_exclusion.tmp"
    grep -v '^#' "$m" | grep '\(\*\&\*\)\|\(\*\*\*\)' | tr -d '!%&()*@' | grep -E "$lite_domain_regex" | xargs | sed 's/ /|/g' | sort -u > "./lite_gfwlist_exclusion.tmp"
    grep -v '^#' "$m" | grep '\(!\&\*\)\|\(!\*\*\)' | tr -d '!%&()*@' | grep -E "$domain_regex" | xargs | sed 's/ /|/g' | sort -u > "./gfwlist_keyword.tmp"
    grep -v '^#' "$m" | grep '\(!\&\*\)\|\(!\*\*\)' | tr -d '!%&()*@' | grep -E "$lite_domain_regex" | xargs | sed 's/ /|/g' | sort -u > "./lite_gfwlist_keyword.tmp"

    # lite 版 addition
    grep -E "$lite_domain_regex" "./cnacc_addition.tmp" | sort -u > "./lite_cnacc_addition.tmp"
    grep -E "$lite_domain_regex" "./gfwlist_addition.tmp" | sort -u > "./lite_gfwlist_addition.tmp"

    # ---- 处理原始数据源 ----
    echo "处理信任域名..."
    cat "./cnacc_trusted.tmp" | sed 's/\/114\.114\.114\.114//g;s/server=\///g' | tr 'A-Z' 'a-z' | grep -E "$domain_regex" | sort -u > "./cnacc_trust.tmp"
    grep -E "$lite_domain_regex" "./cnacc_trust.tmp" | sort -u > "./lite_cnacc_trust.tmp"

    echo "处理 CNACC 域名..."
    cat "./cnacc_domain.tmp" | sed 's/domain://g;s/full://g' | tr 'A-Z' 'a-z' | grep -E "$domain_regex" | sort -u > "./cnacc_checklist.tmp"

    echo "处理 GFWList 域名..."
    cat "./gfwlist_base64.tmp" "./gfwlist_domain.tmp" | \
        sed 's/domain://g;s/full://g;s/http:\/\///g;s/https:\/\///g' | \
        tr -d '|' | tr 'A-Z' 'a-z' | grep -E "$domain_regex" | sort -u > "./gfwlist_checklist.tmp"

    # lite 版 checklist (取主域)
    rev "./cnacc_checklist.tmp" | cut -d '.' -f 1,2 | rev | sort -u > "./lite_cnacc_checklist.tmp"
    rev "./gfwlist_checklist.tmp" | cut -d '.' -f 1,2 | rev | sort -u > "./lite_gfwlist_checklist.tmp"

    # ---- 冲突去重 (集合差集) ----
    echo "执行域名冲突去重..."
    # 构造排除/关键词正则，空文件时不拼接 (避免 () 匹配一切导致全被过滤)
    # 注意: [ -s ] 不够 (文件可能只有 1 字节换行)，必须检查 cat 输出的非空内容
    _re_excl() { local _c; _c=$(cat "$1" 2>/dev/null | tr -d '\n'); [ -n "$_c" ] && echo "(\.($_c)$)|(^$_c$)" || echo ""; }
    _re_kw()   { local _c; _c=$(cat "$1" 2>/dev/null | tr -d '\n'); [ -n "$_c" ] && echo "($_c)" || echo ""; }

    # gfwlist_raw = gfwlist_checklist - cnacc_checklist (从 gfwlist 移除 cnacc 域名)
    awk 'NR==FNR{tmp[$0]=1} NR>FNR{if(tmp[$0]!=1) print}' "./cnacc_checklist.tmp" "./gfwlist_checklist.tmp" > "./gfwlist_raw.tmp"

    # cnacc_raw = cnacc_checklist - gfwlist_checklist, 再应用 cnacc 排除/关键词
    _re1=$(_re_excl './cnacc_exclusion.tmp'); _re2=$(_re_kw './cnacc_keyword.tmp')
    _combined=""
    [ -n "$_re1" ] && _combined="$_re1"
    [ -n "$_re2" ] && _combined="$_combined${_combined:+|}$_re2"
    if [ -n "$_combined" ]; then
        awk 'NR==FNR{tmp[$0]=1} NR>FNR{if(tmp[$0]!=1) print}' "./gfwlist_checklist.tmp" "./cnacc_checklist.tmp" | \
            grep -Ev "$_combined" > "./cnacc_raw.tmp"
    else
        awk 'NR==FNR{tmp[$0]=1} NR>FNR{if(tmp[$0]!=1) print}' "./gfwlist_checklist.tmp" "./cnacc_checklist.tmp" > "./cnacc_raw.tmp"
    fi

    # lite 版冲突去重 (lite_gfwlist 不做 cnacc 排除/关键词，直接差集)
    awk 'NR==FNR{tmp[$0]=1} NR>FNR{if(tmp[$0]!=1) print}' "./lite_cnacc_checklist.tmp" "./lite_gfwlist_checklist.tmp" > "./lite_gfwlist_raw.tmp"
    _re1=$(_re_excl './lite_cnacc_exclusion.tmp'); _re2=$(_re_kw './lite_cnacc_keyword.tmp')
    _combined=""
    [ -n "$_re1" ] && _combined="$_re1"
    [ -n "$_re2" ] && _combined="$_combined${_combined:+|}$_re2"
    if [ -n "$_combined" ]; then
        awk 'NR==FNR{tmp[$0]=1} NR>FNR{if(tmp[$0]!=1) print}' "./lite_gfwlist_checklist.tmp" "./lite_cnacc_checklist.tmp" | \
            grep -Ev "$_combined" > "./lite_cnacc_raw.tmp"
    else
        awk 'NR==FNR{tmp[$0]=1} NR>FNR{if(tmp[$0]!=1) print}' "./lite_gfwlist_checklist.tmp" "./lite_cnacc_checklist.tmp" > "./lite_cnacc_raw.tmp"
    fi

    # 从 gfwlist 移除 cnacc_trust, 再应用 gfwlist 排除/关键词
    _re1=$(_re_excl './gfwlist_exclusion.tmp'); _re2=$(_re_kw './gfwlist_keyword.tmp')
    _combined=""
    [ -n "$_re1" ] && _combined="$_re1"
    [ -n "$_re2" ] && _combined="$_combined${_combined:+|}$_re2"
    if [ -n "$_combined" ]; then
        awk 'NR==FNR{tmp[$0]=1} NR>FNR{if(tmp[$0]!=1) print}' "./cnacc_trust.tmp" "./gfwlist_raw.tmp" | \
            grep -Ev "$_combined" > "./gfwlist_raw_new.tmp"
    else
        awk 'NR==FNR{tmp[$0]=1} NR>FNR{if(tmp[$0]!=1) print}' "./cnacc_trust.tmp" "./gfwlist_raw.tmp" > "./gfwlist_raw_new.tmp"
    fi
    _re1=$(_re_excl './lite_gfwlist_exclusion.tmp'); _re2=$(_re_kw './lite_gfwlist_keyword.tmp')
    _combined=""
    [ -n "$_re1" ] && _combined="$_re1"
    [ -n "$_re2" ] && _combined="$_combined${_combined:+|}$_re2"
    if [ -n "$_combined" ]; then
        awk 'NR==FNR{tmp[$0]=1} NR>FNR{if(tmp[$0]!=1) print}' "./cnacc_trust.tmp" "./lite_gfwlist_raw.tmp" | \
            grep -Ev "$_combined" > "./lite_gfwlist_raw_new.tmp"
    else
        awk 'NR==FNR{tmp[$0]=1} NR>FNR{if(tmp[$0]!=1) print}' "./cnacc_trust.tmp" "./lite_gfwlist_raw.tmp" > "./lite_gfwlist_raw_new.tmp"
    fi

    # ---- 合并 addition 与 trust ----
    cat "./cnacc_raw.tmp" "./lite_cnacc_raw.tmp" "./cnacc_addition.tmp" "./lite_cnacc_addition.tmp" "./cnacc_trust.tmp" "./lite_cnacc_trust.tmp" | sort -u > "./cnacc_added.tmp"
    cat "./gfwlist_raw_new.tmp" "./lite_gfwlist_raw_new.tmp" "./gfwlist_addition.tmp" "./lite_gfwlist_addition.tmp" | sort -u > "./gfwlist_added.tmp"
    cat "./lite_cnacc_raw.tmp" "./lite_cnacc_addition.tmp" "./lite_cnacc_trust.tmp" | sort -u > "./lite_cnacc_added.tmp"
    cat "./lite_gfwlist_raw_new.tmp" "./lite_gfwlist_addition.tmp" | sort -u > "./lite_gfwlist_added.tmp"

    # ---- 应用 subtraction ----
    awk 'NR==FNR{tmp[$0]=1} NR>FNR{if(tmp[$0]!=1) print}' "./cnacc_subtraction.tmp" "./cnacc_added.tmp" > "./cnacc_data.tmp"
    awk 'NR==FNR{tmp[$0]=1} NR>FNR{if(tmp[$0]!=1) print}' "./gfwlist_subtraction.tmp" "./gfwlist_added.tmp" > "./gfwlist_data.tmp"
    awk 'NR==FNR{tmp[$0]=1} NR>FNR{if(tmp[$0]!=1) print}' "./cnacc_subtraction.tmp" "./lite_cnacc_added.tmp" > "./lite_cnacc_data.tmp"
    awk 'NR==FNR{tmp[$0]=1} NR>FNR{if(tmp[$0]!=1) print}' "./gfwlist_subtraction.tmp" "./lite_gfwlist_added.tmp" > "./lite_gfwlist_data.tmp"

    # ---- 加载到数组 ----
    mapfile -t cnacc_data < <(cat "./cnacc_data.tmp" "./lite_cnacc_data.tmp" | sort -u)
    mapfile -t gfwlist_data < <(cat "./gfwlist_data.tmp" "./lite_gfwlist_data.tmp" | sort -u)
    mapfile -t lite_cnacc_data < <(cat "./lite_cnacc_data.tmp" | sort -u)
    mapfile -t lite_gfwlist_data < <(cat "./lite_gfwlist_data.tmp" | sort -u)

    # ---- 数据校验 ----
    echo "数据统计:"
    echo "  cnacc_data: ${#cnacc_data[@]}"
    echo "  gfwlist_data: ${#gfwlist_data[@]}"
    echo "  lite_cnacc_data: ${#lite_cnacc_data[@]}"
    echo "  lite_gfwlist_data: ${#lite_gfwlist_data[@]}"

    if [ ${#cnacc_data[@]} -eq 0 ] || [ ${#gfwlist_data[@]} -eq 0 ]; then
        echo "Error: 数据为空，分析失败"
        exit 1
    fi

    echo "=== 数据分析完成 ==="
}

# ======================== 文件名工具 ========================
# 故意让 generate_temp 与 GenerateRulesBody 错位，配合 OutputData 调用顺序覆盖，
# 最终确保: blacklist = gfwlist+foreign, whitelist = cnacc+domestic
function FileName() {
    case "${generate_file}" in
        black|whiteblack) generate_temp="black" ;;
        white|blackwhite) generate_temp="white" ;;
        *) generate_temp="debug" ;;
    esac
    case "${software_name}" in
        adguardhome|adguardhome_new|domain|ikuai) file_extension="txt" ;;
        bind9|dnsmasq|smartdns|unbound) file_extension="conf" ;;
        *) file_extension="dev" ;;
    esac
    mkdir -p "../gfwlist2${software_name}"
    file_name="${generate_temp}list_${generate_mode}.${file_extension}"
    file_path="../gfwlist2${software_name}/${file_name}"
    # 清空目标文件 (每次重新生成)
    : > "${file_path}"
}

# ======================== Generate Rules ========================
function GenerateRules() {
    function GenerateDefaultUpstream() {
        case ${software_name} in
            adguardhome|adguardhome_new)
                if [ "${generate_mode}" == "full" ] || [ "${generate_mode}" == "lite" ]; then
                    if [ "${generate_file}" == "blackwhite" ]; then
                        printf '%s\n' "${foreign_dns[@]}" >> "${file_path}"
                    elif [ "${generate_file}" == "whiteblack" ]; then
                        printf '%s\n' "${domestic_dns[@]}" >> "${file_path}"
                    fi
                else
                    if [ "${generate_file}" == "black" ]; then
                        printf '%s\n' "${domestic_dns[@]}" >> "${file_path}"
                    elif [ "${generate_file}" == "white" ]; then
                        printf '%s\n' "${foreign_dns[@]}" >> "${file_path}"
                    fi
                fi
                ;;
            *) exit 1 ;;
        esac
    }

    case ${software_name} in
        # ---------- AdGuard Home / AdGuard Home New (共用逻辑) ----------
        adguardhome|adguardhome_new)
            domestic_dns=(
                $(for p in tcp udp; do echo "${p}://dns.alidns.com"; done)
                $(for p in tcp udp; do echo "${p}://223.5.5.5"; done)
                $(for p in tcp udp; do echo "${p}://223.6.6.6"; done)
                $(for p in tcp udp; do echo "${p}://2400:3200::1"; done)
                $(for p in tcp udp; do echo "${p}://2400:3200:baba::1"; done)
                $(for p in tcp udp; do echo "${p}://114.114.114.114"; done)
                $(for p in tcp udp; do echo "${p}://114.114.115.115"; done)
                $(for p in tls quic; do echo "${p}://dns.alidns.com:853"; done)
                $(for p in https h3; do echo "${p}://dns.alidns.com/dns-query"; done)
                $(for p in https h3; do echo "${p}://223.5.5.5/dns-query"; done)
                $(for p in https h3; do echo "${p}://223.6.6.6/dns-query"; done)
                $(for p in tls quic; do echo "${p}://223.5.5.5:853"; done)
                $(for p in tls quic; do echo "${p}://223.6.6.6:853"; done)
                $(for p in https h3; do echo "${p}://2400:3200::1/dns-query"; done)
                $(for p in https h3; do echo "${p}://2400:3200:baba::1/dns-query"; done)
                $(for p in tls quic; do echo "${p}://2400:3200::1:853"; done)
                $(for p in tls quic; do echo "${p}://2400:3200:baba::1:853"; done)
                $(for p in tcp udp; do echo "${p}://119.29.29.29"; done)
                $(for p in tcp udp; do echo "${p}://2402:4e00::"; done)
                $(for p in tcp udp; do echo "${p}://2402:4e00:1::"; done)
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
                $(for p in tcp udp; do echo "${p}://71.131.215.228"; done)
                $(for p in tcp udp; do echo "${p}://117.50.0.88"; done)
                $(for p in tcp udp; do echo "${p}://52.80.53.83"; done)
                $(for p in tcp udp; do echo "${p}://52.80.59.89"; done)
                $(for p in tcp udp; do echo "${p}://113.31.119.88"; done)
                $(for p in tcp udp; do echo "${p}://52.81.114.158"; done)
                $(for p in tcp udp; do echo "${p}://42.240.136.88"; done)
                $(for p in tcp udp; do echo "${p}://2400:7fc0:849e:200:62fd:1de3:1c90:1"; done)
                $(for p in tcp udp; do echo "${p}://2400:7fc0:849e:200:62fd:1de3:1c90:2"; done)
            )
            foreign_dns=(
                $(for p in https h3; do echo "${p}://firefox.dns.nextdns.io/dns-query"; done)
                $(for p in https h3; do echo "${p}://anycast.dns.nextdns.io/dns-query"; done)
                $(for p in https h3; do echo "${p}://doh3.dns.nextdns.io/dns-query"; done)
                $(for p in https h3; do echo "${p}://dns.nextdns.io/dns-query"; done)
                $(for p in https h3; do echo "${p}://dns-unfiltered.adguard.com/dns-query"; done)
                $(for p in https h3; do echo "${p}://unfiltered.adguard-dns.com/dns-query"; done)
                $(for p in https h3; do echo "${p}://dns.google/dns-query"; done)
                $(for p in https h3; do echo "${p}://dns.google.com/dns-query"; done)
                $(printf "%s\n" {https,h3}://{e5aehtlc5e,sepfvn6g5a,1dot1dot1dot1,mozilla,chrome,dns}.cloudflare-dns.com:{443,2083,2053,2087,2096,8443}/dns-query)
                $(for p in tls quic; do
                    echo "${p}://dns.google:853"
                    echo "${p}://dns.google.com:853"
                    echo "${p}://dns.adguard.com:853"
                    echo "${p}://dns-unfiltered.adguard.com:853"
                    echo "${p}://unfiltered.adguard-dns.com:853"
                    echo "${p}://anycast.dns.nextdns.io:853"
                    echo "${p}://dns.nextdns.io:853"
                    echo "${p}://doh3.dns.nextdns.io:853"
                done)
                "https://77.88.8.8:443/dns-query"
                "https://doh.opendns.com/dns-query"
                "https://dns12.quad9.net/dns-query"
                "https://dns.twnic.tw/dns-query"
                "tls://dns.twnic.tw:853"
                "tls://common.dot.dns.yandex.net:853"
                "tls://1dot1dot1dot1.cloudflare-dns.com:853"
                "tls://dns12.quad9.net:853"
                "tls://sandbox.opendns.com:853"
                "tls://dns.mullvad.net:853"
                "tls://ordns.he.net:853"
            )

            function GenerateRulesHeader() { echo -n "[/" >> "${file_path}"; }
            function GenerateRulesBody() {
                local -a data
                if [ "${generate_mode}" == "full" ] || [ "${generate_mode}" == "full_combine" ]; then
                    if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                        data=("${cnacc_data[@]}")
                    else
                        data=("${gfwlist_data[@]}")
                    fi
                else
                    if [ "${generate_file}" == "black" ] || [ "${generate_file}" == "blackwhite" ]; then
                        data=("${lite_cnacc_data[@]}")
                    else
                        data=("${lite_gfwlist_data[@]}")
                    fi
                fi
                # 批量写入替代逐条 echo，性能提升显著
                printf '%s/' "${data[@]}" >> "${file_path}"
            }
            function GenerateRulesFooter() {
                # AdGuard Home 官方格式: [/domain1/domain2/]dns1 dns2 dns3
                # 域名组以 /] 闭合, 多个 DNS 服务器用空格分隔 (参考官方文档)
                if [ "${dns_mode}" == "default" ]; then
                    echo "]#" >> "${file_path}"
                else
                    local -a dns_arr
                    if [ "${dns_mode}" == "domestic" ]; then
                        dns_arr=("${domestic_dns[@]}")
                    else
                        dns_arr=("${foreign_dns[@]}")
                    fi
                    # 第一个 DNS 紧跟 ] (无空格), 其余 DNS 用空格分隔
                    printf ']%s' "${dns_arr[0]}" >> "${file_path}"
                    if [ "${#dns_arr[@]}" -gt 1 ]; then
                        printf ' %s' "${dns_arr[@]:1}" >> "${file_path}"
                    fi
                    echo "" >> "${file_path}"
                fi
            }
            function GenerateRulesProcess() {
                GenerateRulesHeader
                GenerateRulesBody
                GenerateRulesFooter
            }

            if [ "${dns_mode}" == "default" ]; then
                FileName && GenerateDefaultUpstream && GenerateRulesProcess
            elif [ "${dns_mode}" == "domestic" ] || [ "${dns_mode}" == "foreign" ]; then
                # Footer 已将所有 DNS 写入一行，无需循环
                FileName && GenerateDefaultUpstream
                GenerateRulesProcess
            fi
            ;;

        # ---------- Bind9 ----------
        bind9)
            domestic_dns=("119.29.29.29 port 53" "223.5.5.5 port 53" "223.6.6.6 port 53" "101.226.4.6 port 53" "123.125.81.6 port 53" "114.114.114.114 port 53" "114.114.115.115 port 53" "117.50.11.11 port 53" "52.80.66.66 port 53")
            foreign_dns=("208.67.222.222 port 53" "8.8.4.4 port 53" "8.8.8.8 port 53" "1.1.1.1 port 53" "1.0.0.1 port 53" "9.9.9.10 port 53" "94.140.14.140 port 53" "94.140.14.141 port 53" "74.82.42.42 port 53" "185.222.222.222 port 53")
            FileName
            local -a data
            if [ "${generate_mode}" == "full" ]; then
                [ "${generate_file}" == "black" ] && data=("${gfwlist_data[@]}") || data=("${cnacc_data[@]}")
            else
                [ "${generate_file}" == "black" ] && data=("${lite_gfwlist_data[@]}") || data=("${lite_cnacc_data[@]}")
            fi
            local -a dns_list
            [ "${generate_file}" == "black" ] && dns_list=("${foreign_dns[@]}") || dns_list=("${domestic_dns[@]}")
            # 预构建 forwarders 字符串，用 awk 批量生成
            local fwd=""
            for s in "${dns_list[@]}"; do fwd+="${s}; "; done
            printf '%s\n' "${data[@]}" | awk -v f="$fwd" '{printf "zone \"%s.\" {type forward; forwarders { %s}; };\n", $0, f}' >> "${file_path}"
            ;;

        # ---------- DNSMasq ----------
        dnsmasq)
            domestic_dns=("119.29.29.29#53" "223.5.5.5#53" "223.6.6.6#53" "101.226.4.6#53" "123.125.81.6#53" "114.114.114.114#53" "114.114.115.115#53" "117.50.10.10#53" "52.80.52.52#53")
            foreign_dns=("208.67.222.222#53" "8.8.4.4#53" "8.8.8.8#53" "1.1.1.1#53" "1.0.0.1#53" "9.9.9.10#53" "94.140.14.140#53" "94.140.14.141#53" "74.82.42.42#53" "185.222.222.222#53")
            FileName
            local -a data dns_list
            if [ "${generate_mode}" == "full" ]; then
                [ "${generate_file}" == "black" ] && data=("${gfwlist_data[@]}") || data=("${cnacc_data[@]}")
            else
                [ "${generate_file}" == "black" ] && data=("${lite_gfwlist_data[@]}") || data=("${lite_cnacc_data[@]}")
            fi
            [ "${generate_file}" == "black" ] && dns_list=("${foreign_dns[@]}") || dns_list=("${domestic_dns[@]}")
            # 用 awk 批量生成 server 规则
            printf '%s\n' "${data[@]}" | awk -v dns="${dns_list[*]}" 'BEGIN{n=split(dns, arr, " ")} {for(i=1;i<=n;i++) print "server=/" $0 "/" arr[i]}' >> "${file_path}"
            ;;

        # ---------- Domain ----------
        domain)
            FileName
            local -a data
            if [ "${generate_mode}" == "full" ]; then
                [ "${generate_file}" == "black" ] && data=("${gfwlist_data[@]}") || data=("${cnacc_data[@]}")
            else
                [ "${generate_file}" == "black" ] && data=("${lite_gfwlist_data[@]}") || data=("${lite_cnacc_data[@]}")
            fi
            printf '%s\n' "${data[@]}" >> "${file_path}"
            ;;

        # ---------- SmartDNS ----------
        smartdns)
            FileName
            local -a data
            local group
            if [ "${generate_mode}" == "full" ]; then
                if [ "${generate_file}" == "black" ]; then data=("${gfwlist_data[@]}"); group="${foreign_group:-foreign}"
                else data=("${cnacc_data[@]}"); group="${domestic_group:-domestic}"; fi
            else
                if [ "${generate_file}" == "black" ]; then data=("${lite_gfwlist_data[@]}"); group="${foreign_group:-foreign}"
                else data=("${lite_cnacc_data[@]}"); group="${domestic_group:-domestic}"; fi
            fi
            # 批量输出 nameserver 规则
            printf 'nameserver /%s/'"${group}"'\n' "${data[@]}" >> "${file_path}"
            ;;

        # ---------- Unbound ----------
        unbound)
            domestic_dns=("223.5.5.5@853" "223.6.6.6@853" "2400:3200::1@853" "2400:3200:baba::1@853" "1.12.12.12@853" "120.53.53.53@853" "119.29.29.29@53" "2402:4e00::@53" "114.114.114.114@53" "114.114.115.115@53" "117.50.10.10@53" "52.80.52.52@53" "2400:7fc0:849e:200::8@53" "2404:c2c0:85d8:901::8@53")
            foreign_dns=("8.8.4.4@853" "8.8.8.8@853" "2001:4860:4860::8888@853" "2001:4860:4860::8844@853" "1.1.1.1@853" "1.0.0.1@853" "2606:4700:4700::1111@853" "2606:4700:4700::1001@853" "9.9.9.12@853" "149.112.112.12@853" "2620:fe::12@853" "2620:fe::fe:12@853" "94.140.14.140@853" "94.140.14.141@853" "2a10:50c0::1:ff@853" "2a10:50c0::2:ff@853" "209.244.0.3@53" "209.244.0.4@53" "4.2.2.1@53" "4.2.2.2@53" "4.2.2.3@53" "4.2.2.4@53" "4.2.2.5@53" "4.2.2.6@53")
            local forward_ssl_tls_upstream="yes"
            FileName
            local -a data
            if [ "${generate_mode}" == "full" ]; then
                [ "${generate_file}" == "black" ] && data=("${gfwlist_data[@]}") || data=("${cnacc_data[@]}")
            else
                [ "${generate_file}" == "black" ] && data=("${lite_gfwlist_data[@]}") || data=("${lite_cnacc_data[@]}")
            fi
            local -a dns_list
            [ "${dns_mode}" == "domestic" ] && dns_list=("${domestic_dns[@]}") || dns_list=("${foreign_dns[@]}")
            # 预构建 forward-addr 块，用 awk 批量生成 forward-zone
            local addrs=""
            for s in "${dns_list[@]}"; do addrs+="    forward-addr: ${s}\n"; done
            printf '%s\n' "${data[@]}" | awk -v a="$addrs" -v ssl="$forward_ssl_tls_upstream" '{
                print "forward-zone:"
                print "    name: " $0 "."
                printf a
                print "    forward-first: yes"
                print "    forward-no-cache: yes"
                print "    forward-ssl-upstream: " ssl
                print "    forward-tls-upstream: " ssl
            }' >> "${file_path}"
            ;;

        # ---------- iKuai ----------
        ikuai)
            FileName
            echo "[GLOBAL_BYPASS_ROUTE]" > "${file_path}"
            echo "# Generated for iKuai ${generate_mode} ${generate_file}list" >> "${file_path}"
            local -a data
            if [ "${generate_mode}" == "full" ]; then
                [ "${generate_file}" == "black" ] && data=("${gfwlist_data[@]}") || data=("${cnacc_data[@]}")
            else
                [ "${generate_file}" == "black" ] && data=("${lite_gfwlist_data[@]}") || data=("${lite_cnacc_data[@]}")
            fi
            printf 'bypass_route_domain=%s\n' "${data[@]}" >> "${file_path}"
            ;;

        *)
            echo "Error: 未知软件类型: ${software_name}"
            exit 1
            ;;
    esac
}

# ======================== Output Data ========================
function OutputData() {
    echo "=== 开始生成规则 ==="

    # 预先创建输出目录
    for type in adguardhome adguardhome_new bind9 unbound dnsmasq domain smartdns ikuai; do
        mkdir -p "./gfwlist2${type}"
    done

    # AdGuard Home
    echo "处理 AdGuard Home..."
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

    # AdGuard Home (New)
    echo "处理 AdGuard Home (新版)..."
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

    # Bind9
    echo "处理 Bind9..."
    software_name="bind9" && generate_file="black" && generate_mode="full" && GenerateRules
    software_name="bind9" && generate_file="black" && generate_mode="lite" && GenerateRules
    software_name="bind9" && generate_file="white" && generate_mode="full" && GenerateRules
    software_name="bind9" && generate_file="white" && generate_mode="lite" && GenerateRules

    # DNSMasq
    echo "处理 DNSMasq..."
    software_name="dnsmasq" && generate_file="black" && generate_mode="full" && GenerateRules
    software_name="dnsmasq" && generate_file="black" && generate_mode="lite" && GenerateRules
    software_name="dnsmasq" && generate_file="white" && generate_mode="full" && GenerateRules
    software_name="dnsmasq" && generate_file="white" && generate_mode="lite" && GenerateRules

    # Domain
    echo "处理 Domain..."
    software_name="domain" && generate_file="black" && generate_mode="full" && GenerateRules
    software_name="domain" && generate_file="black" && generate_mode="lite" && GenerateRules
    software_name="domain" && generate_file="white" && generate_mode="full" && GenerateRules
    software_name="domain" && generate_file="white" && generate_mode="lite" && GenerateRules

    # SmartDNS
    echo "处理 SmartDNS..."
    software_name="smartdns" && generate_file="black" && generate_mode="full" && foreign_group="foreign" && GenerateRules
    software_name="smartdns" && generate_file="black" && generate_mode="lite" && foreign_group="foreign" && GenerateRules
    software_name="smartdns" && generate_file="white" && generate_mode="full" && domestic_group="domestic" && GenerateRules
    software_name="smartdns" && generate_file="white" && generate_mode="lite" && domestic_group="domestic" && GenerateRules

    # Unbound
    echo "处理 Unbound..."
    software_name="unbound" && generate_file="black" && generate_mode="full" && dns_mode="foreign" && GenerateRules
    software_name="unbound" && generate_file="black" && generate_mode="lite" && dns_mode="foreign" && GenerateRules
    software_name="unbound" && generate_file="white" && generate_mode="full" && dns_mode="domestic" && GenerateRules
    software_name="unbound" && generate_file="white" && generate_mode="lite" && dns_mode="domestic" && GenerateRules

    # iKuai
    echo "处理 iKuai..."
    software_name="ikuai" && generate_file="black" && generate_mode="full" && GenerateRules
    software_name="ikuai" && generate_file="black" && generate_mode="lite" && GenerateRules
    software_name="ikuai" && generate_file="white" && generate_mode="full" && GenerateRules
    software_name="ikuai" && generate_file="white" && generate_mode="lite" && GenerateRules

    echo "=== 规则生成完成 ==="
}

# ======================== 移动生成文件 ========================
function MoveGeneratedFiles() {
    echo "=== 移动生成文件 ==="
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local dest="${script_dir}/hosts-dns"
    mkdir -p "${dest}"

    for type in adguardhome adguardhome_new bind9 unbound dnsmasq domain smartdns ikuai; do
        local src_dir="./gfwlist2${type}"
        [ ! -d "${src_dir}" ] && continue
        local count=0
        while IFS= read -r -d '' file; do
            cp -f "${file}" "${dest}/dnshosts-all-${type}-$(basename "${file}")"
            count=$((count + 1))
        done < <(find "${src_dir}" -type f \( -name "*.txt" -o -name "*.conf" \) -print0)
        echo "  ${type}: 复制 ${count} 个文件"
        [ $count -gt 0 ] && rm -rf "${src_dir}"
    done

    echo "目标目录: ${dest}"
    echo "文件总数: $(find "${dest}" -type f | wc -l)"
}

# ======================== 主流程 ========================
echo "=== DNS Hosts 规则生成开始 ==="
total_main_steps=4
current_main_step=0

execute_step() {
    local step_name="$1" step_function="$2" step_status="$3"
    local step_start=$(date +%s)
    current_main_step=$((current_main_step + 1))
    echo "步骤 ${current_main_step}/${total_main_steps}: ${step_name}..."

    if ! $step_function; then
        echo "[ERROR] ${step_name} 失败"
        return 1
    fi

    record_step_time "$step_name" $step_start
    PrettyProgressBar "$current_main_step" "$total_main_steps" "$step_name" "$step_status"
    print_step_time "$step_name"
}

execute_step "下载数据" GetData "下载中" || { echo "下载失败，终止"; exit 1; }
execute_step "分析数据" AnalyseData "分析中" || { echo "分析失败，终止"; exit 1; }
execute_step "生成规则" OutputData "生成中" || { echo "生成失败，终止"; exit 1; }

# 清理 Temp 目录 (OutputData 后已 cd 到 Temp)
cd ..
rm -rf ./Temp

execute_step "移动文件" MoveGeneratedFiles "移动中" || echo "文件移动失败，继续"

echo "=== 处理完成 ==="
echo "总耗时: $(time_taken $START_TIME)"
