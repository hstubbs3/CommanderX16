#! /bin/usr/env python3

import png
import sys

"""
output format - binary / ready to load 
plan to put BSP tree at A000 - 8k limit or need to test addresses > BFFF ( 1010 1111 )
so addresses >= 10110000 would need to switch banks or use 24bit addressing?
quick sanity check - 
13x4=52 objects/pickups up to 64x64 but most using half or less of the space - 104k or less 	104k 	  104k
8 frames for weapons up to 64x64 - 32k 															 32k 	  136k
6x64 frames for enemies - up to 64x64 but most are less than 32x48 1.5k/frame - 576k 			576k 	  712k
6x19 64x64 wall textures - 114*4k = 456k 														456k 	1,168k
yikes... 
512k memory? need sounds too? sounds are like 116K 												116K 	1,284k
oof.. so really maybe 400k for graphics total.. probably just reduce to 1/4 size like for snes texturing - 292k OK
so say up to 64k avail for level data ... reserve bank 1 for raw map / area , bank 2 for entity data, bank 3 for bsp
going to doom, build, quake or even descent variants could be interesting...
so final output - binary / ready to load to bank, base address at A000

for bank switching - either assume bank switching and use 24bit address.. or indicate bank switch with bit7 set to 0. 
so 1010 0000 (A0) to 1011 1111 (BF) - same bank. assume both children point to same bank? 
example using left child as next node to visit - 
	lda (zp),y 	;	5 	5 	get address of child
	BMI same_bank ; 2 	7
switch_bank:
	sta ZP_child_b 	; 3 	10
	sta abs,x 		; 4  	14 	stash bank num in stack
	dex 			; 2 	16
	iny 			; 2 	18
	lda (ZP),y 		; 5 	23
	sta ZP_child_h  ; 3 	26
	bra store_left_next_low ; 3 	23
same_bank: 	;	1 	8
	sta ZP_child_h 	; 3 	11
	lda ZP_node_b 	; 3 	14
	sta ZP_child_b 	; 3 	17
store_left_next_low: ; 	17/23
	iny 			; 2 	19/25
	lda (ZP),y 		; 5 	24/30
	sta ZP_child_l 	; 3 	27/33
iny / lda / sta abs,x 
is 6 cycle split.. but if using 24bit addresses, would always be the longer path - always X instead of X +/- 3.. ok

so assuming no bank switching? wolf3D style nodes aren't very big right?

		0 	byte 	flags 	segment | last_segment | enabled | seen | 000 | X/Y
		1 	byte 	split_plane_axis_aligned
NODE 	2 	BYTE 	child_min_min_X
		3 	BYTE	child_min_max_X
		4 	BYTE 	child_min_min_Y
		5 	BYTE 	child_min_max_y
		6 	WORD 	child_min
		8 	BYTE 	child_max_min_X
		9 	BYTE	child_max_max_X
		10 	BYTE 	child_max_min_Y
		11 	BYTE 	child_max_max_y
		12 	WORD 	child_max
14 bytes / node - 18 per page

SEG 	2 	BYTE 	left
		3 	BYTE 	right
		4 	BYTE 	texture - BMI or something - if segment is a door, door type, state
		5 	BYTE 	area
6 bytes per SEG - 42 per page

is 8k = 32 pages per bank.. assuming an even-ish split of nodes to walls.. 
4k/4k => 288 nodes, 672 walls
nodes:wall probably closer to 1:1 ?
8k/20 = 409 ... 	409 walls within 64x64 tiles? 
max walls? concentric would be like	62x4=248 + 60x4=240 ... a full on maze could be a lot actually.. something like 1024 walls..
implying a need for 20k ... going banked would mean 22k is max BSP needed.. 

fun bit - if it _is_ a door, the stuff behind it would be far nodes in the bsp tree already... so draw the door in whatever state
and if it is open at all, the far nodes won't be clipped and so drawn anyway.. 

for portal variant, a door would need children pointers, identify far side, visit. potentially segs could only be single-sided, 
in such case for a door, only far pointer needed.

portal variant needs to clip to portal when going to next portal... 

OK so initially want to output the tree for debugging.. 
take in simple 64x64 text file, convert to segs, place into balanced tree. ez-pz

"""