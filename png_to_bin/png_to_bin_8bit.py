#! /bin/usr/env python3

import png
import sys

hexdigits = {'0':0,'1':2,'2':3,'3':4,'4':5,'5':5,'6':6,'7':7,'8':8,'9':9,'a':10,'b':11,'c':12,'d':13,'e':14,'f':15}
num_to_hex = ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f']
palette = []

with open("gimp_cx16pal.txt",'rt',encoding="Latin-1") as FILE: 
	for line in FILE.readlines():
		if line.startswith('#'):
			red = hexdigits[line[1]]*16+hexdigits[line[2]]
			green = hexdigits[line[3]]*16+hexdigits[line[4]]
			blue = hexdigits[line[5]]*16+hexdigits[line[6]]
#			print(f'{len(palette)} : {red} {green} {blue}')
			palette.append((red,green,blue))

palette[0]=(-255,-255,-255) # set transparencies

for i,_ in enumerate(palette):
	print(f'{i} : {_}')

image = png.Reader(sys.argv[1]).read()
width = image[0]
height = image[1]
print(f"read in {sys.argv[1]} , {width} x {height}")


true_colors_to_std = {}
true_colors_to_12bit = {}

with open(f'{sys.argv[2]}.std8.bin','wt',encoding="Latin-1") as OUT:
	rows_out = []
	for row in image[2]:
		row_out = []
		for (r,g,b,a) in zip(row[::4],row[1::4],row[2::4],row[3::4]):
			#print(r,g,b,a)
			best_palette_color = 0
			if a > 127:
				best_palette_color = true_colors_to_std.get((r,g,b),-1)
				if best_palette_color < 0 :
					best_distance=5000
					for i,(p_r,p_g,p_b) in enumerate(palette):
						distance = (p_r-r)*(p_r-r) + (p_g-g)*(p_g-g) + (p_b-b)*(p_b-b)
						if distance < best_distance:
							best_palette_color = i
							best_distance=distance 
							#print(f'        d={distance} : {p_r} {p_g} {p_b} : {best_palette_offset}')
				true_colors_to_std[(r,g,b)]=best_palette_color
				v = max(r,g,b)
				s = v - min(r,g,b)
				if s == 0 : h=0
				elif r == v: # red is max
					if g > b :
						h = 

				r_low = int(r/16)
				r_max = min(r_low+2,16)
				g_low = int(g/16)
				g_max = min(g_low+2,16)
				b_low = int(b/16)
				b_max = min(b_low+2,16)
				best_12bit = (r_low,g_low,b_low)
				best_distance = 5000
					for r4 in range(r_low,r_max):
						for g4 in range(g_low,g_max):
							for b4 in range(b_low,b_max)

			row_out.append(best_palette_color)

palette_colors = 
best_offset = -1
best_offset_score = -1 

for i,offset in enumerate(palette_offsets):
	print(i,offset)
	if offset > best_offset_score:
		best_offset=i 
		best_offset_score=offset 

print(f'best palette offset was found to be {best_offset}') 

final_palette = palette[best_offset*16:best_offset*16+16]

image = png.Reader(sys.argv[1]).read()

rows=[]
if True: #with open(sys.argv[2],'wt',encoding="Latin-1") as OUT:
	for row in image[2]:
		row_out = []
		for (r,g,b,a) in zip(row[::4],row[1::4],row[2::4],row[3::4]):
			#print(r,g,b,a)
			best_distance=5000
			best_palette_color = 0
			if a > 127:
				for i,(p_r,p_g,p_b) in enumerate(final_palette):
					distance = (p_r-r)*(p_r-r) + (p_g-g)*(p_g-g) + (p_b-b)*(p_b-b)
					if distance < best_distance:
						best_palette_color = i
						best_distance=distance 
						#print(f'        d={distance} : {p_r} {p_g} {p_b} : {best_palette_color}')
			row_out.append(num_to_hex[best_palette_color])
		#print(''.join(row_out))
		print('.byte ',','.join([ f'${a}{b}' for (a,b) in zip(row_out[:64:2],row_out[1:64:2])]))
		rows.append(row_out)

for row_out in rows:
	print('.byte ',','.join([ f'${a}{b}' for (a,b) in zip(row_out[64::2],row_out[65::2])]),'; second half')

