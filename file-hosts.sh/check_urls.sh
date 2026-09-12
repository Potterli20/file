#!/usr/bin/env bash
# =============================================================================
# check_urls.sh - 脚本URL有效性检测工具
# =============================================================================
# 功能描述：检测指定脚本中的所有URL是否可访问（HTTP状态码）
# 用法：
#   bash check_urls.sh <脚本路径> [选项]
#   bash check_urls.sh /path/to/script.sh
#   bash check_urls.sh /path/to/script.sh --parallel 8
#   bash check_urls.sh /path/to/script.sh --timeout 10
#   bash check_urls.sh /path/to/script.sh --only-404
#   bash check_urls.sh /path/to/script.sh --output result.txt
# 依赖：curl、grep
# =============================================================================

set -uo pipefail

# ==================== 参数解析 ====================
SCRIPT_PATH=""
PARALLEL_JOBS=10
TIMEOUT=10
ONLY_404=false
SHOW_STATS=true
OUTPUT_FILE=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --parallel)
            PARALLEL_JOBS="$2"
            shift 2
            ;;
        --timeout)
            TIMEOUT="$2"
            shift 2
            ;;
        --only-404)
            ONLY_404=true
            shift
            ;;
        --quiet)
            SHOW_STATS=false
            shift
            ;;
        --output|-o)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        --help|-h)
            echo "用法: bash check_urls.sh <脚本路径> [选项]"
            echo "选项:"
            echo "  --parallel N   并行检测数 (默认: 10)"
            echo "  --timeout N    超时秒数 (默认: 10)"
            echo "  --only-404     只显示404的URL"
            echo "  --quiet        不显示统计信息"
            echo "  --output FILE  输出结果到文件"
            exit 0
            ;;
        *)
            SCRIPT_PATH="$1"
            shift
            ;;
    esac
done

# ==================== 参数校验 ====================
if [[ -z "$SCRIPT_PATH" ]]; then
    echo "[ERROR] 请指定要检测的脚本路径"
    echo "用法: bash check_urls.sh <脚本路径> [选项]"
    exit 1
fi

if [[ ! -f "$SCRIPT_PATH" ]]; then
    echo "[ERROR] 文件不存在: $SCRIPT_PATH"
    exit 1
fi

# ==================== 输出函数 ====================
# 同时输出到屏幕和文件
output() {
    if [[ -n "$OUTPUT_FILE" ]]; then
        echo "$1" | tee -a "$OUTPUT_FILE"
    else
        echo "$1"
    fi
}

# ==================== 提取URL ====================
# 初始化输出文件（清空）
if [[ -n "$OUTPUT_FILE" ]]; then
    : > "$OUTPUT_FILE"
fi

output "=== URL有效性检测工具 ==="
output "脚本: $SCRIPT_PATH"
output ""

# 提取所有URL
URLS_FILE=$(mktemp)
RESULTS_FILE=$(mktemp)
trap "rm -f '$URLS_FILE' '$RESULTS_FILE'" EXIT

# 方法1: 直接提取引号中的URL
grep -oP '(?<=")(https?://[^"]+)' "$SCRIPT_PATH" | sort -u > "$URLS_FILE"

# 方法2: 检测并展开循环生成的URL
# 匹配模式: $(for i in {1..N}; do echo "URL_TEMPLATE"; done)
expand_loop_urls() {
    local script="$1"
    local urls_file="$2"
    
    # 用Python提取循环URL（更可靠）
    python3 - "$script" "$urls_file" << 'PYEOF'
import re
import sys

script_path = sys.argv[1]
urls_file = sys.argv[2]

with open(script_path, 'r') as f:
    content = f.read()

# 匹配 $(for i in {1..N}; do echo "URL"; done) 模式
pattern = r'\$\(for\s+i\s+in\s+\{1\.\.(\d+)\};\s*do\s+echo\s+"([^"]+)";\s*done\)'
matches = re.findall(pattern, content)

urls = []
for range_str, url_template in matches:
    range_max = int(range_str)
    # 生成样本: 前5个、中间1个、后5个
    samples = [1, 2, 3, 4, 5]
    if range_max > 10:
        samples.append(range_max // 2)
    if range_max > 5:
        samples.extend([range_max-4, range_max-3, range_max-2, range_max-1, range_max])
    
    for i in samples:
        if 1 <= i <= range_max:
            # 替换 ${i} 和 $i (多种写法)
            url = url_template
            url = url.replace('${i}', str(i))
            url = url.replace('$i', str(i))
            url = url.replace('{i}', str(i))
            urls.append(url)

with open(urls_file, 'a') as f:
    for url in urls:
        f.write(url + '\n')
PYEOF
}

# 检查是否有循环URL
if grep -qP '\$\(for\s+i\s+in\s+\{1\.\.\d+\}' "$SCRIPT_PATH" 2>/dev/null; then
    output "[INFO] 检测到循环生成的URL，展开样本检测..."
    expand_loop_urls "$SCRIPT_PATH" "$URLS_FILE"
    # 移除未展开的模板URL（包含${i}或$i的URL）
    grep -v '\${i}' "$URLS_FILE" | grep -v '\$i' | sort -u > "${URLS_FILE}.tmp"
    mv "${URLS_FILE}.tmp" "$URLS_FILE"
fi

TOTAL_URLS=$(wc -l < "$URLS_FILE")

if [[ "$TOTAL_URLS" -eq 0 ]]; then
    output "[WARN] 未在脚本中找到URL"
    exit 0
fi

output "共发现 $TOTAL_URLS 个URL"
output "并行检测数: $PARALLEL_JOBS"
output "超时设置: ${TIMEOUT}秒"
output ""

# ==================== 检测URL ====================
# 单个URL检测函数
check_one_url() {
    local url="$1" timeout="$2"
    local http_code
    
    # 获取HTTP状态码（不下载内容，只获取header）
    http_code=$(curl -s -o /dev/null -w "%{http_code}" \
        --connect-timeout "$timeout" \
        --max-time "$((timeout * 2))" \
        -L "$url" 2>/dev/null)
    
    if [[ -z "$http_code" ]]; then
        http_code="000"
    fi
    
    printf '%s|%s\n' "$http_code" "$url"
}

export -f check_one_url

output "开始检测..."
output ""

# 并行检测所有URL
cat "$URLS_FILE" | xargs -P "$PARALLEL_JOBS" -I {} bash -c 'check_one_url "$1" "'"$TIMEOUT"'"' _ {} > "$RESULTS_FILE" 2>/dev/null

# ==================== 分析结果 ====================
# 统计各状态码数量
declare -A STATUS_COUNTS
while IFS='|' read -r http_code url; do
    [[ -z "$http_code" ]] && continue
    STATUS_COUNTS["$http_code"]=$(( ${STATUS_COUNTS["$http_code"]:-0} + 1 ))
done < "$RESULTS_FILE"

# 按状态码分类
OK_COUNT=${STATUS_COUNTS[200]:-0}
REDIRECT_COUNT=$(( ${STATUS_COUNTS[301]:-0} + ${STATUS_COUNTS[302]:-0} + ${STATUS_COUNTS[307]:-0} + ${STATUS_COUNTS[308]:-0} ))
NOT_FOUND_COUNT=${STATUS_COUNTS[404]:-0}
FORBIDDEN_COUNT=${STATUS_COUNTS[403]:-0}
SERVER_ERROR_COUNT=$(( ${STATUS_COUNTS[500]:-0} + ${STATUS_COUNTS[502]:-0} + ${STATUS_COUNTS[503]:-0} + ${STATUS_COUNTS[504]:-0} ))
TIMEOUT_COUNT=${STATUS_COUNTS[000]:-0}
OTHER_COUNT=0

for code in "${!STATUS_COUNTS[@]}"; do
    case "$code" in
        200|301|302|307|308|404|403|500|502|503|504|000) ;;
        *) OTHER_COUNT=$((OTHER_COUNT + STATUS_COUNTS[$code])) ;;
    esac
done

# ==================== 输出统计结果 ====================
if [[ "$SHOW_STATS" == true ]]; then
    output "=== 检测结果统计 ==="
    output ""
    output "  总URL数:            $TOTAL_URLS"
    output "  ✓ 200 OK:           $OK_COUNT"
    output "  → 3xx 重定向:       $REDIRECT_COUNT"
    output "  ✗ 404 Not Found:    $NOT_FOUND_COUNT"
    output "  ✗ 403 Forbidden:    $FORBIDDEN_COUNT"
    output "  ✗ 5xx 服务器错误:   $SERVER_ERROR_COUNT"
    output "  ? 超时/连接失败:    $TIMEOUT_COUNT"
    output "  ? 其他状态码:       $OTHER_COUNT"
    output ""
fi

# ==================== 输出404 URL列表 ====================
if [[ "$NOT_FOUND_COUNT" -gt 0 ]]; then
    output "=== 404 Not Found URL列表 ($NOT_FOUND_COUNT 个) ==="
    output ""
    while IFS='|' read -r http_code url; do
        if [[ "$http_code" == "404" ]]; then
            output "  ✗ $url"
        fi
    done < "$RESULTS_FILE"
    output ""
fi

# ==================== 输出403 URL列表 ====================
if [[ "$FORBIDDEN_COUNT" -gt 0 ]] && [[ "$ONLY_404" == false ]]; then
    output "=== 403 Forbidden URL列表 ($FORBIDDEN_COUNT 个) ==="
    output ""
    while IFS='|' read -r http_code url; do
        if [[ "$http_code" == "403" ]]; then
            output "  ✗ $url"
        fi
    done < "$RESULTS_FILE"
    output ""
fi

# ==================== 输出5xx错误URL列表 ====================
if [[ "$SERVER_ERROR_COUNT" -gt 0 ]] && [[ "$ONLY_404" == false ]]; then
    output "=== 5xx 服务器错误URL列表 ($SERVER_ERROR_COUNT 个) ==="
    output ""
    while IFS='|' read -r http_code url; do
        if [[ "$http_code" =~ ^5[0-9][0-9]$ ]]; then
            output "  ✗ [$http_code] $url"
        fi
    done < "$RESULTS_FILE"
    output ""
fi

# ==================== 输出超时URL列表 ====================
if [[ "$TIMEOUT_COUNT" -gt 0 ]] && [[ "$ONLY_404" == false ]]; then
    output "=== 超时/连接失败URL列表 ($TIMEOUT_COUNT 个) ==="
    output ""
    while IFS='|' read -r http_code url; do
        if [[ "$http_code" == "000" ]]; then
            output "  ? $url"
        fi
    done < "$RESULTS_FILE"
    output ""
fi

# ==================== 输出所有结果 ====================
if [[ "$ONLY_404" == false ]] && [[ "$SHOW_STATS" == true ]]; then
    output "=== 所有URL检测结果 ==="
    output ""
    output "  状态码  URL"
    output "  ------  ---"
    
    while IFS='|' read -r http_code url; do
        [[ -z "$http_code" ]] && continue
        case "$http_code" in
            200) output "  [200] ✓ $url" ;;
            301|302|307|308) output "  [$http_code] → $url" ;;
            404) output "  [404] ✗ $url" ;;
            403) output "  [403] ✗ $url" ;;
            500|502|503|504) output "  [$http_code] ✗ $url" ;;
            000) output "  [000] ? $url" ;;
            *) output "  [$http_code] ? $url" ;;
        esac
    done < "$RESULTS_FILE"
fi

# ==================== 提示输出文件 ====================
if [[ -n "$OUTPUT_FILE" ]]; then
    echo ""
    echo "[INFO] 检测结果已保存到: $OUTPUT_FILE"
fi

# ==================== 退出码 ====================
if [[ "$NOT_FOUND_COUNT" -gt 0 ]]; then
    exit 1
else
    exit 0
fi
