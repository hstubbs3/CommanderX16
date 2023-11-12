#! /usr/bin/env python3

from pathlib import Path
import png
import sys

p = Path('.')

colors = {'transparent':0}
with open('gathered_colors.txt','wt',encoding="Latin-1") as OUT:
	def write(bar):
		OUT.write(f"{bar}\n")
		print(bar)

	for file_name in p.glob('**/*.png'):
		image = png.Reader(filename=file_name).read()
		write(f"Processing : {file_name} : {image[0]} x {image[1]}")
		#print(image[3])
		if 'palette' in image[3] :
			write(f"has palette of length {len(image[3]['palette'])} - checking used colors and assuming 0 is transparent")
			pal = image[3]['palette']
			for row in image[2]:
				for byte in row :
					if byte == 0 :
						colors['transparent'] += 1
					else:
						color = pal[byte]
						num_pixels = colors.get(color,0) + 1
						colors[color] = num_pixels
						if num_pixels == 1:
							write(f'adding color : {color}       now num_colors: {len(colors)}')
		else :
			write("no palette found... reading as RGBA8")
			image_rgba8 = png.Reader(filename=file_name).asRGBA8()
			for row in image[2]:
				write(row)
				write('OK now what?')
				sys.exit()
	write(f'\n\n\n Gathered palette length : {len(colors)}\n\n\n')
	colors_list = [(v,k) for (k,v) in colors.items()]
	colors_list.sort(reverse=True)
	for (count,color) in colors_list:
		write(f'{color} : {count}')
	mod = 2
	while len(colors) > 16 :
		write(f'\n\n\nToo many colors! will attempt reducing using mod {mod}\n\n\n')
		reduced_colors = {'transparent':0}
		for (count,color) in colors_list:
			if str(color) == 'transparent':
				reduced_colors[color] = count
			else:
				r,g,b = color
				r_mod = r%mod
				g_mod = g%mod
				b_mod = b%mod
				r_ = r - r_mod
				g_ = g - g_mod
				b_ = b - b_mod
				if r_mod >= mod/2 :
					r_ += 3*mod/4
				if g_mod >= mod/2 :
					g_ += 3*mod/4
				if b_mod >= mod/2 :
					b_ += 3*mod/4				
				r_color = (int(r_),int(g_),int(b_))
				n_count = reduced_colors.get(r_color,0) + count
				reduced_colors[r_color] = n_count
		colors_list = [(v,k) for (k,v) in reduced_colors.items()]
		colors_list.sort(reverse=True)
		for (count,color) in colors_list:
			write(f'{color} : {count}')
		write(f'\n\n\n MOD {mod} resulted in reduced gathered palette length : {len(reduced_colors)}\n\n\n')
		colors = reduced_colors
		mod = mod * 2