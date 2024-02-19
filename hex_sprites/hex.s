; 	080D
jmp start ; 	3 bytes 
;	0810 	- 240 bytes available for stuff that doesn't need alignment 
SCRATCH240:
.res 240, $FF

;constants

; RAM Interrupt Vectors
IRQVec            = $0314

; VERA
VERA_addr_low     = $9F20
VERA_addr_high    = $9F21
VERA_addr_bank    = $9F22
VERA_data0        = $9F23
VERA_data1        = $9F24
VERA_ctrl         = $9F25
VERA_ien          = $9F26
VERA_isr          = $9F27
VERA_dc_video     = $9F29 ; DCSEL = 0
;   Current Field | Sprites Enable | Layer1 Enable  |Layer0 Enable 
; NTSC/RGB: 240P  | NTSC: Chroma Disable / RGB: HV Sync Output Mode

VERA_dc_hscale    = $9F2A
VERA_dc_vscale    = $9F2B

VERA_L0_config    = $9F2D
;   7       6     5   4       3       2             1   0
;   Map Height | Map Width | T256C | Bitmap Mode | Color Depth
;   0 - 32                  0 - 16    0 tiled       0   1bpp mono                                            
;   1 - 64                  1 - 256   1 enabled     1   2bpp 4 color
;   2 - 128                                         2   4bpp 16 color
;   3 - 256                                         3   8bpp 256 color
;   bitmap mode - tilebase points to bitmap data, mapbase not used
;   tile width = 0 is 320 pixels / tile width=1 is 640 pixels.. so could do 4bpp x 320?
;   The palette offset (in 'H-Scroll (11:8)') modifies the color indexes of the bitmap in the same way as in the tile modes.

VERA_L0_mapbase   = $9F2E  
VERA_L0_tilebase  = $9F2F ;   Tile Base Address (16:11) | Tile Height 0-8/1-16 | Tile Width 0-8/1-16
VERA_L0_HSCROLL_L = $9F30 ;  H-Scroll (7:0)
VERA_L0_HSCROLL_H = $9F31 ;  - H-Scroll (11:8)
VERA_L0_VSCROLL_L = $9F32 ;  V-Scroll (7:0)
VERA_L0_VSCROLL_H = $9F33 ;  - V-Scroll (11:8)

VERA_L1_config    = $9F34 
VERA_L1_mapbase   = $9F35
VERA_L1_tilebase  = $9F36
VERA_L1_HSCROLL_L = $9F37 ;  H-Scroll (7:0)
VERA_L1_HSCROLL_H = $9F38 ;  - H-Scroll (11:8)
VERA_L1_VSCROLL_L = $9F39 ;  V-Scroll (7:0)
VERA_L1_VSCROLL_H = $9F3A ;  - V-Scroll (11:8)

VSYNC_BIT         = $01

; VRAM Addresses
;   Address range Description
;   $00000 - $1F9BF Video RAM   - 129,424 bytes -> 126K is 129,024 (1F800)
;   $1F9C0 - $1F9FF PSG registers
;   $1FA00 - $1FBFF Palette
;   $1FC00 - $1FFFF Sprite attributes

VRAM_UNRESERVED   = $1A000      ; 
; sprite starts must be 32byte aligned...
; only can go to 126K ... 
VRAM_palette      = $1FA00      ;  
VRAM_sprite_attributes = $1FC00

SPRITES_ONLY_VGA = $41



; Kernal
CHROUT            = $FFD2
GETIN             = $FFE4
CINT              = $FF81


; PETSCII Codes
WHITE             = $05
RETURN            = $0D
SPACE             = $20
ZERO_CHAR         = $30
SIX_CHAR          = $36
NINE_CHAR         = $39
C_CHAR            = $43
I_CHAR            = $49
O_CHAR            = $4F
T_CHAR            = $54
CLR               = $93

; 	$0800-$9EFF	BASIC program/variables; available to the user
WORLD_DATA = $8000 	;	so is %100 [Y 5 bits ] : [ab] 0 [X - 6 bits

; global data
default_irq_vector:  .addr 0
VSYNC_counter:       .byte 1

; zero page layout $0022-$007F is available to user
ZP_PTR = $22 

custom_irq_handler:
   lda VERA_isr
   and #VSYNC_BIT
   beq @continue ; non-VSYNC IRQ, no tick update
   inc VSYNC_counter
@continue:
   ; continue to default IRQ handler
   jmp (default_irq_vector)
   ; RTI will happen after jump

start:
  ; start of program - init globals
  lda IRQVec
  sta default_irq_vector
  lda IRQVec+1
  sta default_irq_vector+1
  stz VERA_dc_video   ; disable display
  lda #32 ; set scale for bitmap mode - going for 160x120 mode
  sta VERA_dc_hscale
  sta VERA_dc_vscale
  ; for now no L0 or L1 

  ; let's stick that test sprite data into VRAM at zero for now.. 
  stz VERA_ctrl
  stz VERA_addr_low
  stz VERA_addr_high
  lda #$10
  sta VERA_addr_bank
  ; is 512 bytes at test_cell_sprite label
  lda #<test_cell_sprite
  sta ZP_PTR
  lda #>test_cell_sprite
  sta ZP_PTR+1
  ldy #0 
  ldx #2
  @copy_to_vram_loop:
  	@copy_to_vram_loop_inner:
  	  lda (ZP_PTR),y
  	  sta VERA_data0
  	  iny 
  	  BNE @copy_to_vram_loop_inner
  	inc ZP_PTR+1
  	dex 
  	BNE @copy_to_vram_loop

  ; set this to sprite 0 for first test.. 
  ; 	0	Address (12:5)
  ; 	1	Mode	-	Address (16:13)
  ; 	2	X (7:0)
  ; 	3	-	X (9:8)
  ; 	4	Y (7:0)
  ; 	5	-	Y (9:8)
  ; 	6	Collision mask	Z-depth	V-flip	H-flip
  ; 	7	Sprite height	Sprite width	Palette offset
  stz VERA_addr_low
  lda #>VRAM_sprite_attributes
  sta VERA_addr_high
  lda #$11
  sta VERA_addr_bank
  ldy #128
  LDA #112
  stA ZP_PTR 	;	to keep track of height to draw at...
  
  @row_loop:
    ldx #16
    @e_loop:
      stz VERA_data0 	; 	address 12:5
      STZ VERA_data0 	; 	4bit color address 16:13
      STX VERA_data0 	;	X 
      STZ VERA_data0 	;	 X 
      LDA ZP_PTR
      STA VERA_data0 	;	y
      STZ VERA_data0 	; 	y
      LDA #$0C 
      STA VERA_data0 	; 	3 z depth no flip
      LDA #$D0 			; 	16x64 no palette offset
      STA VERA_data0
      dey 
      beq @end
      TXA
	  CLC
      ADC #16
      TAX
      CPX #144
      BNE @e_loop
    SEC
    LDA ZP_PTR
    SBC #6
    STA ZP_PTR
    ldx #8
    @o_loop:
      stz VERA_data0 	; 	address 12:5
      STZ VERA_data0 	; 	4bit color address 16:13
      STX VERA_data0 	;	X 
      STZ VERA_data0 	;	 X 
      LDA ZP_PTR
      STA VERA_data0 	;	y
      STZ VERA_data0 	; 	y
      LDA #$0C 
      STA VERA_data0 	; 	3 z depth no flip
      LDA #$D0 			; 	16x64 no palette offset
      STA VERA_data0
      dey 
      beq @end
      TXA
      CLC
      ADC #16
      TAX
      CPX #152
      BNE @o_loop
    LDA ZP_PTR
    SEC
    SBC #6
    STA ZP_PTR
    bra @row_loop

  @end:

  ; enable display 
  stz VERA_ctrl
  lda #SPRITES_ONLY_VGA
  sta VERA_dc_video

  ; overwrite RAM IRQ vector with custom handler address
  sei ; disable IRQ while vector is changing
  lda #<custom_irq_handler
  sta IRQVec
  lda #>custom_irq_handler
  sta IRQVec+1
  lda #VSYNC_BIT ; make VERA only generate VSYNC IRQs
  sta VERA_ien
  cli ; enable IRQ now that vector is properly set

  ; main loop here... 
@FRAME_CHECK:
   wai
   ldy VSYNC_counter
   beq @FRAME_CHECK
   stz VSYNC_counter

   ; poll keyboard for input 
   jsr GETIN
   cmp #0
   bne @cleanup_and_exit

   ; update screen
   jsr draw_world
   bra @FRAME_CHECK

@cleanup_and_exit:
   ; restore default IRQ vector
   sei
   lda default_irq_vector
   sta IRQVec
   lda default_irq_vector+1
   sta IRQVec+1
   cli   
   jsr CINT
   rts

draw_world:
  rts 

test_cell_sprite: 	;	is 16x64x16 bit = 512 bytes
; 	   01   23   45   67   89   AB   CD   EF
.byte $00, $00, $66, $66, $66, $66, $00, $00 	; 	0
.byte $00, $66, $EE, $EE, $EE, $EE, $66, $00  	;	1
.byte $06, $EE, $EE, $EE, $EE, $EE, $EE, $60 	;	2
.byte $6E, $EE, $EE, $EE, $EE, $EE, $EE, $E6 	;	3
.byte $6E, $EE, $EE, $EE, $EE, $EE, $EE, $E6 	;	4
.byte $66, $EE, $EE, $EE, $EE, $EE, $E6, $66 	;	5
.byte $66, $66, $EE, $EE, $EE, $EE, $66, $66 	;	6
.byte $EE, $66, $66, $66, $66, $66, $66, $EE 	;	7

.byte $EE, $EE, $66, $66, $66, $66, $EE, $EE 	; 	8
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	12
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	16
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	20
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	24
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	28
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	32
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	36
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	40
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	44
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	48
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	52
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	56
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	60
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63
