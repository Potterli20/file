temp_file=$(mktemp)

curl -fsS https://raw.githubusercontent.com/BililiveRecorder/website/main/src/data/cdn/bcdn.json | grep -oE '"[a-z0-9][a-z0-9.-]*\.(com|cn|net)"' | tr -d '"' >> $temp_file
curl -fsS https://raw.githubusercontent.com/BililiveRecorder/website/main/src/data/cdn/gotcha.json | grep -oE '"[a-z0-9][a-z0-9.-]*\.(com|cn|net)"' | tr -d '"' >> $temp_file
curl -fsS https://raw.githubusercontent.com/babywbx/BiliCDN/refs/heads/data/domains.live.txt >> $temp_file
curl -fsS https://raw.githubusercontent.com/babywbx/BiliCDN/refs/heads/data/domains.txt >> $temp_file
curl -fsS https://raw.githubusercontent.com/babywbx/BiliCDN/refs/heads/data/domains.video.txt >> $temp_file

# 合并并去重
sort -u $temp_file > bilibili-cdn.txt

# 删除临时文件
rm $temp_file
