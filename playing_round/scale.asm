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
VERA_isr          = $9F27
VSYNC_BIT         = $01

; VRAM Addresses
VRAM_layer0_map   = $00000
VRAM_layer1_map   = $1B000
VRAM_lowerchars   = $0B000
VRAM_lower_rev    = VRAM_lowerchars + 128*8
VRAM_petscii      = $1F000
VRAM_palette      = $1FA00
BITMAP_PAL_OFFSET = VERA_L0_hscroll_h

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
LAYER0_ONLY       = $11
LAYER01_ENABLE    = $31
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
ZP_PTR            = $30
INIT_COUNTER = 6
counter:             .byte INIT_COUNTER
scale_mode:          .byte 0
VSYNC_counter:       .byte 1
text_layer_offset_low: .byte 2
text_layer_offset_high: .byte 3
old_scale_mode:    .byte 1

custom_irq_handler:
   lda VERA_isr
   and #VSYNC_BIT
   beq @continue ; non-VSYNC IRQ, no tick update
   inc VSYNC_counter
   dec counter
   bne @continue
   ; counter down to zero, reset
   lda #INIT_COUNTER
   sta counter
   ; ok a second has passed, let's change the scaling based on mode..
   ldx scale_mode
   BEQ @continue
   txa 
   dex
   BEQ @SCALE_H_DEC
   dex
   BEQ @SCALE_H_INC
   dex
   BEQ @SCALE_V_DEC
   dex
   BEQ @SCALE_V_INC
   dex
   BEQ @SCALE_HV_DEC
   BRA @SCALE_HV_INC
@SCALE_H_DEC:
    dec VERA_dc_hscale
    BNE @continue
    BRA @next_mode
@SCALE_H_INC:
    inc VERA_dc_hscale
    BPL @continue
    BRA @next_mode
@SCALE_V_DEC:
    dec VERA_dc_vscale
    BNE @continue
    BRA @next_mode
@SCALE_V_INC:
    inc VERA_dc_vscale
    BPL @continue
    BRA @next_mode
@SCALE_HV_DEC:
    dec VERA_dc_hscale
    dec VERA_dc_vscale
    BNE @continue
    BRA @next_mode
@SCALE_HV_INC:
    inc VERA_dc_hscale
    inc VERA_dc_vscale
    BPL @continue
    stx scale_mode
    BRA @continue
@next_mode:
    inc a
@stash_mode:
  sta scale_mode
@continue:
    ;update Layer1 output stuff
    lda #<VRAM_layer1_map
    sta VERA_addr_low
    lda #(>VRAM_layer1_map+1)
    sta VERA_addr_high
    lda #($10 |^VRAM_layer1_map)
    sta VERA_addr_bank
    ldx #16
    ldy #32
    sty VERA_data0
    stx VERA_data0
    sty VERA_data0
    stx VERA_data0

    lda VERA_dc_hscale
    lsr a
    lsr a 
    lsr a 
    lsr a
    clc
    sbc #10
    BPL @h_scaleh_high_digit
  @h_scaleh_low_digit:
    adc #58
  @h_scaleh_high_digit:
    inc a
    sta VERA_data0
    stx VERA_data0
    lda VERA_dc_hscale
    AND #15
    clc
    sbc #10
    bpl @h_scalel_high_digit
    adc #58
  @h_scalel_high_digit:
    inc a
    sta VERA_data0
    stx VERA_data0

    sty VERA_data0
    stx VERA_data0
    sty VERA_data0
    stx VERA_data0

    lda VERA_dc_vscale 
    lsr a
    lsr a 
    lsr a 
    lsr a
    clc
    sbc #10
    BPL @v_scaleh_high_digit
    adc #58
  @v_scaleh_high_digit:
    inc a
    sta VERA_data0
    stx VERA_data0
    lda VERA_dc_vscale
    AND #15
    clc
    sbc #10
    BPL @v_scalel_high_digit
    adc #58
  @v_scalel_high_digit:
    inc a
    sta VERA_data0
    stx VERA_data0
   
   ; continue to default IRQ handler
   jmp (default_irq_vector)
   ; RTI will happen after jump


COPY_CHAR_FROM_ROM:
   ; Copy Lower/Upper character set from ROM (1kB) to VRAM
   lda #CHARSET_BANK
   sta ROM_BANK
   lda #<LOWER_UPPER
   sta ZP_PTR
   lda #>LOWER_UPPER
   sta ZP_PTR+1
   stz VERA_ctrl  ; Port 0: Standard glyphs copied from ROM
   lda #($10 | ^VRAM_lowerchars) ; Stride = 1
   sta VERA_addr_bank
   lda #>VRAM_lowerchars
   sta VERA_addr_high
   stz VERA_addr_low
   lda #1
   sta VERA_ctrl ; Port 1: Reverse glyphs inverted from ROM
   lda #($10 | ^VRAM_lower_rev) ; Stride = 1
   sta VERA_addr_bank
   lda #>VRAM_lower_rev
   sta VERA_addr_high
   lda #<VRAM_lower_rev
   sta VERA_addr_low
   ldx #4
   ldy #0
@copy_char_loop:
   lda (ZP_PTR),y
   sta VERA_data0 ; original pixel row
   eor #$FF
   sta VERA_data1 ; inverted pixel row
   iny
   bne @copy_char_loop
   inc ZP_PTR+1
   dex
   bne @copy_char_loop
   lda #BASIC_BANK
   sta ROM_BANK
   rts

start:
  ; start of program - init globals
  lda IRQVec
  sta default_irq_vector
  lda IRQVec+1
  sta default_irq_vector+1
  lda #INIT_COUNTER
  sta counter
  stz scale_mode
  ; configure video stuff
  stz VERA_dc_video   ; disable display
  ;lda #DISPLAY_SCALE_TWO ; set scale for bitmap mode
  ;sta VERA_dc_hscale
  ;sta VERA_dc_vscale
  lda #MODE_BITMAP_256BPP
  sta VERA_L0_config 
  lda #(VRAM_bitmap >> 9) ; 320 pixel wide bitmap
  sta VERA_L0_tilebase
  stz BITMAP_PAL_OFFSET ; palette offset 0
  ;configure text overlay
  lda #MODE_128x64_T256C
  sta VERA_L1_config
  lda #(VRAM_layer1_map >> 9)
  sta VERA_L1_mapbase
  lda #(VRAM_petscii>>9)
  sta VERA_L1_tilebase
  lda #<VRAM_layer1_map
  sta text_layer_offset_low
  lda #>VRAM_layer1_map
  sta text_layer_offset_high

  ; load the char set from ROM

  ; enable layers and start drawing
  stz VERA_ctrl
  lda #LAYER01_ENABLE
  sta VERA_dc_video



write_text_layer1:
  lda #($10 | ^VRAM_layer1_map) ; Stride = 1
  sta VERA_addr_bank  ; set bank byte for screen..
  lda text_layer_offset_high
  adc #3
  sta VERA_addr_high
  ldx #0
  ldy #16
  lda #16
  @text_loop_outer:
      pha   ; push outer counter
      lda #16
      stz VERA_addr_low
    @text_loop_inner:
        stx VERA_data0
        sty VERA_data0
        inx
        dec a
        BNE @text_loop_inner
      inc VERA_addr_high
      pla 
      dec a
      BNE @text_loop_outer

;  jmp endless

write_pal_stuff:
  lda #($10 | ^VRAM_bitmap) ; Stride = 1
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

  ; overwrite RAM IRQ vector with custom handler address
  sei ; disable IRQ while vector is changing
  lda #<custom_irq_handler
  sta IRQVec
  lda #>custom_irq_handler
  sta IRQVec+1
  lda #VSYNC_BIT ; make VERA only generate VSYNC IRQs
  sta VERA_ien
  cli ; enable IRQ now that vector is properly set

@start_stop:
  lda scale_mode
  beq @start_scale
@stop_scale:
  sta old_scale_mode
  stz scale_mode
  bra @check_keyboard
@start_scale:
  lda old_scale_mode
  sta scale_mode
@check_keyboard:
   ; poll keyboard for input
   jsr GETIN
   cmp #0
   beq @check_keyboard
   cmp #SPACE
   beq @start_stop
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

