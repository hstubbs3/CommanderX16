
; VERA
VERA_addr_low     = $9F20
VERA_addr_high    = $9F21
VERA_addr_bank    = $9F22
VERA_data0        = $9F23
VERA_data1        = $9F24
VERA_ctrl         = $9F25 ; RESET | 6 bits DCSEL | addrsel
VERA_DCSEL0_ADDR0 = $00
VERA_DCSEL2_ADDR0 = $04
VERA_DCSEL3_ADDR0 = $06
VERA_DCSEL4_ADDR0 = $08
VERA_DCSEL5_ADDR0 = $0A
VERA_DCSEL6_ADDR0 = $0C

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
;   The palette offset (in 'H-Scroll (11:8)') mo  ; start of program
VERA_L0_mapbase   = $9F2E
VERA_L0_tilebase  = $9F2F
;   Tile Base Address (16:11) | Tile Height 0-8/1-16 | Tile Width 0-8/1-16
VERA_L1_config    = $9F34 
VERA_L1_mapbase   = $9F35
VERA_L1_tilebase  = $9F36
VERA_L0_hscroll_h = $9F31

; VRAM addresses 124k+ 
VRAM_MATH_SCRATCH = $1F000     ; 2K of scratch = 512 multiplies
VRAM_CURSOR_SPR   = $1F900 		; up to 16x16 bit sprite 
VRAM_palette      = $1FA00      ;  
VRAM_SPRITE_LIST  = $1FC00

DISPLAY_SCALE_TWO     = 64 ; 2X zoom
DISPLAY_SCALE_ONE     = 128 ; 640x480
MODE_BITMAP_256BPP = $07
MODE_BITMAP_16BPP  = $06
LAYER0_ONLY       = $11
LAYER0SPRITES_ENABLE = $51
LAYER01SPRITES_ENABLE = $71
SPRITES_ONLY = $41

VRAM_INCREMENT_1 = $10
VRAM_INCREMENT_2 = $20
VRAM_INCREMENT_4 = $30
VRAM_INCREMENT_8 = $40
VRAM_INCREMENT_16 = $50
VRAM_INCREMENT_32 = $60
VRAM_INCREMENT_64 = $70
VRAM_INCREMENT_128 = $80
VRAM_INCREMENT_256 = $90
VRAM_INCREMENT_512 = $A0
VRAM_INCREMENT_40 = $B0 
VRAM_INCREMENT_80 = $C0
VRAM_INCREMENT_160 = $D0 
VRAM_INCREMENT_320 = $E0
VRAM_INCREMENT_640 = $F0 


; DCSEL = 2
VERA_FX_CTRL    = $9F29
VERA_FX_TILEBASE = $9F2A
VERA_FX_MAPBASE = $9F2B
VERA_FX_MULT = $9F2C
FX_MULTIPLY_ENABLE = $10

; DCSEL = 3
VERA_FX_X_INC_L = $9F29
VERA_FX_X_INC_H = $9F2A
VERA_FX_Y_INC_L = $9F2B
VERA_FX_Y_INC_H = $9F2C

; DCSEL = 4
VERA_FX_X_POS_L = $9F29
VERA_FX_X_POS_H = $9F2A
VERA_FX_Y_POS_L = $9F2B
VERA_FX_Y_POS_H = $9F2C

; DCSEL = 6
VERA_FX_CACHE_L = $9F29  ; write only.. read here will reset accumulator!
VERA_FX_CACHE_M = $9F2A  ; write only.. read triggers accumulate
VERA_FX_CACHE_H = $9F2B  ; write only
VERA_FX_CACHE_U = $9F2C  ; write only

VSYNC_BIT         = $01

; Kernal
CHROUT            = $FFD2
GETIN             = $FFE4
CINT              = $FF81
CONSOLE_PUT_CHAR  = $FEDE
MOUSE_CONFIG      = $FF68
MOUSE_GET         = $FF6B
MOUSE_SCAN        = $FF71

; RAM Interrupt Vectors
IRQVec            = $0314

ZP_PTR = $22

VERA_SET_MULTIPLY = $10
VERA_RESET_ACCUMULATOR = $80

.macro set_vera_for_single_multiplies  ;  allowing read of bytes 1,2 of each .. 
  ; set addr1
  ldy #VERA_DCSEL2_ADDR0+1 ; set DCSEL = 2 and addrsel to 1 ; 2
  sty VERA_ctrl   ; 4
  ldx #(VRAM_INCREMENT_4 | ^VRAM_MATH_SCRATCH)  ; 6
  stx VERA_addr_bank ;  10
  lda #>VRAM_MATH_SCRATCH ; 12
  sta VERA_addr_high ;  16
  stz VERA_addr_low ; 20
  ; set addr0
  ldy #VERA_DCSEL2_ADDR0 ; set DCSEL =2 and addrsel to 0 
  sty VERA_ctrl
  stx VERA_addr_bank
  sta VERA_addr_high
  lda #1  ; we want bytes 1,2 of each multiply.. 
  sta VERA_addr_low 
  ; set multiply    42
  lda #(VERA_SET_MULTIPLY | VERA_RESET_ACCUMULATOR)  ; set multiply mode
  sta VERA_FX_MULT ;  48
  lda #$48  ; enable cache writes and 16-bit hop
  sta VERA_FX_CTRL ; 54
  lda #VERA_DCSEL6_ADDR0  ; set DCSEL = 6 and addrsel to 0 to prime for accessing cache VERA_FX_CACHE_L,M,H,U
  sta VERA_ctrl ; 60
  stz VERA_FX_CACHE_L
.endmacro 


.macro wait_keypress
  .local waity_wait
  waity_wait:
   wai
   jsr GETIN
   beq waity_wait
.endmacro

ENABLE_MOUSE_CURSOR: 
; expect address of cursor sprite data in ZP_PTR like this -
; ZP_PTR+0/1 - address of data for mouse cursor
    lda #$FF
    jsr MOUSE_CONFIG
    ; configure sprite 0
    stz VERA_addr_low
    lda #>VRAM_SPRITE_LIST
    sta VERA_addr_high
    lda #(VRAM_INCREMENT_1 | ^VRAM_SPRITE_LIST)
    sta VERA_addr_bank
    lda #((VRAM_CURSOR_SPR >> 5) & $FF )
    sta VERA_data0
	lda #($80 | (VRAM_CURSOR_SPR >> 13)) ; high address, 8bit sprite 
	sta VERA_data0
    stz VERA_data0 ; x low  VRAM_SPRITE_LIST + 2
    stz VERA_data0 ; x high
    stz VERA_data0 ; y low
    stz VERA_data0 ; y high 
    lda #$0C
    sta VERA_data0 ; z-depth/flips
    lda #$50 ; is 16/16 sprite, 8bit color / no offset
    sta VERA_data0 ; sprite width/height/palette.. a freed up now.
    ; copy cursor image to sprite 0 
    stz VERA_addr_low
    lda #>VRAM_CURSOR_SPR
    sta VERA_addr_high
    lda #(VRAM_INCREMENT_1 | ^VRAM_CURSOR_SPR)
    sta VERA_addr_bank
    ldy #0
  @cursor_data_loop:
      lda (ZP_PTR),y
      sta VERA_data0
      iny 
      bne @cursor_data_loop
  rts
