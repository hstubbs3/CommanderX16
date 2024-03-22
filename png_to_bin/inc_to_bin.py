#! /bin/usr/env python3

import sys
with open(sys.argv[1],'rt',encoding='Latin-1') as INPUT:
	with open(sys.argv[2],'wb+') as OUTPUT:
		for i,line in enumerate(INPUT.readlines()):
			if line.startswith('.byte'):
				for value in [v.strip() for v in line[6:-1].split(',')]:
					#print(f'{i} - value : |{value}|',end="")
					if value[0] == '$':
						vout = int(value[1:],16)
					else:
						vout = int(value)
					#print(f' to [{vout}]')
					OUTPUT.write(bytes([vout]))
