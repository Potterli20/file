#!/usr/bin/env python
# coding:utf-8

import socket
import argparse
import sys

from datetime import datetime, timedelta, timezone
from rich.console import Console

console = Console()

parser = argparse.ArgumentParser(description='Parse the github domain to get ip, or parse given domain.')
parser.add_argument('-d','--domains',nargs='*',help = 'input domain to be parse')
parser.add_argument('-f','--file',nargs='*',type=argparse.FileType('r'),help='give me a file here!')
parser.add_argument('-o','--output',nargs=1,type=str,help='output name')
args = parser.parse_args()

domains = []
name = "Accelerate-Hosts.txt"

if args.output:
  name = args.output[0]

if args.domains:
  domains.extend(args.domains)
elif args.file:
  for f in args.file:
    domains.extend(f.read().splitlines())
        
def get_ip_list(domain): # 获取域名解析出的IP列表
  ip_list = []
  try:
    addrs = socket.getaddrinfo(domain, None)
    for item in addrs:
      ip = item[4][0]
      if ip not in ip_list:
        ip_list.append(ip)
  except Exception:
    ip_list.append(f'# No resolution for {domain}')
  return ip_list

def gen_host():
    for domain in domains:
        console.print('Querying ip for domain ',style="#66CCFF",end="")
        console.print(domain,style="#ff6800")
        ip_list = get_ip_list(domain.strip())
        for ip in ip_list:
            yield (ip, domain)
        
def get_time(format_string="%Y-%m-%d %H:%M:%S"):#"%Y-%m-%d %H:%M:%S"
    utc_dt = datetime.utcnow().replace(tzinfo=timezone.utc)
    bj_dt = utc_dt.astimezone(timezone(timedelta(hours=8)))
    return bj_dt.strftime(format_string)

def output_hosts():
    with open(name, 'w') as f:
        f.write('# Hosts Start \n')
        for ip, domain in gen_host():
            console.print(f'ip {ip}')
            f.write(f'{ip.ljust(30)} {domain.strip()}\n')
        f.write(f'\n# Last update at {get_time()} (Beijing Time)')
        f.write('\n# Star me GitHub url: https://github.com/Potterli20/file/releases/download/github-hosts')
        f.write('\n# Hosts End \n\n')

if __name__ == '__main__':
    output_hosts()
