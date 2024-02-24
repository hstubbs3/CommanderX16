; 	080D
jmp start ; 	3 bytes 
;	0810 	- 240 bytes available for stuff that doesn't need alignment 
.repeat 28
	.byte $DE,$AD,$BE,$EF
.endrepeat
SCRATCH128:
.repeat 32
	.byte $DE,$AD,$BE,$EF
.endrepeat

ACROSS_ROW_X_H: ; 0900
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte $10,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $E
.byte  $E,  $E,  $E,  $E,  $E,  $D,  $D,  $D,  $D,  $D,  $C,  $C,  $C,  $C,  $B,  $B
.byte  $B,  $B,  $A,  $A,  $A,  $9,  $9,  $9,  $8,  $8,  $8,  $7,  $7,  $7,  $6,  $6
.byte  $6,  $5,  $5,  $5,  $4,  $4,  $3,  $3,  $3,  $2,  $2,  $1,  $1,  $1,  $0,  $0
.byte  $0, $FF, $FF, $FE, $FE, $FE, $FD, $FD, $FC, $FC, $FC, $FB, $FB, $FA, $FA, $FA
.byte $F9, $F9, $F9, $F8, $F8, $F8, $F7, $F7, $F7, $F6, $F6, $F6, $F5, $F5, $F5, $F4
.byte $F4, $F4, $F4, $F3, $F3, $F3, $F3, $F2, $F2, $F2, $F2, $F2, $F1, $F1, $F1, $F1
.byte $F1, $F1, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
.byte $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F1
.byte $F1, $F1, $F1, $F1, $F1, $F2, $F2, $F2, $F2, $F2, $F3, $F3, $F3, $F3, $F4, $F4
.byte $F4, $F4, $F5, $F5, $F5, $F6, $F6, $F6, $F7, $F7, $F7, $F8, $F8, $F8, $F9, $F9
.byte $F9, $FA, $FA, $FA, $FB, $FB, $FC, $FC, $FC, $FD, $FD, $FE, $FE, $FE, $FF, $FF
.byte $00,  $0,  $0,  $1,  $1,  $1,  $2,  $2,  $3,  $3,  $3,  $4,  $4,  $5,  $5,  $5
.byte  $6,  $6,  $6,  $7,  $7,  $7,  $8,  $8,  $8,  $9,  $9,  $9,  $A,  $A,  $A,  $B
.byte  $B,  $B,  $B,  $C,  $C,  $C,  $C,  $D,  $D,  $D,  $D,  $D,  $E,  $E,  $E,  $E
.byte  $E,  $E,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F

ACROSS_ROW_X_L: ; 0A00
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte  $0, $FE, $FB, $F4, $EC, $E1, $D3, $C3, $B1, $9C, $85, $6B, $4F, $31, $10, $ED
.byte $C8, $A0, $76, $4A, $1C, $EB, $B9, $84, $4D, $14, $D9, $9D, $5E, $1D, $DA, $96
.byte $50,  $8, $BE, $73, $26, $D7, $87, $36, $E3, $8F, $39, $E2, $8A, $31, $D7, $7B
.byte $1F, $C2, $63,  $4, $A5, $44, $E3, $81, $1F, $BC, $59, $F5, $91, $2D, $C8, $64
.byte  $0, $9B, $37, $D2, $6E,  $A, $A6, $43, $E0, $7E, $1C, $BB, $5A, $FB, $9C, $3D
.byte $E0, $84, $28, $CE, $75, $1D, $C6, $70, $1C, $C9, $78, $28, $D9, $8C, $41, $F7
.byte $AF, $69, $25, $E2, $A1, $62, $26, $EB, $B2, $7B, $46, $14, $E3, $B5, $89, $5F
.byte $37, $12, $EF, $CE, $B0, $94, $7A, $63, $4E, $3C, $2C, $1E, $13,  $B,  $4,  $1
.byte  $0,  $1,  $4,  $B, $13, $1E, $2C, $3C, $4E, $63, $7A, $94, $B0, $CE, $EF, $12
.byte $37, $5F, $89, $B5, $E3, $14, $46, $7B, $B2, $EB, $26, $62, $A1, $E2, $25, $69
.byte $AF, $F7, $41, $8C, $D9, $28, $78, $C9, $1C, $70, $C6, $1D, $75, $CE, $28, $84
.byte $E0, $3D, $9C, $FB, $5A, $BB, $1C, $7E, $E0, $43, $A6,  $A, $6E, $D2, $37, $9B
.byte  $0, $64, $C8, $2D, $91, $F5, $59, $BC, $1F, $81, $E3, $44, $A5,  $4, $63, $C2
.byte $1F, $7B, $D7, $31, $8A, $E2, $39, $8F, $E3, $36, $87, $D7, $26, $73, $BE,  $8
.byte $50, $96, $DA, $1D, $5E, $9D, $D9, $14, $4D, $84, $B9, $EB, $1C, $4A, $76, $A0
.byte $C8, $ED, $10, $31, $4F, $6B, $85, $9C, $B1, $C3, $D3, $E1, $EC, $F4, $FB, $FE

ACROSS_ROW_Y_H: ; 0B00
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte  $0,  $0,  $0,  $0,  $0,  $0,  $1, $1, $1, $1, $1, $2, $2, $2, $2, $2, $3, $3, $3, $3, $3, $3, $4, $4, $4, $4, $4, $4, $5, $5, $5, $5, $5, $5, $5, $6, $6, $6, $6, $6, $6, $6, $6, $6, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $8, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $6, $6, $6, $6, $6, $6, $6, $6, $6, $5, $5, $5, $5, $5, $5, $5, $4, $4, $4, $4, $4, $4, $3, $3, $3, $3, $3, $3, $2, $2, $2, $2, $2, $1, $1, $1, $1, $1, $0, $0, $0, $0, $0, $0, $FF, $FF, $FF, $FF, $FF, $FE, $FE, $FE, $FE, $FE, $FD, $FD, $FD, $FD, $FD, $FC, $FC, $FC, $FC, $FC, $FC, $FB, $FB, $FB, $FB, $FB, $FB, $FA, $FA, $FA, $FA, $FA, $FA, $FA, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $FA, $FA, $FA, $FA, $FA, $FA, $FA, $FB, $FB, $FB, $FB, $FB, $FB, $FC, $FC, $FC, $FC, $FC, $FC, $FD, $FD, $FD, $FD, $FD, $FE, $FE, $FE, $FE, $FE, $FF, $FF, $FF, $FF, $FF

ACROSS_ROW_Y_L: ; 0C00
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte  $0, $32, $64, $96, $C8, $FA, $2C, $5E, $8F, $C0, $F1, $22, $52, $82
.byte $B1, $E1,  $F, $3D, $6B, $98, $C5, $F1, $1C, $47, $71, $9B, $C3 
.byte $EB, $13, $39, $5F, $84, $A8, $CB, $ED,  $E, $2F, $4E, $6C, $8A
.byte $A6, $C2, $DC, $F5,  $E, $25, $3B, $50, $64, $76, $88, $98, $A7
.byte $B5, $C2, $CE, $D8, $E1, $E9, $F0, $F6, $FA, $FD, $FF,  $0, $FF
.byte $FD, $FA, $F6, $F0, $E9, $E1, $D8, $CE, $C2, $B5, $A7, $98, $88
.byte $76, $64, $50, $3B, $25,  $E, $F5, $DC, $C2, $A6, $8A, $6C, $4E
.byte $2F, $E, $ED, $CB, $A8, $84, $5F, $39, $13, $EB, $C3, $9B, $71, $47, $1C, $F1, $C5, $98, $6B, $3D, $F, $E1, $B1, $82, $52, $22, $F1, $C0, $8F, $5E, $2C, $FA, $C8, $96, $64, $32, $0, $CD, $9B, $69, $37, $5, $D3, $A1, $70, $3F, $E, $DD, $AD, $7D, $4E, $1E, $F0, $C2, $94, $67, $3A, $E, $E3, $B8, $8E, $64, $3C, $14, $EC, $C6, $A0, $7B, $57, $34, $12, $F1, $D0, $B1, $93, $75, $59, $3D, $23, $A, $F1, $DA, $C4, $AF, $9B, $89, $77, $67, $58, $4A, $3D, $31, $27, $1E, $16, $F, $9, $5, $2, $0, $0, $0, $2, $5, $9, $F, $16, $1E, $27, $31, $3D, $4A, $58, $67, $77, $89, $9B, $AF, $C4, $DA, $F1, $A, $23, $3D, $59, $75, $93, $B1, $D0, $F1, $12, $34, $57, $7B, $A0, $C6, $EC, $14, $3C, $64, $8E, $B8, $E3, $E, $3A, $67, $94, $C2, $F0, $1E, $4E, $7D, $AD, $DD, $E, $3F, $70, $A1, $D3, $5, $37, $69, $9B, $CD


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

; zero page layout $0022-$007F is available to user
ZP_PTR = $22 
SCRATCH_PTR = $7E
; global data
.byte $DE,$AD,$BE,$EF
default_irq_vector:  .addr 0
VSYNC_counter:       .byte 1
camera_facing: 		 .byte 1


.macro stash_scratch
	STA (SCRATCH_PTR)
    INC SCRATCH_PTR
.endmacro

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
  ldx #0
  @copy_to_vram_loop:
  	  lda test_cell_sprite_16x8,X
  	  sta VERA_data0
  	  inx
  	  CPX #64
  	  BNE @copy_to_vram_loop

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
   lda #4
  @frame_A:
   wai
   ldy VSYNC_counter
   beq @frame_A
   stz VSYNC_counter
   DEC A
   BNE @frame_A

   ; poll keyboard for input 
   jsr GETIN
   cmp #0
   beq @FRAME_CHECK
   cmp #SPACE
   bne @cleanup_and_exit

   ; switch to next bearing
   INC camera_facing
   ; update screen
   ; jsr draw_world
   jsr draw_test
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

draw_test:
	LDA #>SCRATCH128 	;	setup debug pointer
	STA $7F
	LDA #<SCRATCH128
	STA $7E 	
    stz VERA_addr_low
    lda #>VRAM_sprite_attributes
    sta VERA_addr_high
    lda #$11
    sta VERA_addr_bank
    ; load increments and set start position...
    LDX camera_facing
    ; stash camera facing to scratch 
    TXA
	stash_scratch
	stash_scratch
	stash_scratch
	stash_scratch
	stash_scratch
	stash_scratch
	stash_scratch
	stash_scratch


    LDA ACROSS_ROW_X_L,X 
    STA ZP_PTR+4 	; 	ZP_PTR+4 = spriteX increment Low byte
    STZ ZP_PTR+4 	; 	ZP_PTR+4 = spriteX increment Low byte
	stash_scratch

    STZ ZP_PTR+1
    LDA ACROSS_ROW_X_H,X 
    STA ZP_PTR+5
	stash_scratch
    CMP #0
    BPL @going_right
    LDA #144
    STA ZP_PTR+1
  @going_right:
    LDA ACROSS_ROW_Y_L,X 
    STA ZP_PTR+6 	; 	ZP_PTR+6 = spriteY increment low byte
   ; STZ ZP_PTR+6 	; 	ZP_PTR+6 = spriteY increment low byte
	stash_scratch
    STZ ZP_PTR+3
    LDA ACROSS_ROW_Y_H,X 
    STA ZP_PTR+7 	; 	ZP_PTR+3 = spriteY increment 
    stash_scratch
    CMP #0
    BPL @going_down
    LDA #112
    STA ZP_PTR+3
  @going_down:
    LDY #128 		;	amount of sprites we can write max
    STY ZP_PTR
    STY ZP_PTR+2

  @loop:
  	  TXA
  	  stash_scratch
  	  TYA
  	  stash_scratch

      STZ VERA_data0 ; 	address 12:5
      STZ VERA_data0 ;  mode  | address 16:13
      LDA ZP_PTR+1 	
      STA VERA_data0 ; 	X 7:0
      stash_scratch

      STZ VERA_data0 ; 	X 9:8
      LDA ZP_PTR+3  ; 	spriteY
      STA VERA_data0 ;  Y 7:0
      stash_scratch

      STZ VERA_data0 ; 	Y 9:8
      LDA #$0C 
      STA VERA_data0 	; 	3 z depth no flip
      LDA #$10 			; 	16x8 no palette offset
      STA VERA_data0
    ; increment X
      LDA ZP_PTR 	;	load X_l
      ADC ZP_PTR+4 	
      STA ZP_PTR
      stash_scratch

      LDA ZP_PTR+1
      ADC ZP_PTR+5
      stash_scratch
      CMP #160
      BCS @end 		; covers negatives even.. 
      STA ZP_PTR+1
    ; increment Y
      LDA ZP_PTR+2 	;
      ADC ZP_PTR+6
      STA ZP_PTR+2
      stash_scratch

      LDA ZP_PTR+3
      ADC ZP_PTR+7
      stash_scratch
      CMP #120
      BCS @end 		; 	 covers negatives even.. 
      STA ZP_PTR+3

      LDA #$FF
      stash_scratch
      stash_scratch

      DEY
      BNE @loop 
  @end:
      rts


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

test_cell_sprite_16x8: 	;	16x8x16 bit = 64 bytes
; 	   01   23   45   67   89   AB   CD   EF
.byte $00, $00, $66, $66, $66, $66, $00, $00 	; 	0
.byte $00, $66, $EE, $EE, $EE, $EE, $66, $00  	;	1
.byte $06, $EE, $EE, $EE, $EE, $EE, $EE, $60 	;	2
.byte $6E, $EE, $EE, $EE, $EE, $EE, $EE, $E6 	;	3
.byte $6E, $EE, $EE, $EE, $EE, $EE, $EE, $E6 	;	4
.byte $06, $EE, $EE, $EE, $EE, $EE, $EE, $60 	;	5
.byte $00, $66, $EE, $EE, $EE, $EE, $66, $00  	;	6
.byte $00, $00, $66, $66, $66, $66, $00, $00 	; 	7

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
