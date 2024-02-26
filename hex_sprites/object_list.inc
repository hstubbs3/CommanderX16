; intended to be used with the object_list in banked memory ..
; switch bank before running... 

HFS_OBJECT_LIST_PTR = $A000
HFS_OBJECT_LIST_PTR_HIGH = HFS_OBJECT_LIST_PTR+256
HFS_NEXT_AVAILABLE_OBJECT = HFS_OBJECT_LIST_PTR+512 ; initially list is empty.. 
HFS_OBJECT_LIST_FIRST_AVAILABLE_OBJECT = HFS_OBJECT_LIST_PTR+514 	;	first available location..

HFS_OBJECT_LIST_INIT:
	STZ $7E
    LDA #<HFS_OBJECT_LIST_PTR_HIGH
    STA $7F
    LDA #0
    LDY #0
  : STA ($7E),y
  	INY
    BNE :-
    INC $7F 	;	next available PTR
    LDA #2
    STA HFS_NEXT_AVAILABLE_OBJECT
    LDA #>HFS_OBJECT_LIST_FIRST_AVAILABLE_OBJECT
    STA HFS_NEXT_AVAILABLE_OBJECT+1
    RTS

; set a pointer in Z to first element in list in X .. 
; uses Z and Z+1, clobbers A .. if list is empty jumps to LABEL
.macro 	HFS_OBJECT_LIST_GET_LIST 	lowbyte LABEL
  LDA HFS_OBJECT_LIST_PTR_HIGH,X 
  BEQ LABEL 
  STA lowbyte+1
  LDA HFS_OBJECT_LIST_PTR,X 
  STA lowbyte
.endmacro


; num of available sprites should be set in $7F.. uses Z page going down from there to 
; uses last num_sprites... 
HFS_OBJECT_LIST_DRAW_SPRITES:
	LDA #128
	SEC 
	SBC $7F
	BMI @end 	;	went neg.. oops
	BEQ @end 	;	was zero.. oops
	STZ $9F25  	; 	probably best to be sure vera control set ok
	STZ $7E
	ASL 
	ROL $7E
	ASL 
	ROL $7E
	ASL 
	ROL $7E
	STA $9F20 	;	addr low
	LDA $7E
	ORA #$FC 
	STA $9F21 	; 	addr high
	LDA #$11 	
	STA $9F22  	;	addr high
    LDX #0
    BRA @do_list
  @end:
      rts
  @next_list:
    LDX $7E
  @next_list2:
    INX
    BEQ @end 
  @do_list:
	  LDY HFS_OBJECT_LIST_PTR_HIGH,X 
	  BEQ @next_list2
	  STY $7D
	  LDA HFS_OBJECT_LIST_PTR,X 
	  STX $7E
	@do_sprite_objects:
	    STA $7C
	    LDY #0
	    LDA ($7C),y 	;	address 12:5
	    STA $9F23	
	    INY 
	    LDA ($7C),y 	;	mode | address 16:13
	    STA $9F23	
	    INY 
	    LDA ($7C),y 	;	X 7:0
	    STA $9F23	
	    CMP #160
	    LDA #0
	    BCC :+
	    LDA #3
	  : STA $9F23 		;	X 9:8
	    INY 
	    LDA ($7C),y 	;	Y 7:0
	    STA $9F23	
	    CMP #120
	    LDA #0
	    BCC :+
	    LDA #3
	  : STA $9F23 		;	Y 9:8
	    INY 
	    LDA ($7C),y 	;	collision / Z / V flip / H flip
	    STA $9F23	
	    INY 
	    LDA ($7C),y 	;	Height / Width / palette offset
	    STA $9F23	
	    INY 
	    INY 			;	skip height to draw since is sprite
	    DEC $7F 		;	decrement sprite counter
	    BEQ @done_sprites
	    LDA ($7C),y 	;	next_H
	    BEQ @next_list
	    TAX
	    LDA ($7C),y 	;	next_L
	    STX $7D
	    BRA @do_sprite_objects
	@done_sprites:
		LDX $7E
	    LDA ($7C),y 	;	next_H
	    STA HFS_OBJECT_LIST_PTR_HIGH,X 	;	drawing screen back to front will stop at next object.. 
	    INY ($7C),y 	;	next_L
	    STA HFS_OBJECT_LIST_PTR,X
	    CPX #0
	    BEQ :++
	    DEX 
	    BEQ :++
	  : STZ HFS_OBJECT_LIST_PTR_HIGH,X
	    DEX 
	    BNE :-
	  : rts 

; draws objects to buffer from back to front.. 
HFS_OBJECT_LIST_DRAW_TO_BUFFER: 
    rts
