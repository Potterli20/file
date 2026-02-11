#!/bin/bash

# 定义所有链接
gfwlist2agh_modify=(
    "https://raw.githubusercontent.com/hezhijie0327/GFWList2AGH/refs/heads/main/data/data_modify.txt"
    "https://raw.githubusercontent.com/Atroc-X/GFWList-AGH/source/data/data_modify.txt"
    "https://raw.githubusercontent.com/jimmyshjj/GFWList2AGH/source/data/data_modify.txt"
    "https://raw.githubusercontent.com/madswaord/GFWList2AGH/refs/heads/source/data/data_modify.txt"
    "https://raw.githubusercontent.com/WPF0414/GFWList2AGH/refs/heads/source/data/data_modify.txt"
)

# 下载、合并、去重
tmpfile="gfwlist2agh_modify_merged.txt"
> "$tmpfile"
for url in "${gfwlist2agh_modify[@]}"; do
    curl -sL "$url" >> "$tmpfile"
done

# 确保输出目录存在
mkdir -p ./file-hosts/gfwlist2agh_modify

# 去重并去除空格和#号后输出到最终文件，删除所有包含 example.org 的行，并保留 (*&*)com.cn
sort "$tmpfile" | uniq | sed 's/[[:space:]]//g' | sed '/^#/d;/^$/d' | grep -v 'example\.org'  > ./file-hosts/gfwlist2agh_modify/gfwlist2agh_modify_final.txt

# 可选：删除临时文件
rm "$tmpfile"

echo "合并去重完成，结果在 gfwlist2agh_modify_final.txt"
