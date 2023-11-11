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

VERA_FX_TILEBASE = $9F2A
VERA_FX_MAPBASE = $9F2B

VERA_FX_X_INC_L = $9F29
VERA_FX_X_INC_H = $9F2A
VERA_FX_Y_INC_L = $9F2B
VERA_FX_Y_INC_H = $9F2C

VERA_FX_X_POS_L = $9F29
VERA_FX_X_POS_H = $9F2A
VERA_FX_Y_POS_L = $9F2B
VERA_FX_Y_POS_H = $9F2C

VSYNC_BIT         = $01

; VRAM Addresses
;   Address range Description
;   $00000 - $1F9BF Video RAM   - 129,424 bytes -> 126K is 129,024 (1F800)
;   $1F9C0 - $1F9FF PSG registers
;   $1FA00 - $1FBFF Palette
;   $1FC00 - $1FFFF Sprite attributes

; video output scaling to 320x161 ( 40 x 20 (mod8=1) 8x8 tiles)
VRAM_layer0_bitmapA  = $00000 ;  really visible area starts $00500 - 1.25K down...   
                              ; 320x120 for viewport is 37.5K - so viewA            1.25K   38.75K 
                              ; this needs to be on 2K boundary..  
VRAM_layer0_bitmapA_start = $00500

;   512 bytes slack here...
VRAM_layer0_bitmapB = $0A000 ;  viewB declares @38K to display starting 39.25 to 76.75  39.25   76.75
VRAM_layer0_bitmapB_start = $0A500
;   256 bytes slack here... 
VRAM_layer1_map     = $13400 ;  using 8x8 8bit for HUD and stuff 64x21x2=2688b declare at 77k     77k   80k    
VRAM_layer1_tiles   = $14000 ;  border HUD and font stuff - maybe 256 tiles         16k     80k to  96k 
; for testing this is initialized to use 1bit tile mode / 16 color 


;20k currently unused.. 


VRAM_floor_ceiling  = $1D000 ;  map/tile data for floor/ceiling...                  116k  116.5k 
                              ;wolf3d map was based on like 6 foot cubes? 
                              ; and floor on ships laid in 6,9,or 12 foot lengths.. 
                              ; will do 8x56 with a repeated tile to get 8x64 .. so use 8x8 map = 64 bytes + 7 8x8 tiles = 512bytes
floor_ceiling_map:
  .byte   1,1,4,3,1,1,4,3
  .byte   1,2,5,4,1,2,5,4
  .byte   2,3,6,5,2,3,6,5
  .byte   3,4,7,6,3,4,7,6
  .byte   4,5,1,7,4,5,1,7
  .byte   5,6,1,1,6,5,1,1
  .byte   6,7,2,1,6,7,2,1
  .byte   7,1,3,2,7,1,3,2
.include "floor_ceiling_8x56.inc"


VRAM_weapon_sprite  = $1D800 ; 64x64 8bit color for now .. prob go to 16 color..    118k
VRAM_cursor_sprite  = $1E7C0 ; 8x8 256 color sprite to make a cursor to track... stealing bottom line of weapon sprite... hehe
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

  ; init layer0 for use as 320 wide bitmap
  stz VERA_addr_low
  lda #>VRAM_layer0_bitmapA_start ;
  sta VERA_addr_high
  lda #($10 | ^VRAM_layer0_bitmapA_start) ;
  sta VERA_addr_bank
  ldx #120
  lda #0
  @clear_layer0_to_color:
    ldy #160
    @clear_320_byte_line:
      sta VERA_data0
      sta VERA_data0
      dey 
      bne @clear_320_byte_line
    inc a
    dex
    bne @clear_layer0_to_color

  stz VERA_addr_low
  lda #>VRAM_layer0_bitmapA_start ;
  sta VERA_addr_high
  lda #($10 | ^VRAM_layer0_bitmapA_start) ;
  sta VERA_addr_bank
  ; should zero it out out but for now drawing floor ceiling/floor data as test pattern
  lda #<floor_ceiling_map
  sta ZP_PTR
  lda #>floor_ceiling_map
  sta ZP_PTR+1
  ldx #2
  copy_bytes_to_vram_data0

  ; layer 0 config
  lda #MODE_BITMAP_256BPP
  sta VERA_L0_config
  stz VERA_L0_tilebase
  lda #$0f
  sta VERA_L0_VSCROLL_L
  lda #$00
  sta VERA_L0_VSCROLL_H

  stz VERA_L0_HSCROLL_L
  stz VERA_L0_HSCROLL_H

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

  ; initialize floor/ceiling stuff....
  stz VERA_addr_low
  lda #>VRAM_floor_ceiling
  sta VERA_addr_high
  lda  #($10 | ^VRAM_floor_ceiling)
  sta VERA_addr_high
  lda #<floor_ceiling_map
  sta ZP_PTR
  lda #>floor_ceiling_map
  sta ZP_PTR+1
  ldx #2
  copy_bytes_to_vram_data0


  ; enable layers and start drawing
  ;stz VERA_ctrl
  lda #LAYER01_ENABLE
  ;lda #LAYER0_ONLY ; for testing
  ;lda #LAYER1_ONLY
  ;lda #LAYERSPRITES_ONLY
  ;lda #LAYER01SPRITES_ENABLE
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
   stz VSYNC_counter

check_keyboard:
   wai
   ldy VSYNC_counter
   beq check_keyboard
   stz VSYNC_counter
   lda #$2   ; we're going to put VSYNC counter between HUD and viewport..
   sta VERA_addr_low
   lda #>VRAM_layer1_map+8
   sta VERA_addr_high
   lda #($20 | ^VRAM_layer1_map) ;
   sta VERA_addr_bank
   tya 
   lsr 
   lsr 
   lsr 
   lsr 
   sta VERA_data0
   tya 
   AND #$0F
   sta VERA_data0
   ; poll keyboard for input once per vsync
   jsr GETIN
   cmp #0
   beq check_keyboard
   cmp #SPACE
   beq do_mode7_test
   jmp do_cleanup

do_mode7_test:
   ;  add in mode7 draw thing here..

    stz ZP_PTR
    lda #>VRAM_layer0_bitmapA_start ; start a bit of the ways downscreen for now
    sta ZP_PTR+1
    lda #($10 | ^VRAM_layer0_bitmapA_start) ;
    sta ZP_PTR+2

   ;  configure FX_ctrl
   lda #%00000100    ; DCSEL=2, ADDRSEL=0
   sta VERA_ctrl
   stz VERA_dc_video
   lda #(VRAM_floor_ceiling >>9)
   sta VERA_FX_TILEBASE
   inc a ; add 1 to set FX tilemap size to 8x8
   sta VERA_FX_MAPBASE

   lda #%00000110    ; DCSEL=3, ADDRSEL=0
   sta VERA_ctrl
   stz VERA_FX_X_INC_L
   lda #2 ; incrementing x by 1 each time 
   sta VERA_FX_X_INC_H
   stz VERA_FX_Y_INC_L
   stz VERA_FX_Y_INC_H

   ldx #0
   @draw_row:
    lda #%00000110  ; DCSEL=3, ADDRSEL=0
    sta VERA_ctrl
    lda ZP_PTR+2
    sta VERA_addr_bank
    lda ZP_PTR+1
    sta VERA_addr_high
    lda ZP_PTR
    sta VERA_addr_low

    lda #%00001001   ; DCSEL=4, addrsel=0
    sta VERA_ctrl
    stz VERA_FX_X_POS_L
    stz VERA_FX_X_POS_H
    stx VERA_FX_Y_POS_L
    stz VERA_FX_Y_POS_H
    ldy #160
    @draw_2_pixel:
        lda VERA_data1
        sta VERA_data0
        lda VERA_data1
        lda VERA_data0
        dey
        bne @draw_2_pixel
    clc
    lda ZP_PTR
    adc #64
    sta ZP_PTR
    lda ZP_PTR+1
    adc #1
    sta ZP_PTR+1
    lda ZP_PTR+2
    adc #0
    sta ZP_PTR+2
    inx 
    cpx #120
    bne @draw_row
   stz VERA_ctrl ; clear fX mode

   jmp check_keyboard

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



