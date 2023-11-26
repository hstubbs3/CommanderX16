; This is test for rending 1 set of walls ... 
.include "hfs_x16_stub_debug_font.inc"
; here is now 256 byte aligned in memory to include look up stuffs.. 
; $0900 in RAM 

VIEWPORT_OFFSETS_L: ;	$0900
;		0 	1 	2 	3 	4 	5 	6 	7 	8 	9 	10 	11 	12 	13 	14 	15 	16 	17 	18 	19 	20 	21 	22 	23 	24 	25 	26 	27 	28 	29 	30 	31
.byte   8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200 ;  32 -1F	
.byte   8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200 ;  64 -3F
.byte   8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200 ;  96 -5F
.byte   8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200 ; 128 -7F
.byte   8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200 ; 160 -9F
.byte   8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  8, 72,136,200,  0,  0,  0,  0,  0,  0,  0,  0 ; 192 -BF
TEST_TEXTURE_2: 	; white wall - south facing 	- $09C0
.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 ; $09C0
VIEWPORT_OFFSETS_H: ; $0A00
.byte   5,  6,  7,  8, 10, 11, 12, 13, 15, 16, 17, 18, 20, 21, 22, 23, 25, 26, 27, 28, 30, 31, 32, 33, 35, 36, 37, 38, 40, 41, 42, 43
.byte  45, 46, 47, 48, 50, 51, 52, 53, 55, 56, 57, 58, 60, 61, 62, 63, 65, 66, 67, 68, 70, 71, 72, 73, 75, 76, 77, 78, 80, 81, 82, 83
.byte  85, 86, 87, 88, 90, 91, 92, 93, 95, 96, 97, 98,100,101,102,103,105,106,107,108,110,111,112,113,115,116,117,118,120,121,122,123
.byte 125,126,127,128,130,131,132,133,135,136,137,138,140,141,142,143,145,146,147,148,150,151,152,153,155,156,157,158,160,161,162,163
.byte 165,166,167,168,170,171,172,173,175,176,177,178,180,181,182,183,185,186,187,188,190,191,192,193,195,196,197,198,200,201,202,203
.byte 205,206,207,208,210,211,212,213,215,216,217,218,220,221,222,223,225,226,227,228,230,231,232,233,  0,  0,  0,  0,  0,  0,  0,  0
TEST_TEXTURE_3: ; red wall - north facing 	- $0AC0
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; $0A40
TEST_TEXTURE_0: ; white/black checkerboard texture - north facing wall 	- $0B00
.byte 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1 ; $0900
.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1 ; $0940
TEST_TEXTURE_1: ; red/white checkerboard texture - east facing wall - $0B80
.byte 0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2 ; $0980
.byte 2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0 ; $09C0

; 256 byte alignment not guaranteed after this point!
HUD_ADD_TILES: ; $0C00
.byte %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000011,%00000011 ; upleft corner - 			#40 $28 	$00
.byte %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%11111111,%11111111 ; mid 						#41 #29 	$18
.byte %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%11000000,%11000000 ; upright corner 				#42 $2A 	$20
.byte %00000011,%00000011,%00000011,%00000011,%00000011,%00000011,%00000011,%00000011 ; left side viewport 			#43 $2B 	$28
.byte %11000000,%11000000,%11000000,%11000000,%11000000,%11000000,%11000000,%11000000 ; right side viewport 		#44 $2C 	$30
.byte %00000011,%00000011,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; downleft corner viewport 	#44 $2D 	$38
.byte %11111111,%11111111,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; low mid viewport 	 		#46 $2E 	$40
.byte %11000000,%11000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; downright side viewport 	#47 $2F 	$48
.byte %11111111,%10000000,%10000000,%10000000,%10000000,%10000000,%10000000,%10000000 ; top/left corner HUD 		#48 $30 	$50
.byte %11111111,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; top/mid HUD 				#49 $31 	$58
.byte %11111111,%00000001,%00000001,%00000001,%00000001,%00000001,%00000001,%00000001 ; top/right corner HUD  		#50 $32 	$60
.byte %10000000,%10000000,%10000000,%10000000,%10000000,%10000000,%10000000,%10000000 ; left HUD 					#51 $33 	$68
.byte %00000001,%00000001,%00000001,%00000001,%00000001,%00000001,%00000001,%00000001 ; right HUD 					#52 $34		$70
.byte %10000000,%10000000,%10000000,%10000000,%10000000,%10000000,%10000000,%11111111 ; bottom/left corner HUD 		#53 $35 	$78
.byte %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%11111111; bottom/mid HUD 				#54 $36 	$80
.byte %00000001,%00000001,%00000001,%00000001,%00000001,%00000001,%00000001,%11111111 ; bottom/right corner HUD  	#55 $37 	$88

;	af
HUD_MAP_RUNS: ; for now is just pattern 1,38,25 each line... spelling  it out in case want to make adjusts.. flip it cuz reasons... 25,38,1
; 	   0   1   2   3   4   5   6   7   8   9   10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29, 30, 31, 32 
.byte $FF
.byte  25, 38,  1 ; 30
.byte  25,  1, 36,  1, 25,  1,  1, 36,  1, 25,  1,  1, 36,  1, 25,  1,  1, 36,  1, 25,  1,  1, 36,  1,  1, 25, 38,  1 ; 27 bytes / bottom 6 lines   
; 	29 b 	bottom hud b   28 					27 					26 					25 (top of HUD) 24 (space inbeween)
.byte  25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1 ; 27 54 
; 		23 			22 			21 			20 			19 			18 			17 			16 			15 		
.byte  25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1 ; 27 81 
; 		14 			13 			12 			11 			10 			9 			8 			7 			6 		
.byte  25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1, 25, 38,  1 ; 18 	72 bytes ...  99 +3 = 102 got 105.. hmmm
;		5 			4 			3 			2 			1 			0
HUD_MAP_CHARS:
.byte $FF
.byte  40, 39, 38 	;	3
.byte  42, 50, 49, 48, 41, 42, 47, 36, 46, 41, 42, 47, 36, 46, 41, 42, 47, 36, 46, 41, 42, 45, 44, 43, 41, 40, 39, 38 ; 29-24 	;	27 	30
.byte  42, 36, 41, 42, 36, 41, 42, 36, 41, 42, 36, 41, 42, 36, 41, 42, 36, 41, 42, 36, 41, 42, 36, 41, 42, 36, 41 ; 23-15 	; 	27 	57
.byte  42, 36, 41, 42, 36, 41, 42, 36, 41, 42, 36, 41, 42, 36, 41, 42, 36, 41, 42, 36, 41, 42, 36, 41, 42, 36, 41 ; 14-6 	; 	27 	84
.byte  42, 36, 41, 42, 36, 41, 42, 36, 41, 42, 36, 41, 42, 36, 41, 40, 39, 38 ; 18 +84 = 102
HUD_MAP_COLORS:
.byte $FF
.byte $89,$89,$89
.byte $89,$21,$21,$21,$89,$89,$21,$21,$21,$89,$89,$21,$21,$21,$89,$89,$21,$21,$21,$89,$89,$21,$21,$21,$89,$89,$89,$89 ; 29-24
.byte $89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$0B,$89 ; 23-15
.byte $89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$0B,$89 ; 14-6
.byte $89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$0B,$89,$89,$89,$89 ; 

TEXTURE_WIDTH_MASKS:
.byte 	255 ; 	texture 0 is null
.byte 	1 	;	texture 0 is 2 wide .. 
.byte 	1 	;	texture 1 is 2 wide ..
.byte 	0 	;	texture 2 is 1 wide
.byte 	0 	;	texture 3 is 1 wide
TEXTURE_ADDRESS_HIGH:
.byte 	255 ; 	texture 0 is null
.byte (<TEST_TEXTURE_0)
.byte (<TEST_TEXTURE_1)
.byte (<TEST_TEXTURE_2)
.byte (<TEST_TEXTURE_3)
TEXTURE_ADDRESS_LOW:
.byte 	255 ; 	texture 0 is null
.byte (>TEST_TEXTURE_0)
.byte (>TEST_TEXTURE_1)
.byte (>TEST_TEXTURE_2)
.byte (>TEST_TEXTURE_3)


;	global data
DEBUG_BUFFERA: 		 .byte $DE,$AD,$BE,$EF
DEBUG_STUFF: 		 .byte 0,0,0,0
DEBUG_BUFFERB: 		 .byte $DE,$AD,$BE,$EF
default_irq_vector:  .addr 0
VSYNC_counter:       .byte 1
current_buffer_inc1: .byte VRAM_INCREMENT_1
current_buffer_inc320: .byte VRAM_INCREMENT_320
swap_buffer: 		 .byte 0
; end global data
DEBUG_END_GLOBALS:	 .byte $DE,$AD,$BE,$EF

.include "hfs_x16.inc"

;VRAM addresses - 124K+ reserved for stuffs
							;	0 				1 				2
							;	0123456789ABCDEF0123456789ABCDEF012345
VRAM_DEBUG_FONT = $00000 	;	0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ # 	1bpp / 38*8 = 304 bytes 
VRAM_AFTER_DEBUG_FONT = $00140 ;	304 bytes.. only so useful .. sprites need 32 byte alignment.. 
VRAM_AFTER_ADDED_HUD_TILES = $001A8 ; 424 bytes - needs to stay <= $00208 ( 520 ) - so 12 more tiles could be added before more squeeze..?
VRAM_FIRST_USABLE_SPRITE = $00140 ; 320 bytes in ..  
VRAM_START_DEBUG_TEXT = $00180 	;	384 bytes in // 3 lines in 64x32 tile map.. 320x240=30 lines.. 
DEBUG_VSCROLL = $0014 	;	-20 VSCROLL.. debug has 4 lines above and below possibly trashed 
DEBUG_TILE_CONFIG = $50 ; 	64x64 16 color... using the scroll means using 30+3=33 lines 				4K 	$01000

VRAM_VIEWPORT_A = $00000 ; 	2K align 	need 188 lines * 320 bytes = 60,160 58.75K / EB00  			58.75k 			EB00
VRAM_VIEWPORT_A_START_offset = $0508 ; line 4, x=8  		
VRAM_LAYER1_TILE_MAP 	= $0EA00  ;	needs to be 512B aligned, 64x32, could waste up to 2 lines 128B per line 	4K+128 	62.75K 	$0FB00
VRAM_LAYER1_MAP_VIS = $0EB00 ;
; 62.75 to 64K-1 - $0FA00 to $0FFFF
VRAM_VIEWPORT_B = $10000 ; 2K aligned starting at 6K runs to $1EB00 								 	

;124K+ reserved for stuffs

config_debug_tiles_layer1:
	stz VERA_ctrl
	lda #DEBUG_TILE_CONFIG
	sta VERA_L1_config
	stz	VERA_L1_mapbase ;	tilemap starts at 0 - top 3 lines trashed with debug font data
	stz VERA_L1_tilebase ;  tiles start at 0 
	stz VERA_L1_hscroll_l
	stz VERA_L1_hscroll_h
	lda #<DEBUG_VSCROLL
	sta VERA_L1_vscroll_l
	lda #>DEBUG_VSCROLL
	sta VERA_L1_vscroll_h
    lda #<VRAM_START_DEBUG_TEXT
    sta VERA_addr_low
    lda #>VRAM_START_DEBUG_TEXT
    sta VERA_addr_high
    lda #(VRAM_INCREMENT_1 | ^VRAM_START_DEBUG_TEXT)
    sta VERA_addr_bank
    ; set all tiles to blank tile ... dark grey on transparent
    ;	blank tile is just after Z - is 37 #$25 ... hmmm
    ; 30*64 = 1,920 	7*256 
    ldx #30
    @do_set_color_loop:
	    ldy #64 
      @do_set_color_inner_loop:
      	  lda #$24
      	  sta VERA_data0
          lda #$0C
    	  sta VERA_data0
    	  dey 
    	  bne @do_set_color_inner_loop
      dex 
      bne @do_set_color_loop
    ;
	lda #<VRAM_START_DEBUG_TEXT
	sta VERA_addr_low
	lda #>VRAM_START_DEBUG_TEXT
	sta VERA_addr_high
    lda #(VRAM_INCREMENT_2 | ^VRAM_START_DEBUG_TEXT)
    sta VERA_addr_bank
	lda #0
	@debug_debug_things:
		sta VERA_data0
		inc a 
		cmp #40
		bne @debug_debug_things
	rts

config_viewport_with_hud_display:
	stz VERA_ctrl
	lda #20
	;sta VERA_L1_vscroll_l
	lda #$FF
	;sta VERA_L1_vscroll_h
	lda #(VRAM_LAYER1_TILE_MAP >> 9)
	sta VERA_L1_mapbase
	;	copy the additional tiles
	lda #<VRAM_AFTER_DEBUG_FONT
	sta VERA_addr_low
	lda #>VRAM_AFTER_DEBUG_FONT
	sta VERA_addr_high
	lda #(VRAM_INCREMENT_1 | ^VRAM_AFTER_DEBUG_FONT)
	sta VERA_addr_bank
	lda #0 
	@copy_chars_loop:
		tay 
		lda HUD_ADD_TILES,y 
		sta VERA_data0
		lda HUD_ADD_TILES+1,y 
		sta VERA_data0
		lda HUD_ADD_TILES+2,y 
		sta VERA_data0
		lda HUD_ADD_TILES+3,y 
		sta VERA_data0
		lda HUD_ADD_TILES+4,y 
		sta VERA_data0
		lda HUD_ADD_TILES+5,y 
		sta VERA_data0
		lda HUD_ADD_TILES+6,y 
		sta VERA_data0
		lda HUD_ADD_TILES+7,y 
		sta VERA_data0
		tya 
		clc
		adc #8
		cmp #104
		BNE @copy_chars_loop
	; 	create the map
	stz VERA_addr_low
	LDA #>VRAM_LAYER1_MAP_VIS
	sta VERA_addr_high
	lda #(VRAM_INCREMENT_1 | ^VRAM_LAYER1_MAP_VIS)
	ldy #103
	sty DEBUG_STUFF
	@do_runs_loop:
	    sty ZP_PTR 				;	3 	3
		lda HUD_MAP_RUNS,y  	; 	4* 	7
		sta ZP_PTR+1 			; 	3 	10
	    ldx HUD_MAP_COLORS,y 	; 	4* 	18
		lda HUD_MAP_CHARS,y 	; 	4* 	14
	    ldy ZP_PTR+1 			; 	3 	21 	possibly 24 a run.. 
	  @do_run_loop:
	  	  sta VERA_data0		;	4
	  	  stx VERA_data0 		; 	4 	8
	  	  dey 					;	2 	10
	  	  bne @do_run_loop 		;	3 	13 per go round.. 24+ 13*byte to write.. 3840B * 13 = 49,920 ... 
	  	ldy ZP_PTR ; 	3 	24 / 27
	  	dey 	;	2 		26 / 29
	  	bne @do_runs_loop 	; 3 	29/32 	
	stz VERA_L0_tilebase
	lda #MODE_BITMAP_256BPP
	sta VERA_L0_config
	rts


custom_irq_handler:
   lda VERA_isr
   and #VSYNC_BIT
   beq @continue ; non-VSYNC IRQ, no tick update
   inc VSYNC_counter
   BIT @swap_buffer
   BPL @continue
  @swap_buffer:
  	lda current_buffer_inc1 ;
  	eor #1
  	sta current_buffer_inc1 ;
  	lda current_buffer_inc320 ;
  	eor #1
  	sta current_buffer_inc320 ;
  	and #1
  	clc
  	ror ; bit 0 to C 
  	ror ; C to bit 7 ... ACC is now either $00 or $80 
  	sta VERA_L1_tilebase ;	set location of buffer
@continue:
   ; continue to default IRQ handler
   jmp (default_irq_vector)
   ; RTI will happen after jump


DEBUG_INIT_PREAMBLE:	 
	.byte $DE,$AD,$BE,$EF
INIT: ; start of program per debug font inc
	jsr config_debug_tiles_layer1
	lda #DISPLAY_SCALE_TWO ; set scale for bitmap mode
  	sta VERA_dc_hscale
  	sta VERA_dc_vscale
	lda #LAYER1SPRITES_ENABLE
	sta VERA_dc_video

	wait_keypress
	jsr config_viewport_with_hud_display
	lda #LAYER01SPRITES_ENABLE
	sta VERA_dc_video
	wait_keypress
	jsr CINT
	rts

	lda #1
	jsr MOUSE_CONFIG

    ; overwrite RAM IRQ vector with custom handler address
    sei ; disable IRQ while vector is changing
    lda #<custom_irq_handler
    sta IRQVec
    lda #>custom_irq_handler
    sta IRQVec+1
    lda #VSYNC_BIT ; make VERA only generate VSYNC IRQs
    sta VERA_ien
    cli ; enable IRQ now that vector is properly set
    stz VSYNC_counter

ENDLESS_LOOP:
   wai 
   lda VSYNC_counter
   beq ENDLESS_LOOP
   stz VSYNC_counter
   jsr GETIN
   beq ENDLESS_LOOP

do_cleanup:
   ; restore default IRQ vector
   sei
   lda default_irq_vector
   sta IRQVec
   lda default_irq_vector+1
   sta IRQVec+1
   cli   
   jsr CINT
   rts
