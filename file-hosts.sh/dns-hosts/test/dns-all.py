import requests
import re
import base64
import os
import glob
import shutil # Import shutil for directory removal

def get_data():
    """
    Fetches data from specified URLs.
    """
    print("GetData running...")
    cnacc_domain = [
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/Domains/china/video-domains",
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/Domains/china/china-root",
        "https://github.com/Potterli20/file/releases/download/github-hosts/bilibili-cdn.txt",
        "https://raw.githubusercontent.com/pexcn/daily/gh-pages/chinalist/chinalist.txt",
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt",
        "https://raw.githubusercontent.com/hq450/fancyss/master/rules/WhiteList_new.txt",
        "https://raw.githubusercontent.com/hq450/fancyss/master/rules/apple_china.txt",
        "https://raw.githubusercontent.com/hq450/fancyss/master/rules/cdn.txt",
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/win-update.txt",
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/apple-cn.txt",
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/Domains/china/Domains",
        "https://raw.githubusercontent.com/Loyalsoldier/domain-list-custom/release/apple.txt",
        "https://raw.githubusercontent.com/Loyalsoldier/domain-list-custom/release/icloud.txt",
        "https://raw.githubusercontent.com/Loyalsoldier/domain-list-custom/release/geolocation-cn.txt",
        "https://raw.githubusercontent.com/Loyalsoldier/domain-list-custom/release/cn.txt",
        "https://raw.githubusercontent.com/v2fly/domain-list-community/release/apple.txt",
        "https://raw.githubusercontent.com/v2fly/domain-list-community/release/icloud.txt",
        "https://raw.githubusercontent.com/v2fly/domain-list-community/release/cn.txt",
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/China/China_Domain.list",
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/Domains/apple/Domains",
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-tld-list.txt"
    ]
    cnacc_trusted = [
        "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf",
        "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf",
        "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/google.china.conf"
    ]
    gfwlist_base64 = [
        "https://raw.githubusercontent.com/Loukky/gfwlist-by-loukky/master/gfwlist.txt",
        "https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt",
        "https://raw.githubusercontent.com/poctopus/gfwlist-plus/master/gfwlist-plus.txt",
        "https://raw.githubusercontent.com/Loyalsoldier/domain-list-custom/release/gfwlist.txt"
    ]
    gfwlist_domain = [
        "https://github.com/Potterli20/file/releases/download/github-hosts/bilibili-cdn.txt",
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-tld-list.txt",
        "https://raw.githubusercontent.com/filteryab/ir-blocked-domain/main/data/ir-blocked-domain",
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/Domains/apple/Domains",
        "https://raw.githubusercontent.com/SukkaW/Surge/master/Source/domainset/icloud_private_relay.conf",
        "https://raw.githubusercontent.com/missdeer/blocklist/master/toblock-optimized.lst",
        "https://gitlab.com/Wiggum27/blockers/-/raw/master/hosts",
        "https://raw.githubusercontent.com/smed79/blacklist/master/extra/facebook.txt",
        "https://dl.red.flag.domains/red.flag.domains.txt",
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/Global/Global_Domain.list",
        "https://raw.githubusercontent.com/Loyalsoldier/domain-list-custom/release/steam.txt",
        "https://raw.githubusercontent.com/pexcn/daily/gh-pages/gfwlist/gfwlist.txt",
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/Domains/gfw/Domains",
        "https://github.com/Potterli20/file/releases/download/github-hosts/ad-edge-hosts.txt",
        "https://github.com/Potterli20/file/releases/download/cn-blocked-domain/domains.txt",
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/gfw.txt",
        "https://raw.githubusercontent.com/schrebra/Windows.10.DNS.Block.List/main/hosts.txt",
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/pihole-google.txt",
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/youtubeparsed",
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/shortlinksparsed",
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/proxiesparsed",
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/productsparsed",
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/mailparsed",
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/generalparsed",
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/fontsparsed",
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/firebaseparsed",
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/doubleclickparsed",
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/domainsparsed",
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/dnsparsed",
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/androidparsed",
        "https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/analyticsparsed",
        "https://raw.githubusercontent.com/Loyalsoldier/cn-blocked-domain/release/domains.txt",
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt",
        "https://raw.githubusercontent.com/pexcn/gfwlist-extras/master/gfwlist-extras.txt",
        "https://raw.githubusercontent.com/hq450/fancyss/master/rules/gfwlist.conf",
        "https://raw.githubusercontent.com/Ewpratten/youtube_ad_blocklist/master/blocklist.txt",
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/greatfire.txt",
        "https://raw.githubusercontent.com/kboghdady/youTube_ads_4_pi-hole/master/youtubelist.txt",
        "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt",
        "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/AmazonFireTV.txt",
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/win-spy.txt",
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/win-extra.txt",
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/youtubeblacklist.txt",
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/blockeverything.txt",
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/ad-block-YouTube-Project.txt"
    ]
    gfwlist2agh_modify = [
        "https://raw.githubusercontent.com/Potterli20/file/refs/heads/main/file-hosts/gfwlist2agh_modify/gfwlist2agh_modify_final.txt"
    ]

    output_dir = "./output"
    os.makedirs(output_dir, exist_ok=True)

    def download_urls(urls, output_file, decode_base64=False, strip_leading_dot=False):
        # Ensure the directory for the output file exists
        output_file_dir = os.path.dirname(output_file)
        if output_file_dir: # Check if output_file has a directory part
             os.makedirs(output_file_dir, exist_ok=True)

        with open(output_file, 'w', encoding='utf-8') as f:
            for url in urls:
                try:
                    print(f"Downloading: {url}") # Added for debugging
                    response = requests.get(url, timeout=15)
                    response.raise_for_status()  # Raise an exception for bad status codes
                    content = response.text
                    if decode_base64:
                        try:
                            content = base64.b64decode(content).decode('utf-8')
                        except Exception as e: # Catch potential base64 decoding errors
                            print(f"Warning: Could not base64 decode {url}: {e}")
                            continue
                    if strip_leading_dot:
                         # Remove leading dots from each line
                         content = '\n'.join(line.lstrip('.') for line in content.splitlines())

                    f.write(content + '\n')
                except requests.exceptions.RequestException as e:
                    print(f"Error downloading {url}: {e}")
                except Exception as e: # Catch other potential errors during processing
                    print(f"An unexpected error occurred while processing {url}: {e}")

    download_urls(cnacc_domain, os.path.join(output_dir, "cnacc_domain.tmp"), strip_leading_dot=True)
    download_urls(cnacc_trusted, os.path.join(output_dir, "cnacc_trusted.tmp"))
    download_urls(gfwlist_base64, os.path.join(output_dir, "gfwlist_base64.tmp"), decode_base64=True)
    download_urls(gfwlist_domain, os.path.join(output_dir, "gfwlist_domain.tmp"), strip_leading_dot=True)

def analyse_data():
    """
    Analyzes and processes the fetched data.
    """
    print("AnalyseData running...")

    output_dir = "./output"
    tmp_dir = os.path.join(output_dir, "tmp")
    os.makedirs(tmp_dir, exist_ok=True)

    # Regex to validate domain format as in the bash script
    domain_regex = re.compile(r'^([a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$|^[a-zA-Z0-9]+\.(cn|org\.cn|ac\.cn|mil\.cn|net\.cn|gov\.cn|com\.cn|edu\.cn)$')

    def is_valid_domain(domain):
        # Filter IP addresses (basic check)
        if re.match(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$', domain):
            return False
        # Filter domains with invalid characters
        if re.search(r'[^a-zA-Z0-9.-]', domain):
            return False
        # Ensure valid domain structure using the main regex
        if not domain_regex.match(domain):
            return False
        return True

    def process_file(input_file, output_file, remove_prefixes=None):
        domains = set()
        try:
            with open(input_file, 'r', encoding='utf-8') as f:
                for line in f:
                    line = line.strip()
                    if not line or line.startswith('#'):
                        continue
                    if remove_prefixes:
                        for prefix in remove_prefixes:
                            if line.startswith(prefix):
                                line = line[len(prefix):]

                    # Apply is_valid_domain check
                    if is_valid_domain(line):
                        domains.add(line)
        except FileNotFoundError:
            print(f"Warning: {input_file} not found.")
            return set()
        except Exception as e:
             print(f"An error occurred while processing {input_file}: {e}")
             return set()

        # Ensure the output file directory exists
        output_file_dir = os.path.dirname(output_file)
        if output_file_dir:
             os.makedirs(output_file_dir, exist_ok=True)

        with open(output_file, 'w', encoding='utf-8') as f:
            for domain in sorted(list(domains)):
                f.write(domain + '\n')
        return domains

    # Processing files
    cnacc_data_tmp_set = process_file(os.path.join(output_dir, "cnacc_domain.tmp"), os.path.join(tmp_dir, "cnacc_data.tmp"), remove_prefixes=["domain:", "full:", "."])
    # Adjusting trusted list processing based on bash: sed -E 's/^server=\///;s/\/114\.114\.114\.114$//'
    # This regex looks for server=/ at the start and /114.114.114.114 at the end.
    # We need to apply this specific cleaning before validation.
    cnacc_trust_raw_file = os.path.join(output_dir, "cnacc_trusted.tmp")
    cnacc_trust_cleaned_file = os.path.join(tmp_dir, "cnacc_trust_cleaned.tmp")
    if os.path.exists(cnacc_trust_raw_file):
        cleaned_lines = []
        try:
            with open(cnacc_trust_raw_file, 'r', encoding='utf-8') as f:
                for line in f:
                    line = line.strip()
                    if not line or line.startswith('#'):
                        continue
                    line = re.sub(r'^server=\/', '', line)
                    line = re.sub(r'\/114\.114\.114\.114$', '', line)
                    cleaned_lines.append(line)
        except Exception as e:
            print(f"An error occurred while cleaning {cnacc_trust_raw_file}: {e}")
            cleaned_lines = [] # Clear lines if error

        with open(cnacc_trust_cleaned_file, 'w', encoding='utf-8') as f:
            for line in cleaned_lines:
                f.write(line + '\n')

    cnacc_trust_tmp_set = process_file(cnacc_trust_cleaned_file, os.path.join(tmp_dir, "cnacc_trust.tmp"))


    # Processing gfwlist_base64 (already base64 decoded in get_data)
    gfwlist_decoded_tmp_set = process_file(os.path.join(output_dir, "gfwlist_base64.tmp"), os.path.join(tmp_dir, "gfwlist_decoded.tmp"), remove_prefixes=["||", "@@", ".", "http://", "https://"])
    gfwlist_normal_tmp_set = process_file(os.path.join(output_dir, "gfwlist_domain.tmp"), os.path.join(tmp_dir, "gfwlist_normal.tmp"), remove_prefixes=["domain:", "full:", "http://", "https://", "."])

    # Combine and sort unique domains
    gfwlist_data = sorted(list(gfwlist_decoded_tmp_set.union(gfwlist_normal_tmp_set)))
    cnacc_full = sorted(list(cnacc_data_tmp_set.union(cnacc_trust_tmp_set)))

    with open(os.path.join(output_dir, "gfwlist_data.tmp"), 'w', encoding='utf-8') as f:
        for domain in gfwlist_data:
            f.write(domain + '\n')

    with open(os.path.join(output_dir, "cnacc_full.tmp"), 'w', encoding='utf-8') as f:
        for domain in cnacc_full:
            f.write(domain + '\n')

    # Generate lite versions
    def get_lite_domains(domains):
        lite_domains = set()
        for domain in domains:
            parts = domain.split('.')
            # Ensure there are at least two parts for a valid domain
            if len(parts) >= 2:
                # Get the last two parts
                lite_domain = f"{parts[-2]}.{parts[-1]}"
                # Validate the resulting lite domain
                if is_valid_domain(lite_domain): # Use the same validation
                    lite_domains.add(lite_domain)
            elif len(parts) == 1 and is_valid_domain(domain): # Handle single-part domains if considered valid
                 lite_domains.add(domain)

        return sorted(list(lite_domains))

    lite_cnacc_data = get_lite_domains(cnacc_full)
    lite_gfwlist_data = get_lite_domains(gfwlist_data)

    with open(os.path.join(output_dir, "lite_cnacc_data.tmp"), 'w', encoding='utf-8') as f:
        for domain in lite_cnacc_data:
            f.write(domain + '\n')

    with open(os.path.join(output_dir, "lite_gfwlist_data.tmp"), 'w', encoding='utf-8') as f:
        for domain in lite_gfwlist_data:
            f.write(domain + '\n')

    # Clean up temporary files and directory
    if os.path.exists(tmp_dir):
         shutil.rmtree(tmp_dir)

    # Filter out empty lines from the final tmp files (as done by sed -i '/^$/d')
    for final_tmp_file in [os.path.join(output_dir, "gfwlist_data.tmp"), os.path.join(output_dir, "cnacc_full.tmp"), os.path.join(output_dir, "lite_cnacc_data.tmp"), os.path.join(output_dir, "lite_gfwlist_data.tmp")]:
        if os.path.exists(final_tmp_file):
            with open(final_tmp_file, 'r', encoding='utf-8') as f:
                lines = f.readlines()
            with open(final_tmp_file, 'w', encoding='utf-8') as f:
                for line in lines:
                    if line.strip(): # Write non-empty lines
                        f.write(line)


    return cnacc_full, gfwlist_data, lite_cnacc_data, lite_gfwlist_data


def generate_rules(software_name, generate_file, generate_mode, dns_mode, cnacc_data, gfwlist_data, lite_cnacc_data, lite_gfwlist_data, foreign_group="foreign", domestic_group="domestic"):
    """
    Generates configuration rules for different software.
    Modified to generate AdGuard Home rules according to standard format.
    """
    print(f"\n=== Generating {software_name}/{generate_file}list_{generate_mode} for dns_mode={dns_mode} ===") # More detailed print

    base_dir = "."
    output_dir = os.path.join(base_dir, "output", f"dns-{software_name}")
    os.makedirs(output_dir, exist_ok=True)

    file_extension = "txt" if software_name in ["adguardhome", "adguardhome_new", "domain"] else "conf"
    # Determine generate_temp based on generate_file for file naming
    if generate_file in ["black", "whiteblack"]:
        generate_temp = "black"
    elif generate_file in ["white", "blackwhite"]:
        generate_temp = "white"
    else:
        generate_temp = "debug" # Should ideally not happen with valid inputs

    # File naming convention in bash was slightly different, let's match it closer
    # e.g., dnshosts-all-adguardhome-blacklist_full.txt
    # The base file name without the dnshosts-all-software- prefix was blacklist_full.txt etc.
    file_name_base = f"{generate_temp}list_{generate_mode}.{file_extension}"
    file_path = os.path.join(output_dir, file_name_base)


    print(f"Creating file: {file_path}")

    # Define DNS servers based on software_name (as in the bash script)
    domestic_dns = []
    foreign_dns = []

    if software_name in ["adguardhome", "adguardhome_new"]:
        domestic_dns = [
            "tcp://dns.alidns.com:53", "udp://dns.alidns.com:53",
            "tcp://223.5.5.5:53", "udp://223.5.5.5:53",
            "tcp://223.6.6.6:53", "udp://223.6.6.6:53",
            "tcp://114.114.114.114:53", "udp://114.114.114.114:53",
            "tcp://114.114.115.115:53", "udp://114.114.115.115:53",
            "tls://dns.alidns.com:853", "quic://dns.alidns.com:853",
            "https://dns.alidns.com/dns-query", "h3://dns.alidns.com/dns-query",
            "https://223.5.5.5/dns-query", "h3://223.5.5.5/dns-query",
            "https://223.6.6.6/dns-query", "h3://223.6.6.6/dns-query",
            "tls://223.5.5.5:853", "quic://223.5.5.5:853",
            "tls://223.6.6.6:853", "quic://223.6.6.6:853",
            "https://doh-pure.onedns.net/dns-query",
            "https://doh.pub/dns-query",
            "https://sm2.doh.pub/dns-query",
            "https://1.12.12.12/dns-query",
            "https://120.53.53.53/dns-query",
            "tls://dot-pure.onedns.net:853",
            "tls://dot.pub:853",
            "tls://1.12.12.12:853",
            "tls://120.53.53.53:853"
        ]
        foreign_dns = [
            "https://firefox.dns.nextdns.io/dns-query", "h3://firefox.dns.nextdns.io/dns-query",
            "https://anycast.dns.nextdns.io/dns-query", "h3://anycast.dns.nextdns.io/dns-query",
            "https://doh3.dns.nextdns.io/dns-query", "h3://doh3.dns.nextdns.io/dns-query",
            "https://dns.nextdns.io/dns-query", "h3://dns.nextdns.io/dns-query",
            "https://dns-unfiltered.adguard.com/dns-query", "h3://dns-unfiltered.adguard.com/dns-query",
            "https://unfiltered.adguard-dns.com/dns-query", "h3://unfiltered.adguard-dns.com/dns-query",
            # Cloudflare with various ports
            *[f"{proto}://1dot1dot1dot1.cloudflare-dns.com:{port}/dns-query" for proto in ["https", "h3"] for port in [443, 2083, 2053, 2087, 2096, 8443]],
            *[f"{proto}://mozilla.cloudflare-dns.com:{port}/dns-query" for proto in ["https", "h3"] for port in [443, 2083, 2053, 2087, 2096, 8443]],
            *[f"{proto}://chrome.cloudflare-dns.com:{port}/dns-query" for proto in ["https", "h3"] for port in [443, 2083, 2053, 2087, 2096, 8443]],
            *[f"{proto}://dns.cloudflare-dns.com:{port}/dns-query" for proto in ["https", "h3"] for port in [443, 2083, 2053, 2087, 2096, 8443]],
            *[f"{proto}://e5aehtlc5e.cloudflare-dns.com:{port}/dns-query" for proto in ["https", "h3"] for port in [443, 2083, 2053, 2087, 2096, 8443]],
            *[f"{proto}://sepfvn6g5a.cloudflare-dns.com:{port}/dns-query" for proto in ["https", "h3"] for port in [443, 2083, 2053, 2087, 2096, 8443]],
            "https://77.88.8.8:443/dns-query",
            "https://doh.opendns.com/dns-query",
            "https://dns.google/dns-query",
            "https://dns.google.com/dns-query",
            "https://dns12.quad9.net/dns-query",
            "https://dns.twnic.tw/dns-query",
            "tls://anycast.dns.nextdns.io:853", "quic://anycast.dns.nextdns.io:853",
            "tls://dns-unfiltered.adguard.com:853", "quic://dns-unfiltered.adguard.com:853",
            "tls://dns.nextdns.io:853", "quic://dns.nextdns.io:853",
            "tls://doh3.dns.nextdns.io:853", "quic://doh3.dns.nextdns.io:853",
            "tls://unfiltered.adguard-dns.com:853", "quic://unfiltered.adguard-dns.com:853",
            "tls://dns.google:853", "quic://dns.google:853",
            "tls://dns.google.com:853", "quic://dns.google.com:853",
            "tls://1dot1dot1dot1.cloudflare-dns.com:853", "quic://1dot1dot1dot1.cloudflare-dns.com:853",
            "tls://dns12.quad9.net:853", "quic://dns12.quad9.net:853",
            "tls://dns.twnic.tw:853",
            "tls://common.dot.dns.yandex.net:853"
        ]
    elif software_name == "bind9":
         domestic_dns = [
            "119.29.29.29 port 53", "223.5.5.5 port 53", "223.6.6.6 port 53",
            "101.226.4.6 port 53", "123.125.81.6 port 53", "114.114.114.114 port 53",
            "114.114.115.115 port 53", "117.50.11.11 port 53", "52.80.66.66 port 53"
        ]
         foreign_dns = [
            "208.67.222.222 port 53", "8.8.4.4 port 53", "8.8.8.8 port 53",
            "1.1.1.1 port 53", "1.0.0.1 port 53", "9.9.9.10 port 53",
            "94.140.14.140 port 53", "94.140.14.141 port 53", "74.82.42.42 prot 53",
            "185.222.222.222 prot 53"
        ]
    elif software_name == "dnsmasq":
         domestic_dns = [
            "119.29.29.29#53", "223.5.5.5#53", "223.6.6.6#53",
            "101.226.4.6#53", "123.125.81.6#53", "114.114.114.114#53",
            "114.114.115.115#53", "117.50.10.10#53", "52.80.52.52#53"
        ]
         foreign_dns = [
            "208.67.222.222#53", "8.8.4.4#53", "8.8.8.8#53",
            "1.1.1.1#53", "1.0.0.1#53", "9.9.9.10#53",
            "94.140.14.140#53", "94.140.14.141#53", "74.82.42.42#53",
            "185.222.222.222#53"
        ]
    elif software_name == "unbound":
         domestic_dns = [
            "223.5.5.5@853", "223.6.6.6@853", "2400:3200::1@853", "2400:3200:baba::1@853",
            "1.12.12.12@853", "120.53.53.53@853", "119.29.29.29@53", "2402:4e00::@53",
            "114.114.114.114@53", "114.114.115.115@53", "117.50.10.10@53", "52.80.52.52@53",
            "2400:7fc0:849e:200::8@53", "2404:c2c0:85d8:901::8@53"
        ]
         foreign_dns = [
            "8.8.4.4@853", "8.8.8.8@853", "2001:4860:4860::8888@853", "2001:4860:4860::8844@853",
            "1.1.1.1@853", "1.0.0.1@853", "2606:4700:4700::1111@853", "2606:4700:4700::1001@853",
            "9.9.9.12@853", "149.112.112.12@853", "2620:fe::12@853", "2620:fe::fe:12@853",
            "94.140.14.140@853", "94.140.14.141@853", "2a10:50c0::1:ff@853", "2a10:50c0::2:ff@853",
            "209.244.0.3@53", "209.244.0.4@53", "4.2.2.1@53", "4.2.2.2@53", "4.2.2.3@53",
            "4.2.2.4@53", "4.2.2.5@53", "4.2.2.6@53"
        ]

    with open(file_path, 'w', encoding='utf-8') as f:
        # Generate Default Upstream (as in the bash script's GenerateDefaultUpstream)
        # This is usually placed at the top of the file by the bash script for adguardhome/adguardhome_new
        # It only happens in default dns_mode and for blackwhite/whiteblack file types
        if software_name in ["adguardhome", "adguardhome_new"]:
            if dns_mode == "default":
                if generate_file == "blackwhite":
                    for dns in foreign_dns:
                         f.write(f"{dns}\n")
                elif generate_file == "whiteblack":
                    for dns in domestic_dns:
                         f.write(f"{dns}\n")

        # Determine which domain list to use
        domains_to_use = []
        if generate_mode in ["full", "full_combine"]:
            if generate_file in ["black", "blackwhite"]:
                domains_to_use = gfwlist_data
            elif generate_file in ["white", "whiteblack"]:
                 domains_to_use = cnacc_data
        elif generate_mode in ["lite", "lite_combine"]:
            if generate_file in ["black", "blackwhite"]:
                domains_to_use = lite_gfwlist_data
            elif generate_file in ["white", "whiteblack"]:
                domains_to_use = lite_cnacc_data

        # Generate rule blocks based on dns_mode and domains_to_use
        if domains_to_use: # Only write if there are domains
            if software_name in ["adguardhome", "adguardhome_new"]:
                if dns_mode == "default":
                    # Default mode: Single rule block [/domains/]upstreams or [/domains/]#
                    upstreams_to_use = []
                    if generate_file in ["black", "blackwhite"]:
                        upstreams_to_use = foreign_dns
                    elif generate_file in ["white", "whiteblack"]:
                        upstreams_to_use = domestic_dns

                    f.write("[/")
                    # Join domains with '/'
                    f.write("/".join(domains_to_use))
                    f.write("]")

                    # Write upstreams or #
                    if upstreams_to_use:
                        f.write(" " + " ".join(upstreams_to_use))
                    else: # If no specific upstreams determined for the rule block, use default (#)
                         # Based on bash script, if no specific upstreams, it uses #
                         f.write("#")
                    f.write("\n")

                elif dns_mode == "domestic":
                     # Domestic mode: Generate a rule block for each domestic DNS
                     for dns in domestic_dns:
                         f.write("[/")
                         f.write("/".join(domains_to_use))
                         f.write(f"]{dns}\n")

                elif dns_mode == "foreign":
                     # Foreign mode: Generate a rule block for each foreign DNS
                     for dns in foreign_dns:
                         f.write("[/")
                         f.write("/".join(domains_to_use))
                         f.write(f"]{dns}\n")

            # ... (rest of the function for other software remains the same) ...
            elif software_name == "bind9":
                if generate_mode == "full":
                    if generate_file == "black":
                        for domain in domains_to_use: # Use domains_to_use determined above
                            f.write(f'zone "{domain}." {{type forward; forwarders {{ {" ".join(foreign_dns)}; }}; }};\n')
                    elif generate_file == "white":
                        for domain in domains_to_use: # Use domains_to_use determined above
                            f.write(f'zone "{domain}." {{type forward; forwarders {{ {" ".join(domestic_dns)}; }}; }};\n')

            elif software_name == "dnsmasq":
                if generate_mode == "full":
                    if generate_file == "black":
                        for domain in domains_to_use: # Use domains_to_use determined above
                            for dns in foreign_dns:
                                f.write(f"server=/{domain}/{dns}\n")
                    elif generate_file == "white":
                        for domain in domains_to_use: # Use domains_to_use determined above
                            for dns in domestic_dns:
                                f.write(f"server=/{domain}/{dns}\n")

            elif software_name == "domain":
                 # domains_to_use already determined above
                 for domain in domains_to_use:
                    f.write(f"{domain}\n")

            elif software_name in ["smartdns", "smartdns-domain-rules"]:
                template = "nameserver /{domain}/{group}" if software_name == "smartdns" else "domain-rules -speed-check-mode ping,tcp:80 -nameserver /{domain}/{group}"
                # domains_to_use already determined above
                if generate_file == "black":
                    for domain in domains_to_use:
                        f.write(template.format(domain=domain, group=foreign_group) + "\n")
                elif generate_file == "white":
                    for domain in domains_to_use:
                        f.write(template.format(domain=domain, group=domestic_group) + "\n")

            elif software_name == "unbound":
                forward_ssl_tls_upstream = "yes"
                if generate_mode == "full":
                    # Unbound in bash script seems to process black list with foreign DNS and white list with domestic DNS
                    upstreams_to_use = []
                    if generate_file == "black":
                        upstreams_to_use = foreign_dns
                    elif generate_file == "white":
                        upstreams_to_use = domestic_dns

                    if upstreams_to_use:
                         for domain in domains_to_use: # Use domains_to_use determined above
                            f.write("forward-zone:\n")
                            f.write(f'    name: "{domain}."\n')
                            for dns in upstreams_to_use:
                                 f.write(f'    forward-addr: "{dns}"\n')
                            f.write("    forward-first: \"yes\"\n")
                            f.write("    forward-no-cache: \"yes\"\n")
                            f.write(f"    forward-ssl-upstream: \"{forward_ssl_tls_upstream}\"\n")
                            f.write(f"    forward-tls-upstream: \"{forward_ssl_tls_upstream}\"\n")

def output_data(cnacc_data, gfwlist_data, lite_cnacc_data, lite_gfwlist_data):
    """
    Generates output files for different software.
    """
    print("OutputData running...")
    print("Generating output...")

    output_dir = "./output"
    # Clean up old output files
    if os.path.exists(output_dir):
        shutil.rmtree(output_dir)
    os.makedirs(output_dir, exist_ok=True)
    # No longer need a separate .tmp directory within output_data since analyse_data handles its own tmp and cleans up.
    # os.makedirs(os.path.join(output_dir, ".tmp"), exist_ok=True) # Recreate tmp dir if needed


    software_variants = {
        "adguardhome": {"modes": ["full", "lite"], "files": ["black", "white", "blackwhite", "whiteblack"], "dns_modes": ["default", "domestic", "foreign"]},
        "adguardhome_new": {"modes": ["full", "lite"], "files": ["black", "white", "blackwhite", "whiteblack"], "dns_modes": ["default", "domestic", "foreign"]},
        # For other software, the bash script didn't explicitly loop through dns_modes in the main output section
        # It seemed to imply a default context or that the rule format itself determines the upstream.
        # We will call generate_rules once per mode/file combination for these, assuming a default dns_mode context
        # unless the generate_rules function for that software explicitly uses dns_mode.
        "bind9": {"modes": ["full"], "files": ["black", "white"], "dns_modes": ["default"]},
        "dnsmasq": {"modes": ["full"], "files": ["black", "white"], "dns_modes": ["default"]},
        "domain": {"modes": ["full", "lite"], "files": ["black", "white"], "dns_modes": ["default"]},
        "smartdns": {"modes": ["full", "lite"], "files": ["black", "white"], "params": {"foreign_group": "foreign", "domestic_group": "domestic"}, "dns_modes": ["default"]},
        "smartdns-domain-rules": {"modes": ["full", "lite"], "files": ["black", "white"], "params": {"foreign_group": "foreign", "domestic_group": "domestic"}, "dns_modes": ["default"]},
        "unbound": {"modes": ["full"], "files": ["black", "white"], "dns_modes": ["default"]} # Unbound section in bash seems to use specific upstreams directly in rules, not based on a global dns_mode loop
    }

    # Replicating the bash script's generate loop structure more closely
    for software, config in software_variants.items():
        print(f"\n=== Processing {software} ===")
        modes = config["modes"]
        files = config["files"]
        params = config.get("params", {})
        dns_modes_to_process = config.get("dns_modes", ["default"]) # Default to processing only 'default' if not specified

        if software in ["adguardhome", "adguardhome_new"]:
            # Replicate bash calls for AdGuardHome variants more accurately
            # Default mode files
            for mode in ["full", "lite"]:
                for file_type in ["black", "white", "blackwhite", "whiteblack"]:
                    # Only generate if corresponding data exists
                    if (file_type in ["black", "blackwhite"] and (gfwlist_data or lite_gfwlist_data)) or \
                       (file_type in ["white", "whiteblack"] and (cnacc_data or lite_cnacc_data)):
                         generate_rules(software, file_type, mode, "default", cnacc_data, gfwlist_data, lite_cnacc_data, lite_gfwlist_data, **params)
                    else:
                         print(f"Info: Skipping generation for {software}/{file_type}_{mode} (dns_mode=default) due to empty data.")


            # Domestic mode files (only blackwhite and whiteblack in bash)
            for mode in ["full", "lite"]:
                for file_type in ["blackwhite", "whiteblack"]:
                     # Only generate if corresponding data exists
                     if (file_type in ["blackwhite"] and (gfwlist_data or lite_gfwlist_data or cnacc_data or lite_cnacc_data)) or \
                        (file_type in ["whiteblack"] and (cnacc_data or lite_cnacc_data or gfwlist_data or lite_gfwlist_data)):
                         generate_rules(software, file_type, mode, "domestic", cnacc_data, gfwlist_data, lite_cnacc_data, lite_gfwlist_data, **params)
                     else:
                         print(f"Info: Skipping generation for {software}/{file_type}_{mode} (dns_mode=domestic) due to empty data.")


            # Foreign mode files (only whiteblack in bash, which seems odd - let's process blackwhite too for consistency, though bash didn't)
            # Following bash strictly: only whiteblack for foreign mode
            for mode in ["full", "lite"]:
                for file_type in ["whiteblack"]: # Bash only had whiteblack here
                     # Only generate if corresponding data exists
                     if (file_type in ["whiteblack"] and (cnacc_data or lite_cnacc_data or gfwlist_data or lite_gfwlist_data)):
                         generate_rules(software, file_type, mode, "foreign", cnacc_data, gfwlist_data, lite_cnacc_data, lite_gfwlist_data, **params)
                     else:
                         print(f"Info: Skipping generation for {software}/{file_type}_{mode} (dns_mode=foreign) due to empty data.")


        else:
            # For other software, generate rules for all specified modes/files with default dns_mode context
            for mode in modes:
                for file_type in files:
                    # Only generate if corresponding data exists
                    if (file_type == "black" and (gfwlist_data or lite_gfwlist_data)) or \
                       (file_type == "white" and (cnacc_data or lite_cnacc_data)):
                         # Pass the first dns_mode from the config, assuming it's the relevant one or default
                         # The logic inside generate_rules for these software should handle dns_mode if needed.
                         generate_rules(software, file_type, mode, dns_modes_to_process[0], cnacc_data, gfwlist_data, lite_cnacc_data, lite_gfwlist_data, **params)
                    else:
                         print(f"Info: Skipping generation for {software}/{file_type}_{mode} due to empty data.")


    # Clean up temporary files in .tmp directory (already done in analyse_data)
    # The output/.tmp directory is created in get_data and used by analyse_data.
    # analyse_data cleans it up at the end. So no need to clean it here.
    pass # No cleanup needed here

def move_generated_files():
    """
    Moves generated files to the final output directory and renames them.
    Uses a predefined list of expected software types.
    """
    print("MoveGeneratedFiles running...")

    base_dir = "."
    dest = os.path.join(base_dir, "output")
    os.makedirs(dest, exist_ok=True) # Ensure destination exists
    print(f"Destination directory: {dest}")

    # Use a predefined list of expected software types based on output_data's software_variants keys
    expected_software_types = [
        "adguardhome", "adguardhome_new", "bind9", "dnsmasq",
        "domain", "smartdns", "smartdns-domain-rules", "unbound"
    ]

    files_moved_count = 0

    for type_name in expected_software_types:
        src = os.path.join(dest, f"dns-{type_name}")

        # Check if the source directory was created by generate_rules
        if not os.path.exists(src):
            print(f"Info: Source directory not found for {type_name}: {src}. Skipping move for this type.")
            continue # Skip to the next type if the source directory doesn't exist

        print(f"Processing {type_name} files from {src}...")

        # Define file patterns based on the type_name's expected extensions
        file_patterns = []
        if type_name in ["adguardhome", "adguardhome_new", "domain"]:
            file_patterns = [f"{src}/*.txt"]
        elif type_name in ["bind9", "unbound", "dnsmasq", "smartdns", "smartdns-domain-rules"]:
            file_patterns = [f"{src}/*.conf"]
        else:
             print(f"Warning: Unknown software type '{type_name}'. Cannot determine file patterns.")
             continue

        type_files_found = False
        for pattern in file_patterns:
            for file_path in glob.glob(pattern):
                type_files_found = True
                if os.path.isfile(file_path):
                    file_name = os.path.basename(file_path)
                    # Match the bash renaming: dnshosts-all-${type}-$(basename "${file}")
                    new_file_name = f"dnshosts-all-{type_name}-{file_name}"
                    new_file_path = os.path.join(dest, new_file_name)
                    try:
                        # Use shutil.move for potentially more robust handling across filesystems
                        shutil.move(file_path, new_file_path)
                        print(f"Moved {file_path} to {new_file_path}")
                        files_moved_count += 1
                    except shutil.Error as e:
                        print(f"Error moving file {file_path} to {new_file_path}: {e}")
                    except OSError as e:
                        print(f"OSError moving file {file_path} to {new_file_path}: {e}")
                    except Exception as e:
                         print(f"An unexpected error occurred while moving {file_path}: {e}")

        # No need to print "No files matching patterns" here, the 'Info' message when skipping the directory is enough
        # if not type_files_found:
        #      print(f"Info: No files matching patterns {file_patterns} found in {src} for {type_name}")


        # After moving files from this source directory, clean up the source directory
        # Check if the source directory is now empty before removing
        if os.path.exists(src) and not os.listdir(src):
             try:
                 os.rmdir(src)
                 print(f"Removed empty directory: {src}")
             except OSError as e:
                 print(f"Error removing directory {src}: {e}")
        elif os.path.exists(src):
            print(f"Info: Source directory {src} is not empty after move. Retaining.")


    print(f"\nFinished moving {files_moved_count} files. Final generated files in {dest}:")
    # List files directly in the destination output directory
    final_files = glob.glob(os.path.join(dest, "dnshosts-all-*"))
    if final_files:
        for f in sorted(final_files): # Sort for cleaner output
            print(f)
    else:
        print("No final output files found.")


## Process
if __name__ == "__main__":
    # Clean up output directory at the very beginning for a fresh run
    output_dir_initial = "./output"
    if os.path.exists(output_dir_initial):
        print(f"Cleaning up existing output directory: {output_dir_initial}")
        try:
            shutil.rmtree(output_dir_initial)
        except OSError as e:
            print(f"Error cleaning up directory {output_dir_initial}: {e}")
            print("Please manually remove the output directory and try again.")
            exit(1) # Exit if cleanup fails

    get_data()
    # Ensure analyse_data receives the data from the temporary files created by get_data
    cnacc_data, gfwlist_data, lite_cnacc_data, lite_gfwlist_data = analyse_data()
    output_data(cnacc_data, gfwlist_data, lite_cnacc_data, lite_gfwlist_data)
    move_generated_files()