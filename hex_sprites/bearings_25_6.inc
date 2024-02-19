; lookup tables for 25.6* tilt to draw screen..

;	world is represented in memory like this - 
;   0 1 2 3 4 5 6 7 8 ...
;  0 1 2 3 4 5 6 7 8 ... 
; 0 1 2 3 4 5 6 7 8 ...

;  0 degrees -	bearing 0 - facing north -
; upper left of screen is Col -9, row -18
; going across screen - +1,0 / 16,0 px .. 
; next row - COL 0 / -1 , row +1  	/	-8 / +8px , 10px
; 20 rows of 10/11 - 210 cells 

; 15 degrees - north north west
; upper left of screen = -15,-15
; across screen - +1,0 / +15,+3 - not same Z! meh.. crap.. otay...
; next row - +0,+1 / -1,+1  - 	+3,+7px 
; 18 rows of 11 = 198 cells 

; 30 degrees counter clockwise -  north west
; upper left of screen is -17,-14 
; across screen - +1,-1 / 28,0 px
; next row - +1,+1 / 14,7 px
; 32 rows of 6/5 - 176 cells