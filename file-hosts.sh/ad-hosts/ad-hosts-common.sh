#!/usr/bin/env bash
# =============================================================================
# ad-hosts-common.sh - 广告过滤脚本公共函数库
# =============================================================================
# 功能描述：ad-hosts-pro.sh 和 ad-hosts-lite.sh 的共享函数库
#   - fetch_one: 单URL抓取
#   - fetch_data: 并发抓取
#   - find_singbox: 查找/下载sing-box
#   - AnalyseData: 数据分析
#   - GenerateInformation: 生成元信息
#   - OutputData: 输出多格式文件
#   - ad_hosts_main: 主流程入口
# 使用方式：source "$(dirname "$0")/ad-hosts-common.sh"
# 配置变量（调用方需设置）：
#   - ADFILTER_TITLE: 过滤列表标题
#   - ADFILTER_HOMEPAGE: 主页URL
#   - TEMP_DIR_NAME: 临时目录名
#   - filter_white: 白名单URL数组
# =============================================================================

# 单个 URL 抓取: 独立文件落盘, 成功与否互不影响 (由 xargs 并发调用)
function fetch_one() {
    local url=$1 rc file
    file="parts/$(printf '%s' "$url" | md5sum | awk '{print $1}')"
    curl -fL -s --compressed --connect-timeout 10 --max-time 180 \
        --retry 2 --retry-delay 3 -A "$UA" -o "$file" "$url"
    rc=$?
    if ((rc != 0)); then
        printf '%s %s\n' "$rc" "$url" >>./failed_urls.log
        rm -f "$file"
    fi
}

# xargs 子进程需要调用 fetch_one 并读取 UA
export -f fetch_one
export UA

# 获取 sing-box 可执行文件: 优先 SINGBOX_BIN / PATH, 否则从 GitHub Releases 下载 (仅用于编译 .srs)
function find_singbox() {
    local bin=${SINGBOX_BIN:-} tag url
    if [[ -z $bin ]]; then
        bin=$(command -v sing-box 2>/dev/null || true)
    fi
    if [[ -n $bin && -x $bin ]]; then
        echo "$bin"
        return 0
    fi
    bin=./sing-box/sing-box
    if [[ -x $bin ]]; then
        echo "$bin"
        return 0
    fi
    # 从 releases/latest 的 302 跳转解析版本号, 避免 GitHub API 匿名限流
    tag=$(curl -fsSI --max-time 30 "https://github.com/SagerNet/sing-box/releases/latest" 2>/dev/null |
        tr -d '\r' |
        awk 'tolower($1) == "location:" { sub(".*tag/", "", $2); print $2; exit }')
    if [[ ! $tag =~ ^v[0-9] ]]; then
        echo "[singbox] 无法解析 sing-box 版本, 跳过 .srs 编译 (JSON 规则集不受影响)" >&2
        return 1
    fi
    url="https://github.com/SagerNet/sing-box/releases/download/${tag}/sing-box-${tag#v}-linux-amd64.tar.gz"
    mkdir -p ./sing-box
    if ! curl -fL -s --max-time 180 --retry 2 --retry-delay 3 -o ./sing-box/sb.tar.gz "$url" \
        || ! tar -xzf ./sing-box/sb.tar.gz -C ./sing-box \
        || ! mv ./sing-box/sing-box-${tag#v}-linux-amd64/sing-box "$bin" 2>/dev/null \
        || ! [[ -x $bin ]]; then
        echo "[singbox] sing-box 下载/解压失败, 跳过 .srs 编译 (JSON 规则集不受影响)" >&2
        return 1
    fi
    echo "$bin"
}

# 按类别并发抓取: URL 去重 -> xargs 多进程 -> 合并
function fetch_data() {
    local filter_array=("${!1}")
    local output_file=$2 name=${1%%\[*}
    local total failed
    mkdir -p ./parts
    : >./failed_urls.log
    printf '%s\n' "${filter_array[@]}" | sed '/^$/d' | LC_ALL=C sort -u >./fetch_urls.txt
    total=$(wc -l <./fetch_urls.txt)
    xargs -r -d '\n' -P "$FETCH_JOBS" -n 1 bash -c 'fetch_one "$1"' _ <./fetch_urls.txt
    failed=$(wc -l <./failed_urls.log)
    echo "[fetch] ${name}: 成功 $((total - failed)) / 失败 ${failed} / 共 ${total}" >&2
    if ((failed > 0)); then
        echo "[fetch] ${name} 失败明细 (退出码 URL, 最多显示 10 条):" >&2
        head -n 10 ./failed_urls.log >&2
    fi
    cat ./parts/* >"$output_file" 2>/dev/null || : >"$output_file"
    rm -rf ./parts ./fetch_urls.txt ./failed_urls.log
}

# Analyse Data: 白名单 -> allow; 其余四类合并去重 -> block; 剔除白名单后为最终数据
function AnalyseData() {
    cat ./filter_white.tmp |
        sed 's/[[:space:]]//g;s/0\.0\.0\.0//g;s/127\.0\.0\.1//g;s/::1//g;s/:://g' |
        tr -d "@^|" |
        tr "A-Z" "a-z" |
        grep -a -E "${DOMAIN_RE}" |
        LC_ALL=C sort -u >./filter_allow.tmp

    cat ./filter_adblock.tmp ./filter_domain.tmp ./filter_hosts.tmp ./filter_other.tmp |
        sed 's/[[:space:]]//g;/^$/d;s/0\.0\.0\.0//g;s/127\.0\.0\.1//g;s/255\.255\.255\.255//g;s/local//g;s/localhost//g;s/localhost\.localdomain//g;s/broadcasthost//g;s/ip6-localhost//g;s/::1//g;s/ip6-loopback//g;s/ip6-localnet//g;s/fe80::1%lo0//g;s/ff00::0//g;s/ff02::1//g;s/ff02::2//g;s/ff02::3//g;s/ip6-mcastprefix//g;s/ip6-allnodes//g;s/ip6-allrouters//g;s/ip6-allhosts//g;s/DOMAIN,//g;s/DOMAIN-SUFFIX,//g;s/domain://g;s/full//g' |
        tr -d "^|" |
        tr "A-Z" "a-z" |
        grep -a -E "${DOMAIN_RE}" |
        LC_ALL=C sort -u >./filter_block.tmp

    # 注意: 白名单为空文件时不能让 awk 误把 block 当作白名单 (NR==FNR 陷阱)
    if [[ -s ./filter_allow.tmp ]]; then
        awk 'NR == FNR { tmp[$0] = 1; next } !($0 in tmp)' ./filter_allow.tmp ./filter_block.tmp
    else
        cat ./filter_block.tmp
    fi |
        grep -a -v "\.\." |
        LC_ALL=C sort -u >./filter_data.tmp
    echo "[analyse] 白名单 $(wc -l <./filter_allow.tmp) 条, 去重后拦截域名 $(wc -l <./filter_data.tmp) 条" >&2
}

# Generate Information: 计算元信息并写入各格式文件头
function print_common_headers() {
    printf '! Checksum: %s\n' "$adfilter_checksum"
    printf '! Title: %s for %s\n' "$adfilter_title" "$1"
    printf '! Description: %s\n' "$adfilter_description"
    printf '! Version: %s\n' "$adfilter_version"
    printf '! TimeUpdated: %s\n' "$adfilter_timeupdated"
    printf '! Expires: %s\n' "$adfilter_expires"
    printf '! Homepage: %s\n' "$adfilter_homepage"
    printf '! Total: %s\n' "$adfilter_total"
}

function GenerateInformation() {
    local now
    now=$(date +%s)
    adfilter_checksum=$(printf '%s\n' "$now" | base64)
    adfilter_description="HOSTS Project"
    adfilter_expires="24 hours (update frequency)"
    adfilter_homepage="${ADFILTER_HOMEPAGE}"
    adfilter_timeupdated=$(TZ=UTC-8 date -d "@${now}" '+%Y-%m-%dT%H:%M:%S%:z')
    adfilter_title="${ADFILTER_TITLE}"
    adfilter_total=$(wc -l <./filter_data.tmp)
    adfilter_version=$(TZ=UTC-8 date -d "@${now}" +%Y%m%d)-$((10#$(TZ=UTC-8 date -d "@${now}" +%H) / 3))

    print_common_headers "Adblock" >../ad-adblock.txt
    print_common_headers "AdguardHome" >../ad-adguardhome.txt
    { printf 'payload:\n'; print_common_headers "Clash"; } >../ad-clash.yaml
    { printf 'payload:\n'; print_common_headers "Clash Premium"; } >../ad-clash-premium.yaml
    print_common_headers "Dnsmasq" >../ad-dnsmasq.conf
    print_common_headers "Domains" >../ad-domains.txt
    { print_common_headers "Hosts"; printf '# (DO NOT REMOVE)\n'; } >../ad-hosts.txt
    print_common_headers "Quantumult" >../ad-quantumult.yaml
    print_common_headers "Shadowrocket" >../ad-shadowrocket.list
    print_common_headers "SmartDNS" >../ad-smartdns.conf
    print_common_headers "Surge" >../ad-surge.yaml
    print_common_headers "Unbound" >../ad-unbound.conf
    { print_common_headers "Bind9"
      printf '$TTL 30\n@ IN SOA rpz.trli.home. hostmaster.rpz.trli.home. %s 86400 3600 604800 30\nNS localhost.\n' "$now"
    } >../ad-bind9.conf
    print_common_headers "AdguardHome dnstype" >../ad-adguardhome-dnstype.txt
    # 爱快 (iKuai) 专用: DNS设置->广告过滤导入格式为"一行一条域名"纯文本,
    # ikuai-bypass 的域名分流/远程规则也吃同样格式; 不能带 ! 注释头, 否则会被当作域名
    : >../ad-ikuai.txt
}

# Output Data
function OutputData() {
    local total_lines
    total_lines=$(wc -l <./filter_data.tmp)
    if ((total_lines < MIN_DOMAINS)); then
        echo "[error] 最终域名仅 ${total_lines} 条, 疑似抓取大面积失败, 已中止以保护线上产物 (临时目录 ./${TEMP_DIR_NAME} 保留供排查)" >&2
        exit 1
    fi

    # 与上一次产物比对, 无变化则跳过 (CI 全新检出时无历史文件, 始终生成)
    if [[ -f ../ad-domains.txt ]]; then
        tail -n +9 ../ad-domains.txt >./filter_data.old
        if cmp -s ./filter_data.tmp ./filter_data.old; then
            echo "[output] 数据无变化, 跳过生成" >&2
            cd "$ORIG_PWD" && rm -rf "./${TEMP_DIR_NAME}"
            return 0
        fi
    fi

    GenerateInformation

    # 单次 awk 遍历生成全部格式 (每个文件只开关一次, 远快于逐域名 echo)
    awk '{
        print "||" $0 "^"                              >> "../ad-adblock.txt"
        print "|" $0 "^"                               >> "../ad-adguardhome.txt"
        print $0                                       >> "../ad-ikuai.txt"
        print "  - DOMAIN," $0                         >> "../ad-clash.yaml"
        print "  - \047+." $0 "\047"                   >> "../ad-clash-premium.yaml"
        print "address=/" $0 "/"                       >> "../ad-dnsmasq.conf"
        print $0                                       >> "../ad-domains.txt"
        print "127.0.0.53 " $0                         >> "../ad-hosts.txt"
        print "HOST-SUFFIX," $0 ",REJECT"              >> "../ad-quantumult.yaml"
        print "DOMAIN-SUFFIX," $0 ",REJECT"            >> "../ad-shadowrocket.list"
        print "address /" $0 "/#"                      >> "../ad-smartdns.conf"
        print "DOMAIN," $0                             >> "../ad-surge.yaml"
        print "local-zone: \"" $0 "\" always_nxdomain" >> "../ad-unbound.conf"
        print $0 " CNAME ."                            >> "../ad-bind9.conf"
        print "* " $0 " CNAME ."                       >> "../ad-bind9.conf"
        print "||" $0 "^$client=127.0.0.53,dnstype=A"  >> "../ad-adguardhome-dnstype.txt"
    }' ./filter_data.tmp

    # sing-box 规则集: 官方纯格式, 不含任何元数据字段 (sing-box 严格解析, 多余字段会被拒绝)
    {
        printf '{\n  "version": 1,\n  "rules": [\n    {\n      "domain_suffix": [\n'
        awk '{ if (NR > 1) printf ",\n"; printf "        \"%s\"", $0 } END { if (NR > 0) printf "\n" }' ./filter_data.tmp
        printf '      ]\n    }\n  ]\n}\n'
    } >../ad-singbox.json

    # 编译 .srs 二进制规则集 (体积远小于 JSON, 加载更快; 编译失败不影响 JSON 产物)
    local sb_bin
    if sb_bin=$(find_singbox); then
        if "$sb_bin" rule-set compile ../ad-singbox.json -o ../ad-singbox.srs 2>/dev/null ||
            "$sb_bin" rule-set compile ../ad-singbox.json ../ad-singbox.srs 2>/dev/null; then
            echo "[singbox] ad-singbox.srs 编译完成 ($(du -h ../ad-singbox.srs | cut -f1))" >&2
        else
            rm -f ../ad-singbox.srs
            echo "[singbox] .srs 编译失败, 仅提供 JSON 规则集" >&2
        fi
    fi

    cd "$ORIG_PWD" && rm -rf "./${TEMP_DIR_NAME}"
}

# =============================================================================
# 主流程入口
# =============================================================================
# 调用方需先设置以下变量：
#   ADFILTER_TITLE - 过滤列表标题
#   ADFILTER_HOMEPAGE - 主页URL
#   TEMP_DIR_NAME - 临时目录名
#   filter_adblock - adblock过滤URL数组
#   filter_domain - 域名过滤URL数组
#   filter_hosts - hosts过滤URL数组
#   filter_other - 其他过滤URL数组
#   filter_white - 白名单URL数组
ad_hosts_main() {
    mkdir -p "./${TEMP_DIR_NAME}" && cd "./${TEMP_DIR_NAME}"

    fetch_data filter_adblock[@]    ./filter_adblock.tmp
    fetch_data filter_domain[@]     ./filter_domain.tmp
    fetch_data filter_hosts[@]      ./filter_hosts.tmp
    fetch_data filter_other[@]      ./filter_other.tmp
    fetch_data filter_white[@]      ./filter_white.tmp

    AnalyseData
    OutputData
}
