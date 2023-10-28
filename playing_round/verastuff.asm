.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

  jmp start

; VERA
VERA_addr_low     = $9F20
VERA_addr_high    = $9F21
VERA_addr_bank    = $9F22
VERA_data0        = $9F23
VERA_data1        = $9F24
VERA_ctrl         = $9F25
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
VERA_L0_tilebase  = $9F2F
;   Tile Base Address (16:11) | Tile Height 0-8/1-16 | Tile Width 0-8/1-16
VERA_L1_config    = $9F34 
VERA_L1_mapbase   = $9F35
VERA_L1_tilebase  = $9F36
VERA_L0_hscroll_h = $9F31

; VRAM Addresses
VRAM_layer1_map   = $1B000
VRAM_layer0_map   = $00000
VRAM_lowerchars   = $0B000
VRAM_lower_rev    = VRAM_lowerchars + 128*8
VRAM_petscii      = $1F000
VRAM_palette      = $1FA00
BITMAP_PAL_OFFSET = VERA_L0_hscroll_h

DISPLAY_SCALE_FOUR    = 32
DISPLAY_SCALE_TWO     = 64 ; 2X zoom
DISPLAY_SCALE_ONE     = 128 ; 640x480
MODE_BITMAP_256BPP = $07
MODE_BITMAP_16BPP  = $06
LAYER0_ONLY       = $11
VRAM_bitmap       = $04000

start:
  ; start of program
  stz VERA_dc_video   ; disable display
  lda #DISPLAY_SCALE_TWO ; set scale for bitmap mode
  sta VERA_dc_hscale
  sta VERA_dc_vscale
  lda #MODE_BITMAP_256BPP
  sta VERA_L0_config 
  lda #(VRAM_bitmap >> 9) ; 320 pixel wide bitmap
  sta VERA_L0_tilebase
  stz BITMAP_PAL_OFFSET ; palette offset 0
  lda #LAYER0_ONLY
  sta VERA_dc_video
  lda #^VRAM_bitmap   ; load the bank byte of VRAM bitmap
  adc #$10            ; set increment value
  sta VERA_addr_bank  ; set bank byte for screen..
  ldx #<VRAM_bitmap
  ldy #>VRAM_bitmap
  lda #240
  @outerloop:
    stx VERA_addr_low    ;  set VRAM address for the line
    sty VERA_addr_high    ;
    pha                 ; push loop counter
    lda #0               ; start with a zero for the loop..
    @innerloop:
      sta VERA_data0    ; write a pixel
      inc a             ; add 1
      BNE @innerloop    ; did write 256 pixels?
    txa               ; transfer x register to A
    clc
    ADC #64           ; add 64 ( carry should be 1 from loop...)
    tax               ; transfer a to X -> low byte of address
    tya               ; transfer y to a 
    adc #1            ; if x overflowed, adjusts Y .. combined adds 256 to the address to start next line
    tay               ; transfer high byte of the address .. 
    pla               ; pop our counter var
    dec a             ; decrement loop counter
    bne @outerloop    ; not done!
endless:
    bra endless       ; little endless loop to sit at.. 
  rts
