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
        "https://github.com/hoshsadiq/adblock-nocoin-list/blob/master/nocoin.txt"
        "https://raw.githubusercontent.com/elliotwutingfeng/Inversion-DNSBL-Blocklists/main/Google_hostnames_ABP.txt"
        "https://zoso.ro/pages/rolist.txt"
        "https://zoso.ro/pages/rolist2.txt"
        $(for i in {1..300}; do echo "https://filters.adtidy.org/android/filters/${i}_optimized.txt"; done)
        $(for i in {1..300}; do echo "https://filters.adtidy.org/extension/chromium/filters/${i}.txt"; done)
        $(for i in {1..300}; do echo "https://filters.adtidy.org/windows/filters/${i}.txt"; done)
        $(for i in {1..300}; do echo "https://filters.adtidy.org/extension/ublock/filters/${i}_optimized.txt"; done)
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/AdGuard/BlockHttpDNS/BlockHttpDNS.txt"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/AdGuard/Privacy/Privacy.txt"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/AdGuard/AdvertisingTest/AdvertisingTest.txt"
        "https://raw.githubusercontent.com/lennihein/LostAd/main/lostad.txt"
        "https://raw.githubusercontent.com/lennihein/LostAd/main/lostad_dns.txt"
        "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=adblockplus&showintro=1&mimetype=plaintext"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/AdGuard/AdvertisingLite/AdvertisingLite.txt"
        "https://raw.githubusercontent.com/BlackJack8/iOSAdblockList/master/Hosts.txt"
        "https://code.gitlink.org.cn/zzp282/ads/raw/branch/master/ADSLJ.txt"
        "https://raw.githubusercontent.com/easylist/easylist/master/easylist/easylist_adservers.txt"
        "https://raw.githubusercontent.com/easylist/easylistchina/master/easylistchina.txt"
        "https://raw.githubusercontent.com/easylist/ruadlist/master/advblock/adservers.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/adult-themed/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/autodiscover/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/bogons/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/cloak/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/covid/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/dutch/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/easylist/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/family-safe/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/firebogtick/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/french/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/homograph/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/mal-ip-tiny/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/malicious-dom/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/my-routedns-regexp/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/my-routedns/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/nasty/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/nextdns-recommended/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/nextdns/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/nrd/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/ofac/adblock.txt"
        "https://raw.githubusercontent.com/alexsannikov/adguardhome-filters/master/porn.txt	"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/private-only/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/spamhaus/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/tlds/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/top/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/typosquat/adblock.txt"
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
        "https://raw.githubusercontent.com/MkingSakura/AD-Hosts/main/Hosts/360Hosts.txt"
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
        "https://sub.adtchrome.com/adt-chinalist-easylist.txt"
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
        "https://raw.githubusercontent.com/hufilter/hufilter/master/hufilter-dns.txt"
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
        "https://raw.githubusercontent.com/mtxadmin/ublock/master/hosts/subdomains/_marketing_ad-_all"
        "https://raw.githubusercontent.com/mtxadmin/ublock/master/hosts/subdomains/_marketing_a-d-_all"
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
        "https://raw.githubusercontent.com/MkingSakura/AD-Hosts/main/Hosts/WzHost.txt"
        "https://www.github.developerdan.com/hosts/lists/ads-and-tracking-extended.txt"
        "https://raw.githubusercontent.com/FiltersHeroes/KADhosts/master/KADhosts.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardApps.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardCNAME.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardDNS.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardMobileAds.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardMobileSpyware.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/EasyPrivacyCNAME.txt"
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/EasyPrivacySpecific.txt"
        "https://dbl.oisd.nl"
        "https://orca.pet/notonmyshift/hosts.txt"
        "https://stopforumspam.com/downloads/toxic_domains_whole.txt"
        "https://hblock.molinero.dev/hosts"
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/ad-block-YouTube-Project.txt"
        "https://raw.githubusercontent.com/vdbhb59/hosts/master/hblock"
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
        "https://raw.githubusercontent.com/Ewpratten/youtube_ad_blocklist/master/blocklist.txt"
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
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/NorwegianExperimentalList%20alternate%20versions/AdawayHosts"
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
        "https://raw.githubusercontent.com/DivineEngine/Profiles/master/Quantumult/Filter/Guard/Advertising.list"
        "https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Advertising.list"
        "https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Hijacking.list"
        "https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Privacy.list"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/Privacy/Privacy_Classical.yaml"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/Advertising/Advertising_Classical.yaml"
    )
    filter_white=(
        "https://raw.githubusercontent.com/Potterli20/file/main/file-hosts/allow/Domains"
    )
    mkdir ./ad-hosts-pro && cd ./ad-hosts-pro

    function fetch_data() {
        local filter_array=("${!1}")
        local output_file=$2
        for url in "${filter_array[@]}"; do
            curl -m 30 -s -L --connect-timeout 15 "$url" >>"$output_file"
        done
    }

    fetch_data filter_adblock[@] ./filter_adblock.tmp
    fetch_data filter_domain[@] ./filter_domain.tmp
    fetch_data filter_hosts[@] ./filter_hosts.tmp
    fetch_data filter_other[@] ./filter_other.tmp
    fetch_data filter_white[@] ./filter_white.tmp
}

# Analyse Data
function AnalyseData() {
    filter_data=(
        $(cat ./filter_white.tmp |
            sed "s/[[:space:]]//g;s/0\.0\.0\.0//g;s/127\.0\.0\.1//g;s/\:\:1//g;s/\:\://g" |
            sed 's/[ ]*//g' |
            sed '/^$/d' |
            tr -d "@^|" |
            tr "A-Z" "a-z" |
            grep -a -E "^(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$" |
            sort |
            uniq >./filter_allow.tmp &&
            cat ./filter_adblock.tmp ./filter_domain.tmp ./filter_hosts.tmp ./filter_other.tmp |
            sed 's/[ ]*//g' |
            sed '/^$/d' |
            sed "s/0\.0\.0\.0//g;s/127\.0\.0\.1//g;s/255.255.255.255//g;s/local//g;s/localhost//g;s/localhost.localdomain//g;s/broadcasthost//g;s/ip6-localhost//g;s/::1//g;s/ip6-loopback//g;s/ip6-localnet//g;s/fe80::1%lo0//g;s/ff00::0//g;s/ff02::1//g;s/ff02::2//g;s/ff02::3//g;s/ip6-mcastprefix//g;s/ip6-allnodes//g;s/ip6-allrouters//g;s/ip6-allhosts//g;/^$/d;s/[[:space:]]//g;s/DOMAIN\,//g;s/DOMAIN\-SUFFIX\,//g;s/domain\://g;s/full\://g" |
            tr -d "^|" |
            tr "A-Z" "a-z" |
            grep -a -E "^(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$" |
            sort |
            uniq >./filter_block.tmp &&
            awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./filter_allow.tmp ./filter_block.tmp |
            sort |
            uniq >./filter_data.tmp &&
            cat ./filter_data.tmp |
            grep -v "\.\." |
            awk "{ print $2 }")
    )
}

# Generate Information
function GenerateInformation() {
    adfilter_checksum=$(TZ=UTC-8 date "+%s" | base64)
    adfilter_description="HOSTS Project"
    adfilter_expires="24 hours (update frequency)"
    adfilter_homepage="https://github.com/Potterli20/file/releases/tag/ad-hosts-pro"
    adfilter_timeupdated=$(TZ=UTC-8 date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%Y-%m-%dT%H:%M:%S%:z")
    adfilter_title="trli's Ad Filter for Pro"
    adfilter_total=$(sed -n '$=' ./filter_data.tmp)
    adfilter_version=$(TZ=UTC-8 date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%Y%m%d")-$((10#$(TZ=UTC-8 date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%H") / 3))

    function generate_file() {
        local file_path=$1
        local header=$2
        echo "$header" >"$file_path"
    }

    function generate_common_headers() {
        local title_suffix=$1
        echo "! Checksum: ${adfilter_checksum}"
        echo "! Title: ${adfilter_title} for ${title_suffix}"
        echo "! Description: ${adfilter_description}"
        echo "! Version: ${adfilter_version}"
        echo "! TimeUpdated: ${adfilter_timeupdated}"
        echo "! Expires: ${adfilter_expires}"
        echo "! Homepage: ${adfilter_homepage}"
        echo "! Total: ${adfilter_total}"
    }

    generate_file ../ad-adblock.txt "$(generate_common_headers "Adblock")"
    generate_file ../ad-adguardhome.txt "$(generate_common_headers "AdguardHome")"
    generate_file ../ad-clash.yaml "payload:\n$(generate_common_headers "Clash")"
    generate_file ../ad-clash-premium.yaml "payload:\n$(generate_common_headers "Clash Premium")"
    generate_file ../ad-dnsmasq.conf "$(generate_common_headers "Dnsmasq")"
    generate_file ../ad-domains.txt "$(generate_common_headers "Domains")"
    generate_file ../ad-hosts.txt "$(generate_common_headers "Hosts")\n# (DO NOT REMOVE)"
    generate_file ../ad-quantumult.yaml "$(generate_common_headers "Quantumult")"
    generate_file ../ad-shadowrocket.list "$(generate_common_headers "Shadowrocket")"
    generate_file ../ad-smartdns.conf "$(generate_common_headers "SmartDNS")"
    generate_file ../ad-surge.yaml "$(generate_common_headers "Surge")"
    generate_file ../ad-unbound.conf "$(generate_common_headers "Unbound")"
    generate_file ../ad-bind9.conf "$(generate_common_headers "Bind9")\n\$TTL 30\n@ IN SOA rpz.trli.home. hostmaster.rpz.trli.home. 1643540837 86400 3600 604800 30\nNS localhost."
    generate_file ../ad-adguardhome-dnstype.txt "$(generate_common_headers "AdguardHome dnstype")"
    
    # 优化 ad-singbox.json 文件生成逻辑
    generate_file ../ad-singbox.json "{\n  \"version\": \"1\",\n  \"rules\": [\n    {\n      \"domain_suffix\": [\n"
    local json_header="{\n  \"checksum\": \"${adfilter_checksum}\",\n  \"title\": \"${adfilter_title} for Singbox\",\n  \"description\": \"${adfilter_description}\",\n  \"version\": \"${adfilter_version}\",\n  \"timeUpdated\": \"${adfilter_timeupdated}\",\n  \"expires\": \"${adfilter_expires}\",\n  \"homepage\": \"${adfilter_homepage}\",\n  \"total\": ${adfilter_total}\n}"
    echo -e "$json_header" >> ../ad-singbox.json
    truncate -s-2 ../ad-singbox.json
    echo "\n      ]\n    }\n  ]\n}" >>../ad-singbox.json
}

# Output Data
function OutputData() {
    function FormatedOutputData() {
        for filter_data_task in "${!filter_data[@]}"; do
            echo "||${filter_data[$filter_data_task]}^" >>../ad-adblock.txt
            echo "|${filter_data[$filter_data_task]}^" >>../ad-adguardhome.txt
            echo "  - DOMAIN,${filter_data[$filter_data_task]}" >>../ad-clash.yaml
            echo "  - '+.${filter_data[$filter_data_task]}'" >>../ad-clash-premium.yaml
            echo "address=/${filter_data[$filter_data_task]}/" >>../ad-dnsmasq.conf
            echo "${filter_data[$filter_data_task]}" >>../ad-domains.txt
            echo "127.0.0.53 ${filter_data[$filter_data_task]}" >>../ad-hosts.txt
            echo "HOST-SUFFIX,${filter_data[$filter_data_task]},REJECT" >>../ad-quantumult.yaml
            echo "DOMAIN-SUFFIX,${filter_data[$filter_data_task]},REJECT" >>../ad-shadowrocket.list
            echo "address /${filter_data[$filter_data_task]}/#" >>../ad-smartdns.conf
            echo "DOMAIN,${filter_data[$filter_data_task]}" >>../ad-surge.yaml
            echo "local-zone: \"${filter_data[$filter_data_task]}\" always_nxdomain" >>../ad-unbound.conf
            echo "${filter_data[$filter_data_task]} CNAME ." >>../ad-bind9.conf
            echo "* ${filter_data[$filter_data_task]} CNAME ." >>../ad-bind9.conf
            echo "||${filter_data[$filter_data_task]}^$client=127.0.0.53,dnstype=A" >>../ad-adguardhome-dnstype.txt
            echo "        \"${filter_data[$filter_data_task]}\"," >>../ad-singbox.json
        done
        # Remove the last comma and close the JSON array
        truncate -s-2 ../ad-singbox.json
        echo "\n      ]\n    }\n  ]\n}" >>../ad-singbox.json
    }

    if [ ! -f "../ad-domains.txt" ]; then
        GenerateInformation && FormatedOutputData
        cd .. && rm -rf ./ad-hosts-pro
    else
        cat ../ad-domains.txt | head -n $(sed -n '$=' ../ad-domains.txt) | tail -n +9 >./filter_data.old
        if [ "$(diff ./filter_data.tmp ./filter_data.old)" == "" ]; then
            cd .. && rm -rf ./ad-hosts-pro
        else
            GenerateInformation && FormatedOutputData
            cd .. && rm -rf ./ad-hosts-pro ./ad-hosts
        fi
    fi
}

## Process
# Call GetData
GetData
# Call AnalyseData
AnalyseData
# Call OutputData
OutputData
