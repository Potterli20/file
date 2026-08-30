#!/usr/bin/env bash
# ad-youtube-hosts.sh —— 聚合 YouTube 广告拦截列表并生成多格式输出
#
# 用法: 在仓库根目录执行  bash ./file-hosts.sh/ad-hosts/ad-youtube-hosts.sh
#       (workflow 与此一致; 产物 ./ad-youtube-* 输出到当前运行目录, 临时目录 ./ad-youtube-hosts 用后即删)
#
# 与 ad-hosts-pro.sh 同步的修复:
#   1. 并发下载 (FETCH_JOBS, 默认 16), URL 去重, curl 加 -f 防 404 页混入, --retry 内建重试
#   2. 输出改为单次 awk 遍历; 修复 echo 头行损坏 (原 payload: 与头信息挤成一行)
#   3. 修复 ad-youtube-singbox.json: 原 "rules" 是空数组塞字符串 (非法规则集),
#      原 ad-youtube-singbox.srs 里写的是 Clash 格式行; 现为官方纯格式并自动编译真正的 .srs
#   4. 修复无变化比对读错文件 (原来对比的是 ad-hosts-pro 的 ad-domains.txt)
#   5. 修复 $client 变量展开为空、Bind9 头 "Dind9" 拼写、RPZ SOA 序列号固定
#   6. 修复分析管道对同一文件边读边截断的竞态; 抓取失败清单落盘汇总
set -uo pipefail

ORIG_PWD=$PWD
FETCH_JOBS=${FETCH_JOBS:-16}
MIN_DOMAINS=${MIN_DOMAINS:-1000}   # 最终域名低于该值视为抓取失败, 中止保护
UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:139.0) Gecko/20100101 Firefox/139.0"
# 合法域名单行正则 (与 ad-hosts-pro 同一套判定规则)
DOMAIN_RE='^(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$'

# Download Data
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
    [[ -d file-hosts.sh ]] || echo "[warn] 建议在仓库根目录运行本脚本, 产物将输出到当前目录" >&2
    mkdir -p ./ad-youtube-hosts && cd ./ad-youtube-hosts || exit 1

    fetch_data filter_domain[@] ./filter_domain.tmp
    fetch_data filter_hosts[@] ./filter_hosts.tmp
}

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

# xargs 子进程需要调用 fetch_one 并读取 UA
export -f fetch_one
export UA

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

# Analyse Data (YouTube 拦截列表无白名单)
function AnalyseData() {
    cat ./filter_domain.tmp ./filter_hosts.tmp |
        sed 's/[[:space:]]//g;/^$/d;s/0\.0\.0\.0//g;s/127\.0\.0\.1//g;s/255\.255\.255\.255//g;s/local//g;s/localhost//g;s/localhost\.localdomain//g;s/broadcasthost//g;s/ip6-localhost//g;s/::1//g;s/ip6-loopback//g;s/ip6-localnet//g;s/fe80::1%lo0//g;s/ff00::0//g;s/ff02::1//g;s/ff02::2//g;s/ff02::3//g;s/ip6-mcastprefix//g;s/ip6-allnodes//g;s/ip6-allrouters//g;s/ip6-allhosts//g;s/DOMAIN,//g;s/DOMAIN-SUFFIX,//g;s/domain://g;s/full://g' |
        tr -d "^|" |
        tr "A-Z" "a-z" |
        grep -a -E "${DOMAIN_RE}" |
        LC_ALL=C sort -u >./filter_block.tmp

    grep -a -v "\.\." ./filter_block.tmp | LC_ALL=C sort -u >./filter_data.tmp
    echo "[analyse] 去重后拦截域名 $(wc -l <./filter_data.tmp) 条" >&2
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
    adfilter_homepage="https://file.trli.club:2083/ad-youtube-hosts/"
    adfilter_timeupdated=$(TZ=UTC-8 date -d "@${now}" '+%Y-%m-%dT%H:%M:%S%:z')
    adfilter_title="trli's Ad Filter Youtube"
    adfilter_total=$(wc -l <./filter_data.tmp)
    adfilter_version=$(TZ=UTC-8 date -d "@${now}" +%Y%m%d)-$((10#$(TZ=UTC-8 date -d "@${now}" +%H) / 3))

    print_common_headers "Adblock" >../ad-youtube-adblock.txt
    print_common_headers "AdguardHome" >../ad-youtube-adguardhome.txt
    { printf 'payload:\n'; print_common_headers "Clash"; } >../ad-youtube-clash.yaml
    { printf 'payload:\n'; print_common_headers "Clash Premium"; } >../ad-youtube-clash-premium.yaml
    print_common_headers "Dnsmasq" >../ad-youtube-dnsmasq.conf
    print_common_headers "Pi-hole" >../ad-youtube-domains.txt
    { print_common_headers "Hosts"; printf '# (DO NOT REMOVE)\n'; } >../ad-youtube-hosts.txt
    print_common_headers "Quantumult" >../ad-youtube-quantumult.yaml
    print_common_headers "Shadowrocket" >../ad-youtube-shadowrocket.list
    print_common_headers "SmartDNS" >../ad-youtube-smartdns.conf
    print_common_headers "Surge" >../ad-youtube-surge.yaml
    print_common_headers "Unbound" >../ad-youtube-unbound.conf
    { print_common_headers "Bind9"
      printf '$TTL 30\n@ IN SOA rpz.trli.home. hostmaster.rpz.trli.home. %s 86400 3600 604800 30\nNS localhost.\n' "$now"
    } >../ad-youtube-bind9.conf
    print_common_headers "AdguardHome dnstype" >../ad-youtube-adguardhome-dnstype.txt
    # 爱快 (iKuai) 专用: DNS设置->广告过滤导入格式为"一行一条域名"纯文本, 不能带 ! 注释头
    : >../ad-youtube-ikuai.txt
}

# Output Data
function OutputData() {
    local total_lines
    total_lines=$(wc -l <./filter_data.tmp)
    if ((total_lines < MIN_DOMAINS)); then
        echo "[error] 最终域名仅 ${total_lines} 条, 疑似抓取大面积失败, 已中止以保护线上产物 (临时目录 ./ad-youtube-hosts 保留供排查)" >&2
        exit 1
    fi

    # 与上一次产物比对, 无变化则跳过 (CI 全新检出时无历史文件, 始终生成)
    if [[ -f ../ad-youtube-domains.txt ]]; then
        tail -n +9 ../ad-youtube-domains.txt >./filter_data.old
        if cmp -s ./filter_data.tmp ./filter_data.old; then
            echo "[output] 数据无变化, 跳过生成" >&2
            cd "$ORIG_PWD" && rm -rf ./ad-youtube-hosts
            return 0
        fi
    fi

    GenerateInformation

    # 单次 awk 遍历生成全部格式 (hosts/dnstype 沿用 127.0.0.1)
    awk '{
        print "||" $0 "^"                              >> "../ad-youtube-adblock.txt"
        print "|" $0 "^"                               >> "../ad-youtube-adguardhome.txt"
        print "  - DOMAIN," $0                         >> "../ad-youtube-clash.yaml"
        print "  - \047+." $0 "\047"                   >> "../ad-youtube-clash-premium.yaml"
        print "address=/" $0 "/"                       >> "../ad-youtube-dnsmasq.conf"
        print $0                                       >> "../ad-youtube-domains.txt"
        print $0                                       >> "../ad-youtube-ikuai.txt"
        print "127.0.0.1 " $0                          >> "../ad-youtube-hosts.txt"
        print "HOST-SUFFIX," $0 ",REJECT"              >> "../ad-youtube-quantumult.yaml"
        print "DOMAIN-SUFFIX," $0 ",REJECT"            >> "../ad-youtube-shadowrocket.list"
        print "address /" $0 "/#"                      >> "../ad-youtube-smartdns.conf"
        print "DOMAIN," $0                             >> "../ad-youtube-surge.yaml"
        print "local-zone: \"" $0 "\" always_nxdomain" >> "../ad-youtube-unbound.conf"
        print $0 " CNAME ."                            >> "../ad-youtube-bind9.conf"
        print "* " $0 " CNAME ."                       >> "../ad-youtube-bind9.conf"
        print "||" $0 "^$client=127.0.0.1,dnstype=A"   >> "../ad-youtube-adguardhome-dnstype.txt"
    }' ./filter_data.tmp

    # sing-box 规则集: 官方纯格式, 不含任何元数据字段 (sing-box 严格解析, 多余字段会被拒绝)
    {
        printf '{\n  "version": 1,\n  "rules": [\n    {\n      "domain_suffix": [\n'
        awk '{ if (NR > 1) printf ",\n"; printf "        \"%s\"", $0 } END { if (NR > 0) printf "\n" }' ./filter_data.tmp
        printf '      ]\n    }\n  ]\n}\n'
    } >../ad-youtube-singbox.json

    # 编译 .srs 二进制规则集 (体积远小于 JSON, 加载更快; 编译失败不影响 JSON 产物)
    local sb_bin
    if sb_bin=$(find_singbox); then
        if "$sb_bin" rule-set compile ../ad-youtube-singbox.json -o ../ad-youtube-singbox.srs 2>/dev/null ||
            "$sb_bin" rule-set compile ../ad-youtube-singbox.json ../ad-youtube-singbox.srs 2>/dev/null; then
            echo "[singbox] ad-youtube-singbox.srs 编译完成 ($(du -h ../ad-youtube-singbox.srs | cut -f1))" >&2
        else
            rm -f ../ad-youtube-singbox.srs
            echo "[singbox] .srs 编译失败, 仅提供 JSON 规则集" >&2
        fi
    fi

    cd "$ORIG_PWD" && rm -rf ./ad-youtube-hosts
}

## Process
# Call GetData
GetData
# Call AnalyseData
AnalyseData
# Call OutputData
OutputData
