# Get Data
function GetData() {
    dhdb_checklist=(
        "https://github.com/Potterli20/file/releases/download/dns-hosts/dns-domain-blacklist_full.txt"
        "https://github.com/Potterli20/file/releases/download/dns-hosts/dns-domain-whitelist_full.txt"
        "https://github.com/Potterli20/file/releases/download/ad-hosts-pro/ad-domains.txt"
        "https://raw.githubusercontent.com/hezhijie0327/AdFilter/main/adfilter_domains.txt"
        "https://raw.githubusercontent.com/hezhijie0327/GFWList2AGH/main/gfwlist2domain/blacklist_full.txt"
        "https://raw.githubusercontent.com/hezhijie0327/GFWList2AGH/main/gfwlist2domain/whitelist_full.txt"
        "https://raw.githubusercontent.com/hezhijie0327/Trackerslist/main/trackerslist_combine.txt"
    )
    rm -rf "./Temp" && mkdir "./Temp" && cd "./Temp"
    for dhdb_checklist_task in "${!dhdb_checklist[@]}"; do
        curl -s --connect-timeout 15 "${dhdb_checklist[$dhdb_checklist_task]}" >> "./dhdb_checklist.tmp"
    done
}
# Analyse Data
function AnalyseData() {
    function GetOldData() {
        cat ../dhdb_*.txt | sort | uniq > "./dhdb_data.old"
    }
    domain_name_regex="^(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$"
    GetOldData && if [ ! -s "./dhdb_data.old" ]; then
        dhdb_data=($(cat "./dhdb_checklist.tmp" | tr "/:" "\n" | grep -E "${domain_name_regex}" | sort | uniq | awk "{ print $2 }"))
    else
        dhdb_data=($(cat "./dhdb_checklist.tmp" | tr "/:" "\n" | grep -E "${domain_name_regex}" | sort | uniq > dhdb_data.tmp && awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' "./dhdb_data.old" "./dhdb_data.tmp" | sort | uniq | awk "{ print $2 }"))
        if [ "${#dhdb_data[*]}" -le "300" ]; then
            dhdb_data=($(cat "./dhdb_checklist.tmp" | tr "/:" "\n" | grep -E "${domain_name_regex}" | shuf -n 1000 | sort | uniq | awk "{ print $2 }"))
        fi
    fi
}
# Output Data
function OutputData() {
    function GetDNSRecord() {
        dns_record_alidns=$(curl -s --connect-timeout 15 -H "accept: application/dns-json" "https://doh.pub/dns-query?name=${dhdb_data[$dhdb_data_task]}&type=A)
        dns_record_cloudflare=$(curl -s --connect-timeout 15 -H "accept: application/dns-json" "https://doh.opendns.com/dns-query?name=${dhdb_data[$dhdb_data_task]}&type=A")
        dns_record_google=$(curl -s --connect-timeout 15 -H "accept: application/dns-json" "https://anycast.dns.nextdns.io/dns-query?name=${dhdb_data[$dhdb_data_task]}&type=A)
    }
    function GetDNSStatus() {
        if [ "$(echo ${dns_record_alidns} | jq -Sr 'keys' | grep 'Answer')" != "" ]; then
            dns_status_alidns=$(echo "${dns_record_alidns}" | jq -Sr '.Answer|.[]|.type' | sort | uniq | grep "1" | head -n 1)
        else
            dns_status_alidns=""
        fi
        if [ "$(echo ${dns_record_cloudflare} | jq -Sr 'keys' | grep 'Answer')" != "" ]; then
            dns_status_cloudflare=$(echo "${dns_record_cloudflare}" | jq -Sr '.Answer|.[]|.type' | sort | uniq | grep "1" | head -n 1)
        else
            dns_status_cloudflare=""
        fi
        if [ "$(echo ${dns_record_google} | jq -Sr 'keys' | grep 'Answer')" != "" ]; then
            dns_status_google=$(echo "${dns_record_google}" | jq -Sr '.Answer|.[]|.type' | sort | uniq | grep "1" | head -n 1)
        else
            dns_status_google=""
        fi

    }
    function GetDNSResult() {
        ipv4_addr_regex="^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}$"
        if [ "${dns_status_alidns}" != "" ] && [ "${dns_status_google}" != "" ]; then
            dns_result_alidns=$(echo "${dns_record_alidns}" | jq -Sr '.Answer|.[]|.data' | sort | uniq | grep -E "${ipv4_addr_regex}" | head -n 1)
            dns_result_cloudflare=""
            dns_result_google=$(echo "${dns_record_google}" | jq -Sr '.Answer|.[]|.data' | sort | uniq | grep -E "${ipv4_addr_regex}" | head -n 1)
        elif [ "${dns_status_alidns}" != "" ] && [ "${dns_status_google}" == "" ]; then
            dns_result_alidns=$(echo "${dns_record_alidns}" | jq -Sr '.Answer|.[]|.data' | sort | uniq | grep -E "${ipv4_addr_regex}" | head -n 1)
            dns_result_cloudflare=""
            dns_result_google=""
        elif [ "${dns_status_alidns}" == "" ] && [ "${dns_status_google}" != "" ]; then
            dns_result_alidns=""
            dns_result_cloudflare=""
            dns_result_google=$(echo "${dns_record_google}" | jq -Sr '.Answer|.[]|.data' | sort | uniq | grep -E "${ipv4_addr_regex}" | head -n 1)
        else
            if [ "${dns_status_cloudflare}" != "" ]; then
                dns_result_alidns=""
                dns_result_cloudflare=$(echo "${dns_record_cloudflare}" | jq -Sr '.Answer|.[]|.data' | sort | uniq | grep -E "${ipv4_addr_regex}" | head -n 1)
                dns_result_google=""
            else
                dns_result_alidns=""
                dns_result_cloudflare=""
                dns_result_google=""
            fi
        fi
    }
    function GetWHOISResult() {
        if [ "${dns_result_alidns}" != "" ] && [ "${dns_result_google}" != "" ]; then
            whois_info_alidns=$(whois "${dns_result_alidns}" | tr "a-z" "A-Z" | grep -v "\#" | grep "COUNTRY\:" | sed "s/[[:space:]]//g;s/COUNTRY\://g" | tail -n 1 | rev | cut -c "1-2" | rev)
            whois_info_cloudflare=""
            whois_info_google=$(whois "${dns_result_google}" | tr "a-z" "A-Z" | grep -v "\#" | grep "COUNTRY\:" | sed "s/[[:space:]]//g;s/COUNTRY\://g" | tail -n 1 | rev | cut -c "1-2" | rev)
        elif [ "${dns_result_alidns}" != "" ] && [ "${dns_result_google}" == "" ]; then
            whois_info_alidns=$(whois "${dns_result_alidns}" | tr "a-z" "A-Z" | grep -v "\#" | grep "COUNTRY\:" | sed "s/[[:space:]]//g;s/COUNTRY\://g" | tail -n 1 | rev | cut -c "1-2" | rev)
            whois_info_cloudflare=""
            whois_info_google=""
        elif [ "${dns_result_alidns}" == "" ] && [ "${dns_result_google}" != "" ]; then
            whois_info_alidns=""
            whois_info_cloudflare=""
            whois_info_google=$(whois "${dns_result_google}" | tr "a-z" "A-Z" | grep -v "\#" | grep "COUNTRY\:" | sed "s/[[:space:]]//g;s/COUNTRY\://g" | tail -n 1 | rev | cut -c "1-2" | rev)
        else
            if [ "${dns_result_cloudflare}" != "" ]; then
                whois_info_alidns=""
                whois_info_cloudflare=$(whois "${dns_result_cloudflare}" | tr "a-z" "A-Z" | grep -v "\#" | grep "COUNTRY\:" | sed "s/[[:space:]]//g;s/COUNTRY\://g" | tail -n 1 | rev | cut -c "1-2" | rev)
                whois_info_google=""
            else
                whois_info_alidns=""
                whois_info_cloudflare=""
                whois_info_google=""
            fi
        fi
    }
    function AnalyseWHOISResult() {
        if [ "${whois_info_alidns}" != "" ] && [ "${whois_info_google}" != "" ]; then
            if [ "${whois_info_alidns}" == "CN" ] && [ "${whois_info_google}" == "CN" ]; then
                whois_result="#00CN"
            elif [ "${whois_info_alidns}" != "CN" ] && [ "${whois_info_google}" != "CN" ]; then
                whois_result="#0NCN"
            else
                whois_result="#0CDN"
            fi && error_code="#NULL" && dns_result_1="${dns_result_alidns}" && dns_result_2="${dns_result_google}" && whois_result_1="${whois_info_alidns}" && whois_result_2="${whois_info_google}"
        elif [ "${whois_info_alidns}" != "" ] && [ "${whois_info_google}" == "" ]; then
            if [ "${whois_info_alidns}" == "CN" ]; then
                whois_result="#00CN"
            else
                whois_result="#0NCN"
            fi && error_code="#NULL" && dns_result_1="${dns_result_alidns}" && dns_result_2="NULL" && whois_result_1="${whois_info_alidns}" && whois_result_2="NULL"
        elif [ "${whois_info_alidns}" == "" ] && [ "${whois_info_google}" != "" ]; then
            if [ "${whois_info_google}" == "CN" ]; then
                whois_result="#00CN" && error_code="#NULL"
            else
                whois_result="#11GR" && error_code="${whois_result}"
            fi && dns_result_1="NULL" && dns_result_2="${dns_result_google}" && whois_result_1="NULL" && whois_result_2="${whois_info_google}"
        else
            if [ "${whois_info_cloudflare}" != "" ]; then
                if [ "${whois_info_cloudflare}" == "CN" ]; then
                    whois_result="#00CN" && error_code="#NULL"
                else
                    whois_result="#11CR" && error_code="${whois_result}"
                fi && dns_result_1="NULL" && dns_result_2="${dns_result_cloudflare}" && whois_result_1="NULL" && whois_result_2="${whois_info_cloudflare}"
            else
                whois_result="#1111" && error_code="#DEAD" && dns_result_1="NULL" && dns_result_2="NULL" && whois_result_1="NULL" && whois_result_2="NULL"
            fi
        fi
    }
    function RateLimiter() {
        if [ "${whois_result}" == "#11CR" ] || [ "${whois_result}" == "#11GR" ]; then
            sleep 3
        elif [ "${whois_result}" == "#1111" ]; then
            sleep 2
        else
            sleep 1
        fi
    }
    result_cdn="0" && result_dead="0" && result_domestic="0" && result_error="0" && result_foreign="0" && time_strated=$(date "+%s") && time_limited="2700"
    for dhdb_data_task in "${!dhdb_data[@]}"; do
        if (( $(( $(date +%s) - ${time_strated})) < ${time_limited} )); then
            dhdb_data_original[$dhdb_data_task]="${dhdb_data[$dhdb_data_task]}" && GetDNSRecord && GetDNSStatus && GetDNSResult && GetWHOISResult && AnalyseWHOISResult && if [ "${whois_result}" == "#0CDN" ]; then
                echo "${dhdb_data_original[$dhdb_data_task]}" >> ./dhdb_domestic.tmp && result_cdn=$(( ${result_cdn} + 1 ))
            elif [ "${whois_result}" == "#00CN" ]; then
                echo "${dhdb_data_original[$dhdb_data_task]}" >> ./dhdb_domestic.tmp && result_domestic=$(( ${result_domestic} + 1 ))
            elif [ "${whois_result}" == "#0NCN" ]; then
                echo "${dhdb_data_original[$dhdb_data_task]}" >> ./dhdb_foreign.tmp && result_foreign=$(( ${result_foreign} + 1 ))
            else
                dhdb_data[$dhdb_data_task]="www.${dhdb_data[$dhdb_data_task]}" && GetDNSRecord && GetDNSStatus && RateLimiter && GetDNSResult && GetWHOISResult && AnalyseWHOISResult && if [ "${whois_result}" == "#0CDN" ]; then
                    echo "${dhdb_data_original[$dhdb_data_task]}" >> ./dhdb_domestic.tmp && result_cdn=$(( ${result_cdn} + 1 ))
                elif [ "${whois_result}" == "#00CN" ]; then
                    echo "${dhdb_data_original[$dhdb_data_task]}" >> ./dhdb_domestic.tmp && result_domestic=$(( ${result_domestic} + 1 ))
                elif [ "${whois_result}" == "#0NCN" ]; then
                    echo "${dhdb_data_original[$dhdb_data_task]}" >> ./dhdb_foreign.tmp && result_foreign=$(( ${result_foreign} + 1 ))
                elif [ "${whois_result}" == "#1111" ]; then
                    echo "${dhdb_data_original[$dhdb_data_task]}" >> ./dhdb_dead.tmp && result_dead=$(( ${result_dead} + 1 ))
                else
                    echo "${dhdb_data_original[$dhdb_data_task]}" >> ./dhdb_error.tmp && result_error=$(( ${result_error} + 1 ))
                fi
            fi && RateLimiter && echo "( Index: $(( ${dhdb_data_task} + 1 )) | Result: ${whois_result} | Error: ${error_code} | DNS1: ${dns_result_1} | DNS2: ${dns_result_2} | WHOIS1: ${whois_result_1} | WHOIS2: ${whois_result_2} | Domain: ${dhdb_data_original[$dhdb_data_task]} )"
        else
            break
        fi
    done && echo "( Dead: ${result_dead} | CDN: ${result_cdn} | Domestic: ${result_domestic} | Error: ${result_error} | Foreign: ${result_foreign} | Total: $(( ${result_cdn} + ${result_dead} + ${result_domestic} + ${result_error} + ${result_foreign} )) )"
    if [ ! -f "./dhdb_alive.tmp" ]; then
        if [ ! -f "./dhdb_domestic.tmp" ]; then
            touch "./dhdb_domestic.tmp"
        fi
        if [ ! -f "./dhdb_foreign.tmp" ]; then
            touch "./dhdb_foreign.tmp"
        fi
        cat "./dhdb_domestic.tmp" "./dhdb_foreign.tmp" | sort | uniq > "./dhdb_alive.tmp"
    fi
    if [ ! -f "./dhdb_dead.tmp" ]; then
        touch "./dhdb_dead.tmp"
    fi
    if [ ! -f "./dhdb_error.tmp" ]; then
        touch "./dhdb_error.tmp"
    fi
    if [ -f "../dhdb_alive.txt" ] && [ -f "../dhdb_dead.txt" ] && [ -f "../dhdb_domestic.txt" ] && [ -f "../dhdb_foreign.txt" ]; then
        cat ./dhdb_alive.tmp ../dhdb_alive.txt | sort | uniq > ./dhdb_alive.new
        cat ./dhdb_dead.tmp ../dhdb_dead.txt | sort | uniq > ./dhdb_dead.new
        cat ./dhdb_domestic.tmp ../dhdb_domestic.txt | sort | uniq > ./dhdb_domestic.new
        cat ./dhdb_foreign.tmp ../dhdb_foreign.txt | sort | uniq > ./dhdb_foreign.new
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_alive.new ./dhdb_dead.new > ../dhdb_dead.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_dead.new ./dhdb_alive.new > ../dhdb_alive.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_domestic.new ./dhdb_foreign.new > ./dhdb_foreign.mix
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_foreign.new ./dhdb_domestic.new > ./dhdb_domestic.mix
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ../dhdb_dead.txt ./dhdb_domestic.mix > ../dhdb_domestic.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ../dhdb_dead.txt ./dhdb_foreign.mix > ../dhdb_foreign.txt
    elif [ -f "../dhdb_alive.txt" ] && [ -f "../dhdb_dead.txt" ] && [ -f "../dhdb_domestic.txt" ] && [ ! -f "../dhdb_foreign.txt" ]; then
        cat ./dhdb_alive.tmp ../dhdb_alive.txt | sort | uniq > ./dhdb_alive.new
        cat ./dhdb_dead.tmp ../dhdb_dead.txt | sort | uniq > ./dhdb_dead.new
        cat ./dhdb_domestic.tmp ../dhdb_domestic.txt | sort | uniq > ./dhdb_domestic.new
        cat ./dhdb_foreign.tmp | sort | uniq > ./dhdb_foreign.new
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_alive.new ./dhdb_dead.new > ../dhdb_dead.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_dead.new ./dhdb_alive.new > ../dhdb_alive.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_domestic.new ./dhdb_foreign.new > ./dhdb_foreign.mix
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_foreign.new ./dhdb_domestic.new > ./dhdb_domestic.mix
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ../dhdb_dead.txt ./dhdb_domestic.mix > ../dhdb_domestic.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ../dhdb_dead.txt ./dhdb_foreign.mix > ../dhdb_foreign.txt
    elif [ -f "../dhdb_alive.txt" ] && [ -f "../dhdb_dead.txt" ] && [ ! -f "../dhdb_domestic.txt" ] && [ -f "../dhdb_foreign.txt" ]; then
        cat ./dhdb_alive.tmp ../dhdb_alive.txt | sort | uniq > ./dhdb_alive.new
        cat ./dhdb_dead.tmp ../dhdb_dead.txt | sort | uniq > ./dhdb_dead.new
        cat ./dhdb_domestic.tmp | sort | uniq > ./dhdb_domestic.new
        cat ./dhdb_foreign.tmp ../dhdb_foreign.txt | sort | uniq > ./dhdb_foreign.new
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_alive.new ./dhdb_dead.new > ../dhdb_dead.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_dead.new ./dhdb_alive.new > ../dhdb_alive.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_domestic.new ./dhdb_foreign.new > ./dhdb_foreign.mix
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_foreign.new ./dhdb_domestic.new > ./dhdb_domestic.mix
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ../dhdb_dead.txt ./dhdb_domestic.mix > ../dhdb_domestic.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ../dhdb_dead.txt ./dhdb_foreign.mix > ../dhdb_foreign.txt
    elif [ -f "../dhdb_alive.txt" ] && [ -f "../dhdb_dead.txt" ] && [ ! -f "../dhdb_domestic.txt" ] && [ ! -f "../dhdb_foreign.txt" ]; then
        cat ./dhdb_alive.tmp ../dhdb_alive.txt | sort | uniq > ./dhdb_alive.new
        cat ./dhdb_dead.tmp ../dhdb_dead.txt | sort | uniq > ./dhdb_dead.new
        cat ./dhdb_domestic.tmp | sort | uniq > ./dhdb_domestic.new
        cat ./dhdb_foreign.tmp | sort | uniq > ./dhdb_foreign.new
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_alive.new ./dhdb_dead.new > ../dhdb_dead.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_dead.new ./dhdb_alive.new > ../dhdb_alive.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_domestic.new ./dhdb_foreign.new > ./dhdb_foreign.mix
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_foreign.new ./dhdb_domestic.new > ./dhdb_domestic.mix
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ../dhdb_dead.txt ./dhdb_domestic.mix > ../dhdb_domestic.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ../dhdb_dead.txt ./dhdb_foreign.mix > ../dhdb_foreign.txt
    elif [ -f "../dhdb_alive.txt" ] && [ ! -f "../dhdb_dead.txt" ]; then
        cat ./dhdb_alive.tmp ../dhdb_alive.txt | sort | uniq > ./dhdb_alive.new
        cat ./dhdb_dead.tmp | sort | uniq > ./dhdb_dead.new
        cat ./dhdb_domestic.tmp ../dhdb_domestic.txt | sort | uniq > ./dhdb_domestic.new
        cat ./dhdb_foreign.tmp ../dhdb_foreign.txt | sort | uniq > ./dhdb_foreign.new
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_alive.new ./dhdb_dead.new > ../dhdb_dead.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_dead.new ./dhdb_alive.new > ../dhdb_alive.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_domestic.new ./dhdb_foreign.new > ./dhdb_foreign.mix
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_foreign.new ./dhdb_domestic.new > ./dhdb_domestic.mix
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ../dhdb_dead.txt ./dhdb_domestic.mix > ../dhdb_domestic.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ../dhdb_dead.txt ./dhdb_foreign.mix > ../dhdb_foreign.txt
    elif [ ! -f "../dhdb_alive.txt" ] && [ -f "../dhdb_dead.txt" ]; then
        cat ./dhdb_alive.tmp | sort | uniq > ./dhdb_alive.new
        cat ./dhdb_dead.tmp ../dhdb_dead.txt | sort | uniq > ./dhdb_dead.new
        cat ./dhdb_domestic.tmp | sort | uniq > ./dhdb_domestic.new
        cat ./dhdb_foreign.tmp | sort | uniq > ./dhdb_foreign.new
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_alive.new ./dhdb_dead.new > ../dhdb_dead.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_dead.new ./dhdb_alive.new > ../dhdb_alive.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_domestic.new ./dhdb_foreign.new > ./dhdb_foreign.mix
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./dhdb_foreign.new ./dhdb_domestic.new > ./dhdb_domestic.mix
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ../dhdb_dead.txt ./dhdb_domestic.mix > ../dhdb_domestic.txt
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ../dhdb_dead.txt ./dhdb_foreign.mix > ../dhdb_foreign.txt
    else
        cat ./dhdb_alive.tmp | sort | uniq > ../dhdb_alive.txt
        cat ./dhdb_dead.tmp | sort | uniq > ../dhdb_dead.txt
        cat ./dhdb_domestic.tmp | sort | uniq > ../dhdb_domestic.txt
        cat ./dhdb_foreign.tmp | sort | uniq > ../dhdb_foreign.txt
    fi
    if [ ! -f "../dhdb_error.txt" ]; then
        cat ./dhdb_error.tmp | sort | uniq > ../dhdb_error.txt
    else
        cat ./dhdb_error.tmp ../dhdb_error.txt | sort | uniq > ./dhdb_error.new
        if [ ! -s "../dhdb_alive.txt" ] || [ ! -s "../dhdb_dead.txt" ]; then
            cat ./dhdb_error.new | sort | uniq > ../dhdb_error.txt
        else
            awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ../dhdb_alive.txt ./dhdb_error.new > ./dhdb_error.mix
            awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ../dhdb_dead.txt ./dhdb_error.mix > ../dhdb_error.txt
        fi
    fi && cd .. && rm -rf ./Temp && exit 0
}

## Process
# Call GetData
GetData
# Call AnalyseData
AnalyseData
# Call OutputData
OutputData
