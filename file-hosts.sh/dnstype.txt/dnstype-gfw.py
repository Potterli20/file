# 导入必要的库
import re
import requests

# 获取网络文件的内容
response = requests.get('https://github.com/Potterli20/file/releases/download/github-hosts/gfw-Hosts.txt')
lines = response.text.split('\n')

# 定义你的替换函数
def replace_text(line):
    pattern = r"(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\s+)(\S+)"
    replacement = "||\\2^$dnsrewrite=NOERROR;A;\\1"
    return re.sub(pattern, replacement, line)

# 应用替换函数到每一行
new_lines = [replace_text(line) for line in lines]

# 写入新的文件
with open('gfw-Hosts-dnstype.txt', 'w') as file:
    file.write('# Hosts Start \n')
    for line in new_lines:
        file.write(line + '\n')
    file.write('\n# Last update at %s (Beijing Time)\n'%(get_time()))
    file.write('# Star me GitHub url: https://github.com/Potterli20/file/releases/download/github-hosts-dnstype\n')
    file.write('# Hosts End \n\n')