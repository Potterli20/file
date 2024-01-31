# 导入必要的库
import re
import requests
from datetime import datetime
import pytz

# 获取网络文件的内容
response = requests.get('https://github.com/Potterli20/file/releases/download/github-hosts/gfw-Hosts.txt')
lines = response.text.split('\n')

# 定义你的替换函数
def replace_text(line):
    ipv4_pattern = r"(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\s+)(\S+)"
    ipv6_pattern = r"([0-9a-fA-F]{1,4}:[0-9a-fA-F:]{1,39}\s+)(\S+)"
    ipv4_replacement = "||\\2^$dnsrewrite=NOERROR;A;\\1"
    ipv6_replacement = "||\\2^$dnsrewrite=NOERROR;AAAA;\\1"
    line = re.sub(ipv4_pattern, ipv4_replacement, line)
    line = re.sub(ipv6_pattern, ipv6_replacement, line)
    return line

# 获取当前的北京时间
def get_time():
    beijing_tz = pytz.timezone('Asia/Shanghai')
    beijing_time = datetime.now(beijing_tz)
    return beijing_time.strftime('%Y-%m-%d %H:%M:%S')

# 应用替换函数到每一行
new_lines = [replace_text(line) for line in lines]

# 写入新的文件
with open('./file-hosts.sh/dnstype.txt/gfw-Hosts-dnstype.txt', 'w') as file:
    file.write('# Hosts Start \n')
    for line in new_lines:
        file.write(line + '\n')
    file.write('\n# Last update at %s (Beijing Time)\n'%(get_time()))
    file.write('# Star me GitHub url: https://github.com/Potterli20/file/releases/download/github--dnstype\n')
    file.write('# Hosts End \n\n')