#!/bin/bash

# 设置URL
URL='https://blackip.ustc.edu.cn/list.php?txt'

# 输出欢迎信息
echo "正在从 $URL 获取内容..."

# 获取内容并保存到临时文件
TEMP_FILE=$(mktemp)
curl -s "$URL" -o "$TEMP_FILE"

# 检查curl是否成功
if [ $? -ne 0 ]; then
    echo "获取内容失败！"
    rm -f "$TEMP_FILE"
    exit 1
fi

# 计算总行数
total_lines=$(grep -c '^' "$TEMP_FILE")
echo "总共获取到 $total_lines 行数据"

# 每1000行一个文件
chunk_size=1000
part_number=1

# 使用split命令分割文件
split -l $chunk_size -d -a 1 "$TEMP_FILE" "blackip_part_"

# 重命名文件并添加.txt扩展名
for file in blackip_part_*; do
    if [ -f "$file" ]; then
        new_name="blackip_${part_number}.txt"
        mv "$file" "$new_name"
        lines_in_file=$(grep -c '^' "$new_name")
        echo "已创建 $new_name，包含 $lines_in_file 行数据"
        part_number=$((part_number + 1))
    fi
done

# 清理临时文件
rm -f "$TEMP_FILE"

echo "所有文件已创建完成！"
