#!/usr/bin/env bash
# =============================================================================
# edge-hosts.sh - Edge浏览器广告屏蔽列表下载脚本
# =============================================================================
# 功能描述：从Edge浏览器广告拦截API下载屏蔽列表，提取URL生成hosts文件
# 数据源：Microsoft Edge Abusive Ad Blocking API
# 输出文件：ad-edge-hosts.txt
# 依赖：curl、grep
# 用法：bash edge-hosts.sh
# =============================================================================

set -euo pipefail

# 引入公共工具库
source "$(dirname "$0")/common_utils.sh"

# ==================== 配置区域 ====================

# Edge浏览器广告拦截API URL
EDGE_API_URL="https://edge.microsoft.com/abusiveadblocking/api/v1/blocklist"

# 输出文件名
OUTPUT_FILE="./ad-edge-hosts.txt"

# ==================== 配置结束 ====================

# =============================================================================
# 主处理逻辑
# =============================================================================

main() {
    log_info "edge-hosts.sh 脚本启动"
    log_info "从Edge API下载广告屏蔽列表: $EDGE_API_URL"

    # 下载并提取URL
    if ! curl -s "$EDGE_API_URL" | grep -oP '(?<=url":")(.*?)(?=")' > "$OUTPUT_FILE" 2>/dev/null; then
        log_error "从Edge API下载或处理数据失败"
        exit 1
    fi

    # 检查输出文件
    if [ ! -s "$OUTPUT_FILE" ]; then
        log_warn "输出文件为空，可能API返回数据中无匹配的URL字段"
    else
        log_info "输出文件生成成功: $OUTPUT_FILE ($(wc -l < "$OUTPUT_FILE") 行)"
    fi

    log_info "edge-hosts.sh 脚本执行完成"
}

main
