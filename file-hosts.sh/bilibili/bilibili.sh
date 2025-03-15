temp_file=$(mktemp)

curl https://raw.githubusercontent.com/BililiveRecorder/website/main/src/data/cdn/bcdn.json | grep -o "\w.*com" >> $temp_file
curl https://raw.githubusercontent.com/BililiveRecorder/website/main/src/data/cdn/gotcha.json | grep -o "\w.*com" >> $temp_file

# 合并并去重
sort -u $temp_file > bilibili-cdn.txt

# 删除临时文件
rm $temp_file
