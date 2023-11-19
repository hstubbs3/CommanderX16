/*
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

    
