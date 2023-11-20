.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

; just a quick test to try out filling polygons... 
; will use mouse to select 3 points to color in for testing..
; no double buffer, 320x240 8bit mode. 
; cycle colors through palette just cuz.. 

  jmp start

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
  stz VERA_dc_video   ; disable display
  lda #DISPLAY_SCALE_TWO ; set scale for bitmap mode
  sta VERA_dc_hscale
  sta VERA_dc_vscale
  lda #MODE_BITMAP_256BPP
  sta VERA_L0_config 
  lda #(VRAM_bitmap >> 9) ; 320 pixel wide bitmap

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

; 124k + 
VRAM_cursor_data  = $1F000      ; using through $1F1C0 only
VRAM_MATH_SCRATCH = $1F200      ; 2K of scratch = 512 multiplies
VRAM_palette      = $1FA00      ;  
VRAM_SPRITE_LIST  = $1FC00

BITMAP_PAL_OFFSET = VERA_L0_hscroll_h

DISPLAY_SCALE_FOUR    = 32
DISPLAY_SCALE_TWO     = 64 ; 2X zoom
DISPLAY_SCALE_ONE     = 128 ; 640x480
MODE_BITMAP_256BPP = $07
MODE_BITMAP_16BPP  = $06
LAYER0_ONLY       = $11
LAYER0SPRITES_ENABLE = $51
LAYER01SPRITES_ENABLE = $71
SPRITES_ONLY = $41
VRAM_bitmap       = $00000

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

; Kernal
CHROUT            = $FFD2
GETIN             = $FFE4
CINT              = $FF81
MOUSE_CONFIG      = $FF68
MOUSE_GET         = $FF6B
MOUSE_SCAN        = $FF71
; RAM Interrupt Vectors
IRQVec            = $0314

; global data

default_irq_vector:  .addr 0
VSYNC_counter:       .byte 1
DONE_DONE:           .byte 0
CLICK_BOUNCE:        .byte 0
CLICK_MODE:          .byte 0
CURRENT_COLOR:       .byte 0

ZP_MOUSE = $22
ZP_PTR = $27    ;   lowest left available to user
ZP_SCRATCH = $1F ;  highest Available to the user .. hopefully this doesn't hit ZP_PTR whatever you are doing...


VERA_SET_MULTIPLY = $10
VERA_RESET_ACCUMULATOR = $80

set_vera_for_single_multiplies  ;  allowing read of bytes 1,2 of each .. 
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
  rts ; 6?  so 66?

; FX should already be setup for multiply diff y is unsigned byte!
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

; x0,y0 through x2,y2 are each 2 bytes residing at ZP_PTR[:12]
; will only draw polygon with clockwise winding - so backface culling... ok 
DO_POLYGON:
    set_vera_for_single_multiplies ;  60+... jsr = 20 .. rts = 60 ! ooooo.. wow.. ok 

    ; first need to identify top most vertex
    lda ZP_PTR+2  ; 3   3   ZP_PTR+2/3 is y0 .. y>255 is invalid! so only need compare low bytes
    cmp ZP_PTR+6  ; 3   6   ZP_PTR+6/7 is y1 
    BMI @poly01_   ; 2   8
    BEQ @poly01_equaly ; 2  10
  @poly_10_: ;  10  a is y0
      cmp ZP_PTR+10 ; 3   13  ZP_PTR+10/11 is y2
      BMI @poly_102_ ; 2  15
      BEQ @poly_1_02_ ; 2 17
  @poly_12_0_: ; 17   need to sort 12 in y 
      lda ZP_PTR+6 ; 3  20
      cmp ZP_PTR+10 ; 3   23
      BMI @poly_120_ ; 2  25 y order established.  
      BEQ @poly_1e20_ ; 2  27 flat topped check winding 1->2
  @poly_210_ : ;  27  check x1<=x0 .. if x1>x0 exit.. 
      sec ;  2  29
      lda ZP_PTR ; 3  32  load x0L
      sbc ZP_PTR+4 ; 3 35 sub x1l 
      sta VERA_FX_CACHE_H ; 4  39
      lda ZP_PTR+1 ; 3  42 load X0H 
      sbc ZP_PTR+5 ; 3  45 sub x1H 
      bpl @poly_210_ok ; 2  47  winding checked
      rts 
    @poly_210_ok: ; 48
      sta VERA_FX_CACHE_U ; 4   52 
      ; calc y diff at bottom .. borrow is clear here.. so carry is already set
      lda ZP_PTR+2 ; 3  55  y0
      sbc ZP_PTR+6 ; 3  58  y1 ... is already known this is positive
      sta ZP_SCRATCH ; 3  61  ZP_SCRATCH = num bottom lines 
      tay ; 2   63  macro expects y in y.. 
      ; ZP_SCRATCH-4/3 - bottom left x_inc
      ; ZP_SCRATCH-2/1 - bottom right x_inc
      ; ZP_SCRATCH-0   - num bottom lines
      calc_x_over_y_halved ; ~48 53 worse case  ~116  a is x inc h, x is low byte 
      sta ZP_SCRATCH-3 ; 3  119   ZP_SCRATCH-3 = bottom left x_inc h 
      stx ZP_SCRATCH-4 ; 3  122   ZP_SCRATCH-4 = bottom left x_inc l 
      sec ; 2   124
      lda ZP_PTR+2 ; 3  127   y0 
      sbc ZP_PTR+10 ; 3 130   y2
      tay ; 2 132
      lda ZP_PTR ; 3  135   x0l 
      sbc ZP_PTR+8 ; 3 138  x2l 
      sta VERA_FX_CACHE_H ; 4 142
      lda ZP_PTR+1 ; 3  145   x0h
      sbc ZP_PTR+9 ; 3  148   x2h
      sta VERA_FX_CACHE_U ; 4   152
      calc_x_over_y_halved ; 53   205
      sta ZP_SCRATCH-1 ; 3  208   stash right x-increment to bottom/right
      stx ZP_SCRATCH-2 ; 3  211   
      sta ZP_SCRATCH-6 ; 3  214   stash right x-increment for top/right
      stx ZP_SCRATCH-7 ; 3  217   
      ; calc top left x-increment 
      sec ; 2   219
      lda ZP_PTR+6 ; 3  222   y1
      sbc ZP_PTR+10 ; 3  225   y2
      ; ZP_SCRATCH-12/11 start_x
      ; ZP_SCRATCH-10   start_y
      ; ZP_SCRATCH-9/8  top left x_inc
      ; ZP_SCRATCH-7/6  top right x_inc
      ; ZP_SCRATCH-5 - num top lines      
      sta ZP_SCRATCH-5 ; 3  228   num top lines 
      tay ; 2  230
      lda ZP_PTR+4 ; 3  233   x1l
      sbc ZP_PTR+8 ; 3  266   x2l
      sta VERA_FX_CACHE_H ; 4   270
      lda ZP_PTR+5 ; 3  273 x1h
      sbc ZP_PTR+9 ; 3  276   x2h 
      calc_x_over_y_halved ; 53   329
      sta ZP_SCRATCH-8 ; 3  332   stash top left x-increment
      stx ZP_SCRATCH-9 ; 3  335
      lda ZP_PTR+10 ; 3   338   y2
      sta ZP_SCRATCH-10 ; 3 341 start y
      lda ZP_PTR+9 ; 3  344   
      sta ZP_SCRATCH-11 ; 3 347 start x H 
      lda ZP_PTR+8 ; 3 350
      sta ZP_SCRATCH-12 ; 3 353 start X L 
      jmp POLYGON_DO_TOP_FILL ; 6   359
  @poly01_: ; 9 
  @poly01_equaly: ; 12 01 is flat top or bottom?
  @poly_102_: ; 16  check x0<x2 
  @poly_1_02_ ; 18  flat bottomed, check x0<x2
  @poly_120_: ; 26  y order established. check x0<x2 
  @poly_1e20_: ; 28 flat topped, check x1<x2

DONE_POLYGON:
  inc CURRENT_COLOR ; 6
  rts

POLYGON_DO_TOP_FILL:
POLYGON_SWAP_DO_BOTTOM_FILL:
  jmp DONE_POLYGON

start:
  ; start of program
  stz VERA_dc_video   ; disable display

  ; init vectors
  lda IRQVec
  sta default_irq_vector
  lda IRQVec+1
  sta default_irq_vector+1

  lda #DISPLAY_SCALE_TWO ; set scale for bitmap mode
  sta VERA_dc_hscale
  sta VERA_dc_vscale
  lda #MODE_BITMAP_256BPP
  sta VERA_L0_config 
  stz VERA_L0_tilebase ; 320 pixel wide bitmap at top of memory
 

  stz VERA_addr_low
  lda #>VRAM_cursor_data
  sta VERA_addr_high
  lda #(VRAM_INCREMENT_1 | ^VRAM_cursor_data)
  sta VERA_addr_bank

  lda #<cursor_sprite ; low 
  sta ZP_PTR ;
  lda #>cursor_sprite ; high
  sta ZP_PTR+1 ;
  ldy 0 ;
  stz VERA_data0
  @cursor_data_loop:
      lda (ZP_PTR),y
      sta VERA_data0
      iny 
      bne @cursor_data_loop
  ldy 0 ;
  inc ZP_PTR+1
  stz VERA_data0
  @markers_loop:
      lda (ZP_PTR),y
      sta VERA_data0
      iny 
      bne @markers_loop

  stz VERA_addr_low
  lda #>VRAM_SPRITE_LIST
  sta VERA_addr_high
  lda #(VRAM_INCREMENT_1 | ^VRAM_SPRITE_LIST)
  sta VERA_addr_bank  
  ; mouse pointer
  lda #((VRAM_cursor_data >> 5) & $FF )
  sta VERA_data0  ; low address
  lda #($80 | (VRAM_cursor_data >> 13)) ; high address, 8bit sprite 
  sta VERA_data0 
  stz VERA_data0 ; x low  VRAM_SPRITE_LIST + 2
  stz VERA_data0 ; x high
  stz VERA_data0 ; y low
  stz VERA_data0 ; y high 
  lda #$0C
  sta VERA_data0 ; z-depth/flips
  lda #$50
  sta VERA_data0 ; sprite width/height
  ; marker A 
  lda #(((VRAM_cursor_data + 256) >> 5) & $FF )
  sta VERA_data0  ; low address
  lda #($80 | (VRAM_cursor_data >> 13)) ; high address, 8bit sprite 
  sta VERA_data0 
  stz VERA_data0 ; x low  VRAM_SPRITE_LIST + 2
  stz VERA_data0 ; x high
  stz VERA_data0 ; y low
  stz VERA_data0 ; y high 
  lda #$0C
  sta VERA_data0 ; z-depth/flips
  stz VERA_data0 ; 8x8 sprite 

  ; marker B 
  lda #(((VRAM_cursor_data + 320) >> 5) & $FF )
  sta VERA_data0  ; low address
  lda #($80 | (VRAM_cursor_data >> 13)) ; high address, 8bit sprite 
  sta VERA_data0 
  stz VERA_data0 ; x low  VRAM_SPRITE_LIST + 2
  stz VERA_data0 ; x high
  stz VERA_data0 ; y low
  stz VERA_data0 ; y high 
  lda #$0C
  sta VERA_data0 ; z-depth/flips
  stz VERA_data0 ; 8x8 sprite 

  ; marker C 
  lda #(((VRAM_cursor_data + 384) >> 5) & $FF )
  sta VERA_data0  ; low address
  lda #($80 | (VRAM_cursor_data >> 13)) ; high address, 8bit sprite 
  sta VERA_data0 
  stz VERA_data0 ; x low  VRAM_SPRITE_LIST + 2
  stz VERA_data0 ; x high
  stz VERA_data0 ; y low
  stz VERA_data0 ; y high 
  lda #$0C
  sta VERA_data0 ; z-depth/flips
  stz VERA_data0 ; 8x8 sprite 

  ; turn the mouse cursor on.. 
  lda #$FF
  jsr MOUSE_CONFIG
  ; jsr wait_keypress

  stz VERA_addr_low
  stz VERA_addr_high
  lda #VRAM_INCREMENT_1
  sta VERA_addr_bank
  ldx 0
  @clear_VRAM_OUTER:
    ldy 0
    @clear_VRAM_inner:
      stz VERA_data0
      iny 
      bne @clear_VRAM_inner
    inx
    bne @clear_VRAM_OUTER

  lda #LAYER0SPRITES_ENABLE
  ;lda #SPRITES_ONLY
  sta VERA_dc_video

  ; jsr wait_keypress

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

  ; jsr wait_keypress

ENDLESS_LOOP:

   wai 
   lda VSYNC_counter
   beq ENDLESS_LOOP
   stz VSYNC_counter
   jsr DO_CLICK_MODE
   jsr GETIN
   beq ENDLESS_LOOP

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

wait_keypress:
   wai
   jsr GETIN
   beq wait_keypress
   rts

custom_irq_handler:
   lda VERA_isr
   and #VSYNC_BIT
   beq @continue ; non-VSYNC IRQ, no tick update
   inc VSYNC_counter
   ;jmp (default_irq_vector)

@check_mouse:
   ;jsr MOUSE_SCAN
   ldx #ZP_MOUSE
   jsr MOUSE_GET
   sta ZP_MOUSE+4
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
   jsr DO_POLYGON 
   rts 

DO_POLYGON_OLD:
  stz VERA_addr_low
  stz VERA_addr_high
  lda #VRAM_INCREMENT_64
  sta VERA_addr_bank
  lda CURRENT_COLOR
  sta VERA_data0
  sta VERA_data0
  sta VERA_data0
  sta VERA_data0
  sta VERA_data0
  sta VERA_data0
  sta VERA_data0
  sta VERA_data0
  sta VERA_data0
  sta VERA_data0
  sta VERA_data0
  sta VERA_data0
  sta VERA_data0
  sta VERA_data0
  sta VERA_data0
  sta VERA_data0
  inc CURRENT_COLOR
  rts

; put the lookups at top of available memory.. mainly is to align
.res $09B00-* ;  we have from 
ONE_OVER_X_HALVED_LOOKUPS_LOW:
.include "one_over_8bit_halved_17_15_low.inc"

.res $09C00-* ;  we have from 
ONE_OVER_X_HALVED_LOOKUPS_HIGH:
.include "one_over_8bit_halved_17_15_high.inc"

.res $09D00-* ;  we have from 
X_INC_H_TABLE:
.include "x_inch_h_32x.inc"

.res $09E00-* ;  we have from 
X_INC_H_TABLE:
.include "x_inch_l_32x.inc"

.end






/
*
given polygon with 8bit screen verts in ZP locations X0,X1,X2,Y0,Y1,Y2

pushing to ZP locations TOP_X,TOP_Y,LEFT_X,RIGHT_X,MID_Y,BOTTOM_Y
TOP_LINES,BOTTOM_LINES,LONG_LINES
LEFT_SLOPE_TOP,RIGHT_SLOPE,BOTTOM_SLOPE
*/
;first need to identify top vert
  lda Y0 ; 3
  cmp Y1 ; 3   6
  BMI @y0_y1 ; 2/3 8/9
  BEQ @y0_eq_y1 ; 2/3 10/11
@y1_l_y0: ; 10
  cmp Y2 ; 3   13
  BMI @y1_y0_y2 ; 2   15/16   y order is solidified 102 
  BEQ @y1_l_y0_eq_y2 ; 2/3   17/18 Y1 is top, y0=y2 so flat bottom
@y1_y2_l_y0: 17 ... need to sort y1/y2
  sta BOTTOM_Y ; 3   20   well.. at least that's stashed? 
  lda Y1 ; 3   23
  cmp Y2 ; 3   26
  BMI @y1_y2_y0 ; 2/3   28/29   y order solidified 120
  BEQ @y1_eq_y2_l_y0 ; 2/3 30/31  flat topped 120
@y2_y1_y0: ;  30   order solidified as 210
  sta MID_Y ; 3   33   MID_Y and bottom_Y now filled in
  lda X2 ; 3 36
  sta TOP_X ; 3 39
  lda Y2 ; 3 42
  sta TOP_Y ; 3 45   all 3 Y filled in
  lda X1 ; 3 45
  cmp X0 ; 3 48   find which is left/right
  bmi @y2_y1_y0_x1left ; 2/3 50/51
@y2_y1_y0_x1right: ; 50
  sta RIGHT_X ; 3   53
  lda X0 ; 3   56
  sta LEFT_X ; 3   59
  bra @short_left_side ; 3 62

@short_left_side:
  ; setup starting position...
  ldx TOP_Y ; 3 
  ldy ABS,x ; 4  get low byte for the line start
  sty VERA_ADDR_LOW ; 4
  ldy ABS,X ; 4 get high byte for the line start
  sty VERA_ADDR_HIGH ; 4 
  ldy ABS,X ; 4 get the bank/incrementer setup for line start
  sty VERA_ADDR_BANK ; 4
  tay ; 2 ... LONG_LINES shoved into Y for later...
  lda TOP_X ; 3   
  sta FX_POS_X_L ; 4 
  sta FX_POS_Y_L ; 4
  ; calculate length / slope for left side / top 
  sec ; 2
  lda MID_Y ; 3 
  sbc TOP_Y ; 3   
  sta TOP_LINES ; 3
  tax ; 2
  ; slope calcumalator - 
  AND #%11111000
  sta SLOPE_LOOKUP ; 2
  sec ; 2
  lda TOP_X ; 3
  sbc LEFT_X ; 3 
  ; ok want to make a + LEFT_SLOPE_TOP_L into useable lookup address for slope.. using 4k table
  ; so 1bit sign 10bits .. 5bits of X / 5 bits of Y 256*4=1024*2=2048*2 bytes/word = 4K 
  lsr a ; 2 lose bottom bit of X... sign +6 _sxxxxx0
  lsr a ; 2 ; sign +5  __sxxxxx
  ror SLOPE_LOOKUP ; 5  shift bottom of X into the y - ___sxxxx xyyyyy00
  lsr a ; 2 ; sign +4 bit
  ror SLOPE_LOOKUP ; 5 shift bottom of X into the y  - ____sxxx xxyyyyy0 16*256=4K table.. ok
  ORA #<SLOPE_LOOKIE_TABLE
  STA SLOPE_LOOKUP+1 ; 4
  ldy #0 ; 2
  lda (SLOPE_LOOKUP),y
  STA FX_X_INCREMENT_L
  iny ; 2
  lda (SLOPE_LOOKUP),y
  STA FX_X_INCREMENT_H

  ; calc lines and slope for left / bottom
  lda BOTTOM_Y ; 3
  sec ; 2
  sbc MID_Y ; 3
  sta BOTTOM_LINES
  adc TOP_LINES
  ; have length for long side .. do repeat of above to calc slope2 and put to increment.. 

  ; OK run top lines..  
  ldy color_to_draw
  ldx TOP_LINES
  clc ; 2
  @sl_top_lines_loop:
    lda DATA1 ; 4   doesn't return anything useful just sets ADDR1 to ADDR0+X1 
    lda FILL_LENGTH_LOW ; 4 8
    BPL @TOP_FILL_LESS_THAN_16 ; 2/3    10/11
    lda FILL_LENGTH_HIGH ; 4 14
    cmp #$C0 ; 2 16
    BPL @sl_NO_TOP_FILL ; 2/3 18/19
    @sl_top_lines_fill_loop:
      sty DATA1
      sty DATA1
      sty DATA1
      sty DATA1
      sty DATA1
      sty DATA1
      sty DATA1
      sty DATA1
      sbc #1 ; 2 subtracts 2 because reasons... 
      BNE @top_lines_fill_loop ; 2/3 - 8*4+2+3=37 cycles per 8 pixels = 4.625 a pixel.. entire 192x128 screen in ~123k cycles?
    lda FILL_LENGTH_LOW
    AND #14
    BEQ @sl_NO_TOP_FILL
  @sl_TOP_FILL_LESS_THAN_16:
      sty DATA1 ;2 
      sbc #1 ; 2 
      BNE @sl_TOP_FILL_LESS_THAN_16
  @sl_NO_TOP_FILL:
    lda DATA0
    dex
    BNE @sl_top_lines_loop
; load increment for bottom section
bra do_bottom_bits
short_right_side: ; hmm.. maybe won't end up being within range of the brancher.. will probably becaome jump targets.. 

do_bottom_bits:


/* using a jump table would be a little weird.. would want to push a return value to the next thing ? 
   possibly ends up as self-modifying code.. 

   so have jump table to do like entire row of pixels... 192x128 was suggested resolution...

   sta DATA1 is 3 byte instruction.. 576 bytes to do the row in 1 shot... solidly 4 cycles/pixel + the overhead..

   well, return would always be to same place just have the jump table 3 times for top left / top right and bottom...
   or status flag to switch between... ? 

   then reading the fill value part is like this 
    lda FILL_LENGTH_LOW ; 4 
    BPL @TOP_FILL_LESS_THAN_16 ; 2/3    6/7
    asl a ; 
    asl a ; 
    asl a ;
    asl a ; 4.0.3    14
    EOR #$F0 ; 2   16    negate the number by flip bits add 1 
    ; quick check here - 0000 -> 1111 15 0001 1110 14 0010 2 1101 13 0100 4 1011 11 1000 8 0111 7 ok cool..  
    clc ; clear carry! 
    adc #$10 ; because reasons 
    ; quick check here - 1111 -> 0000 0-> .. 1110 14 -> 1111 -1... OK
    sta FILL_JUMPER ; 3   17
    lda FILL_LENGTH_HIGH ; 4 21
    cmp #$C0 ; 2 23
    BPL @sl_NO_TOP_FILL ; 2/3 25/26
    ; oops adc #1 ; 2 if there was a carry from the adc #$10 before, this will increase the high byte....   
    ; so if it was 0000 originally.. became 15 carry 1 ... only zero carries through.. should it ripple next byte?
    ; say original number is 16..  0x10 .. do EOR + 1 nibble by nibble... 
    ; 0001 0000
    ; 1110 1111
    ; 1111 0000 <- this is neg 16 no add..  
    lsr a ; 2   27  _9876543 ; hopefully this isn't wider than our screen? maybe them 320 pixel wide bitmaps aren't so bad?
    EOR #$1F ; 2 flip the bitties neg.. 9 and 8 should be zero.. screen is only 192 wide ! (should clip polys somewhere.... )
    clc
    adc #1 ; ok is all negated see where we at. .
    lsr a ; 2   29  __987654
    lsr a ; 2   31  ___98765
    ror FILL_JUMPER ; 5 36  ___98765 43210___
    lsr a ; 2   38  ____9876 5
    ror FILL_JUMPER ; 5  43 ____9876 543210__
    lsr a ; 2   45  _____987 6
    ror FILL_JUMPER ; 5 50  _____987 6543210_
    lsr a ; 2   52  ______98 7 
    ror FILL_JUMPER ; 5 57  ______98 76543210
    ; for 192, should only be through bits 7 setup.. and that's all we have in the jump table so cap here.. 
    stz FILL_JUMPER+1 ; 3 60 ; all the evil bits should be in the low bite.. hehe
    ;  double check logic.. if given 192 to fill.. 00 1100 0000 pixels to fill.. 
    ;  ignore 98... 1100 0000 only.. EOR'd 0011 1111 +1'd -> 0100 0000 <- 64
    ;  we'll have to add the actual 16bit jump target later.. so here we can leave this alone and use magic number minus 192 later..  
    ;  we do need to mul by 3 though... 
    lda FILL_JUMPER ; 3   63        load that 64 baby! 
    asl a ; 2 65                     128
    rol FILL_JUMPER+1 ; 5  70         no carry, still zero ... no carry out either..
    adc FILL_JUMPER ; 3 73           128+64 = 192
    sta FILL_JUMPER ; 3 76           stashed
    lda FILL_JUMPER+1 ; 3 79
    adc #0 ; 2 81
    sta FILL_JUMPER+1 ; 3 84   1x +2x = 3x ... 
    lda #>fill_jump_base ; 2 86
    adc FILL_JUMPER ; 3 89
    sta FILL_JUMPER ; 3 92
    lda #<fill_jump_base ; 2 95
    adc FILL_JUMPER+1 ; 3 97
    sta FILL_JUMPER+1 ; 3 100
    jmp (FILL_JUMPER) ; 6 106 

    ; the return jump could use similar to get back... is like per line setup here of 110 cycles ... is no savings over the 8 up before.. 

    needs to be jump to jump.. no fiddling.. 
    after 25 cycles, we haz fill_length_high in acc as 9876 543_ ..
    use that to trampoline, deal with those last 7 or so later... 
    tax ; 2 27
    lda #>next_row ; 2 29 
    sta ZP_return ; 3 32
    lda #<nex_trow ; 2 34
    sta ZP_return ; 3 37
    jmp (fill_trampoline),x ; 6 43   away we go!!!  ... overhead of 43 for worse case 16 = ~3 cycles/pixel .. parity at 68.8 px ...?
    ; maybe not even worth it.. drawing is already pretty gud...  
  next_row:
  ......

fill_trampoline: 
    jmp do_fill_machine + 576
    jmp do_fill_machine + 573 
    ....
    jmp do_fill_machine + 0

    
