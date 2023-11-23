  jmp INIT ;
; now we're at RAM address $0810 - there's 240 bytes from here to next page boundary.. code to load bank files could go here later...
; for now, want to be sure we end at page boundary

HFS_DEBUG_FONT_1BPP: ; is 8x5 font, 16*5=80 bytes hex digits 0-F
.byte %00111100 ; 0    
.byte %01000110
.byte %01010010
.byte %01100010
.byte %00111100
.byte %00000100 ; 1
.byte %00000100
.byte %00000100
.byte %00000100
.byte %00000100
.byte %00111100 ; 2
.byte %01000010
.byte %00001100
.byte %00010000
.byte %01111110
.byte %00111100 ; 3
.byte %01000010
.byte %00001100
.byte %01000010
.byte %00111100
.byte %01000010 ; 4
.byte %01000010
.byte %01111110
.byte %00000010
.byte %00000010
.byte %01111110 ; 6
.byte %01000000
.byte %01111100
.byte %00000010
.byte %00111100
.byte %00111100 ; 7
.byte %00000100
.byte %00001000
.byte %00010000
.byte %00010000
.byte %00111100 ; 8
.byte %01000010
.byte %00111100
.byte %01000010
.byte %00111100
.byte %00111100 ; 9
.byte %01000010
.byte %00111110
.byte %00000010
.byte %00000010
.byte %00011000 ; A
.byte %00100100
.byte %01111110
.byte %01000010
.byte %01000010
.byte %01111000 ; B
.byte %01000100
.byte %01111000
.byte %01000110
.byte %01111000
.byte %00111100 ; C
.byte %01000010
.byte %01000000
.byte %01000010
.byte %00111100
.byte %01111000 ; D
.byte %01000100
.byte %01000010
.byte %01000100
.byte %01111000
.byte %01111110 ; E
.byte %01000000
.byte %01111000
.byte %01000000
.byte %01111110
.byte %01111110 ; F
.byte %01000000
.byte %01111000
.byte %01000000
.byte %01000000 ;   16*5=80+16=96 bytes leaves 160 for align.. 
DECODE_DEBUG_FONT_TO_VRAM:  ;   $0860 .. location to write this should already be set for addr0 ... clobbers y, ZP_PTR
;    ldy #16 

.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000 ; 1
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
; actual calling file would start at page boundary if no functions in this file...
