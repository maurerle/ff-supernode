#! /usr/bin/python3

import sys
import re

for line in sys.stdin:
    try:
      line = line.strip()
      if not line: continue
      ip, name = re.split(r'\s+', line)
      split_name = name.split(".")
      split_name[0] = split_name[0][:63].replace("+", "-").replace("&", "-").strip("-")
      # bad hack, to only use new wg domain addresses
      if ip[16] == ':': continue
      # idna should not be too long
      name = ".".join(split_name)
      print("{} {}".format(ip, name.encode('idna').decode()))
    except Exception as e:
      raise Exception(f"{name} {e}")
