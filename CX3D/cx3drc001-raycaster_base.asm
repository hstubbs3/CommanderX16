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

VRAM_RC_layer_tileA = $00000      ; must be 4K aligned - 25x14 x8x8 = 22,400B   21.875K actually starts at  0   - 21.875K - last 128 bytes unused... 
VRAM_RC_layer_map  = $05800       ; must be 512B aligned  32x32 assigned=2K actually using ~32x20           22K  - 24K    - 
VRAM_RC_layer_tileB = $06000      ; must be 4K aligned              21.875K                                 24k  - 45.875K 
RC_ZERO_TILE=$015E
VRAM_HUD_layer_map   = $0B800      ; must be 512B aligned  32x32 assigned=2k uses 20 lines -> 1,280 used..   46k  - 47.25  - 768 bytes unused...
VRAM_HUD_layer_tile  = $0C000      ; must be 4K aligned . 256*1bpp 8x8 = 2K max                              48K  - 50K 

VRAM_tex_cache_64 = $0C800      ; space for 64x64 textures.. 4x of these just in case..                   50k  - 66K
VRAM_tex_cache_48 = $10800      ; 48x48 textures - 2.25K each.. space for 8x .. 18K                       66k  - 84k
VRAM_tex_cache_32 = $15000      ; 32x32 textures - 1k each - space for 16x                                84k  - 100k
VRAM_tex_cache_24 = $19000      ; 16x16 textures 256k each - 32x=8k                                       100k - 108k
VRAM_UNRESERVED   = $1A000      ; 126K+ used for palette/sprites, so 108K-126K=18K available for hud/effects stuffs..
; sprite starts must be 32byte aligned...
; only can go to 126K ... 
VRAM_palette      = $1FA00      ;  

BITMAP_PAL_OFFSET = 0
; constants
DISPLAY_SCALE_FOUR    = 32
DISPLAY_SCALE_TWO     = 64 ; 2X zoom
DISPLAY_SCALE_ONE     = 128 ; 640x480
MODE_BITMAP_256BPP = $07
MODE_BITMAP_16BPP  = $06
MODE_TILE_64_WIDE = $10
MODE_T256C = $0D
MODE_128x64_T16C = $60 ; 128x64, 16-color text
MODE_128x64_T256C = $68 ; 128x64, 256-color text
MODE_64x32_T256C = $18
MODE_32x32_256BPP = $03
MODE_32x32_T16C   = $00
LAYER0_ONLY       = $11
LAYER01_ENABLE    = $31
LAYER1_ONLY       = $21
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
PLAYER_X_SUB: .byte   $80
PLAYER_X:     .byte   $01 ; (1,14) on the small test map.. 
PLAYER_Y_SUB:  .byte   $80
PLAYER_Y:     .byte   $0E
PLAYER_ANGLE:        .byte 32 ; facing NorthEast

ZP_PTR = $22

HUD_layer_TILEDATA:
  .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000 ; empty

  .byte %00000000   ; HEX digits for debug
  .byte %00011110
  .byte %00101011
  .byte %01001011
  .byte %01010011
  .byte %01010010
  .byte %01111100
  .byte %00000000
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; 1
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; 2
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; 3
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; 4
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; 5
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; 6
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; 7
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; 8
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; 9
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; A
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; B
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; C
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; D
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; E
  .byte %00000000, %00011110, %00101011, %01001011, %01010011, %01010010, %01111100, %00000000 ; F (16)

  .byte %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111 ; filled (17)
  .byte %10101010, %01010101, %10101010, %01010101, %10101010, %01010101, %10101010, %01010101 ; 1x1 checkerboard - 18
  ; 19 - floor / ceiling gradients
  ; is like fade between two colors ..
  ;    100% color0 7/8 ...    6/8(3/4)    5/8
  .byte %00000000, %00000001, %01000100, %10010010, %01010101, %10110110, %11011011, %01111111

HUD_layer_MAPDATA:
  ; 32x32 but only populating 32x20
  ;     0         1       2         3       4         5         6       7         8       9       10        11      12          13        14    15
  .byte $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03 ;  
  .byte $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 0

  .byte $12,$03, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11 
  .byte $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 1

  .byte $12,$03, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11 
  .byte $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $13,$11, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 2

  .byte $12,$03, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F
  .byte $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $13,$1F, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 3

  .byte $12,$03, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC
  .byte $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $13,$FC, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 4

  .byte $12,$03, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB
  .byte $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $13,$CB, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 5

  .byte $12,$03, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB
  .byte $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 6

  .byte $12,$03, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB
  .byte $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $13,$BB, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 7

  .byte $12,$03, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99 
  .byte $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ;  line 8

  .byte $12,$03, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99 
  .byte $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $13,$99, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ;  line 9

  .byte $12,$03, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98 
  .byte $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $13,$98, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ;  line 10

  .byte $12,$03, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88 
  .byte $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $13,$88, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ;
  .byte $12,$03, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87 ; 
  .byte $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $13,$87, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 12

  .byte $12,$03, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77
  .byte $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 13

  .byte $12,$03, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77
  .byte $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $13,$77, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 14

  .byte $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 15
  .byte $12,$03, $00,$00, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01 
  .byte $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $00,$00, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 16
  .byte $12,$03, $00,$00, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01 
  .byte $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $00,$00, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 17
  .byte $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 18
  .byte $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03 ;  
  .byte $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $12,$03, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 19

custom_irq_handler:
   lda VERA_isr
   and #VSYNC_BIT
   beq @continue ; non-VSYNC IRQ, no tick update
   inc VSYNC_counter
@continue:
   ; continue to default IRQ handler
   jmp (default_irq_vector)
   ; RTI will happen after jump

INITIALIZE_VRAM_DATA:
  stz VERA_ctrl
  ;init layer0
  stz VERA_addr_low
  lda #>VRAM_RC_layer_map
  sta VERA_addr_high
  lda #($10 | ^VRAM_RC_layer_map) ;
  sta VERA_addr_bank
  lda #33
  ldx #$5E
  ldy #$01
  @init_layer0_map_line0:
    stx VERA_data0
    sty VERA_data0
    dec a
    BNE @init_layer0_map_line0
  lda #255
  sta ZP_PTR
  stz ZP_PTR+1
  ldy #14  
  sty ZP_PTR+2
  clc
  @init_layer0_map_disp_row_loop:
    ldy #25
    inc ZP_PTR
    lda ZP_PTR
    ldx ZP_PTR+1
    @init_layer0_disp_row:
      sta VERA_data0
      stx VERA_data0
      adc #14 ; was 28
      bcc @no_carry
      inx
      clc
    @no_carry:
      dey
      BNE @init_layer0_disp_row
    lda #7
    ldx #$5E
    ldy #$01
    @zero_rest_row:
      stx VERA_data0
      sty VERA_data0
      dec a
      BNE @zero_rest_row
    dec ZP_PTR+2
    BNE @init_layer0_map_disp_row_loop
  lda #160
  @init_layer1_clear_bottom_rows:
    stx VERA_data0
    sty VERA_data0
    dec a
    BNE @init_layer1_clear_bottom_rows

  ; jmp no_tilemap_0A_clear
  ; zero out RC layer
  stz VERA_addr_low
  stz VERA_addr_high
  lda #$10
  sta VERA_addr_bank
  ldy #88
  lda #0
  ldx #1
  clc
  @loopA:
    @loopB:
      ; simple loop to zero out.. 
      ; stz VERA_data0
      ; inc a

      ; draw a 4x4 grid... 
      stz VERA_data0  ; one tile row
      stx VERA_data0
      stz VERA_data0
      stz VERA_data0
      stz VERA_data0  
      stx VERA_data0
      stz VERA_data0
      stz VERA_data0

      stx VERA_data0  ; 2 tile row
      stx VERA_data0
      stx VERA_data0
      stx VERA_data0
      stx VERA_data0
      stx VERA_data0
      stx VERA_data0
      stx VERA_data0

      stz VERA_data0  ; 3 tile row
      stx VERA_data0
      stz VERA_data0
      stz VERA_data0
      stz VERA_data0  
      stx VERA_data0
      stz VERA_data0
      stz VERA_data0

      stz VERA_data0  ; 4 tile row
      stx VERA_data0
      stz VERA_data0
      stz VERA_data0
      stz VERA_data0  
      stx VERA_data0
      stz VERA_data0
      stz VERA_data0
      adc #32 ; 32 pixels drawn...
      BNE @loopB
    clc
    dey
    BNE @loopB
    lda #$80
    sta VERA_addr_low
    lda #$57
    sta VERA_addr_high
    lda #64
    @clear_tile_15E:
      stz VERA_data0
      dec a 
      BNE @clear_tile_15E

no_tilemap_0A_clear:

  stz VERA_addr_low
  lda #>VRAM_HUD_layer_tile ;
  sta VERA_addr_high
  lda #($10 | ^VRAM_HUD_layer_tile) ;
  sta VERA_addr_bank
  lda #<HUD_layer_TILEDATA
  sta ZP_PTR
  lda #>HUD_layer_TILEDATA
  STA ZP_PTR+1
  ldx #8
  ldy #0
  @init_layer1_tiledata:
    @init_layer1_tiledata_inner:
      lda (ZP_PTR),y
      sta VERA_data0
      iny 
      BNE @init_layer1_tiledata_inner
    inc ZP_PTR+1
    dex
    BNE @init_layer1_tiledata
  stz VERA_addr_low
  lda #>VRAM_HUD_layer_map
  sta VERA_addr_high
  lda #($10 | ^VRAM_HUD_layer_map) ;
  sta VERA_addr_bank
  lda #<HUD_layer_MAPDATA
  sta ZP_PTR
  lda #>HUD_layer_MAPDATA
  sta ZP_PTR+1
  ldx #5
  @init_layer1_mapdata:
    @init_layer1_mapdata_inner:
      lda (ZP_PTR),y
      sta VERA_data0
      iny 
      BNE @init_layer1_mapdata_inner
    inc ZP_PTR+1
    dex
    BNE @init_layer1_mapdata
  rts


start:
  ; start of program - init globals
  lda IRQVec
  sta default_irq_vector
  lda IRQVec+1
  sta default_irq_vector+1

  stz VERA_dc_video   ; disable display
  lda #43 ; set scale for bitmap mode
  sta VERA_dc_hscale
  lda #42
  sta VERA_dc_vscale
  ; layer 0 config...
  lda #MODE_32x32_256BPP 
  sta VERA_L1_config 
  lda #(VRAM_RC_layer_map >> 9)
  sta VERA_L1_mapbase
  ; lda #(VRAM_layer0_tileA >> 9) ;
  ; sta VERA_L0_tilebase
  stz VERA_L1_tilebase
  stz BITMAP_PAL_OFFSET ; palette offset 0
  ;layer 1 config
  lda #MODE_32x32_T16C
  sta VERA_L0_config
  lda #(VRAM_HUD_layer_map >> 9)
  sta VERA_L0_mapbase
  lda #(VRAM_HUD_layer_tile>>9)
  sta VERA_L0_tilebase

  lda #1 
  sta VERA_L0_HSCROLL_H
  sta VERA_L0_VSCROLL_H
  sta VERA_L1_HSCROLL_H
  sta VERA_L1_VSCROLL_H
  lda #1
  sta VERA_L0_HSCROLL_L
  sta VERA_L0_VSCROLL_L
  sta VERA_L1_HSCROLL_L
  sta VERA_L1_VSCROLL_L
  ; load initial tile data
  jsr INITIALIZE_VRAM_DATA;

  ; enable layers and start drawing
  ;stz VERA_ctrl
  lda #LAYER01_ENABLE
  ;lda #LAYER0_ONLY ; for testing
  ;lda #LAYER1_ONLY
  sta VERA_dc_video

;jmp no_interrupt
  ; overwrite RAM IRQ vector with custom handler address
  sei ; disable IRQ while vector is changing
  lda #<custom_irq_handler
  sta IRQVec
  lda #>custom_irq_handler
  sta IRQVec+1
  lda #VSYNC_BIT ; make VERA only generate VSYNC IRQs
  sta VERA_ien
  cli ; enable IRQ now that vector is properly set


  ; draw stuff

  ; main loop here... 
@check_keyboard:
   ; poll keyboard for input
   jsr GETIN
   cmp #0
   beq @check_keyboard
   cmp #SPACE
   beq cleanup_and_exit
   cmp #CHAR_UP
   BEQ @move_foward
   cmp #CHAR_DOWN
   BEQ @move_backward
   cmp #CHAR_LEFT
   BEQ @turn_left
   cmp #CHAR_RIGHT
   BEQ @turn_right
   BRA @check_keyboard
  @move_foward:
    dec PLAYER_Y
    bra @update_display
  @move_backward:
    inc PLAYER_Y
    bra @update_display
  @turn_left:
    inc PLAYER_ANGLE
    dec PLAYER_X
    bra @update_display
  @turn_right:
    dec PLAYER_ANGLE
    dec PLAYER_X
    ;bra @update_display
  @update_display:
    jsr RENDER_RAYCAST
    bra @check_keyboard

cleanup_and_exit:
   ; TODO - somehow reset to BASIC ? 

   ; restore default IRQ vector
   sei
   lda default_irq_vector
   sta IRQVec
   lda default_irq_vector+1
   sta IRQVec+1
   cli   
   jsr CINT
   rts

no_interrupt:
@check_keyboard:
   ; poll keyboard for input
   jsr GETIN
   cmp #0
   beq @check_keyboard
end:
  jsr CINT
  rts

RENDER_RAYCAST:
  stz VERA_addr_low
  stz VERA_addr_high
  lda #$10
  sta VERA_addr_bank
  lda PLAYER_Y
  asl a
  asl a
  asl a
  asl a
  clc 
  adc PLAYER_X
  tay
  stz ZP_PTR
  lda #BANKED_RAM_HIGH
  sta ZP_PTR+1
  ; do a ghetto raycast up/right
  @find_wall:
    tya
    sbc $10 ; up in y
    inc a ; go to right
    tay     
    lda (ZP_PTR),y
    beq @find_wall
  ldx #64
  @loop:
    sta VERA_data0
    dex
    BNE @loop
  rts


.org $A000 
SMALLTESTMAPDATA:
  ;     0    1  2   3   4   5   6   7   8   9   10  11  12  13  14  15 
  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
  .byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04
  .byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04
  .byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04
  .byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04
  .byte $02, $00, $00, $00, $00, $06, $05, $00, $00, $00, $00, $00, $00, $00, $00, $04
  .byte $02, $00, $00, $00, $00, $05, $06, $00, $00, $00, $00, $00, $00, $00, $00, $04
  .byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04
  .byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04
  .byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04
  .byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04
  .byte $02, $00, $00, $FF, $02, $03, $04, $05, $06, $07, $08, $09, $00, $00, $00, $04
  .byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04
  .byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04
  .byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04
  .byte $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03 
