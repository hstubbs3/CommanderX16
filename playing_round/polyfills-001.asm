.include "hfs_x16_stub_debug_font.inc"

ONE_OVER_X_HALVED_LOOKUPS_LOW:
.include "one_over_8bit_halved_17_15_low.inc"
ONE_OVER_X_HALVED_LOOKUPS_HIGH:
.include "one_over_8bit_halved_17_15_high.inc"
X_INC_H_TABLE:
.include "x_inc_h_32x.inc"
X_INC_L_TABLE:
.include "x_inc_l_32x.inc"

cursor_sprite:
  ;     0   1     2   3    4    5     6     7   8   9     A    B    C     D   E    F
  .byte   0,  24,  24,  24,  24,  24,  24,  24,  24,  24,  24,  24,   0,   0,   0,   0 
  .byte  24, 143, 143, 143, 143, 143, 143, 143, 143, 143,  24,   0,   0,   0,   0,   0
  .byte  24, 143, 143, 143, 143, 143, 143, 143, 143,  24,   0,   0,   0,   0,   0,   0
  .byte  24, 143, 143, 143, 143, 143, 143, 143,  24,   0,   0,   0,   0,   0,   0,   0
  .byte  24, 143, 143, 143, 143, 143, 143,  24,   0,   0,   0,   0,   0,   0,   0,   0
  .byte  24, 143, 143, 143, 143, 143, 143,  24,   0,   0,   0,   0,   0,   0,   0,   0
  .byte  24, 143, 143, 143, 143, 143, 143, 143,  24,   0,   0,   0,   0,   0,   0,   0
  .byte  24, 143, 143, 143,  24,  24, 143, 143, 143,  24,   0,   0,   0,   0,   0,   0
  .byte  24, 143, 143,  24,   0,   0,  24, 143, 143, 143,  24,   0,   0,   0,   0,   0
  .byte  24, 143,  24,   0,   0,   0,   0,  24, 143, 143, 143,  24,   0,   0,   0,   0
  .byte  24,  24,   0,   0,   0,   0,   0,   0,  24, 143, 143, 143,  24,   0,   0,   0
  .byte  24,   0,   0,   0,   0,   0,   0,   0,   0,  24, 143, 143, 143,  24,   0,   0
  .byte   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  24, 143, 143, 143,  24,   0
  .byte   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  24, 143, 143, 143,  24
  .byte   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  24, 143, 143,  24
  .byte   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  24,  24,  24 ; 16x16=256 bytes

marker_sprite_a:
  .byte 143, 143, 143, 143, 143, 143, 143, 143
  .byte 143,   0,   0,   0,   0,   0,   0,   0
  .byte 143,   0,   0,   0,   0,   0,   0,   0
  .byte 143,   0,   0,   0,   0,   0,   0,   0
  .byte 143,   0,   0,   0,   0,   0,   0,   0
  .byte 143,   0,   0,   0,   0,   0,   0,   0
  .byte 143,   0,   0,   0,   0,   0,   0,   0
  .byte 143,   0,   0,   0,   0,   0,   0,   0
marker_sprite_b:
  .byte 1, 1, 1, 1, 1, 1, 1, 1
  .byte 1,   0,   0,   0,   0,   0,   0,   0
  .byte 1,   0,   0,   0,   0,   0,   0,   0
  .byte 1,   0,   0,   0,   0,   0,   0,   0
  .byte 1,   0,   0,   0,   0,   0,   0,   0
  .byte 1,   0,   0,   0,   0,   0,   0,   0
  .byte 1,   0,   0,   0,   0,   0,   0,   0
  .byte 1,   0,   0,   0,   0,   0,   0,   0
marker_sprite_c:
  .byte 157, 157, 157, 157, 157, 157, 157, 157
  .byte 157,   0,   0,   0,   0,   0,   0,   0
  .byte 157,   0,   0,   0,   0,   0,   0,   0
  .byte 157,   0,   0,   0,   0,   0,   0,   0
  .byte 157,   0,   0,   0,   0,   0,   0,   0
  .byte 157,   0,   0,   0,   0,   0,   0,   0
  .byte 157,   0,   0,   0,   0,   0,   0,   0
  .byte 157,   0,   0,   0,   0,   0,   0,   0


.include "hfs_x16.inc"

.macro calc_x_over_y_halved ; diff y in y, sets VERA_FX_CACHE_L/M .. HU should get set for X diff to multiply.. xdiff assumed positive here...
  ; correct for 3+, 2 is close ... 0/1 borked. 
  ; returns x_inc in x,a ( x is low byte, a is high byte )
  ; 
  .local done_calced
    lda ONE_OVER_X_HALVED_LOOKUPS_LOW,y ; abs,y 4   11
    sta VERA_FX_CACHE_L ; 4   15
    lda ONE_OVER_X_HALVED_LOOKUPS_HIGH,y ; 4  19
    sta VERA_FX_CACHE_M ; 4 23 
    sta VERA_data1 ; 4  27  do the maths .. now read DATA0 twice to get result
    ldx VERA_data0 ; 4  31  get the low byte
    lda VERA_data0 ; 4  35  get the high byte 
    cmp #64  ;  2   37
    BMI done_calced  ; 2 39
    tay ; 2   41
    lda X_INC_H_TABLE,y ; 4   45 <- note, we're only fixing up inc_h here... 
    cmp #193 ; 2  47
    BPL done_calced ; 2   49 <- was negative so only little adjustment needed
    ldx X_INC_L_TABLE,y ; 4   53  <- fix low byte for 32x'd 
  done_calced: ;  40/50/54
.endmacro 


;	global data
default_irq_vector:  .addr 0
VSYNC_counter:       .byte 1
DONE_DONE:           .byte 0
CLICK_BOUNCE:        .byte 0
CLICK_MODE:          .byte 0
CURRENT_COLOR:       .byte 0
DEBUG_BUFFERA: 		 .byte $DE,$AD,$BE,$EF
DEBUG_STUFF: 		 .byte 0,0,0,0
DEBUG_BUFFERB: 		 .byte $DE,$AD,$BE,$EF

ZP_MOUSE = ZP_PTR+32

;VRAM addresses - 124K+ reserved for stuffs
VRAM_layer0_bitmap = $00000   ; note - first lines contain the debug font...
VRAM_MARKER_A = 320*240
VRAM_MARKER_B = VRAM_MARKER_A + 64
VRAM_MARKER_C = VRAM_MARKER_B + 64

VRAM_MARKER_A_X = VRAM_SPRITE_LIST+10
VRAM_MARKER_A_Y = VRAM_SPRITE_LIST+12
VRAM_MARKER_B_X = VRAM_SPRITE_LIST+18
VRAM_MARKER_B_Y = VRAM_SPRITE_LIST+20
VRAM_MARKER_C_X = VRAM_SPRITE_LIST+26
VRAM_MARKER_C_Y = VRAM_SPRITE_LIST+28

;tile map need to be 512 aligned.. 320x240 needs 40x30 map.. 64x32 map = 4k.. 
VRAM_layer1_map = 76*1024   ; yeah I is lazy
;tilebase needs to be 2K aligned
VRAM_layer1_tilebase = 80*1024

custom_irq_handler:
   lda VERA_isr
   and #VSYNC_BIT
   beq @continue ; non-VSYNC IRQ, no tick update
   inc VSYNC_counter
@continue:
   ; continue to default IRQ handler
   jmp (default_irq_vector)
   ; RTI will happen after jump

DO_CLICK_MODE:
   lda CLICK_BOUNCE
   beq @do_check_click
   lda ZP_MOUSE+4
   bne @done
   dec CLICK_BOUNCE
  @done:
    rts
@do_check_click: 
   lda ZP_MOUSE+4
   bne @clickmode_check_a
   rts
@clickmode_check_a:
   lda #2
   sta CLICK_BOUNCE
   lda CLICK_MODE
   bne @clickmode_check_b
   lda #1
   sta CLICK_MODE
   lda #10
   sta VERA_addr_low
   lda #>VRAM_SPRITE_LIST
   sta VERA_addr_high
   lda #(VRAM_INCREMENT_1 | ^VRAM_SPRITE_LIST)
   sta VERA_addr_bank  
   lda ZP_MOUSE
   sta ZP_PTR
   sta VERA_data0
   lda ZP_MOUSE+1
   sta ZP_PTR+1
   sta VERA_data0
   lda ZP_MOUSE+2
   sta ZP_PTR+2
   sta VERA_data0
   lda ZP_MOUSE+3
   sta ZP_PTR+3
   sta VERA_data0
   rts 
  @clickmode_check_b:
   cmp #1 
   bne @clickmode_check_c
   lda #2
   sta CLICK_MODE
   lda #18
   sta VERA_addr_low
   lda #>VRAM_SPRITE_LIST
   sta VERA_addr_high
   lda #(VRAM_INCREMENT_1 | ^VRAM_SPRITE_LIST)
   sta VERA_addr_bank  
   lda ZP_MOUSE
   sta ZP_PTR+4
   sta VERA_data0

   lda ZP_MOUSE+1
   sta ZP_PTR+5
   sta VERA_data0

   lda ZP_MOUSE+2
   sta ZP_PTR+6
   sta VERA_data0

   lda ZP_MOUSE+3
   sta ZP_PTR+7
   sta VERA_data0
   rts 
  @clickmode_check_c:
   stz CLICK_MODE
   lda #26
   sta VERA_addr_low
   lda #>VRAM_SPRITE_LIST
   sta VERA_addr_high
   lda #(VRAM_INCREMENT_1 | ^VRAM_SPRITE_LIST)
   sta VERA_addr_bank  
   lda ZP_MOUSE
   sta ZP_PTR+8
   sta VERA_data0
   lda ZP_MOUSE+1
   sta ZP_PTR+9
   sta VERA_data0
   lda ZP_MOUSE+2
   sta ZP_PTR+10
   sta VERA_data0
   lda ZP_MOUSE+3
   sta ZP_PTR+11
   sta VERA_data0
DO_POLYGON:
    rts

INIT:
  ; init vectors
  lda IRQVec
  sta default_irq_vector
  lda IRQVec+1
  sta default_irq_vector+1

  lda #<cursor_sprite
  sta ZP_PTR
  sta DEBUG_STUFF
  lda #>cursor_sprite
  sta ZP_PTR+1
  sta DEBUG_STUFF+1
  jsr ENABLE_MOUSE_CURSOR

  stz VERA_addr_low
  lda #3
  sta VERA_addr_high
  lda #VRAM_INCREMENT_1
  sta VERA_addr_bank
  ldx #247  ; 320x200 is 250*256 .. starting at 512 .. 
  ldy #0
  @clear_200_LINES_LOOP:
    @clear_200_lines_loop_inner:
        stz VERA_data0
        iny
        bne @clear_200_lines_loop_inner
      dex
      bne @clear_200_LINES_LOOP
  ldx #50   ; 320*40 is 50*256 
  @make_low_40_pattern:
    @make_low_40_pattern_inner:
        sty VERA_data0
        iny
        bne @make_low_40_pattern_inner
      sty VERA_data0
      dex
      bne @make_low_40_pattern
  ; VRAM already at markerA so and is OK to just write 256 bytes so.. 
  lda #<VRAM_MARKER_A
  sta VERA_addr_low
  lda #>VRAM_MARKER_A
  sta VERA_addr_high
  inc ZP_PTR+1
  @markers_loop:
      lda (ZP_PTR),y
      sta VERA_data0
      iny 
      bne @markers_loop

  ; setup layer 0 for bitmap..
  lda #DISPLAY_SCALE_TWO ; set scale for bitmap mode
  sta VERA_dc_hscale
  lda #54 ; setting up a 320x200 screen.. 
  sta VERA_dc_vscale
  lda #MODE_BITMAP_256BPP
  sta VERA_L0_config 
  stz VERA_L0_tilebase ; 320 pixel wide bitmap at top of memory

  ; setup sprite table entries for the markers.. put them under layer1 but over layer0 - $08 z-depth
  lda #8 ;  need sprite 1 entry
  sta VERA_addr_low
  lda #>VRAM_SPRITE_LIST
  sta VERA_addr_high
  lda #(VRAM_INCREMENT_1 | ^VRAM_SPRITE_LIST)
  sta VERA_addr_bank
  ldx #$08  ; z depth
  ; marker A - 8 bytes
  lda #((VRAM_MARKER_A >> 5) & $FF) ; markerA address low byte
  sta VERA_data0
  lda #($80 | (VRAM_MARKER_A >> 13)) ; markerA address high byte
  sta VERA_data0
  stz VERA_data0  ; markerA x low 
  stz VERA_data0  ; markerA x high
  stz VERA_data0  ; markerA y low 
  stz VERA_data0  ; markerA y high
  stx VERA_data0  ; markerA z-depth
  stz VERA_data0  ; markerA size/pal offset
  ; marker B - 8 bytes
  lda #((VRAM_MARKER_B >> 5) & $FF) ; markerA address low byte
  sta VERA_data0
  lda #($80 | (VRAM_MARKER_B >> 13)) ; markerA address high byte
  sta VERA_data0
  lda #16
  sta VERA_data0  ; markerA x low 
  stz VERA_data0  ; markerA x high
  sta VERA_data0  ; markerA y low 
  stz VERA_data0  ; markerA y high
  stx VERA_data0  ; markerA z-depth
  stz VERA_data0  ; markerA size/pal offset
  ; marker C - 8 bytes
  lda #((VRAM_MARKER_C >> 5) & $FF) ; markerA address low byte
  sta VERA_data0
  lda #($80 | (VRAM_MARKER_C >> 13)) ; markerA address high byte
  sta VERA_data0
  lda #32
  sta VERA_data0  ; markerA x low 
  stz VERA_data0  ; markerA x high
  sta VERA_data0  ; markerA y low 
  stz VERA_data0  ; markerA y high
  stx VERA_data0  ; markerA z-depth
  stz VERA_data0  ; markerA size/pal offset

  lda #LAYER0SPRITES_ENABLE
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

ENDLESS_LOOP:
  stz VSYNC_counter
  wai 
  lda VSYNC_counter
  beq ENDLESS_LOOP
  ; in VSYNC, check mouse
  ldx #ZP_MOUSE
  jsr MOUSE_GET
  sta ZP_MOUSE+4
  jsr DO_CLICK_MODE
  
 jsr GETIN
 beq ENDLESS_LOOP


END:
   ; restore default IRQ vector
   sei
   lda default_irq_vector
   sta IRQVec
   lda default_irq_vector+1
   sta IRQVec+1
   cli   
   jsr CINT

  rts 

