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
WORLD_DATA = $6000 	;	so is %100 [Y 5 bits ] : [ab] 0 [X - 6 bits
SCREEN_buffer = $8000

; global data
default_irq_vector:  .addr 0
VSYNC_counter:       .byte 1
camera_facing: 		 .byte 1

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


  bra   @end ; skip this test stuff

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
   beq @FRAME_CHECK
   cmp #SPACE
   bne @cleanup_and_exit
   ; switch to next bearing
   LDA camera_facing
   INC A
   CMP #3
   BCC @draw
   LDA #0
   @draw:
   STA camera_facing

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

; all the objects need to get into a structure to be drawn at each screen Y..
; need object type, screenX .. store back to front .. track # objects to be drawn ?
; there's 120 lines on screen.. up to say 32 objects per line would need about 8K RAM for the list.. each line needs 64 bytes

draw_world:
  ; clear first entry for each line... 
  STZ ZP_PTR 
  LDA #>SCREEN_buffer
  STA ZP_PTR+1
  LDX #30
  LDA #0
  @loop:
    TAY
    STA (ZP_PTR),y 	;	set first buffer entry for line mod 4 = 0 
    LDY #64 		; 	move buffer pointer to next line
    STA (ZP_PTR),y 	;	set first buffer entry for line mode 4 =1 
    LDY #128 		; 	move buffer pointer to next line
    STA (ZP_PTR),y 	;	set first buffer entry for line mode 4 =2
    LDY #192 		; 	move buffer pointer to next line
    STA (ZP_PTR),y 	;	set first buffer entry for line mode 4 =3 
    INC ZP_PTR+1 	;	next page plz
    DEX  
    BNE @loop
  ; fetch bearing data .. 
  LDA camera_facing
  ASL 
  TAX
  jmp (@T_BEARINGS,X)
@T_BEARINGS:
	.addr BEARING_ZERO
	.addr BEARING_ONE
	.addr BEARING_TWO

BEARING_ZERO:
    LDA #112 ; starting at screen Y=112 
  @E_loop:
    STA ZP_PTR+2 ; stash the Y we're working at... 
      STZ ZP_PTR   ; zero this out to use pointer .. 
      LSR 
      ROR ZP_PTR ; 
      LSR
      ROR ZP_PTR ; because is 64 avail for each 
      ORA #>SCREEN_buffer ; making pointer woot! 
      STA ZP_PTR+1 ; ZP_PTR points to the line.. 
      LDY #0 	;	set to first offset in that buffer.. we'll add other objects to the lines later so this will always be null object
      LDA #8 	;   start at X=0
    @E_loopE:
        TAX
        LDA #2 	;	water type
        STA (ZP_PTR),y 
        iny 
        TXA ;	get X value
        STA (ZP_PTR),y 
        iny 
        CLC
        adc #16
        CMP #136
        BCC @E_loopE 	;kk
      LDA #0
      STA (ZP_PTR),y ; stash zero value to end the thing
      LDA ZP_PTR+2
      SBC #15 	;	borrow is set ...
      BCS @E_loop ; still spots left on screen.. otay
    jmp update_screen 
BEARING_ONE:
BEARING_TWO: ; 30 degrees .. 
    LDA #116 ; starting at screen Y=112 
  @E_loop:
    STA ZP_PTR+2 ; stash the Y we're working at... 
      STZ ZP_PTR   ; zero this out to use pointer .. 
      LSR 
      ROR ZP_PTR ; 
      LSR
      ROR ZP_PTR ; because is 64 avail for each 
      ORA #>SCREEN_buffer ; making pointer woot! 
      STA ZP_PTR+1 ; ZP_PTR points to the line.. 
      LDY #0 	;	set to first offset in that buffer.. we'll add other objects to the lines later so this will always be null object
      LDA #12 	;   start at X=0
    @E_loopE:
        TAX
        LDA #2 	;	water type
        STA (ZP_PTR),y 
        iny 
        TXA ;	get X value
        STA (ZP_PTR),y 
        iny 
        CLC
        adc #28
        CMP #136
        BCC @E_loopE 	;kk
      LDA #0
      STA (ZP_PTR),y ; stash zero value to end the thing
      LDA ZP_PTR+2
      SBC #13 	;	borrow is set ...
      BCS @E_loop ; still spots left on screen.. otay
    jmp update_screen 

  rts 

update_screen:
  stz VERA_addr_low
  lda #>VRAM_sprite_attributes
  sta VERA_addr_high
  lda #$11
  sta VERA_addr_bank
    LDA #119
    STA ZP_PTR+2 ; stash line we at .. 
      STZ ZP_PTR
      LSR 
      ROR ZP_PTR ; 
      LSR
      ROR ZP_PTR ; because is 64 avail for each 
      ORA #>SCREEN_buffer ; making pointer woot! 
      STA ZP_PTR+1 ; ZP_PTR points to the line.. 
  @y_line_loop:
      LDY #0 ; set to check that first point .. 
      dec ZP_PTR+2
    @do_check_line:
        LDA (ZP_PTR),Y ;	get type 
        INY 
        TAX 
        JMP (@T_objtypes,X) ; 
    @T_objtypes:
        .addr @end_line 
        .addr @do_water 
    @do_water:
      stz VERA_data0 	; 	address 12:5
      STZ VERA_data0 	; 	4bit color address 16:13
      LDA (ZP_PTR),Y  	;	get the X
      iny 
      STA VERA_data0 	;	X 
      STZ VERA_data0 	;	 X 
      LDA ZP_PTR+2
      STA VERA_data0 	;	y
      STZ VERA_data0 	; 	y
      LDA #$0C 
      STA VERA_data0 	; 	3 z depth no flip
      LDA #$D0 			; 	16x64 no palette offset
      STA VERA_data0
      bra @do_check_line
    @end_line:
        SEC 
        LDA ZP_PTR
        SBC #64
        STA ZP_PTR
        LDA ZP_PTR+1
        SBC #0
        STA ZP_PTR+1
        CMP #>SCREEN_buffer
        BCS @y_line_loop
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
