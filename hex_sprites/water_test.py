#! /bin/usr/env python3

world = [ [0 for _ in range(23)] for _ in range(13)]
old_world = [ [0 for _ in range(23)] for _ in range(13)]

#world[0][0] = 63
#world[7][12] = 127
#world[6][0] = 127
#world[7][11] = 63
#world[7][13] = 63
world[6][12] = 63
#world[6][13] = 63
#world[8][12] = 63
#world[8][13] = 63


for i,row in enumerate(world):
		if i % 2 : print('   ',end="")
		print(''.join([str(int(n)).rjust(6) for n in row]))

steps = 32
go = True
while go and steps:
	go = False 
	steps -=1
	print(f"steps left : {steps}")
	for y in range(13):
		row_modulus = y % 2
		for x in range(23):
			old_self = world[y][x]
			delta = 2*old_self
			# upleft / up right neighbors
			if y :
				delta += world[y-1][x]
				if row_modulus: #if odd row, upleft is same X and upright is X+1 ...
					if x < 22 : delta += world[y-1][x+1]
					else : delta += old_self
				else : # if even row, upleft is is x-1 ..
					if x: 	delta += world[y-1][x-1]
					else : 	delta += old_self
			else :
				delta += 2*old_self

			if x :
				delta += world[y][x-1]
				if x < 22: delta += world[y][x+1]
				else : delta += old_self
			else : 
				delta += world[y][x] + world[y][x+1]

			if y < 12:
				delta += world[y+1][x]
				if row_modulus: # odd, downright is x+1 ... 
					if x <22: delta += world[y+1][x+1]
					else : delta += old_self
				else: # even, downleft is x-1
					if x : delta += world[y+1][x-1]
					else : delta += old_self
			else :
				delta += 2*old_self

			old_world[y][x] = delta/8 - old_world[y][x]
			#old_world[y][x] = max(old_world[y][x],-old_world[y][x])

			if old_world[y][x] : 
				go = True

			
	t = old_world
	old_world = world
	world = t

	for i,row in enumerate(world):
		if i % 2 : print('   ',end="")
		print(''.join([str(int(n)).rjust(6) for n in row]))
