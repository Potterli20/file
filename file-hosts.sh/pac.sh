function GetData() {
    china_domain=(
        "https://github.com/Potterli20/file/releases/download/dns-hosts-adgh-pro/dnshosts-adgh-pro-adguardhome-blacklist_full_combine.txt"
    )
    gfwlist_domain=(
        "https://github.com/Potterli20/file/releases/download/dns-hosts-adgh-pro/dnshosts-adgh-pro-adguardhome-whitelist_full_combine.txt"
    )
    rm -rf ./listpac_* ./Temp && mkdir ./Temp && cd ./Temp
    for china_domain_task in "${!china_domain[@]}"; do
        curl -m 10 -s -L --connect-timeout 15 -0 ./china_domain.tmp "${china_domain[$china_domain_task]}"
    done
    for gfwlist_domain_task in "${!gfwlist_domain[@]}"; do
        curl -m 10 -s -L --connect-timeout 15 -0 ./gfwlist_domain.tmp "${gfwlist_domain[$gfwlist_domain_task]}"
    done
}
# Analyse Data
function AnalyseData() {
    china_data=($(cat ./china_domain.tmp | sed "1,15d;s/\[\///g;s/\/\]//g;s/\//\n/g" | sed 's/[ ]*//g' | sed '/^$/d' | sort | uniq | awk "{ print $2 }"))
    gfwlist_data=($(cat ./gfwlist_domain.tmp | sed "1,25d;s/\[\///g;s/\/\]//g;s/\//\n/g" | sed 's/[ ]*//g' | sed '/^$/d' | sort | uniq | awk "{ print $2 }"))
}
# Generate Header Information
function GenerateHeaderInformation() {
    listpac_checksum=$(TZ=UTC-8 date "+%s" | base64)
    listpac_expires="24 hours (update frequency)"
    listpac_homepage="https://file.trli.club:2083/pac/"
    listpac_timeupdated=$(TZ=UTC-8 date -d @$(echo "${listpac_checksum}" | base64 -d) "+%Y-%m-%dT%H:%M:%S%:z")
    listpac_title=$(if [ "${china_gfwlist}" == "china" ]; then echo "Trli's ChinaList"; elif [ "${china_gfwlist}" == "gfwlist" ]; then echo "Trli's GFWList"; else exit 1; fi)
    function listpac_autoproxy() {
        echo "[AutoProxy 0.2.9]" >../listpac_${china_gfwlist}_autoproxy.txt
        echo "! Checksum: ${listpac_checksum}" >>../listpac_${china_gfwlist}_autoproxy.txt
        echo "! Title: ${listpac_title} for Auto Proxy" >>../listpac_${china_gfwlist}_autoproxy.txt
        echo "! TimeUpdated: ${listpac_timeupdated}" >>../listpac_${china_gfwlist}_autoproxy.txt
        echo "! Expires: ${listpac_expires}" >>../listpac_${china_gfwlist}_autoproxy.txt
        echo "! Homepage: ${listpac_homepage}" >>../listpac_${china_gfwlist}_autoproxy.txt
    }
    function listpac_clash() {
        echo "payload:" >../listpac_${china_gfwlist}_clash.yaml
        echo "# Checksum: ${listpac_checksum}" >>../listpac_${china_gfwlist}_clash.yaml
        echo "# Title: ${listpac_title} for Clash" >>../listpac_${china_gfwlist}_clash.yaml
        echo "# TimeUpdated: ${listpac_timeupdated}" >>../listpac_${china_gfwlist}_clash.yaml
        echo "# Expires: ${listpac_expires}" >>../listpac_${china_gfwlist}_clash.yaml
        echo "# Homepage: ${listpac_homepage}" >>../listpac_${china_gfwlist}_clash.yaml
    }
    function listpac_clash_premium() {
        echo "payload:" >../listpac_${china_gfwlist}_clash_premium.yaml
        echo "# Checksum: ${listpac_checksum}" >>../listpac_${china_gfwlist}_clash_premium.yaml
        echo "# Title: ${listpac_title} for Clash Premium" >>../listpac_${china_gfwlist}_clash_premium.yaml
        echo "# TimeUpdated: ${listpac_timeupdated}" >>../listpac_${china_gfwlist}_clash_premium.yaml
        echo "# Expires: ${listpac_expires}" >>../listpac_${china_gfwlist}_clash_premium.yaml
        echo "# Homepage: ${listpac_homepage}" >>../listpac_${china_gfwlist}_clash_premium.yaml
    }
    function listpac_shadowrocket() {
        echo "# Checksum: ${listpac_checksum}" >../listpac_${china_gfwlist}_shadowrocket.conf
        echo "# Title: ${listpac_title} for Shadowrocket" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "# TimeUpdated: ${listpac_timeupdated}" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "# Expires: ${listpac_expires}" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "# Homepage: ${listpac_homepage}" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "[General]" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "bypass-system = true" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "bypass-tun = 10.0.0.0/8, 127.0.0.0/8, 169.254.0.0/16, 172.16.0.0/12, 192.0.0.0/24, 192.0.2.0/24, 192.88.99.0/24, 192.168.0.0/16, 198.18.0.0/15, 198.51.100.0/24, 203.0.113.0/24, 224.0.0.0/4, 240.0.0.0/4, 255.255.255.255/32" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "dns-server = https://dns.alidns.com/dns-query, https://dns.google/dns-query, https://doh.pub/dns-query,https://1dot1dot1dot1.cloudflare-dns.com/dns-query, https://doh.opendns.com/dns-query, https://odoh.cloudflare-dns.com/dns-query, https://doh.dns.sb/dns-query, https://dns-unfiltered.adguard.com/dns-query," >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "ipv6 = true" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "skip-proxy = 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, localhost, *.local" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "[Rule]" >>../listpac_${china_gfwlist}_shadowrocket.conf
    }
    function listpac_surge() {
        echo "# Checksum: ${listpac_checksum}" >../listpac_${china_gfwlist}_surge.yaml
        echo "# Title: ${listpac_title} for Surge" >>../listpac_${china_gfwlist}_surge.yaml
        echo "# TimeUpdated: ${listpac_timeupdated}" >>../listpac_${china_gfwlist}_surge.yaml
        echo "# Expires: ${listpac_expires}" >>../listpac_${china_gfwlist}_surge.yaml
        echo "# Homepage: ${listpac_homepage}" >>../listpac_${china_gfwlist}_surge.yaml
    }
    function listpac_quantumult() {
        echo "# Checksum: ${listpac_checksum}" >../listpac_${china_gfwlist}_quantumult.yaml
        echo "# Title: ${listpac_title} for Quantumult" >>../listpac_${china_gfwlist}_quantumult.yaml
        echo "# TimeUpdated: ${listpac_timeupdated}" >>../listpac_${china_gfwlist}_quantumult.yaml
        echo "# Expires: ${listpac_expires}" >>../listpac_${china_gfwlist}_quantumult.yaml
        echo "# Homepage: ${listpac_homepage}" >>../listpac_${china_gfwlist}_quantumult.yaml
    }
    function listpac_v2raya() {
        echo "# Checksum: ${listpac_checksum}" >../listpac_${china_gfwlist}_v2raya.txt
        echo "# Title: ${listpac_title} for v2rayA" >>../listpac_${china_gfwlist}_v2raya.txt
        echo "# TimeUpdated: ${listpac_timeupdated}" >>../listpac_${china_gfwlist}_v2raya.txt
        echo "# Expires: ${listpac_expires}" >>../listpac_${china_gfwlist}_v2raya.txt
        echo "# Homepage: ${listpac_homepage}" >>../listpac_${china_gfwlist}_v2raya.txt
        echo -n "domain(" >>../listpac_${china_gfwlist}_v2raya.txt
    }
    function listpac_v2rayn() {
        echo "# Checksum: ${listpac_checksum}" >../listpac_${china_gfwlist}_v2rayn.txt
        echo "# Title: ${listpac_title} for v2rayN" >>../listpac_${china_gfwlist}_v2rayn.txt
        echo "# TimeUpdated: ${listpac_timeupdated}" >>../listpac_${china_gfwlist}_v2rayn.txt
        echo "# Expires: ${listpac_expires}" >>../listpac_${china_gfwlist}_v2rayn.txt
        echo "# Homepage: ${listpac_homepage}" >>../listpac_${china_gfwlist}_v2rayn.txt
    }
    listpac_autoproxy
    listpac_clash
    listpac_clash_premium
    listpac_shadowrocket
    listpac_surge
    listpac_quantumult
    listpac_v2raya
    listpac_v2rayn
}
# Generate Footer Information
function GenerateFooterInformation() {
    function listpac_shadowrocket() {
        echo "DOMAIN-SET,https://file.trli.club:2083/ad-hosts/ad-hosts-pro/ad-shadowrocket.list" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "[URL Rewrite]" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "#all" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/(\w+\.)?(adclick|ads([0-9]+)?|adx|adserver|adformat|analysis|analytics|banners?|click|counter|delivery|log|log-?\w+?|pagead|stat|stats|statis|trace|track|tracking|uniad)\.\w+\.(com|cn|org|info|io|net|vn|com.vn)" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "#facebook" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://graph.facebook.com/.+activities" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://graph.facebook.com/.+advertiser_id=" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://graph.facebook.com/.+events" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://graph.facebook.com/.+skadnetwork" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://graph.facebook.com/network_ads_common" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.facebook\.com\/adnw_logging" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.facebook\.com\/adnw_sync" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/connect\.facebook\.net\/en_US\/fbadnw\.js _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "#nhaccuatui" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://graph.nhaccuatui.com/.+ads" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://graph.nhaccuatui.com/.+logs" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://graph.nhaccuatui.com/.+deviceinfo" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "#spotify" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://spclient.wg.spotify.com/ad-logic" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://spclient.wg.spotify.com/ads" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://spclient.wg.spotify.com/.+ad_slot" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://spclient.wg.spotify.com/.+banners" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://spclient.wg.spotify.com/.+crashlytics" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://spclient.wg.spotify.com/.+doubleclick" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://spclient.wg.spotify.com/.+enabled-tracks" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://spclient.wg.spotify.com/.+event" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://spclient.wg.spotify.com/.+promoted" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?://spclient.wg.spotify.com/.+sponsored" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "#google" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "#^https?:\/\/.+\.googlevideo\.com\/.+ctier" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.googlevideo\.com\/.+oad=" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.googlevideo\.com\/.+owc=" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.googlevideo\.com\/ptracking" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.googlevideo\.com\/videogoodput" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/[\s\S]*\.googlevideo\.com\/.+&(oad|ctier) _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.youtube\.com\/.+adformat" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.youtube\.com\/.+get_ads" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.youtube\.com\/api\/stats\/ads" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.youtube\.com\/api\/stats\/atr" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.youtube\.com\/api\/stats\/qoe" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.youtube\.com\/csi_204" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.youtube\.com\/error_204" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.youtube\.com\/gen_204" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.youtube\.com\/generate_204" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.youtube\.com\/get_midroll" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.youtube\.com\/pagead" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.youtube\.com\/pcs\/activeview" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.youtube\.com\/ptracking" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.googleapis.com/.+ad_break" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.googleapis.com/.+log_event" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.googleapis.com/adsmeasurement" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/[\w-]+\.googlevideo\.com\/.+&(oad|ctier) _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/(www|s)\.youtube\.com\/api\/stats\/ads _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/(www|s)\.youtube\.com\/api\/stats\/qoe _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/(www|s)\.youtube\.com\/(pagead|ptracking) _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/\s.youtube.com/api/stats/qoe?.*adformat= _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.googlesyndication\.com\/pagead\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/youtubei\.googleapis\.com\/youtubei\/v1\/att\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/youtubei\.googleapis\.com\/youtubei\/v1\/log_event\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "#tiktok" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.tiktokv\.com\/.+stats" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.tiktokv\.com\/api\/ad" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.musical\.ly\/.+stats" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.musical\.ly\/api\/ad" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.snssdk\.com\/.+app_log" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.snssdk\.com\/.+promotion" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.snssdk\.com\/.+report" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.snssdk\.com\/.+stats" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.snssdk\.com\/api\/ad" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.snssdk\.com\/monitor" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.amemv\.com\/.+app_log" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.amemv\.com\/.+report" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.amemv\.com\/.+stats" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+\.amemv\.com\/api\/ad" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+?\.(musical|snssdk|tiktokv)\.(com|ly)\/(api|motor)\/ad\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/api\d?\.tiktokv\.com\/api\/ad\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/[\w-]+\.(amemv|musical|snssdk|tiktokv)\.(com|ly)\/(api|motor)\/ad\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/api\d?\.musical\.ly\/api\/ad\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+?\.(musical|snssdk)\.(com|ly)\/(api|motor)\/ad\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+?\.(snssdk|amemv)\.com\/api\/ad\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/frontier\.snssdk\.com\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/aweme\.snssdk\.com\/aweme\/v1\/aweme\/stats\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/aweme\.snssdk\.com\/aweme\/v1\/device\/update\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/aweme\.snssdk\.com\/aweme\/v1\/screen\/ad\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/aweme\.snssdk\.com\/service\/1\/app_logout\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/aweme\.snssdk\.com\/service\/2\/app_log _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/[\w-]+\.snssdk\.com\/.+_ad\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/[\s\S]*\.snssdk\.com\/api\/ad\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/.+?\.snssdk\.com\/motor\/operation\/activity\/display\/config\/V2\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "# Redirect Google Search Service" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/(www.)?(g|google)\.cn https://www.google.com 302" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "# Redirect Google Maps Service" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/(ditu|maps).google\.cn https://maps.google.com 302" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "#taobao" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/acs\.m\.taobao\.com\/gw\/mtop\.alibaba\.advertisementservice\.getadv _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/acs\.m\.taobao\.com\/gw\/mtop\.alimusic\.common\.mobileservice\.startinit\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/acs\.m\.taobao\.com\/gw\/mtop\.film\.mtopadvertiseapi\.queryadvertise\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/acs\.m\.taobao\.com\/gw\/mtop\.o2o\.ad\.gateway\.get\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/acs\.m\.taobao\.com\/gw\/mtop\.taobao\.idle\.home\.welcome\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/acs\.m\.taobao\.com\/gw\/mtop\.trip\.activity\.querytmsresources\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "#jd" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/(bdsp-x|dsp-x)\.jd\.com\/adx\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/(bdsp-x|dsp-x)\.jd\.com\/adx\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/api\.m\.jd\.com\/openUpgrade _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/bdsp-x\.jd\.com\/adx\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/img\d+\.360buyimg\.com\/jddjadvertise\/ _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/ms\.jr\.jd\.com\/gw\/generic\/aladdin\/(new)?na\/m\/getLoadingPicture _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/ms\.jr\.jd\.com\/gw\/generic\/base\/(new)?na\/m\/adInfo _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "# Redirect False to True" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "# > IGN China to IGN Global" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/(www.)?ign\.xn--fiqs8s\/ http://cn.ign.com/ccpref/us 302" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "# AbeamTV _ api.abema.io" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^https?:\/\/api\.abema\.io\/v\d\/ip\/check _ REJECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "# bilibili Intl" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "(^https?:\/\/app\.biliintl\.com\/intl\/.+)(&s_locale=zh-Hans_[A-Z]{2})(.+) $1&s_locale=en-US_US$3 302" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "(^https?:\/\/app\.biliintl\.com\/intl\/.+)(&sim_code=\d+)(.+) $1$3 302" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "# AICoin" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^http:\/\/(www.)?aicoin\.cn\/$ https://www.aicoin.cn/?long_lives_aicoin=%22live%22 302" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "# tiktokv" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "(?<=_region=)CN(?=&) TW 307" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "(?<=&mcc_mnc=)4 2 307" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "^(https?:\/\/(tnc|dm)[\w-]+\.\w+\.com\/.+)(\?)(.+) $1$3 302" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "(^https?:\/\/*\.\w{4}okv.com\/.+&.+)(\d{2}\.3\.\d)(.+) $118.0$3 302" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "[MITM]" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "enable = true" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "hostname = *.tiktokv.com,*.byteoversea.com,*.tik-tokapi.com,*.googlevideo.com,app.biliintl.com,www.cocomanhua.com,www.ohmanhua.com,*.tiktokcdn.com,*.ipstatp.com,*.snapkit.com,*.appsflyer.com,*.googleapis.com,raph.nhaccuatui.com, spclient.wg.spotify.com,*.youtube.com,*.youtu.be,*googleapis.com" >>../listpac_${china_gfwlist}_shadowrocket.conf

    }
    function listpac_v2raya() {
        if [ "${china_gfwlist}" == "china" ]; then
            echo -n ")->direct" >>../listpac_${china_gfwlist}_v2raya.txt
        else
            echo -n ")->proxy" >>../listpac_${china_gfwlist}_v2raya.txt
        fi
        sed -i 's/,)/)/g' "../listpac_${china_gfwlist}_v2raya.txt"
    }
    listpac_shadowrocket
    listpac_v2raya
}
# Encode Data
function EncodeData() {
    function listpac_autoproxy() {
        cat ../listpac_${china_gfwlist}_autoproxy.txt | base64 >../listpac_${china_gfwlist}_autoproxy.base64
        mv ../listpac_${china_gfwlist}_autoproxy.base64 ../listpac_${china_gfwlist}_autoproxy.txt
    }
    listpac_autoproxy
}
# Output Data
function OutputData() {
    china_gfwlist="china" && GenerateHeaderInformation
    for china_data_task in "${!china_data[@]}"; do
        echo "@@||${china_data[china_data_task]}^" >>../listpac_${china_gfwlist}_autoproxy.txt
        echo "  - DOMAIN-SUFFIX,${china_data[china_data_task]}" >>../listpac_${china_gfwlist}_clash.yaml
        echo "  - '+.${china_data[china_data_task]}'" >>../listpac_${china_gfwlist}_clash_premium.yaml
        echo "DOMAIN-SUFFIX,${china_data[china_data_task]},DIRECT" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "DOMAIN-SUFFIX,${china_data[china_data_task]},DIRECT" >>../listpac_${china_gfwlist}_surge.yaml
        echo "DOMAIN-SUFFIX,${china_data[china_data_task]},DIRECT" >>../listpac_${china_gfwlist}_quantumult.yaml
        echo -n "domain:${china_data[china_data_task]}," >>../listpac_${china_gfwlist}_v2raya.txt
        echo "domain:${china_data[china_data_task]}," >>../listpac_${china_gfwlist}_v2rayn.txt
    done
    GenerateFooterInformation && EncodeData
    china_gfwlist="gfwlist" && GenerateHeaderInformation
    for gfwlist_data_task in "${!gfwlist_data[@]}"; do
        echo "||${gfwlist_data[gfwlist_data_task]}^" >>../listpac_${china_gfwlist}_autoproxy.txt
        echo "  - DOMAIN-SUFFIX,${gfwlist_data[gfwlist_data_task]}" >>../listpac_${china_gfwlist}_clash.yaml
        echo "  - '+.${gfwlist_data[gfwlist_data_task]}'" >>../listpac_${china_gfwlist}_clash_premium.yaml
        echo "DOMAIN-SUFFIX,${gfwlist_data[gfwlist_data_task]},PROXY" >>../listpac_${china_gfwlist}_shadowrocket.conf
        echo "DOMAIN-SUFFIX,${gfwlist_data[gfwlist_data_task]},PROXY" >>../listpac_${china_gfwlist}_surge.yaml
        echo "DOMAIN-SUFFIX,${gfwlist_data[gfwlist_data_task]},PROXY" >>../listpac_${china_gfwlist}_quantumult.yaml
        echo -n "domain:${gfwlist_data[gfwlist_data_task]}," >>../listpac_${china_gfwlist}_v2raya.txt
        echo "domain:${gfwlist_data[gfwlist_data_task]}," >>../listpac_${china_gfwlist}_v2rayn.txt
    done
    GenerateFooterInformation && EncodeData
    cd .. && rm -rf ./Temp
    exit 0
}
## Process
# Call GetData
GetData
# Call AnalyseData
AnalyseData
# Call OutputData
OutputData
