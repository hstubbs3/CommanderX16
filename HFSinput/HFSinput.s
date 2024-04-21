HFS_KEYMAP:
.res 256,0

HFS_KEYSTATE:
.res 256,0



GETIN             = $FFE4

HFS_INIT_KEYMAP:
	LDX #0
 :  TXA 
 	STA HFS_KEYMAP,X 
 	INX 
 	BNE :-
 	rts

HFS_DEC_KEYS:
    LDX #0
    LDA #0
 : STA HFS_KEYSTATE,X
 	INX 
 	BNE :-
   rts

 :  TAY
   LDX HFS_KEYMAP,Y
    LDA #255
   STA HFS_KEYSTATE,X 
HFS_GET_KEY:
 :  JSR GETIN
    CMP #0
	BNE :--
    rts