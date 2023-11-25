; This is test for rending 1 set of walls ... 
.include "hfs_x16_stub_debug_font.inc"
; here is now 256 byte aligned in memory to include look up stuffs.. 
; $0900 in RAM 

; white/black checkerboard texture - north facing wall 	- $0900
.byte 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1 ; $0900
.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1 ; $0940
.byte 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1 ; $0900
.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1 ; $0940
; red/white checkerboard texture - east facing wall - $0A00
.byte 0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2 ; $0980
.byte 2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0 ; $09C0
.byte 0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2 ; $0980
.byte 2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0 ; $09C0
; white wall - south facing 	- $0B00
.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 ; $0A00
.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 ; $0A40
.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 ; $0A00
.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 ; $0A40
; red wall - north facing 	- $0C00 
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; $0A80
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; $0
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; $0A80
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; $0

;end 256 byte aligned - $0D00

;	global data
DEBUG_BUFFERA: 		 .byte $DE,$AD,$BE,$EF
DEBUG_STUFF: 		 .byte 0,0,0,0
DEBUG_BUFFERB: 		 .byte $DE,$AD,$BE,$EF
default_irq_vector:  .addr 0
VSYNC_counter:       .byte 1
DONE_DONE:           .byte 0
CLICK_BOUNCE:        .byte 0
CLICK_MODE:          .byte 0
CURRENT_COLOR:       .byte 0
; end global data
DEBUG_END_GLOBALS:	 .byte $DE,$AD,$BE,$EF

.include "hfs_x16.inc"

;VRAM addresses - 124K+ reserved for stuffs
							;	0 				1 				2
							;	0123456789ABCDEF0123456789ABCDEF012345
VRAM_DEBUG_FONT = $00000 	;	0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ # 	1bpp / 38*8 = 304 bytes 
VRAM_AFTER_DEBUG_FONT = $00130 ;	304 bytes.. only so useful .. sprites need 32 byte alignment.. 
VRAM_FIRST_USABLE_SPRITE = $00140 ; 320 bytes in ..  
VRAM_START_DEBUG_TEXT = $00180 	;	384 bytes in // 3 lines in 64x32 tile map.. 320x240=30 lines.. 
DEBUG_VSCROLL = $0014 	;	-20 VSCROLL.. debug has 4 lines above and below possibly trashed 
DEBUG_TILE_CONFIG = $10 ; 	64x32 16 color... using the scroll means using 30+3=33 lines 				4K 	$01000

;124K+ reserved for stuffs

config_debug_tiles_layer0:
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
		cmp #38
		bne @debug_debug_things
	rts



custom_irq_handler:
   lda VERA_isr
   and #VSYNC_BIT
   beq @continue ; non-VSYNC IRQ, no tick update
   inc VSYNC_counter
@continue:
   ; continue to default IRQ handler
   jmp (default_irq_vector)
   ; RTI will happen after jump


DEBUG_INIT_PREAMBLE:	 
	.byte $DE,$AD,$BE,$EF
INIT: ; start of program per debug font inc
	jsr config_debug_tiles_layer0
	lda #DISPLAY_SCALE_TWO ; set scale for bitmap mode
  	sta VERA_dc_hscale
  	sta VERA_dc_vscale
	lda #LAYER1SPRITES_ENABLE
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
