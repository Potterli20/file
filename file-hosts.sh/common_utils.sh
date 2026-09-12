#!/usr/bin/env bash
# =============================================================================
# common_utils.sh - 公共工具库
# =============================================================================
# 功能描述：为 allow.sh、pac.sh、edge-hosts.sh 提供共享的公共功能
#   - 日志输出（log_info/log_warn/log_error）
#   - 临时文件管理（create_temp_file/create_temp_dir/cleanup_temp）
#   - 下载函数（download_url/download_urls_parallel）
#   - trap 注册（register_cleanup_trap）
# 依赖：mktemp、curl、date、rm
# 使用方式：source "$(dirname "$0")/common_utils.sh"
# =============================================================================

# 仅启用未定义变量检测和管道失败检测，不强制 set -e 以免影响宿主脚本
set -uo pipefail

# -----------------------------------------------------------------------------
# 全局变量：临时资源注册表
# -----------------------------------------------------------------------------
_TEMP_FILES=()
_TEMP_DIRS=()
_LAST_TEMP_RESULT=""    # 用于传递 create_temp_file/dir 的结果，避免子shell问题

# =============================================================================
# 日志函数
# =============================================================================

# 输出信息级日志到标准错误
# 参数: $1 - 日志消息
log_info() {
    local msg="$1"
    printf '[INFO] %s %s\n' "$(date '+%Y-%m-%dT%H:%M:%S')" "$msg" >&2
    return 0
}

# 输出警告级日志到标准错误
# 参数: $1 - 日志消息
log_warn() {
    local msg="$1"
    printf '[WARN] %s %s\n' "$(date '+%Y-%m-%dT%H:%M:%S')" "$msg" >&2
    return 0
}

# 输出错误级日志到标准错误
# 参数: $1 - 日志消息
log_error() {
    local msg="$1"
    printf '[ERROR] %s %s\n' "$(date '+%Y-%m-%dT%H:%M:%S')" "$msg" >&2
    return 0
}

# =============================================================================
# 临时文件管理
# =============================================================================

# 创建安全的临时文件并注册到清理列表
# 参数: $1 - 可选前缀名（默认为脚本名）
# 输出: 临时文件路径到全局变量 _LAST_TEMP_RESULT
# 返回: 0成功，1失败
# 用法: create_temp_file "prefix"; local tmpfile="$_LAST_TEMP_RESULT"
create_temp_file() {
    local prefix="${1:-$(basename "${BASH_SOURCE[1]:-$0}")}"
    local tmp_file
    tmp_file=$(mktemp "/tmp/${prefix}.XXXXXX" 2>/dev/null) || {
        log_error "创建临时文件失败"
        return 1
    }
    _TEMP_FILES+=("$tmp_file")
    _LAST_TEMP_RESULT="$tmp_file"
    return 0
}

# 创建安全的临时目录并注册到清理列表
# 参数: $1 - 可选前缀名
# 输出: 临时目录路径到全局变量 _LAST_TEMP_RESULT
# 返回: 0成功，1失败
# 用法: create_temp_dir "prefix"; local tmpdir="$_LAST_TEMP_RESULT"
create_temp_dir() {
    local prefix="${1:-$(basename "${BASH_SOURCE[1]:-$0}")}"
    local tmp_dir
    tmp_dir=$(mktemp -d "/tmp/${prefix}.XXXXXX" 2>/dev/null) || {
        log_error "创建临时目录失败"
        return 1
    }
    _TEMP_DIRS+=("$tmp_dir")
    _LAST_TEMP_RESULT="$tmp_dir"
    return 0
}

# 清理所有已注册的临时文件和目录
# 参数: 无
# 返回: 始终为0
cleanup_temp() {
    local item
    for item in "${_TEMP_FILES[@]:-}"; do
        [ -n "$item" ] && rm -f "$item" 2>/dev/null || true
    done
    for item in "${_TEMP_DIRS[@]:-}"; do
        [ -n "$item" ] && rm -rf "$item" 2>/dev/null || true
    done
    _TEMP_FILES=()
    _TEMP_DIRS=()
    return 0
}

# =============================================================================
# 下载函数
# =============================================================================

# 下载单个URL到指定文件，带超时和错误处理
# 参数: $1 - URL, $2 - 输出文件路径, $3 - 可选超时秒数(默认15)
# 返回: 0成功，1下载失败
download_url() {
    local url="$1"
    local output="$2"
    local timeout="${3:-15}"

    if curl -s -L --connect-timeout "$timeout" "$url" -o "$output" 2>/dev/null; then
        if [ -s "$output" ]; then
            return 0
        else
            log_warn "下载内容为空: $url"
            return 1
        fi
    else
        log_warn "下载失败: $url"
        return 1
    fi
}

# 并行下载多个URL，结果合并到指定文件
# 参数: $1 - URL数组名(间接引用), $2 - 输出文件路径, $3 - 可选并行度(默认8)
# 返回: 0（部分失败仅记录日志不中断）
download_urls_parallel() {
    local -n _urls=$1
    local _output="$2"
    local _parallel="${3:-8}"
    local _timeout=15
    local _url_count=${#_urls[@]}
    local _fail_count=0

    [ "$_url_count" -eq 0 ] && {
        log_warn "URL列表为空，跳过下载"
        return 0
    }

    log_info "开始并行下载 ${_url_count} 个URL (并行度: ${_parallel})"

    # 使用 xargs -P 实现并行下载
    # 每个URL下载结果直接追加到输出文件
    printf '%s\n' "${_urls[@]}" | xargs -P "$_parallel" -I {} bash -c '
        curl -s -L --connect-timeout '"$_timeout"' "{}" 2>/dev/null
    ' >> "$_output" 2>/dev/null

    # 检查输出文件
    if [ ! -s "$_output" ]; then
        log_warn "下载完成后输出文件为空: $_output"
        return 0
    fi

    log_info "并行下载完成，输出文件: $_output"
    return 0
}

# =============================================================================
# trap 管理
# =============================================================================

# 注册信号trap，确保异常退出时清理临时资源
# 参数: $1 - 可选额外清理函数名
# 返回: 始终为0
register_cleanup_trap() {
    local extra_cleanup="${1:-}"

    _do_cleanup() {
        local exit_code=$?
        # 调用额外清理函数（如存在）
        if [ -n "$extra_cleanup" ] && type "$extra_cleanup" &>/dev/null; then
            "$extra_cleanup" 2>/dev/null || true
        fi
        # 清理临时资源
        cleanup_temp 2>/dev/null || true
        exit "$exit_code"
    }

    trap _do_cleanup EXIT INT TERM
    return 0
}
