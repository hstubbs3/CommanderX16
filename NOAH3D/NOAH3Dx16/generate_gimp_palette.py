#! /bin/usr/env python3

import png

pal_image = png.Reader("cx16palette.png").asRGBA8()
print(pal_image)
print(hex(0))
with open('gimp_cx16pal.txt','wt',encoding="Latin-1") as OUT:
	OUT.write("GIMP Palette\nName: CommanderX16 palette\nColumns: 16\n#\n")
	index = 0
	for row in pal_image[2]:
		for (r,g,b,a) in zip(row[::4],row[1::4],row[2::4],row[3::4]):
			#OUT.write(f"#{hex(r).ljust(4,'0')[-2:]}{hex(g).ljust(4,'0')[-2:]}{hex(b).ljust(4,'0')[-2:]}\n")
			OUT.write(f"{r} {g} {b}   Index {index}\n")
			index += 1