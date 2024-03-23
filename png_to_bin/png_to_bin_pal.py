#! /bin/usr/env python3

import png
import sys
from math import sqrt

config = {
	'pal_mode':256,
	'pal_offset':0,
	'do_pal': False,
	'use_pal_file':'gimp_cx16pal.txt'
}

hexdigits = {'0':0,'1':2,'2':3,'3':4,'4':5,'5':5,'6':6,'7':7,'8':8,'9':9,'a':10,'b':11,'c':12,'d':13,'e':14,'f':15}
num_to_hex = ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f']
palette = []

image = png.Reader(sys.argv[1]).read()
width = image[0]
height = image[1]
info = image[3]
print(f"read in {sys.argv[1]} , {width} x {height}, {info}")

x = 3
while x < len(sys.argv):
	if sys.argv[x] in ('2','4','16','256'):
		config['pal_mode'] = int(sys.argv[x])
		print(f"palette mode set to : {config['pal_mode']} bpp")
	elif sys.argv[x] == '-p':
		x+=1
		config['use_pal_file']=sys.argv[x]
		print(f"using palette : {config['use_pal_file']}")
	elif sys.argv[x] == '-g':
		config['do_pal']=True
		x+=1
		config['use_pal_file']=sys.argv[x]
		print(f"doing generate palette : {config['use_pal_file']}")
	elif sys.argv[x] == '-o':
		config['pal_offset']=int(sys.argv[x])
		print(f"palette offset : {config['pal_offset']}")
	else :
		print(f"huh? {sys.argv[x:]}")
		sys.exit()
	x+=1

for (k,v) in config.items(): print(f'config : {k} : {v}')

if image[3]['planes']==4:
	image_rows = [ [ (r,g,b) if a > 128 else False for (r,g,b,a) in zip(row[::4],row[1::4],row[2::4],row[3::4]) ] for row in image[2]]
elif image[3]['planes']==3:
	image_rows = [ [ (r,g,b) for (r,g,b) in zip(row[::3],row[1::3],row[2::3]) ] for row in image[2]]
else:
	print(f"only so many planes {image[3]['planes']}")

print(f"obtained {len(image_rows)} rows of {len(image_rows[0])} cols")

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
					h = int((green-blue)/red * 256/6) % 256
				elif green == maxi :
					h = int((blue-red)/green * 256/6 + 255/3)
				else :
					h = int((green-red)/blue * 256/6 + 510/3) 
			return h,s,p

palette_colors = {}
true_colors = {}
if config['do_pal']:
	num_pal_colors = config['pal_mode']-1
	print(f"generating palette of {num_pal_colors} colors")
	for i,c in enumerate([c for r in image_rows for c in r if c]) :
		if not c : continue
		if c not in true_colors:
			r,g,b = c
			r_low = int(r/16.0)
			g_low = int(g/16.0)
			b_low = int(b/16.0)
			h,s,p = calc_hsp(r,g,b)
			best_distance = 500000
			out_color = False
			for r_try in range(r_low,min(16,r_low+2)):
				for g_try in range(g_low,min(16,g_low+2)):
					for b_try in range(b_low,min(16,b_low+2)):
						rt=r_try*17
						gt=g_try*17
						bt=b_try*17
						p_h, p_s, p_p = calc_hsp(rt,gt,bt)
						dh = min(p_h-h,256-p_h-h) if p_h >= h else min(h-p_h,256-p_h-h)
						distance = int(sqrt((dh)*(dh) + (p_s-s)*(p_s-s) + (p_p-p)*(p_p-p)))
						if distance < best_distance:
							#print(f"{i} : {len(palette_colors)} : converting {c} : {rt},{gt},{bt} : ({r_try},{g_try},{b_try}) : {distance} ++++++")
							best_distance = distance 
							out_color = (r_try,g_try,b_try,p_h,p_s,p_p) 
						#else:
							#print(f"{i} : {len(palette_colors)} : converting {c} : {rt},{gt},{bt} : ({r_try},{g_try},{b_try}) : {distance} ")
			true_colors[c]=out_color
			pt = palette_colors.get(out_color,[])
			pt.append((r,g,b,h,s,p))
			palette_colors[out_color]=pt
			print(f"{i} : {len(palette_colors)} : convert {c} : ({out_color[0]*17},{out_color[1]*17},{out_color[2]*17}) : {out_color} : {best_distance} : {len(pt)}")
			#print(f"{out_color} : {pt}")
	for i,c in enumerate(palette_colors,1):
		print(f"{i} : {c} : {len(palette_colors[c])}")
	print(f"starting from {len(palette_colors)} wanted {num_pal_colors} ....")
	times_round=0
	while len(palette_colors) > num_pal_colors:
		times_round+=1
		print(f"{times_round} : oops... need to quantize palette.... have {len(palette_colors)} wanted {num_pal_colors}")
		palette_colors_sort=[]
		for i,(c,pt) in enumerate(palette_colors.items(),1):
			centroid_r = 0
			centroid_g = 0
			centroid_b = 0
			for (r,g,b,h,s,p) in pt:
				centroid_r+=r 
				centroid_g+=g 
				centroid_b+=b 
			centroid=(int(centroid_r/len(pt)),int(centroid_g/len(pt)),int(centroid_b/len(pt)))
			centroid_r,centroid_g,centroid_b=centroid
			c_h,c_s,c_p = calc_hsp(centroid_r,centroid_g,centroid_b)
			radius = 0
			for (r,g,b,h,s,p) in pt:
						dh = min(c_h-h,256-c_h-h) if c_h >= h else min(h-c_h,256-c_h-h)
						distance = int(sqrt((dh)*(dh) + (c_s-s)*(c_s-s) + (c_p-p)*(c_p-p)))
						radius = max(radius,distance)
			print(f"{times_round} : {i} : palette color : {c} : has centroid at {centroid} and radius : {radius} covering {len(pt)}")
			palette_colors_sort.append((radius,c_p,c_h,c_s,c,False))
		palette_colors_sort.sort()
		max_radius = times_round + palette_colors_sort[int(len(palette_colors_sort)/2)][0]
		print(f"max radius set to {max_radius}")
		old_palette = palette_colors
		palette_colors = {}
		for i,(radius,p,h,s,c,fit) in enumerate(palette_colors_sort):
			if fit :
					print(f"{times_round} : {i} : already combined...")
					continue
			combine_with = False
			best_distance = 500000
			for j,(radius2,p2,h2,s2,c2,f2) in enumerate(palette_colors_sort[i+1:],i+1):
						if f2 : continue
						dh = min(h-h2,256-h2-h) if h >= h2 else min(h2-h,256-h-h2)
						distance = radius+radius2+int(sqrt((dh)*(dh) + (s2-s)*(s2-s) + (p2-p)*(p2-p)))
						if distance > max_radius : break 
						if distance > best_distance : continue
						combine_with = j
						best_distance = distance
						print(f"{times_round} : {i} {j} : combine for possible radius {best_distance}")

			if combine_with:
						print(f"{times_round} : {i} got combine_with = {combine_with}")
						(radius2,p2,h2,s2,c2,f2) = palette_colors_sort[combine_with]
						palette_colors_sort[combine_with]=(radius2,p2,h2,s2,c2,True) 
						print(radius2,p2,h2,s2,c2,f2)
						print(f"lengths of PT : {len(old_palette[c])} + {len(old_palette[c2])}")
						pt = old_palette[c] + old_palette[c2]
						print(f"length of PT now is {len(pt)}")
						#print(' '.join([str(_) for _ in pt]))
						centroid_r = 0
						centroid_g = 0
						centroid_b = 0
						for (r,g,b,h,s,p) in pt:
							centroid_r+=r 
							centroid_g+=g 
							centroid_b+=b 
						centroid=(int(centroid_r/len(pt)),int(centroid_g/len(pt)),int(centroid_b/len(pt)))
						r,g,b=centroid
						c_h,c_s,c_p = calc_hsp(r,g,b)
						r_low = int(r/16.0)
						g_low = int(g/16.0)
						b_low = int(b/16.0)
						h,s,p = calc_hsp(r,g,b)
						best_distance = 500000
						out_color = False
						for r_try in range(r_low,min(16,r_low+2)):
							for g_try in range(g_low,min(16,g_low+2)):
								for b_try in range(b_low,min(16,b_low+2)):
									rt=r_try*17
									gt=g_try*17
									bt=b_try*17
									p_h, p_s, p_p = calc_hsp(rt,gt,bt)
									dh = min(p_h-h,256-p_h-h) if p_h >= h else min(h-p_h,256-p_h-h)
									distance = int(sqrt((dh)*(dh) + (p_s-s)*(p_s-s) + (p_p-p)*(p_p-p)))
									if distance < best_distance:
										out_color = (r_try,g_try,b_try,p_h,p_s,p_p) 
										print(f"{times_round} : {i} + {combine_with} : {len(palette_colors)} : converting {c} : {rt},{gt},{bt} : ({r_try},{g_try},{b_try}) : {distance} ++++++")
										best_distance = distance 
									#else:
										#print(f"{times_round} : {i} + {combine_with} : {len(palette_colors)} : converting {c} : {rt},{gt},{bt} : ({r_try},{g_try},{b_try}) : {distance} ")

						print(f"{times_round} : {i} + {combine_with} : {c} color : {out_color[:3]} : has centroid at {centroid} : covering {len(pt)}")
						if not out_color :
							print("error!! out_color is false!")
						if out_color in palette_colors :
							print(f"{times_round} : {i} : {combine_with} color duped! {out_color[:3]} : already had {len(palette_colors[out_color])}")
							palette_colors[out_color]+=pt
						else :
							palette_colors[out_color]=pt
			elif c in palette_colors:
				print(f"{times_round} : {i} : {c} : keeping.. {len(palette_colors)} and combining with existing! {len(palette_colors[c])} v {len(old_palette[c])}")
				palette_colors[c]+=old_palette[c]
			else: 
				palette_colors[c]=old_palette[c]
				print(f"{times_round} : {i} : {c} : keeping.. {len(palette_colors)}")
		print("\n\nchecking palette for this round ..... . \n\n")
		for i,(c,pt) in enumerate(palette_colors.items(),1):
				print(f"{i} : {c} : {len(pt)}")

	pal_out = [(0,0,0)]
	true_colors = {}
	print(f"saving palette file {config['use_pal_file']}....")
	with open(config['use_pal_file'],'wb+') as OUT:
		OUT.write(bytes([0,0]))
		for i,(c,pt) in enumerate(palette_colors.items(),1):
			(r,g,b,h,s,p) = c
			OUT.write(bytes([(g*16+b),r]))
			pal_out.append((r,g,b))
			for (r,g,b,h,s,p) in pt:
				true_colors[(r,g,b)]=i

if config['pal_mode'] == 256 :
		print(f"converting image to 8bit palette and writing to {sys.argv[2]}")
		with open(sys.argv[2],'wb+') as OUT:
				for i,c in enumerate([c for r in image_rows for c in r if c],1) :
						if not c : continue
						pc = true_colors[c]
						#print(f"{i}:{c}:{pc}  ",end="")
						OUT.write(bytes([pc]))
						if i % width == 0 : print('.',end="")
				print('\n\n')

