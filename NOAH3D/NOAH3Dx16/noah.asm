.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

  jmp start
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

; video output scaling to 320x161 ( 40 x 20 (mod8=1) 8x8 tiles)
VRAM_layer0_bitmap  = $00000 ;  using 320x120 doublebuffered for viewport = 75k     0k    75k-1
VRAM_layer1_map     = $12C00 ;  using 8x8 8bit for HUD and stuff 64x21x2=2688b      75k   78k
VRAM_layer1_tiles   = $13800 ;  border HUD and font stuff - maybe 256 tiles         16k   94k
; for testing this is initialized to use 1bit tile mode / 16 color 
VRAM_cursor_sprite  = $1E7C0 ; 8x8 256 color sprite to make a cursor to track position
VRAM_MAP_SPRITE     = $1E800 ; space for 256 color 64x64 sprite for HUD/map ..      122k  126k 
VRAM_UNRESERVED     = $1A000 ; 126K+ used for palette/sprites, so 108K-126K=18K available for hud/effects stuffs..
; sprite starts must be 32byte aligned...
; only can go to 126K ... 
VRAM_palette      = $1FA00      ;  
VRAM_SPRITE_LIST  = $1FC00
BITMAP_PAL_OFFSET = 0

; constants
MODE_BITMAP_256BPP = $07
MODE_BITMAP_16BPP  = $06
MODE_TILE_64_WIDE = $10
MODE_T256C = $0D
MODE_128x64_T16C = $60 ; 128x64, 16-color text
MODE_128x64_T256C = $68 ; 128x64, 256-color text
MODE_64x32_T256C = $18
MODE_64x32_T16C  = $10
MODE_32x32_256BPP = $03
MODE_32x32_T16C   = $00
LAYER0_ONLY       = $11
LAYER01_ENABLE    = $31
LAYER1_ONLY       = $21
LAYER01SPRITES_ENABLE = $71
LAYERSPRITES_ONLY = $41
VRAM_bitmap       = $04000
LOWER_UPPER       = $C400

; ROM Banks
ROM_BANK          = $01
BASIC_BANK        = 4
CHARSET_BANK      = 6
RAM_BANK          = $00
KERNAL_RAM_BANK   = $00

MAP_RAM_BANK      = $01
BANKED_RAM_HIGH   = $A0

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
CHAR_UP           = $91
CHAR_DOWN         = $11
CHAR_LEFT         = $9D
CHAR_RIGHT        = $1D

; global data

default_irq_vector:  .addr 0
VSYNC_counter:       .byte 1
ZP_PTR = $22

cursor_data:
  .byte   $1,$1,$1,$1,$1,$0,$0,$0
  .byte   $1,$0,$1,$0,$1,$0,$0,$0
  .byte   $1,$1,$0,$1,$1,$0,$0,$0
  .byte   $1,$0,$1,$0,$1,$0,$0,$0
  .byte   $1,$1,$1,$1,$1,$0,$0,$0
  .byte   $0,$0,$0,$0,$0,$0,$0,$0
  .byte   $0,$0,$0,$0,$0,$0,$0,$0
  .byte   $0,$0,$0,$0,$0,$0,$0,$0

test_tiles:
  .byte   %00000000                 ; 0
  .byte   %00111100
  .byte   %01000010
  .byte   %01000010
  .byte   %01000010
  .byte   %01000010
  .byte   %00111100
  .byte   %00000000                 

  .byte   %00000000                 ; 1
  .byte   %00011000
  .byte   %00101000
  .byte   %00001000
  .byte   %00001000
  .byte   %01001000
  .byte   %01111110
  .byte   %00000000                 

  .byte   %00000000                 ; 2
  .byte   %00111100
  .byte   %01101110
  .byte   %00011100
  .byte   %01110000
  .byte   %01110000
  .byte   %01111110
  .byte   %00000000                 

  .byte   %00000000                 ; 3
  .byte   %00111100
  .byte   %01000110
  .byte   %00011100
  .byte   %00000100
  .byte   %01000110
  .byte   %00111100
  .byte   %00010001                 

  .byte   %00000000                 ; 4
  .byte   %01000100
  .byte   %01000100
  .byte   %01111100
  .byte   %00001100
  .byte   %00001100
  .byte   %00001100
  .byte   %00010000                 

  .byte   %00100000                 ; 5
  .byte   %01111100
  .byte   %01000000
  .byte   %01111100
  .byte   %00000100
  .byte   %01000100
  .byte   %00111100
  .byte   %00010000                 

  .byte   %00000000                 ; 6
  .byte   %00111100
  .byte   %01000010
  .byte   %01110000
  .byte   %01000100
  .byte   %01110100
  .byte   %00111100
  .byte   %00010000                 

  .byte   %00000000                 ; 7
  .byte   %01111110
  .byte   %01111110
  .byte   %00001100
  .byte   %00011000
  .byte   %00110100
  .byte   %01100000
  .byte   %00010000                 

  .byte   %00000000                 ; 8
  .byte   %01111100
  .byte   %01000010
  .byte   %00111100
  .byte   %01000010
  .byte   %01000010
  .byte   %01111100
  .byte   %00010000                 

  .byte   %00100000                 ; 9
  .byte   %01111100
  .byte   %01111110
  .byte   %01111110
  .byte   %00011100
  .byte   %01110100
  .byte   %01111110
  .byte   %00010001                 

  .byte   %00100000                 ; A
  .byte   %01111100
  .byte   %01111110
  .byte   %00011100
  .byte   %01111110
  .byte   %01110100
  .byte   %01111110
  .byte   %00010001                 

  .byte   %00100000                 ; B
  .byte   %01111100
  .byte   %01111110
  .byte   %01111110
  .byte   %00011100
  .byte   %01110100
  .byte   %01111110
  .byte   %00010001                 

  .byte   %00100000                 ; C
  .byte   %01111100
  .byte   %01111110
  .byte   %01111110
  .byte   %00011100
  .byte   %01110100
  .byte   %01111110
  .byte   %00010001                 

  .byte   %00100000                 ; D
  .byte   %01111100
  .byte   %01111110
  .byte   %01111110
  .byte   %00011100
  .byte   %01110100
  .byte   %01111110
  .byte   %00010001                 

  .byte   %00100000                 ; E
  .byte   %01111100
  .byte   %01111110
  .byte   %01111110
  .byte   %00011100
  .byte   %01110100
  .byte   %01111110
  .byte   %00010001                 

  .byte   %00100000                 ; F
  .byte   %01111100
  .byte   %01111110
  .byte   %01111110
  .byte   %00011100
  .byte   %01110100
  .byte   %01111110
  .byte   %00010001                 

  .byte   $0,$0,$0,$0,$0,$0,$0,$0   ; $10   blank

layer1_map:
.incbin "hud_test_map.bin"

.macro copy_bytes_to_vram_data0 ; ZP_PTR/+1 is source, x is *256 bytes to copy, x y a ZP_PTR+1 clobbered
    .local _copy 
    .local _copy_byte 
    ldy #0
    _copy:
      _copy_byte:
        lda (ZP_PTR),y
        sta VERA_data0
        iny 
        bne _copy_byte
      inc ZP_PTR+1
      dex
      bne _copy
.endmacro

start:

  ; start of program - init globals
  lda IRQVec
  sta default_irq_vector
  lda IRQVec+1
  sta default_irq_vector+1

  stz VERA_dc_video   ; disable display
  lda #64 ; set screen scaling - 320 wide
  sta VERA_dc_hscale
  lda #43 ; by 160 tall
  sta VERA_dc_vscale

  ; start by init VRAM data 
  stz VERA_ctrl
  ; init layer1 for hud testing...
  stz VERA_addr_low
  lda #>VRAM_layer1_tiles ;
  sta VERA_addr_high
  lda #($10 | ^VRAM_layer1_tiles) ;
  sta VERA_addr_bank
  lda #<test_tiles
  sta ZP_PTR
  lda #>test_tiles
  sta ZP_PTR+1
  ldx #1  ; really only need to copy 136 bytes but.. whatev
  copy_bytes_to_vram_data0

  stz VERA_addr_low
  lda #>VRAM_layer1_map ;
  sta VERA_addr_high
  lda #($10 | ^VRAM_layer1_map) ;
  sta VERA_addr_bank
  lda #<layer1_map
  sta ZP_PTR
  lda #>layer1_map
  sta ZP_PTR+1
  ldx #11   ; copy 21 rows * 128 bytes = 2,688 - ~11*256
  copy_bytes_to_vram_data0

  ;layer 1 config
  lda #MODE_64x32_T16C
  sta VERA_L1_config
  lda #(VRAM_layer1_map >> 9)
  sta VERA_L1_mapbase
  lda #(VRAM_layer1_tiles>>9)
  sta VERA_L1_tilebase

  lda #1 
  sta VERA_L1_VSCROLL_H
  lda #4
  sta VERA_L1_VSCROLL_L

  ; enable layers and start drawing
  ;stz VERA_ctrl
  ;lda #LAYER01_ENABLE
  ;lda #LAYER0_ONLY ; for testing
  lda #LAYER1_ONLY
  ;lda #LAYERSPRITES_ONLY
  ;lda #LAYER01SPRITES_ENABLE
  sta VERA_dc_video

@check_keyboard:
   ; poll keyboard for input
   jsr GETIN
   cmp #0
   beq @check_keyboard

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
