#!/usr/bin/env bash
# ad-hosts-pro.sh —— 聚合各广告/恶意域名过滤列表并生成多格式输出
#
# 用法: 在仓库根目录执行  bash ./file-hosts.sh/ad-hosts/ad-hosts-pro.sh
#       (workflow 与此一致; 产物 ./ad-* 输出到当前运行目录, 临时目录 ./ad-hosts-pro 用后即删)
#
# 主要优化:
#   1. 并发下载 (FETCH_JOBS, 默认 16), URL 先去重, 每个地址独立落盘, 互不污染
#   2. curl 加 -f: HTTP 404/5xx 不再把错误页正文混入规则; --retry 内建重试替代手写循环
#   3. 输出改为单次 awk 遍历写全部 16 种格式, 替代逐域名 15 次 echo 的百万级进程开销
#   4. 修复 ad-singbox.json (原文件为非法 JSON)、echo "\n" 字面量导致的头行损坏
#   5. sing-box 规则集对齐官方纯格式 (version+rules; 多余元数据字段会被 sing-box 严格解析拒绝),
#      并在 sing-box 可用时自动编译体积更小的 .srs, 参照 REIJI007/AdBlock_Rule_For_Sing-box
#   6. 修复 Total 统计口径、白名单为空时全量误杀、$client 变量展开为空、RPZ SOA 序列号固定
#   7. 抓取失败清单落盘汇总; 最终域名数量异常过少时中止, 防止空列表覆盖线上产物
set -uo pipefail

ORIG_PWD=$PWD
FETCH_JOBS=${FETCH_JOBS:-16}
MIN_DOMAINS=${MIN_DOMAINS:-1000}   # 最终域名低于该值视为抓取失败, 中止保护
UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:139.0) Gecko/20100101 Firefox/139.0"
# 合法域名单行正则 (沿用原有判定规则)
DOMAIN_RE='^(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$'

# Download Data
function GetData() {
    filter_adblock=(
        "https://malware-filter.gitlab.io/malware-filter/phishing-filter-agh.txt"
        "https://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt"
        "https://easylist-downloads.adblockplus.org/advblock.txt"
        "https://easylist-downloads.adblockplus.org/antiadblockfilters.txt"
        "https://easylist-downloads.adblockplus.org/bulgarian_list.txt"
        "https://easylist-downloads.adblockplus.org/easylistchina.txt"
        "https://easylist-downloads.adblockplus.org/easylistdutch.txt"
        "https://easylist-downloads.adblockplus.org/easylistgermany.txt"
        "https://easylist-downloads.adblockplus.org/easylistitaly.txt"
        "https://easylist-downloads.adblockplus.org/easylistlithuania.txt"
        "https://easylist-downloads.adblockplus.org/easylistpolish.txt"
        "https://easylist-downloads.adblockplus.org/easylistportuguese.txt"
        "https://easylist-downloads.adblockplus.org/easylistspanish.txt"
        "https://easylist-downloads.adblockplus.org/easylist.txt"
        "https://easylist-downloads.adblockplus.org/easyprivacy.txt"
        "https://easylist-downloads.adblockplus.org/indianlist.txt"
        "https://easylist-downloads.adblockplus.org/israellist.txt"
        "https://easylist-downloads.adblockplus.org/koreanlist.txt"
        "https://easylist-downloads.adblockplus.org/latvianlist.txt"
        "https://easylist-downloads.adblockplus.org/Liste_AR.txt"
        "https://easylist-downloads.adblockplus.org/liste_fr.txt"
        "https://easylist-downloads.adblockplus.org/ruadlist.txt"
        "https://filters.adavoid.org/ultimate-ad-filter.txt"
        "https://filters.adavoid.org/ultimate-privacy-filter.txt"
        "https://filters.adavoid.org/ultimate-security-filter.txt"
        "https://raw.githubusercontent.com/elliotwutingfeng/Inversion-DNSBL-Blocklists/main/Google_hostnames_ABP.txt"
        "https://zoso.ro/pages/rolist.txt"
        "https://zoso.ro/pages/rolist2.txt"
        $(for i in {1..400}; do echo "https://filters.adtidy.org/android/filters/${i}_optimized.txt"; done)
        $(for i in {1..400}; do echo "https://filters.adtidy.org/extension/chromium/filters/${i}.txt"; done)
        $(for i in {1..400}; do echo "https://filters.adtidy.org/windows/filters/${i}.txt"; done)
        $(for i in {1..400}; do echo "https://filters.adtidy.org/extension/ublock/filters/${i}_optimized.txt"; done)
        $(for i in {1..400}; do echo "https://filters.adtidy.org/extension/ublock/filters/${i}.txt"; done)
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/AdGuard/BlockHttpDNS/BlockHttpDNS.txt"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/AdGuard/Privacy/Privacy.txt"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/AdGuard/AdvertisingTest/AdvertisingTest.txt"
        "https://adblock.lostinthe.cloud/lostad_full.txt"
        "https://adblock.lostinthe.cloud/lostad_dns.txt"
        "https://adblock.lostinthe.cloud/lostad_annoyances.txt"
        "https://adblock.lostinthe.cloud/lostad_cookies.txt"
        "https://adblock.lostinthe.cloud/lostad_core.txt"
        "https://adblock.lostinthe.cloud/lostad_german.txt"
        "https://adblock.lostinthe.cloud/lostad_lean.txt"
        "https://adblock.lostinthe.cloud/lostad_social.txt"
        "https://adblock.lostinthe.cloud/lostad_tracking.txt"
        "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=adblockplus&showintro=1&mimetype=plaintext"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/AdGuard/AdvertisingLite/AdvertisingLite.txt"
        "https://raw.githubusercontent.com/BlackJack8/iOSAdblockList/master/Hosts.txt"
        "https://code.gitlink.org.cn/zzp282/ads/raw/branch/master/ADSLJ.txt"
        "https://raw.githubusercontent.com/easylist/easylist/master/easylist/easylist_adservers.txt"
        "https://raw.githubusercontent.com/easylist/easylistchina/master/easylistchina.txt"
        "https://raw.githubusercontent.com/easylist/ruadlist/master/advblock/adservers.txt"
        "https://raw.githubusercontent.com/alexsannikov/adguardhome-filters/master/porn.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_10_Useful/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_11_Mobile/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_12_Safari/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_13_Turkish/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_14_Annoyances/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_15_DnsFilter/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_16_French/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_17_TrackParam/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_18_Annoyances_Cookies/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_19_Annoyances_Popups/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_1_Russian/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_20_Annoyances_MobileApp/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_21_Annoyances_Other/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_224_Chinese/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_22_Annoyances_Widgets/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_3_Spyware/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_4_Social/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_5_Experimental/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_6_German/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_7_Japanese/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_8_Dutch/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_9_Spanish/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_101_EasyList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_102_ABPindo/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_103_BulgarianList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_104_EasyListChina/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_105_EasyListCzechAndSlovak/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_106_EasyListDutch/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_107_EasyListGermany/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_108_EasyListHebrew/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_109_EasyListItaly/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_110_EasyListLithuania/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_111_LatvianList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_112_ListeAR/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_113_ListeFR/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_114_ROList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_115_RUAdList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_116_Wiltteri/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_117_PolishSubFilters/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_118_EasyPrivacy/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_119_IcelandicABPList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_120_AdBlockID/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_121_VoidGr/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_122_FanboysAnnoyances/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_123_FanboysSocialBlockingList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_200_ABPJapaneseFilters/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_201_WebAnnoyancesUltralist/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_202_EasyListThailand/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_203_hufilter/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_204_PeterLowesList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_205_SchacksAdblockPlusListe/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_206_Xfiles/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_207_AdblockWarningRemovalList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_209_ADgkMobileChinalist/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_210_Spam404/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_211_AntiAdblockKillerReek/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_212_RUAdListCounters/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_213_RUAdListBitBlock/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_214_ABPVNList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_215_FanboysEnancedTrackingList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_216_PolskiFiltr/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_217_PolskiFiltrCookies/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_218_EstonianList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_219_ChinaListAndEasyList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_220_CJXsAnnoyanceList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_221_PolskiFiltrSocial/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_222_ABPPersian/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_223_FanboySwedish/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_225_fanboyAntifacebook/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_226_FanboyVietnamese/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_227_List-KR/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_228_xinggsf/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_229_IdontCareAboutCookies/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_230_FanboyEspanol/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_231_EasyListSpanish/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_232_KADPrzekrety/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_233_AdblockListFinland/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_234_ROList2/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_235_PersianBlocker/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_236_ROad-Block/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_237_PolishAnnoyance/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_238_PolskiFiltrAdg/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_239_FanboyAntifonts/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_240_BarbBlock/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_241_FanboyCookiemonster/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_242_NoCoin/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_243_FrellwitSwedish/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_244_YousList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_245_AlleBlock/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_246_EasyListPolish/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_247_PolishRssFilters/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_249_NorwegianList/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_250_DandelionSproutAnnoyances/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_251_LegitimateURLShortener/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_252_DandelionSproutSerboCroatian/filter.txt"
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/ThirdParty/filter_253_IndianList/filter.txt"
        "https://hblock.molinero.dev/hosts_adblock.txt"
        "https://gitlab.com/malware-filter/phishing-filter/-/raw/master/dist/phishing-filter-agh.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/360Rules.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/360SpeedBrowserRules.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/ADSLJFRules.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/AdFiltersRules.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/AdRulesListHosts.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/AdbybyRules.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/CfGgRules.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/CfSpRules.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/CoolapkRules.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/DivineMachineRules.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/NetizensRules.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/NextIDSeeRules.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/MergeRules/OceanMerge.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/MergeRules/QingYaMerge.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/QuarkRules.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/TomatoNovelRules.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/OtherRules/WzRules.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/MergeRules/XXKillerMerge.txt"
        "https://raw.githubusercontent.com/Kuroba-Sayuki/FuLing-AdRules/refs/heads/Master/FuLingRules/FuLingBlockList.txt"
        "https://raw.githubusercontent.com/abpvn/abpvn/master/filter/abpvn_adguard.txt"
        "https://raw.github.com/reek/anti-adblock-killer/master/anti-adblock-killer-filters.txt"
        "https://easylist-msie.adblockplus.org/abp-filters-anti-cv.txt"
        "https://raw.githubusercontent.com/abp-filters/abp-filters-anti-cv/master/english.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt"
        "https://raw.githubusercontent.com/k2jp/abp-japanese-filters/master/abpjf.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2020.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2021.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2022.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/lan-block.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/legacy.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badlists.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt"
        "https://raw.githubusercontent.com/Ealenn/AdGuard-Home-List/gh-pages/AdGuard-Home-List.Block.txt"
        "https://raw.githubusercontent.com/FutaGuard/FutaFilter/master/hosts.txt"
        "https://raw.githubusercontent.com/BlueSkyXN/AdGuardHomeRules/master/manhua.txt"
        "https://raw.githubusercontent.com/BlueSkyXN/AdGuardHomeRules/master/all.txt"
        "https://raw.githubusercontent.com/MohamedElashri/filters/main/rules/adguard.txt"
        "https://raw.githubusercontent.com/chillipal/dns-blocklist/master/lists/blocklist-adguard.txt"
        "https://o0.pages.dev/Xtra/adblock.txt"
        "https://raw.githubusercontent.com/ppfeufer/adguard-filter-list/master/blocklist"
        "https://raw.githubusercontent.com/Noyllopa/NoAppDownload/master/NoAppDownload.txt"
        "https://raw.githubusercontent.com/notracking/hosts-blocklists/master/adblock/adblock.txt"
        "https://raw.githubusercontent.com/gioxx/xfiles/master/siteblock.txt"
        "https://easylist.to/easylist/easylist.txt"
        "https://easylist.to/easylist/easyprivacy.txt"
        "https://easylist.to/easylistgermany/easylistgermany.txt"
        "https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/mv.txt"
        "https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/rule.txt"
        "https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/minority-mv.txt"
        "https://raw.githubusercontent.com/VeleSila/VELE-SILA-List/gh-pages/KaFanList.txt"
        "https://raw.githubusercontent.com/banbendalao/ADgk/master/ADgk.txt"
        "https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjx-annoyance.txt"
        "https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjxlist.txt"
        "https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-edentw.txt"
        "https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-mo.txt"
        "https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-pc.txt"
        "https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad.txt"
        "https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad2.txt"
        "https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad3.txt"
        "https://www.fanboy.co.nz/enhancedstats.txt"
        "https://secure.fanboy.co.nz/fanboy-social.txt"
        "https://www.fanboy.co.nz/fanboy-annoyance.txt"
        "https://easylist-downloads.adblockplus.org/easylistchina.txt"
        "https://easylist-downloads.adblockplus.org/easyprivacy.txt"
        "https://easylist-downloads.adblockplus.org/fanboy-annoyance.txt"
        "https://easylist-downloads.adblockplus.org/antiadblockfilters.txt"
        "https://easylist-downloads.adblockplus.org/easylistchina+easylistchina_compliance+easylist.txt"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
        "https://www.i-dont-care-about-cookies.eu/abp/"
        "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/ChineseFilter/sections/adservers.txt"
        "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/ChineseFilter/sections/antiadblock.txt"
        "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/GermanFilter/sections/adservers.txt"
        "https://raw.githubusercontent.com/yous/YousList/master/youslist.txt"
        "https://raw.githubusercontent.com/easylist/easylist/master/easyprivacy/easyprivacy_specific_international.txt"
        "https://raw.githubusercontent.com/AdguardTeam/cname-trackers/master/data/combined_disguised_ads.txt"
        "https://raw.githubusercontent.com/AdguardTeam/cname-trackers/master/data/combined_disguised_clickthroughs.txt"
        "https://raw.githubusercontent.com/AdguardTeam/cname-trackers/master/data/combined_disguised_microsites.txt"
        "https://raw.githubusercontent.com/AdguardTeam/cname-trackers/master/data/combined_disguised_trackers.txt"
        "https://raw.githubusercontent.com/AdguardTeam/cname-trackers/master/data/combined_original_trackers.txt"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/YouTubeEvenMorePureVideoExperience.txt"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AdGuard%20Home%20Compilation%20List/AdGuardHomeCompilationList.txt"
        "https://raw.githubusercontent.com/hufilter/hufilter/refs/heads/gh-pages/hufilter-adguard.txt"
        "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/SpywareFilter/sections/mobile.txt"
        "https://raw.githubusercontent.com/easylist/easylist/master/easyprivacy/easyprivacy_thirdparty.txt"
        "https://raw.githubusercontent.com/easylist/easylist/master/easyprivacy/easyprivacy_specific.txt"
        "https://raw.githubusercontent.com/easylist/easylist/master/easylist/easylist_specific_block.txt"
        "https://raw.githubusercontent.com/lassekongo83/Frellwits-filter-lists/master/Frellwits-Swedish-Filter.txt"
        "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/nocoin.txt"
        "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV-AGH.txt"
        "https://raw.githubusercontent.com/durablenapkin/scamblocklist/master/adguard.txt"
        "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt"
        "https://raw.githubusercontent.com/ppfeufer/adguard-filter-list/refs/heads/master/blocklist"
    )
    filter_domain=(
        $(for i in {1..10}; do echo "https://raw.githubusercontent.com/MikhailKasimov/validin-phish-feed/refs/heads/main/validin-phish-feed-${i}.txt"; done)
        $(for i in {1..20}; do echo "https://raw.githubusercontent.com/MikhailKasimov/validin-phish-feed/refs/heads/main/validin-phish-feed-phishydnstxt-${i}.txt"; done)
        "https://raw.githubusercontent.com/MikhailKasimov/validin-phish-feed/refs/heads/main/validin-phish-feed-crissmonovmcom.txt"
        "https://raw.githubusercontent.com/MikhailKasimov/validin-phish-feed/refs/heads/main/validin-phish-feed-youcangetnoinfo.txt"
        "https://raw.githubusercontent.com/MikhailKasimov/validin-phish-feed/refs/heads/main/validin-phish-feed.txt"
        "https://raw.githubusercontent.com/cenk/bad-hosts/main/bad-hosts-domains"
        "https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt"
        "https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts_full"
        "https://raw.githubusercontent.com/RooneyMcNibNug/pihole-stuff/master/SNAFU.txt"
        "https://v.firebog.net/hosts/neohostsbasic.txt"
        "https://raw.githubusercontent.com/matomo-org/referrer-spam-blacklist/master/spammers.txt"
        "https://malware-filter.gitlab.io/malware-filter/phishing-filter.txt"
        "https://raw.githubusercontent.com/jarelllama/Scam-Blocklist/main/lists/wildcard_domains/scams.txt"
        "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/ultimate.txt"
        "https://github.com/Potterli20/file/releases/download/github-hosts/ad-edge-hosts.txt"
        "https://raw.githubusercontent.com/groovy-sky/SaferDNS/main/blocklists/domains/Ultimate.Hosts.Blacklist.txt"
        "https://raw.githubusercontent.com/neodevpro/neodevhost/master/domain"
        "https://raw.githubusercontent.com/notracking/hosts-blocklists-scripts/master/domains.dead.txt"
        "https://raw.githubusercontent.com/notracking/hosts-blocklists-scripts/master/hostnames.dead.txt"
        "https://dl.red.flag.domains/red.flag.domains.txt"
        "https://raw.githubusercontent.com/gioxx/xfiles/master/domains/upd_domains.txt"
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/ad-hosts/hosts"
        "https://raw.githubusercontent.com/badmojr/addons_1Hosts/main/kidSaf/domains.txt"
        "https://raw.githubusercontent.com/mitchellkrogza/Badd-Boyz-Hosts/master/domains"
        "https://v.firebog.net/hosts/static/w3kbl.txt"
        "https://gitlab.com/Wiggum27/blockers/-/raw/master/hosts"
        "https://raw.githubusercontent.com/MajkiIT/polish-ads-filter/master/polish-mikrotik-filters/forti_list.txt"
        "https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt"
        "https://gitlab.com/ZeroDot1/CoinBlockerLists/-/raw/master/list_browser.txt"
        "https://gitlab.com/ZeroDot1/CoinBlockerLists/-/raw/master/hosts"
        "https://gitlab.com/ZeroDot1/CoinBlockerLists/-/raw/master/hosts_browser"
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/reject-list.txt"
        "https://raw.githubusercontent.com/examplecode/ad-rules-for-xbrowser/master/core-rule-cn.txt"
        "https://raw.githubusercontent.com/hezhijie0327/AdFilter/source/data/data_block.txt"
        "https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-domains.txt"
        "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADomains.txt"
        "https://raw.githubusercontent.com/marcusminus/Orthrus-BlockList/master/domains.txt"
        "https://hosts.ubuntu101.co.za/domains.list"
        "https://raw.githubusercontent.com/scafroglia93/blocklists/master/blocklists-personal.txt"
        "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/android-tracking.txt"
        "https://gitlab.com/ZeroDot1/CoinBlockerLists/raw/master/list_browser.txt"
        "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"
        "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt"
        "https://hostfiles.frogeye.fr/multiparty-only-trackers.txt"
        "https://orca.pet/notonmyshift/domains.txt"
        "https://rescure.fruxlabs.com/rescure_domain_blacklist.txt"
        "https://phishing.army/download/phishing_army_blocklist_extended.txt"
        "https://raw.githubusercontent.com/stamparm/blackbook/master/blackbook.txt"
        "https://raw.githubusercontent.com/cenk/bad-hosts/refs/heads/main/bad-hosts-domains"
    )
    filter_hosts=(
        "https://v.firebog.net/hosts/Prigent-Crypto.txt"
        "https://gitlab.com/quidsup/notrack-blocklists/-/raw/master/trackers.hosts"
        "https://urlhaus.abuse.ch/downloads/hostfile/"
        "https://paulgb.github.io/BarbBlock/blacklists/hosts-file.txt"
        "https://winhelp2002.mvps.org/hosts.txt"
        "https://someonewhocares.org/hosts/zero/hosts"
        "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt"
        "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts"
        "https://raw.githubusercontent.com/d3ward/toolz/master/src/d3host.txt"
        "https://schakal.ru/hosts/alive_hosts.txt"
        "https://threatview.io/Downloads/DOMAIN-High-Confidence-Feed.txt"
        "https://raw.githubusercontent.com/symbuzzer/Turkish-Ad-Hosts/main/hosts"
        "https://raw.githubusercontent.com/lingeringsound/10007_auto/master/all"
        "https://raw.githubusercontent.com/yous/YousList/master/hosts.txt"
        "https://raw.githubusercontent.com/smed79/blacklist/master/hosts.txt"
        "https://sysctl.org/cameleon/hosts"
        "https://zerodot1.gitlab.io/CoinBlockerLists/hosts"
        "https://gitlab.com/intr0/iVOID.GitLab.io/raw/master/iVOID.hosts"
        "https://adm.dimonvideo.ru/alive_hosts.txt"
        "https://raw.githubusercontent.com/bongochong/CombinedPrivacyBlockLists/master/newhosts-final.hosts"
        "https://raw.githubusercontent.com/thisisu/hosts_adultxxx/master/hosts"
        "https://www.github.developerdan.com/hosts/lists/ads-and-tracking-extended.txt"
        "https://raw.githubusercontent.com/FiltersHeroes/KADhosts/master/KADhosts.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardApps.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardCNAME.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardDNS.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardMobileAds.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardMobileSpyware.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/EasyPrivacyCNAME.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/EasyPrivacySpecific.txt"
        "https://big.oisd.nl/domainswild2"
        "https://small.oisd.nl/domainswild2"
        "https://nsfw.oisd.nl/domainswild2"
        "https://nsfw-small.oisd.nl/domainswild2"
        "https://orca.pet/notonmyshift/hosts.txt"
        "https://stopforumspam.com/downloads/toxic_domains_whole.txt"
        "https://hblock.molinero.dev/hosts"
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/ad-block-YouTube-Project.txt"
        "https://hosts.flossboxin.org.in/files/hosts"
        "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"
        "https://hostfiles.frogeye.fr/multiparty-only-trackers-hosts.txt"
        "https://hostfiles.frogeye.fr/multiparty-trackers-hosts.txt"
        "https://hostfiles.frogeye.fr/firstparty-only-trackers-hosts.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/EasyPrivacy3rdParty.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardTracking.txt"
        "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
        "https://blokada.org/blocklists/ddgtrackerradar/standard/hosts.txt"
        "https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Extension/GoodbyeAds-Xiaomi-Extension.txt"
        "https://raw.githubusercontent.com/kboghdady/youTube_ads_4_pi-hole/master/youtubelist.txt"
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/youtubeblacklist.txt"
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/blockeverything.txt"
        "https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Extension/GoodbyeAds-YouTube-AdBlock.txt"
        "http://www.hostsfile.org/Downloads/hosts.txt"
        "https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts"
        "https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt"
        "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt"
        "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts"
        "https://raw.githubusercontent.com/E7KMbb/AD-hosts/master/system/etc/hosts"
        "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt"
        "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/AmazonFireTV.txt"
        "https://raw.githubusercontent.com/ilpl/ad-hosts/master/hosts"
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/win-spy.txt"
        "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/win-extra.txt"
        "https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts"
        "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
        "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
        "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt"
        "https://raw.githubusercontent.com/neoFelhz/neohosts/gh-pages/full/hosts"
        "https://adaway.org/hosts.txt"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/refs/heads/master/NorwegianExperimentalList%20alternate%20versions/NordicFiltersAdGuardHome.txt"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt"
        "https://raw.githubusercontent.com/uniartisan/adblock_list/master/adblock_privacy.txt"
        "https://raw.githubusercontent.com/uniartisan/adblock_list/master/adblock_plus.txt"
        "https://raw.githubusercontent.com/lassekongo83/Frellwits-filter-lists/master/Frellwits-Swedish-Hosts-File.txt"
        "https://abpvn.com/android/abpvn.txt"
        "https://someonewhocares.org/hosts/hosts"
        "https://raw.githubusercontent.com/durablenapkin/scamblocklist/master/hosts.txt"
        "https://raw.githubusercontent.com/Ultimate-Hosts-Blacklist/blacklist/master/output/domains.list/hosts/ACTIVE/hosts"
        "https://raw.githubusercontent.com/ookangzheng/blahdns/master/hosts/blacklist.txt"
        "https://warui.intaa.net/adhosts/hosts.txt"
        "https://raw.githubusercontent.com/ricardbejarano/hosts/master/hosts"
    )
    filter_other=(
        "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanAD.list"
        "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanProgramAD.list"
        "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanEasyList.list"
        "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanEasyListChina.list"
        "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanEasyPrivacy.list"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/Privacy/Privacy_Classical.yaml"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/Advertising/Advertising_Classical.yaml"
    )
    filter_white=(
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/allow/Domains"
    )
    [[ -d file-hosts.sh ]] || echo "[warn] 建议在仓库根目录运行本脚本, 产物将输出到当前目录" >&2
    mkdir -p ./ad-hosts-pro && cd ./ad-hosts-pro || exit 1

    fetch_data filter_adblock[@] ./filter_adblock.tmp
    fetch_data filter_domain[@] ./filter_domain.tmp
    fetch_data filter_hosts[@] ./filter_hosts.tmp
    fetch_data filter_other[@] ./filter_other.tmp
    fetch_data filter_white[@] ./filter_white.tmp
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
        sed 's/[[:space:]]//g;/^$/d;s/0\.0\.0\.0//g;s/127\.0\.0\.1//g;s/255\.255\.255\.255//g;s/local//g;s/localhost//g;s/localhost\.localdomain//g;s/broadcasthost//g;s/ip6-localhost//g;s/::1//g;s/ip6-loopback//g;s/ip6-localnet//g;s/fe80::1%lo0//g;s/ff00::0//g;s/ff02::1//g;s/ff02::2//g;s/ff02::3//g;s/ip6-mcastprefix//g;s/ip6-allnodes//g;s/ip6-allrouters//g;s/ip6-allhosts//g;s/DOMAIN,//g;s/DOMAIN-SUFFIX,//g;s/domain://g;s/full://g' |
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
    adfilter_homepage="https://github.com/Potterli20/file/releases/tag/ad-hosts-pro"
    adfilter_timeupdated=$(TZ=UTC-8 date -d "@${now}" '+%Y-%m-%dT%H:%M:%S%:z')
    adfilter_title="trli's Ad Filter for Pro"
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
        echo "[error] 最终域名仅 ${total_lines} 条, 疑似抓取大面积失败, 已中止以保护线上产物 (临时目录 ./ad-hosts-pro 保留供排查)" >&2
        exit 1
    fi

    # 与上一次产物比对, 无变化则跳过 (CI 全新检出时无历史文件, 始终生成)
    if [[ -f ../ad-domains.txt ]]; then
        tail -n +9 ../ad-domains.txt >./filter_data.old
        if cmp -s ./filter_data.tmp ./filter_data.old; then
            echo "[output] 数据无变化, 跳过生成" >&2
            cd "$ORIG_PWD" && rm -rf ./ad-hosts-pro
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

    cd "$ORIG_PWD" && rm -rf ./ad-hosts-pro
}

## Process
# Call GetData
GetData
# Call AnalyseData
AnalyseData
# Call OutputData
OutputData
