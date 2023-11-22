.include "hfs_x16_stub.inc"

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

custom_irq_handler:
   lda VERA_isr
   and #VSYNC_BIT
   beq @continue ; non-VSYNC IRQ, no tick update
   inc VSYNC_counter
@continue:
   ; continue to default IRQ handler
   jmp (default_irq_vector)
   ; RTI will happen after jump

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

  lda #LAYER01SPRITES_ENABLE
  sta VERA_dc_video

ENDLESS_LOOP:
  wait_keypress
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

