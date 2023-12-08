curl https://raw.githubusercontent.com/BililiveRecorder/website/main/src/data/cdn/bcdn.json|grep -o "\w.*com"|sort >bilibili1.txt
curl https://raw.githubusercontent.com/BililiveRecorder/website/main/src/data/cdn/gotcha.json|grep -o "\w.*com"|sort > bilibili2.txt
# 合并两个文件
cat bilibili1.txt bilibili2.txt |sort -u | uniq > bilibili-cdn.txt
