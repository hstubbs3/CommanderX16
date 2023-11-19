#! /bin/usr/env python3

import png
import sys

image = png.Reader(sys.argv[1]).read()
width = image[0]
height = image[1]
print(f"read in {sys.argv[1]} , {width} x {height}")
tile_width = 8
tile_height = 8
with open(sys.argv[2],'wt',encoding="Latin-1") as OUT:
	try:
		tile_width = int(sys.argv[3])
		print(f'tile width value set to {tile_width}')
	except:
		tile_width = 8
	try:
		tile_height = int(sys.argv[4])
		print(f'tile height value set to {tile_height}')
	except:
		tile_height = 8
	index = 0
	rows = [ r for r in image[2]]
	tile_row_index = 0 
	current_row = 0
	while current_row < height:
		tile_col_index = 0
		current_col = 0
		while current_col < width:
			OUT.write("  .byte ")
			tile_data = []
			for row in range(current_row,current_row+tile_height):
				if row >= height :
					for col in range(tile_width):
						tile_data.append(0)
				else:
					for col in range(current_col,current_col+tile_width):
						if col >= width:
							tile_data.append(0)
						else:
							#print(f"t_row: {tile_row_index} t_col: {tile_col_index} x: {col} y: {row} value: {rows[row][col]}")
							tile_data.append(rows[row][col])
			OUT.write(', '.join([str(pal_index) for pal_index in tile_data]))
			OUT.write(f" ; {tile_col_index},{tile_row_index}: tile {index}\n")
			current_col += tile_width
			tile_col_index += 1
			index += 1
		current_row += tile_height
		tile_row_index += 1