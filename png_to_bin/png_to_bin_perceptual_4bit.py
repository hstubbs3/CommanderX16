#! /bin/usr/env python3

import png
import sys
from math import sqrt

hexdigits = {'0':0,'1':2,'2':3,'3':4,'4':5,'5':5,'6':6,'7':7,'8':8,'9':9,'a':10,'b':11,'c':12,'d':13,'e':14,'f':15}
num_to_hex = ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f']
palette = []

def calc_hsp(red,green,blue):
			p = int(sqrt( 0.299*(red)*(red) + 0.587*(green)*(green) + 0.114*(blue)*(blue) ))
			maxi = max(red,green,blue)
			d = maxi - min(red,green,blue)

			if p == 0 : 
				h = 0
				s = 0
			else:
				s = int(255*d/maxi)
				if red == maxi :
					h = int((green-blue)/red * 255/6) % 256
				elif green == maxi :
					h = int((blue-red)/green * 255/6 + 255/3)
				else :
					h = int((green-red)/blue * 255/6 + 510/3) 
			return h,s,p


with open("gimp_cx16pal.txt",'rt',encoding="Latin-1") as FILE: 
	for line in FILE.readlines():
		if line.startswith('#'):
			red = hexdigits[line[1]]*16+hexdigits[line[2]]
			green = hexdigits[line[3]]*16+hexdigits[line[4]]
			blue = hexdigits[line[5]]*16+hexdigits[line[6]]
			#https://alienryderflex.com/hsp.html
			h,s,p = calc_hsp(red,green,blue)


			print(f'{len(palette)} : {red} {green} {blue} : {h} {s} {p}')
			palette.append((red,green,blue,h,s,p))

for x in range(0,255,16):
	palette[x]=(-255,-255,-255,-255,-255,-255) # set transparencies

for _ in palette:
	print(f'{_}')

image = png.Reader(sys.argv[1]).read()
width = image[0]
height = image[1]
print(f"read in {sys.argv[1]} , {width} x {height}")
img_data=[ _ for _ in image[2]]

palette_offsets = [0 for _ in range(16)]

if True: #with open(sys.argv[2],'wt',encoding="Latin-1") as OUT:
	for row in img_data:
		for (r,g,b,a) in zip(row[::4],row[1::4],row[2::4],row[3::4]):
			#print(r,g,b,a)
			if a > 127:
				best_distance=5000
				best_palette_offset = 0
				h,s,p = calc_hsp(r,g,b)
				for i,(p_r,p_g,p_b,p_h,p_s,p_p) in enumerate(palette):
					#https://alienryderflex.com/hsp.html using the brightness modeling to account for hue here
					distance = (p_h-h)*(p_h-h) + (p_s-s)*(p_s-s) + (p_p-p)*(p_p-p)

					if distance < best_distance:
						best_palette_offset = int(i/16)
						best_distance=distance 
						#print(f'        d={distance} : {p_r} {p_g} {p_b} : {best_palette_offset}')
				palette_offsets[best_palette_offset]+=1 
				print(best_palette_offset,end=' ')
		print()

best_offset = -1
best_offset_score = -1 

for i,offset in enumerate(palette_offsets):
	print(i,offset)
	if offset > best_offset_score:
		best_offset=i 
		best_offset_score=offset 

print(f'best palette offset was found to be {best_offset}') 

with open(sys.argv[2],'wt',encoding="Latin-1") as OUT:
	OUT.write(f'; best palette offset was found to be {best_offset} ... but providing options...\n')
	for offset in range(16):
		OUT.write(f'{sys.argv[1][:-4]}_{offset}:\n')
		rows_out = []
		final_palette = palette[offset*16:offset*16+16]
		for row in img_data:
			row_out = []
			for (r,g,b,a) in zip(row[::4],row[1::4],row[2::4],row[3::4]):
				#print(r,g,b,a)
				best_distance=500000
				best_palette_color = 0
				if a > 127:
					h,s,p = calc_hsp(r,g,b)
					for i,(p_r,p_g,p_b,p_h,p_s,p_p) in enumerate(final_palette):
						distance = (p_h-h)*(p_h-h) + (p_s-s)*(p_s-s) + (p_p-p)*(p_p-p)
						if distance < best_distance:
							best_palette_color = i
							best_distance=distance 
							#print(f'        d={distance} : {p_r} {p_g} {p_b} : {best_palette_color}')
				row_out.append(num_to_hex[best_palette_color])
			#print(''.join(row_out))
			str_out = '.byte '+','.join([ f'${a}{b}' for (a,b) in zip(row_out[:64:2],row_out[1:64:2])])
			print(str_out)
			OUT.write(str_out)
			OUT.write('\n')
			rows_out.append(row_out)
		for row_out in rows_out:
			str_out = '.byte '+','.join([ f'${a}{b}' for (a,b) in zip(row_out[64::2],row_out[65::2])])
			print(str_out)
			OUT.write(str_out)
			OUT.write('\n')
	
