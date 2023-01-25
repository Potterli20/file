# Get Data
function GetData() {
    filter_adblock=(
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/AdGuard/AdvertisingLite/AdvertisingLite.txt"
        "https://raw.githubusercontent.com/BlackJack8/iOSAdblockList/master/Hosts.txt"
        "https://code.gitlink.org.cn/zzp282/ads/raw/branch/master/ADSLJ.txt"
        "https://raw.githubusercontent.com/easylist/easylist/master/easylist/easylist_adservers.txt"
        "https://raw.githubusercontent.com/easylist/easylistchina/master/easylistchina.txt"
        "https://raw.githubusercontent.com/easylist/ruadlist/master/advblock/adservers.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/autodiscover/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/bogons/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/cloak/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/covid/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/deugniets/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/doh/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/dutch/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/easylist/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/family-safe/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/firebogtick/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/french/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/homograph/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/mal-ip-tiny/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/malicious-dom/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/malicious-ip/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/my-routedns-regexp/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/my-routedns/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/nasty/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/nextdns-recommended/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/nextdns/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/nrd/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/ofac/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/oisd/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/private-only/adblock.txt"
        "https://raw.githubusercontent.com/cbuijs/accomplist/master/quantum/adblock.txt"
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
        "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_2_English/filter.txt"
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
        "https://abl.arapurayil.com/filters/main.txt"
        "https://abl.arapurayil.com/filters/nsfw.txt"
        "https://abl.arapurayil.com/filters/social.txt"
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
        "https://filters.adtidy.org/extension/chromium/filters/1.txt"
        "https://filters.adtidy.org/extension/chromium/filters/101.txt"
        "https://filters.adtidy.org/extension/chromium/filters/102.txt"
        "https://filters.adtidy.org/extension/chromium/filters/103.txt"
        "https://filters.adtidy.org/extension/chromium/filters/104.txt"
        "https://filters.adtidy.org/extension/chromium/filters/105.txt"
        "https://filters.adtidy.org/extension/chromium/filters/106.txt"
        "https://filters.adtidy.org/extension/chromium/filters/107.txt"
        "https://filters.adtidy.org/extension/chromium/filters/108.txt"
        "https://filters.adtidy.org/extension/chromium/filters/109.txt"
        "https://filters.adtidy.org/extension/chromium/filters/11.txt"
        "https://filters.adtidy.org/extension/chromium/filters/110.txt"
        "https://filters.adtidy.org/extension/chromium/filters/111.txt"
        "https://filters.adtidy.org/extension/chromium/filters/112.txt"
        "https://filters.adtidy.org/extension/chromium/filters/113.txt"
        "https://filters.adtidy.org/extension/chromium/filters/114.txt"
        "https://filters.adtidy.org/extension/chromium/filters/115.txt"
        "https://filters.adtidy.org/extension/chromium/filters/116.txt"
        "https://filters.adtidy.org/extension/chromium/filters/117.txt"
        "https://filters.adtidy.org/extension/chromium/filters/118.txt"
        "https://filters.adtidy.org/extension/chromium/filters/119.txt"
        "https://filters.adtidy.org/extension/chromium/filters/12.txt"
        "https://filters.adtidy.org/extension/chromium/filters/120.txt"
        "https://filters.adtidy.org/extension/chromium/filters/121.txt"
        "https://filters.adtidy.org/extension/chromium/filters/122.txt"
        "https://filters.adtidy.org/extension/chromium/filters/123.txt"
        "https://filters.adtidy.org/extension/chromium/filters/13.txt"
        "https://filters.adtidy.org/extension/chromium/filters/14.txt"
        "https://filters.adtidy.org/extension/chromium/filters/15.txt"
        "https://filters.adtidy.org/extension/chromium/filters/16.txt"
        "https://filters.adtidy.org/extension/chromium/filters/17.txt"
        "https://filters.adtidy.org/extension/chromium/filters/2.txt"
        "https://filters.adtidy.org/extension/chromium/filters/200.txt"
        "https://filters.adtidy.org/extension/chromium/filters/201.txt"
        "https://filters.adtidy.org/extension/chromium/filters/203.txt"
        "https://filters.adtidy.org/extension/chromium/filters/204.txt"
        "https://filters.adtidy.org/extension/chromium/filters/205.txt"
        "https://filters.adtidy.org/extension/chromium/filters/206.txt"
        "https://filters.adtidy.org/extension/chromium/filters/207.txt"
        "https://filters.adtidy.org/extension/chromium/filters/208.txt"
        "https://filters.adtidy.org/extension/chromium/filters/209.txt"
        "https://filters.adtidy.org/extension/chromium/filters/210.txt"
        "https://filters.adtidy.org/extension/chromium/filters/211.txt"
        "https://filters.adtidy.org/extension/chromium/filters/212.txt"
        "https://filters.adtidy.org/extension/chromium/filters/213.txt"
        "https://filters.adtidy.org/extension/chromium/filters/214.txt"
        "https://filters.adtidy.org/extension/chromium/filters/215.txt"
        "https://filters.adtidy.org/extension/chromium/filters/216.txt"
        "https://filters.adtidy.org/extension/chromium/filters/217.txt"
        "https://filters.adtidy.org/extension/chromium/filters/218.txt"
        "https://filters.adtidy.org/extension/chromium/filters/219.txt"
        "https://filters.adtidy.org/extension/chromium/filters/220.txt"
        "https://filters.adtidy.org/extension/chromium/filters/221.txt"
        "https://filters.adtidy.org/extension/chromium/filters/222.txt"
        "https://filters.adtidy.org/extension/chromium/filters/223.txt"
        "https://filters.adtidy.org/extension/chromium/filters/224.txt"
        "https://filters.adtidy.org/extension/chromium/filters/225.txt"
        "https://filters.adtidy.org/extension/chromium/filters/226.txt"
        "https://filters.adtidy.org/extension/chromium/filters/227.txt"
        "https://filters.adtidy.org/extension/chromium/filters/228.txt"
        "https://filters.adtidy.org/extension/chromium/filters/229.txt"
        "https://filters.adtidy.org/extension/chromium/filters/230.txt"
        "https://filters.adtidy.org/extension/chromium/filters/231.txt"
        "https://filters.adtidy.org/extension/chromium/filters/232.txt"
        "https://filters.adtidy.org/extension/chromium/filters/233.txt"
        "https://filters.adtidy.org/extension/chromium/filters/234.txt"
        "https://filters.adtidy.org/extension/chromium/filters/235.txt"
        "https://filters.adtidy.org/extension/chromium/filters/236.txt"
        "https://filters.adtidy.org/extension/chromium/filters/237.txt"
        "https://filters.adtidy.org/extension/chromium/filters/238.txt"
        "https://filters.adtidy.org/extension/chromium/filters/239.txt"
        "https://filters.adtidy.org/extension/chromium/filters/240.txt"
        "https://filters.adtidy.org/extension/chromium/filters/241.txt"
        "https://filters.adtidy.org/extension/chromium/filters/242.txt"
        "https://filters.adtidy.org/extension/chromium/filters/243.txt"
        "https://filters.adtidy.org/extension/chromium/filters/244.txt"
        "https://filters.adtidy.org/extension/chromium/filters/245.txt"
        "https://filters.adtidy.org/extension/chromium/filters/246.txt"
        "https://filters.adtidy.org/extension/chromium/filters/247.txt"
        "https://filters.adtidy.org/extension/chromium/filters/249.txt"
        "https://filters.adtidy.org/extension/chromium/filters/3.txt"
        "https://filters.adtidy.org/extension/chromium/filters/4.txt"
        "https://filters.adtidy.org/extension/chromium/filters/5.txt"
        "https://filters.adtidy.org/extension/chromium/filters/6.txt"
        "https://filters.adtidy.org/extension/chromium/filters/7.txt"
        "https://filters.adtidy.org/extension/chromium/filters/8.txt"
        "https://filters.adtidy.org/extension/chromium/filters/9.txt"
        "https://filters.adtidy.org/extension/chromium/filters/10.txt"
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
        "https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/ABP-FX.txt"
        "https://sub.adtchrome.com/adt-chinalist-easylist.txt"
        "https://www.fanboy.co.nz/enhancedstats.txt"
        "https://secure.fanboy.co.nz/fanboy-social.txt"
        "https://www.fanboy.co.nz/fanboy-annoyance.txt"
        "https://easylist-downloads.adblockplus.org/easylistchina.txt"
        "https://easylist-downloads.adblockplus.org/easyprivacy.txt"
        "https://easylist-downloads.adblockplus.org/fanboy-annoyance.txt"
        "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/gh-pages/Filters/filter.txt"
        "https://easylist-downloads.adblockplus.org/antiadblockfilters.txt"
        "https://easylist-downloads.adblockplus.org/easylistchina+easylistchina_compliance+easylist.txt"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
        "https://filters.adtidy.org/android/filters/10_optimized.txt"
        "https://filters.adtidy.org/android/filters/11_optimized.txt"
        "https://filters.adtidy.org/android/filters/15_optimized.txt"
        "https://gitee.com/hong145/some-web-advertising-rules/raw/master/not-app.txtsed"
        "https://www.i-dont-care-about-cookies.eu/abp/"
        "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/ChineseFilter/sections/adservers.txt"
        "https://raw.githubusercontent.com/Zelo72/adguard/main/multi.adblock"
        "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/ChineseFilter/sections/antiadblock.txt"
        "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/GermanFilter/sections/adservers.txt"
        "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/AnnoyancesFilter/sections/annoyances.txt"
        "https://raw.githubusercontent.com/yous/YousList/master/youslist.txt"
        "https://raw.githubusercontent.com/easylist/easylist/master/easyprivacy/easyprivacy_specific_cname.txt"
        "https://raw.githubusercontent.com/easylist/easylist/master/easyprivacy/easyprivacy_specific_international.txt"
        "https://raw.githubusercontent.com/AdguardTeam/cname-trackers/master/combined_disguised_trackers.txt"
        "https://raw.githubusercontent.com/AdguardTeam/cname-trackers/master/combined_original_trackers.txt"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/YouTubeEvenMorePureVideoExperience.txt"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/AdGuard%20Home%20Compilation%20List/AdGuardHomeCompilationList.txt"
        "https://raw.githubusercontent.com/hufilter/hufilter/master/hufilter-dns.txt"
        "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/EnglishFilter/sections/adservers.txt"
        "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/SpywareFilter/sections/mobile.txt"
        "https://raw.githubusercontent.com/easylist/easylist/master/easyprivacy/easyprivacy_thirdparty.txt"
        "https://raw.githubusercontent.com/easylist/easylist/master/easyprivacy/easyprivacy_specific.txt"
        "https://raw.githubusercontent.com/easylist/easylist/master/easylist/easylist_specific_block.txt"
        "https://raw.githubusercontent.com/lassekongo83/Frellwits-filter-lists/master/Frellwits-Swedish-Filter.txt"
        "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/nocoin.txt"
        "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV-AGH.txt"
        "https://raw.githubusercontent.com/durablenapkin/scamblocklist/master/adguard.txt"
        "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt"
        "https://filters.adtidy.org/windows/filters/2.txt"
        "https://filters.adtidy.org/windows/filters/11.txt"
        "https://filters.adtidy.org/windows/filters/3.txt"
        "https://filters.adtidy.org/windows/filters/224.txt"
        "https://filters.adtidy.org/windows/filters/14.txt"
        "https://filters.adtidy.org/windows/filters/5.txt"
        "https://filters.adtidy.org/windows/filters/4.txt"
        "https://filters.adtidy.org/windows/filters/17.txt"
        "https://filters.adtidy.org/windows/filters/228.txt"
        "https://filters.adtidy.org/extension/ublock/filters/224_optimized.txt"
    )
    filter_domain=(
        "https://raw.githubusercontent.com/slyfox1186/pihole-regex/main/domains/blacklist/exact-blacklist.txt"
        "https://raw.githubusercontent.com/groovy-sky/SaferDNS/main/blocklists/domains/Ultimate.Hosts.Blacklist.txt"
        "https://raw.githubusercontent.com/neodevpro/neodevhost/master/domain"
        "https://raw.githubusercontent.com/notracking/hosts-blocklists-scripts/master/domains.dead.txt"
        "https://raw.githubusercontent.com/notracking/hosts-blocklists-scripts/master/hostnames.dead.txt"
        "https://dl.red.flag.domains/red.flag.domains.txt"
        "https://raw.githubusercontent.com/gioxx/xfiles/master/domains/upd_domains.txt"
        "https://raw.githubusercontent.com/Potterli20/file/main/ad-hosts/hosts"
        "https://block.energized.pro/unified/formats/domains.txt"
        "https://raw.githubusercontent.com/badmojr/addons_1Hosts/main/kidSaf/domains.txt"
        "https://raw.githubusercontent.com/Potterli20/file/main/ad-hosts/ad-edge-hosts.txt"
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
        "https://raw.githubusercontent.com/symbuzzer/Turkish-Ad-Hosts/main/hosts"
        "https://raw.githubusercontent.com/dxuyin/hosts/main/hosts"
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
    	"https://urlhaus.abuse.ch/downloads/hostfile"
        "https://dbl.oisd.nl"
        "https://orca.pet/notonmyshift/hosts.txt"
        "https://stopforumspam.com/downloads/toxic_domains_whole.txt"
        "https://hblock.molinero.dev/hosts"
        "https://raw.githubusercontent.com/RootFiber/youtube-ads/main/ad-block-YouTube-Project.txt"
        "https://raw.githubusercontent.com/sonofhelga/yicklist/master/yick.list"
        "https://raw.githubusercontent.com/vdbhb59/hosts/master/hosts"
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
        "https://curben.gitlab.io/malware-filter/urlhaus-filter-hosts.txt"
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
        "https://raw.githubusercontent.com/Zelo72/adguard/main/big.adblock"
        "https://raw.githubusercontent.com/uniartisan/adblock_list/master/adblock_privacy.txt"
        "https://raw.githubusercontent.com/uniartisan/adblock_list/master/adblock_plus.txt"
        "https://raw.githubusercontent.com/lassekongo83/Frellwits-filter-lists/master/Frellwits-Swedish-Hosts-File.txt"
        "https://abpvn.com/android/abpvn.txt"
        "https://someonewhocares.org/hosts/hosts"
        "https://raw.githubusercontent.com/durablenapkin/scamblocklist/master/hosts.txt"
        "https://raw.githubusercontent.com/Ultimate-Hosts-Blacklist/blacklist/master/output/domains.list/hosts/ACTIVE/hosts"
        "https://raw.githubusercontent.com/ookangzheng/blahdns/master/hosts/blacklist.txt"
        "https://curben.gitlab.io/malware-filter/urlhaus-filter-hosts-online.txt"
        "https://warui.intaa.net/adhosts/hosts.txt"
        "https://raw.githubusercontent.com/ricardbejarano/hosts/master/hosts"
    )
    filter_other=(
        "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanAD.list"
        "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanProgramAD.list"
        "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanEasyList.list"
        "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanEasyListChina.list"
        "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanEasyPrivacy.list"
        "https://raw.githubusercontent.com/eHpo1/Rules/master/Surge4/Ruleset/Liby.list"
        "https://raw.githubusercontent.com/lhie1/Rules/master/Surge/Surge%203/Provider/Reject.list"
        "https://raw.githubusercontent.com/DivineEngine/Profiles/master/Quantumult/Filter/Guard/Advertising.list"
        "https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Advertising.list"
        "https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Hijacking.list"
        "https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Privacy.list"
        "https://raw.githubusercontent.com/CipherOps/AdGuardBlocklists/main/REGEX.txt"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/Privacy/Privacy_Classical.yaml"
        "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/Advertising/Advertising_Classical.yaml"
    )
    filter_white=(
        "https://raw.githubusercontent.com/Potterli20/file/main/allow/Domains"
    )
    mkdir ./ad-hosts-pro && cd ./ad-hosts-pro
    for filter_adblock_task in "${!filter_adblock[@]}"; do
        curl -s -L --connect-timeout 15 "${filter_adblock[$filter_adblock_task]}" >> ./filter_adblock.tmp
    done
    for filter_domain_task in "${!filter_domain[@]}"; do
        curl -s -L --connect-timeout 15 "${filter_domain[$filter_domain_task]}" >> ./filter_domain.tmp
    done
    for filter_hosts_task in "${!filter_hosts[@]}"; do
        curl -s -L --connect-timeout 15 "${filter_hosts[$filter_hosts_task]}" >> ./filter_hosts.tmp
    done
    for filter_other_task in "${!filter_other[@]}"; do
        curl -s -L --connect-timeout 15 "${filter_other[$filter_other_task]}" >> ./filter_other.tmp
    done
    for filter_white_task in "${!filter_white[@]}"; do
        curl -s -L --connect-timeout 15 "${filter_white[$filter_white_task]}" >> ./filter_white.tmp
    done
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
        grep -E "^(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$" |
        sort |
        uniq > ./filter_allow.tmp &&
        cat ./filter_adblock.tmp ./filter_domain.tmp ./filter_hosts.tmp ./filter_other.tmp |
        sed 's/[ ]*//g' |
        sed '/^$/d' |
        sed "s/0\.0\.0\.0//g;s/127\.0\.0\.1//g;s/255.255.255.255//g;s/local//g;s/localhost//g;s/localhost.localdomain//g;s/broadcasthost//g;s/ip6-localhost//g;s/::1//g;s/ip6-loopback//g;s/ip6-localnet//g;s/fe80::1%lo0//g;s/ff00::0//g;s/ff02::1//g;s/ff02::2//g;s/ff02::3//g;s/ip6-mcastprefix//g;s/ip6-allnodes//g;s/ip6-allrouters//g;s/ip6-allhosts//g;/^$/d;s/[[:space:]]//g;s/DOMAIN\,//g;s/DOMAIN\-SUFFIX\,//g;s/domain\://g;s/full\://g" |
        tr -d "^|" |
        tr "A-Z" "a-z" |
        grep -E "^(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$" |
        sort |
        uniq > ./filter_block.tmp &&
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./filter_allow.tmp ./filter_block.tmp |
        sort |
        uniq > ./filter_data.tmp &&
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
    adfilter_homepage="https://file.trli.club:2083/ad-hosts/ad-hosts-pro"
    adfilter_timeupdated=$(TZ=UTC-8 date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%Y-%m-%dT%H:%M:%S%:z")
    adfilter_title="trli's Ad Filter for Pro"
    adfilter_total=$(sed -n '$=' ./filter_data.tmp)
    adfilter_version=$(TZ=UTC-8 date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%Y%m%d")-$((10#$(TZ=UTC-8 date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%H") / 3))
    function adfilter_adblock() {
        echo "! Checksum: ${adfilter_checksum}" > ../ad-adblock.txt
        echo "! Title: ${adfilter_title} for Adblock" >> ../ad-adblock.txt
        echo "! Description: ${adfilter_description}" >> ../ad-adblock.txt
        echo "! Version: ${adfilter_version}" >> ../ad-adblock.txt
        echo "! TimeUpdated: ${adfilter_timeupdated}" >> ../ad-adblock.txt
        echo "! Expires: ${adfilter_expires}" >> ../ad-adblock.txt
        echo "! Homepage: ${adfilter_homepage}" >> ../ad-adblock.txt
        echo "! Total: ${adfilter_total}" >> ../ad-adblock.txt
    }
    function adfilter_adguardhome() {
        echo "! Checksum: ${adfilter_checksum}" > ../ad-adguardhome.txt
        echo "! Title: ${adfilter_title} for AdguardHome" >> ../ad-adguardhome.txt
        echo "! Description: ${adfilter_description}" >> ../ad-adguardhome.txt
        echo "! Version: ${adfilter_version}" >> ../ad-adguardhome.txt
        echo "! TimeUpdated: ${adfilter_timeupdated}" >> ../ad-adguardhome.txt
        echo "! Expires: ${adfilter_expires}" >> ../ad-adguardhome.txt
        echo "! Homepage: ${adfilter_homepage}" >> ../ad-adguardhome.txt
        echo "! Total: ${adfilter_total}" >> ../ad-adguardhome.txt
    }
    function adfilter_clash() {
        echo "payload:" > ../ad-clash.yaml
        echo "# Checksum: ${adfilter_checksum}" >> ../ad-clash.yaml
        echo "# Title: ${adfilter_title} for Clash " >> ../ad-clash.yaml
        echo "# Description: ${adfilter_description}" >> ../ad-clash.yaml
        echo "# Version: ${adfilter_version}" >> ../ad-clash.yaml
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../ad-clash.yaml
        echo "# Expires: ${adfilter_expires}" >> ../ad-clash.yaml
        echo "# Homepage: ${adfilter_homepage}" >> ../ad-clash.yaml
        echo "# Total: ${adfilter_total}" >> ../ad-clash.yaml
    }
    function adfilter_clash_premium() {
        echo "payload:" > ../ad-clash-premium.yaml
        echo "# Checksum: ${adfilter_checksum}" >> ../ad-clash-premium.yaml
        echo "# Title: ${adfilter_title} for Clash Premium" >> ../ad-clash-premium.yaml
        echo "# Description: ${adfilter_description}" >> ../ad-clash-premium.yaml
        echo "# Version: ${adfilter_version}" >> ../ad-clash-premium.yaml
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../ad-clash-premium.yaml
        echo "# Expires: ${adfilter_expires}" >> ../ad-clash-premium.yaml
        echo "# Homepage: ${adfilter_homepage}" >> ../ad-clash-premium.yaml
        echo "# Total: ${adfilter_total}" >> ../ad-clash-premium.yaml
    }
    function adfilter_dnsmasq() {
        echo "# Checksum: ${adfilter_checksum}" > ../ad-dnsmasq.conf
        echo "# Title: ${adfilter_title} for Dnsmasq " >> ../ad-dnsmasq.conf
        echo "# Description: ${adfilter_description}" >> ../ad-dnsmasq.conf
        echo "# Version: ${adfilter_version}" >> ../ad-dnsmasq.conf
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../ad-dnsmasq.conf
        echo "# Expires: ${adfilter_expires}" >> ../ad-dnsmasq.conf
        echo "# Homepage: ${adfilter_homepage}" >> ../ad-dnsmasq.conf
        echo "# Total: ${adfilter_total}" >> ../ad-dnsmasq.conf
    }
    function adfilter_domains() {
        echo "# Checksum: ${adfilter_checksum}" > ../ad-domains.txt
        echo "# Title: ${adfilter_title} for Domains " >> ../ad-domains.txt
        echo "# Description: ${adfilter_description}" >> ../ad-domains.txt
        echo "# Version: ${adfilter_version}" >> ../ad-domains.txt
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../ad-domains.txt
        echo "# Expires: ${adfilter_expires}" >> ../ad-domains.txt
        echo "# Homepage: ${adfilter_homepage}" >> ../ad-domains.txt
        echo "# Total: ${adfilter_total}" >> ../ad-domains.txt
    }
    function adfilter_hosts() {
        echo "# Checksum: ${adfilter_checksum}" > ../ad-hosts.txt
        echo "# Title: ${adfilter_title} for Hosts " >> ../ad-hosts.txt
        echo "# Description: ${adfilter_description}" >> ../ad-hosts.txt
        echo "# Version: ${adfilter_version}" >> ../ad-hosts.txt
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../ad-hosts.txt
        echo "# Expires: ${adfilter_expires}" >> ../ad-hosts.txt
        echo "# Homepage: ${adfilter_homepage}" >> ../ad-hosts.txt
        echo "# Total: ${adfilter_total}" >> ../ad-hosts.txt
        echo "# (DO NOT REMOVE)" >> ../ad-hosts.txt
    }
    function adfilter_quantumult() {
        echo "# Checksum: ${adfilter_checksum}" > ../ad-quantumult.yaml
        echo "# Title: ${adfilter_title} for Quantumult " >> ../ad-quantumult.yaml
        echo "# Description: ${adfilter_description}" >> ../ad-quantumult.yaml
        echo "# Version: ${adfilter_version}" >> ../ad-quantumult.yaml
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../ad-quantumult.yaml
        echo "# Expires: ${adfilter_expires}" >> ../ad-quantumult.yaml
        echo "# Homepage: ${adfilter_homepage}" >> ../ad-quantumult.yaml
        echo "# Total: ${adfilter_total}" >> ../ad-quantumult.yaml
    }
    function adfilter_shadowrocket() {
        echo "# Checksum: ${adfilter_checksum}" > ../ad-shadowrocket.list
        echo "# Title: ${adfilter_title} for Shadowrocket " >> ../ad-shadowrocket.list
        echo "# Description: ${adfilter_description}" >> ../ad-shadowrocket.list
        echo "# Version: ${adfilter_version}" >> ../ad-shadowrocket.list
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../ad-shadowrocket.list
        echo "# Expires: ${adfilter_expires}" >> ../ad-shadowrocket.list
        echo "# Homepage: ${adfilter_homepage}" >> ../ad-shadowrocket.list
        echo "# Total: ${adfilter_total}" >> ../ad-shadowrocket.list
    }
    function adfilter_smartdns() {
        echo "# Checksum: ${adfilter_checksum}" > ../ad-smartdns.conf
        echo "# Title: ${adfilter_title} for SmartDNS " >> ../ad-smartdns.conf
        echo "# Description: ${adfilter_description}" >> ../ad-smartdns.conf
        echo "# Version: ${adfilter_version}" >> ../ad-smartdns.conf
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../ad-smartdns.conf
        echo "# Expires: ${adfilter_expires}" >> ../ad-smartdns.conf
        echo "# Homepage: ${adfilter_homepage}" >> ../ad-smartdns.conf
        echo "# Total: ${adfilter_total}" >> ../ad-smartdns.conf
    }
    function adfilter_surge() {
        echo "# Checksum: ${adfilter_checksum}" > ../ad-surge.yaml
        echo "# Title: ${adfilter_title} for Surge " >> ../ad-surge.yaml
        echo "# Description: ${adfilter_description}" >> ../ad-surge.yaml
        echo "# Version: ${adfilter_version}" >> ../ad-surge.yaml
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../ad-surge.yaml
        echo "# Expires: ${adfilter_expires}" >> ../ad-surge.yaml
        echo "# Homepage: ${adfilter_homepage}" >> ../ad-surge.yaml
        echo "# Total: ${adfilter_total}" >> ../ad-surge.yaml
    }
    function adfilter_unbound() {
        echo "# Checksum: ${adfilter_checksum}" > ../ad-unbound.conf
        echo "# Title: ${adfilter_title} for Unbound " >> ../ad-unbound.conf
        echo "# Description: ${adfilter_description}" >> ../ad-unbound.conf
        echo "# Version: ${adfilter_version}" >> ../ad-unbound.conf
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../ad-unbound.conf
        echo "# Expires: ${adfilter_expires}" >> ../ad-unbound.conf
        echo "# Homepage: ${adfilter_homepage}" >> ../ad-unbound.conf
        echo "# Total: ${adfilter_total}" >> ../ad-unbound.conf
    }
    function adfilter_bind9() {
        echo "# Checksum: ${adfilter_checksum}" > ../ad-bind9.conf
        echo "# Title: ${adfilter_title} for Dind9 " >> ../ad-bind9.conf
        echo "# Description: ${adfilter_description}" >> ../ad-bind9.conf
        echo "# Version: ${adfilter_version}" >> ../ad-bind9.conf
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../ad-bind9.conf
        echo "# Expires: ${adfilter_expires}" >> ../ad-bind9.conf
        echo "# Homepage: ${adfilter_homepage}" >> ../ad-bind9.conf
        echo "# Total: ${adfilter_total}" >> ../ad-bind9.conf
        echo "\$TTL 30" >> ../ad-bind9.conf
        echo "@ IN SOA rpz.trli.home. hostmaster.rpz.trli.home. 1643540837 86400 3600 604800 30" >> ../ad-bind9.conf
        echo "NS localhost." >> ../ad-bind9.conf
    }
    function adfilter_adguardhome_dnstype() {
        echo "! Checksum: ${adfilter_checksum}" > ../ad-adguardhome-dnstype.txt
        echo "! Title: ${adfilter_title} for AdguardHome dnstype" >> ../ad-adguardhome-dnstype.txt
        echo "! Description: ${adfilter_description}" >> ../ad-adguardhome-dnstype.txt
        echo "! Version: ${adfilter_version}" >> ../ad-adguardhome-dnstype.txt
        echo "! TimeUpdated: ${adfilter_timeupdated}" >> ../ad-adguardhome-dnstype.txt
        echo "! Expires: ${adfilter_expires}" >> ../ad-adguardhome-dnstype.txt
        echo "! Homepage: ${adfilter_homepage}" >> ../ad-adguardhome-dnstype.txt
        echo "! Total: ${adfilter_total}" >> ../ad-adguardhome-dnstype.txt
    }
    adfilter_adblock
    adfilter_adguardhome
    adfilter_clash
    adfilter_dnsmasq
    adfilter_domains
    adfilter_hosts
    adfilter_quantumult
    adfilter_shadowrocket
    adfilter_smartdns
    adfilter_surge
    adfilter_unbound
    adfilter_clash_premium
    adfilter_bind9
    adfilter_adguardhome_dnstype
}
# Output Data
function OutputData() {
    function FormatedOutputData() {
        for filter_data_task in "${!filter_data[@]}"; do
            echo "||${filter_data[$filter_data_task]}^" >> ../ad-adblock.txt
            echo "|${filter_data[$filter_data_task]}^" >> ../ad-adguardhome.txt
            echo "  - DOMAIN,${filter_data[$filter_data_task]}" >> ../ad-clash.yaml
            echo "  - '+.${filter_data[$filter_data_task]}'" >> ../ad-clash-premium.yaml
            echo "address=/${filter_data[$filter_data_task]}/" >> ../ad-dnsmasq.conf
            echo "${filter_data[$filter_data_task]}" >> ../ad-domains.txt
            echo "127.0.0.53 ${filter_data[$filter_data_task]}" >> ../ad-hosts.txt
            echo "HOST-SUFFIX,${filter_data[$filter_data_task]},REJECT" >> ../ad-quantumult.yaml
            echo "DOMAIN-SUFFIX,${filter_data[$filter_data_task]},REJECT" >> ../ad-shadowrocket.list
            echo "address /${filter_data[$filter_data_task]}/#" >> ../ad-smartdns.conf
            echo "DOMAIN,${filter_data[$filter_data_task]}" >> ../ad-surge.yaml
            echo "local-zone: \"${filter_data[$filter_data_task]}\" always_nxdomain" >> ../ad-unbound.conf
            echo "${filter_data[$filter_data_task]} CNAME ." >> ../ad-bind9.conf
            echo "* ${filter_data[$filter_data_task]} CNAME ." >> ../ad-bind9.conf
            echo "||${filter_data[$filter_data_task]}^$client=127.0.0.53,dnstype=A" >> ../ad-adguardhome-dnstype.txt
        done
    }
    if [ ! -f "../ad-domains.txt " ]; then
        GenerateInformation && FormatedOutputData
        cd .. && rm -rf ./ad-hosts-pro
    else
        cat ../ad-domains.txt | head -n $(sed -n '$=' ../ad-domains.txt ) | tail -n +9 > ./filter_data.old
        if [ "$(diff ./filter_data.tmp ./filter_data.old)" == "" ]; then
            cd .. && rm -rf ./ad-hosts-pro
        else
            GenerateInformation && FormatedOutputData
            cd .. && rm -rf ./ad-hosts-pro
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
