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

VRAM_layer0_mapA  = $00000      ; must be 512B aligned  32x32 assigned=2K actually using 32x16 only..1K   0   - 1k 
VRAM_layer0_tileA = $00000      ; must be 4K aligned - 25x14 x8x8 = 22,400B   21.875K actually starts at  1k  - 22.875k
VRAM_layer0_mapB  = $05C00      ; must be 512B aligned  32x32 assigned=2K actually using 32x16 only..1k   23k  - 24k
VRAM_layer0_tileB = $06000      ; must be 4K aligned              21.875K                                 24k  - 46K
VRAM_layer1_map   = $0B800      ; must be 512B aligned  32x32 assigned=2k uses 20 lines -> 1,280 used..   46k  - 48k
VRAM_layer1_tile  = $0C000      ; must be 4K aligned . 256*1bpp 8x8 = 2K max                              48K  - 50K 
VRAM_tex_cache_64 = $0C800      ; space for 64x64 textures.. 4x of these just in case..                   50k  - 66K
VRAM_tex_cache_48 = $10800      ; 48x48 textures - 2.25K each.. space for 8x .. 18K                       66k  - 84k
VRAM_tex_cache_32 = $15000      ; 32x32 textures - 1k each - space for 16x                                84k  - 100k
VRAM_tex_cache_24 = $19000      ; 16x16 textures 256k each - 32x=8k                                       100k - 108k
VRAM_UNRESERVED   = $1A000      ; 
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

; Kernal
CHROUT            = $FFD2
GETIN             = $FFE4

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

; global data
default_irq_vector:  .addr 0
VSYNC_counter:       .byte 1
ZP_PTR = $30

LAYER0A_MAPDATA:
LAYER0B_MAPDATA:

LAYER1_TILEDATA:
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
  .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %11111111, %11111111 ; filled line? - 19

LAYER1_MAPDATA:
  ; 32x32 but only populating 32x20
  ;     0         1       2         3       4         5         6       7         8       9       10        11      12          13        14    15
  .byte $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63 ;  
  .byte $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 0
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 1
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 2
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 3
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 4
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 5
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 6
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 7
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 8
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 9
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 10
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 10
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 12
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 13
  .byte $12,$63, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03  
  .byte $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $13,$03, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 14
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 16
  .byte $12,$63, $00,$00, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01 
  .byte $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 17
  .byte $12,$63, $00,$00, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01 
  .byte $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $01,$01, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 17
  .byte $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00
  .byte $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 18
  .byte $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63 ;  
  .byte $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $12,$63, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00 ; line 0

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
  stz VERA_addr_low
  lda #>VRAM_layer1_tile ;
  sta VERA_addr_high
  lda #($10 | ^VRAM_layer1_tile) ;
  sta VERA_addr_bank
  lda #<LAYER1_TILEDATA
  sta ZP_PTR
  lda #>LAYER1_TILEDATA
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
  lda #>VRAM_layer1_map
  sta VERA_addr_high
  lda #($10 | ^VRAM_layer1_map) ;
  sta VERA_addr_bank
  lda #<LAYER1_MAPDATA
  sta ZP_PTR
  lda #>LAYER1_MAPDATA
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
  lda #41 ; set scale for bitmap mode
  sta VERA_dc_hscale
  lda #40
  sta VERA_dc_vscale
  ; layer 0 config...
  lda #MODE_32x32_256BPP 
  sta VERA_L0_config 
  lda #(VRAM_layer0_tileA >> 9) ; 320 pixel wide bitmap
  sta VERA_L0_tilebase
  stz BITMAP_PAL_OFFSET ; palette offset 0
  ;layer 1 config
  lda #MODE_32x32_T16C
  sta VERA_L1_config
  lda #(VRAM_layer1_map >> 9)
  sta VERA_L1_mapbase
  lda #(VRAM_layer1_tile>>9)
  sta VERA_L1_tilebase
  lda #1 
  sta VERA_L1_HSCROLL_H
  sta VERA_L1_VSCROLL_H
  lda #6
  sta VERA_L1_HSCROLL_L
  sta VERA_L1_VSCROLL_L
  ; load initial tile data
  jsr INITIALIZE_VRAM_DATA;

  ; enable layers and start drawing
  stz VERA_ctrl
  ;lda #LAYER01_ENABLE
  ;lda #LAYER0_ONLY ; for testing
  lda #LAYER1_ONLY
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

  ; draw stuff

  ; main loop here... 
@check_keyboard:
   ; poll keyboard for input
   jsr GETIN
   cmp #0
   beq @check_keyboard
   cmp #SPACE
   bne @check_keyboard
   cmp #RETURN
   BNE @check_keyboard

cleanup_and_exit:
   ; restore default IRQ vector
   sei
   lda default_irq_vector
   sta IRQVec
   lda default_irq_vector+1
   sta IRQVec+1
   cli   
   lda #MODE_128x64_T16C
   sta VERA_L1_config
   rts

