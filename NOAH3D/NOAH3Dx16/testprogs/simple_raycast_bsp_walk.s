; Wolf3D style BSP walk.. level is 64x64 tiles in 1/4th tile increments
; reserve Zero Page space during rendering - $0022-$007F  Available to the user
; will need to determine which to use , but can make it movable.. 
.ifndef BSP_ZP_START
  BSP_ZP_START = $22
.endif
; BSP_stack uses only 128 entries because seriously how complicated should a level be? adds 1 cycle if page crossed..
; these are all conditionally defined so that the calling application can redefine these in low-RAM. 

; eventually will use call-back pointers so this code can be reused for tracing bullets and stuff. . need to consider code size.. 
.ifndef BSP_STACK_LOW
BSP_STACK_LOW:
.res 128
.endif
.ifndef BSP_STACK_HIGH
BSP_STACK_HIGH:
.res 128
.endif
.ifndef TEXTURES_LOW
TEXTURES_LOW:
.res 256
.endif
.ifndef TEXTURES_HIGH
TEXTURES_HIGH:
.res 256
.endif
.ifndef TEXTURES_BANK
TEXTURES_BANK:
.res 256
.endif
.ifndef PVS_BYTE_LOOKIES
PVS_BYTE_LOOKIES:
  .res 8,0
  .res 8,1
  .res 8,2
  .res 8,3
  .res 8,4
  .res 8,5
  .res 8,6
  .res 8,7
  .res 8,8
  .res 8,9
  .res 8,10
  .res 8,11
  .res 8,12
  .res 8,13
  .res 8,14
  .res 8,15
  .res 8,16
  .res 8,17
  .res 8,18
  .res 8,19
  .res 8,20
  .res 8,21
  .res 8,22
  .res 8,23
  .res 8,24
  .res 8,25
  .res 8,26
  .res 8,27
  .res 8,28
  .res 8,29
  .res 8,30
  .res 8,31
.endif
.ifndef PVS_BIT_LOOKIES
PVS_BIT_LOOKIES:
  .repeat 32  
    .byte 1,2,4,8,16,32,64,128
  .endrepeat   
.endif
; BSP tree itself must fit somewhere in memory without needing bank switching - either within a bank or occupying low ram
.addr BSP_START

; BSP format for WOLF3D
; SPLITNODE
; 0     BYTE  FLAG_JUMP - determines type of thing... 
; 1     BYTE  MAIN_AXIS
; 2     BYTE  BOUND_BOX_MIN_MAIN
; 3     BYTE  MINOR_AXIS_MIN_MIN
; 4     BYTE  MINOR_AXIS_MIN_MAX
; 5/6   ADDR  MIN_CHILD
; 7/8   ADDR  MAX_CHILD
; 9     BYTE  MINOR_AXIS_MAX_MAX
; 10    BYTE  MINOR_AXIS_MAX_MIN
; 11    BYTE  BOUND_BOX_MAX_MAIN
; splitnode w/ bound checks - 14 bytes
;
; Improved SPLITNODE - because LEAFNODES in PVS anyway ... 
; 0     BYTE  FLAG_JUMP - determines type of thing... 
; 1     BYTE  MAIN_AXIS
; 2/3   ADDR  MIN_CHILD
; 4/5   ADDR  MAX_CHILD
; 6 bytes per splitnode .. at 6 bytes splitnode, 2 bytes leafnode 1 byte end_list and 6 bytes for a wall seg... 
; say 6 bytes / element - 8K banked = >1000 elements .. maybe PVS won't have to be banked? may not even be 256 PVS area
; LEAFNODE
;  0    BYTE  FLAG_JUMP - determines type of thing
;  1    BYTE  AREA - used for sound, tracking connected areas.. nav meshing? PVS, whatever.. 
;  2    childs list of segments and stuff starts here... 
;
; WALL
; 0     BYTE  FLAG_JUMP - determines type of thing... 
; 1     BYTE  MAIN_AXIS
; 2     BYTE  LEFT
; 3     BYTE  RIGHT
; 4     BYTE  TEXTURE
; 5     BYTE  TAGS
;
; DOOR
; 0     BYTE  FLAG_JUMP - determines type of thing... 
; 1     BYTE  MAIN_AXIS
; 2     BYTE  MIN
; 3     BYTE  MAX
; 4     BYTE  STATE
; 5     BYTE  TEXTURE
; 6     BYTE  AREA_MIN
; 7     BYTE  AREA_MAX
;
; DECORATION
; 0     BYTE  FLAG_JUMP - determines type of thing... 
; 1     BYTE  X_POS
; 2     BYTE  Y_POS
; 3     BYTE  TYPE_STATE

ZP_BSP_STACK_PTR = BSP_ZP_START ; address  2   1
ZP_BSP = BSP_ZP_START+1   ; address   2     3
ZP_BSP_NEXT = BSP_ZP_START+3   ; address   2   5   holds address for 'next' pointer... 
ZP_PLX = BSP_ZP_START+5   ; byte      1     6   "PLAYER" position - really camera
ZP_PLX_SUB = BSP_ZP_START+6 ; byte    1     7
ZP_PLY = BSP_ZP_START+7   ; byte      1     8
ZP_PLY_SUB = BSP_ZP_START+8 ; byte    1     9
ZP_PVS_POINTER = BSP_ZP_START+9 ; address 2   11
ZP_PLAYER_HEIGHT = BSP_ZP_START+11 ; BYTE   1   12
ZP_BSP_PVS_BANK = BSP_ZP_START+12 ;   BYTE  1   13
ZP_BSP_RAM_BANK = BSP_ZP_START+13 ;   BYTE  1   14
ZP_VISIBLE_OCTANTS = BSP_ZP_START+14 ; BYTE 1   15
ZP_VIEW_ANGLE = BSP_ZP_START+15 ;   BYTE  1   16
ZP_BSP_LX = BSP_ZP_START+16 ;   BYTE  1   17
ZP_BSP_LY = BSP_ZP_START+17 ;   BYTE  1   18
ZP_BSP_RX = BSP_ZP_START+18 ;   BYTE  1   19
ZP_BSP_RY = BSP_ZP_START+19 ;   BYTE  1   20
ZP_BSP_MATH_TEMP = BSP_ZP_START+20 ; BYTE   4   24

.macro SWITCH_TO_ZP_BSP_NEXT
    LDA ZP_BSP_NEXT  ; 3   3
    STA ZP_BSP  ; 3   6
    LDA ZP_BSP_NEXT+1 ; 3  9
    STA ZP_BSP+1 ; 3  12
.endmacro

.macro WALK_BSP
    LDY #1          ; 2   2   
    LDA (ZP_BSP)  ; 5   7
    TAX             ; 2   9 
    JMP (WALK_BSP_JUMPTABLE,x) ; 6  15
.endmacro

.macro WALK_SEGMENT 
  LDA (ZP_BSP),y  ; 5   5   ; set y and ZP_BSP correctly! 
  TAX             ; 2   7
  INY             ; 2   9
  JMP (WALK_SEGMENT_JUMPTABLE,x) ; 6  15
.endmacro


; prepare to do walk, create back-stack, identify current node for PVS
READ_WALK_BSP_FIND_LEAF:
  LDA #<DO_LEAFNODE_PREP
  STA WALK_BSP_JUMPTABLE+2
  LDA #>DO_LEAFNODE_PREP
  STA WALK_BSP_JUMPTABLE+3
READY_WALK_BSP:
  stz ZP_BSP_STACK_PTR  ; if stack ptr becomes neg we overflow .. 
  stz ZP_BSP_B
  stz ZP_BSP_B
  lda BSP_START   
  sta ZP_BSP
  lda BSP_sTART+1
  sta ZP_BSP+1
  WALK_BSP

WALK_BSP_JUMPTABLE:
  .addr DO_LEAFNODE             ; 0000 0010
  .addr DO_SPLITNODE_X          ; 0000 0100
  .addr DO_SPLITNODE_Y          ; 0000 0110

WALK_SEGMENT_JUMPTABLE:
  .addr POP_BSP_STACK           ; 0000 0000   really is END_SEGMENTS but ya know OK 
  .addr DO_SEGMENT_X_FACE_MIN   ; 0000 1000
  .addr DO_SEGMENT_X_FACE_MAX   ; 0000 1010
  .addr DO_SEGMENT_Y_FACE_MIN   ; 0000 1100
  .addr DO_SEGMENT_Y_FACE_MAX   ; 0000 1110
  .addr DO_DOOR_VERTICAL        ; 0001 0000
  .addr DO_DOOR_HORIZONTAL      ; 0001 0010
  .addr DO_DECORATION           ; 0001 0100 
;   .addr DO_SPLITNODE_FORTYFIVE  ; 0000 0110
;  .addr DO_SPLITNODE_X_MAJOR    ; 0000

DO_LEAFNODE_PREP:
    LDA (ZP_BSP),Y            ;   5   5   grab the PVS value
    STZ ZP_PVS_POINTER        ;   3   8
    LSR A                     ;   2   10
    ROR ZP_PVS_POINTER        ;   5   15  C
    LSR A                     ;   2   17
    ROR ZP_PVS_POINTER        ;   5   22  CC
    LSR A                     ;   2   24
    ROR ZP_PVS_POINTER        ;   5   29  CCC
    ORA #$A0                  ;   2   31
    STA ZP_PVS_POINTER+1      ;   3   34  vs 42 sliding the other way.. otay. 
    LDA #<DO_LEAFNODE         ;   2   36
    STA WALK_BSP_JUMPTABLE+2  ;   4   40
    LDA #>DO_LEAFNODE         ;   2   42
    STA WALK_BSP_JUMPTABLE+3  ;   4   46
    ; groovy PVS configured, jumptable patched..  we are at first leaf ready to trace !
    INY                       ;   2   48
    WALK_SEGMENT              ; 13    51

; SPLITNODE
; 0     BYTE  FLAG_JUMP - determines type of thing... 
; 1     BYTE  MAIN_AXIS
; 2/3   ADDR  MIN_CHILD
; 4/5   ADDR  MAX_CHILD

DO_SPLITNODE_X:
    LDA (ZP_BSP),y  ;  5   5   X value of the split
    INC ZP_BSP_STACK_PTR  ; 5   10
    LDX ZP_BSP_STACK_PTR  ; 3   13
    CMP ZP_PLX      ;  3   16   'player' X
    BMI @NXP_MAX    ;  2   18  
  @NXP_MIN: ; we're on min side   18
      LDY #5                ; 2   20  max_child_h 
      LDA (ZP_BSP),y        ; 5   25 
      STA BSP_STACK_HIGH,x  ; 4   29
      DEY                   ; 2   31  max_child_l
      LDA (ZP_BSP),y        ; 5   36
      STA BSP_STACK_LOW,x   ; 4   40
      DEY                   ; 2   42  min_child_h
      LDA (ZP_BSP),y        ; 5   47  
      TAX                   ; 2   49
      DEY                   ; 2   51  min_child_l
      LDA (ZP_BSP),y        ; 5   56
      STX ZP_BSP+1          ; 3   59
      STA ZP_BSP            ; 3   62
      WALK_BSP              ; 15  77  
  @NXP_MAX: ; we're on max side   19
      INY                   ; 2   21  min_child_l 
      LDA (ZP_BSP),y        ; 5   26 
      STA BSP_STACK_LOW,x   ; 4   30
      INY                   ; 2   32  min_child_h
      LDA (ZP_BSP),y        ; 5   37
      STA BSP_STACK_HIGH,x   ; 4   41
      INY                   ; 2   43  max_child_l
      LDA (ZP_BSP),y        ; 5   48  
      TAX                   ; 2   50
      INY                   ; 2   52  max_child_h
      LDA (ZP_BSP),y        ; 5   57
      STX ZP_BSP            ; 3   60
      STA ZP_BSP+1          ; 3   63
      WALK_BSP              ; 15  78  
    

DO_SPLITNODE_Y:
    LDA (ZP_BSP),y  ;  5   5   X value of the split
    INC ZP_BSP_STACK_PTR  ; 5   10
    LDX ZP_BSP_STACK_PTR  ; 3   13
    CMP ZP_PLY      ;  3   16   'player' y
    BMI @NYP_MAX    ;  2   18  
  @NYP_MIN: ; we're on min side   18
      LDY #5                ; 2   20  max_child_h 
      LDA (ZP_BSP),y        ; 5   25 
      STA BSP_STACK_HIGH,x  ; 4   29
      DEY                   ; 2   31  max_child_l
      LDA (ZP_BSP),y        ; 5   36
      STA BSP_STACK_LOW,x   ; 4   40
      DEY                   ; 2   42  min_child_h
      LDA (ZP_BSP),y        ; 5   47  
      TAX                   ; 2   49
      DEY                   ; 2   51  min_child_l
      LDA (ZP_BSP),y        ; 5   56
      STX ZP_BSP+1          ; 3   59
      STA ZP_BSP            ; 3   62
      WALK_BSP              ; 15  77  
  @NYP_MAX: ; we're on max side   19
      INY                   ; 2   21  min_child_l 
      LDA (ZP_BSP),y        ; 5   26 
      STA BSP_STACK_LOW,x   ; 4   30
      INY                   ; 2   32  min_child_h
      LDA (ZP_BSP),y        ; 5   37
      STA BSP_STACK_HIGH,x   ; 4   41
      INY                   ; 2   43  max_child_l
      LDA (ZP_BSP),y        ; 5   48  
      TAX                   ; 2   50
      INY                   ; 2   52  max_child_h
      LDA (ZP_BSP),y        ; 5   57
      STX ZP_BSP            ; 3   60
      STA ZP_BSP+1          ; 3   63
      WALK_BSP              ; 15  78  

SKIP_SEG_TYPE: ; used to skip segments that won't be visible at all, like if facing North can't see walls facing north. 
    TYA
    CLC
    ADC #5
    TAY
    WALK_SEGMENT
DO_LEAFNODE:
    LDA (ZP_BSP),Y            ;   5   5   grab the PVS value... 
    TAX                       ;   2   7   swap it to X register
    ; assuming banked right
    LDA $0                    ;   3   10  current RAM bank
    STA ZP_BSP_RAM_BANK       ;   3   13  stash current RAM bank - should be BSP data
    LDA ZP_BSP_PVS_BANK       ;   3   16  grab PVS RAM bank
    STA $0                    ;   3   19  switched
    LDY PVS_BYTE_LOOKIES,x    ;   4   11  get offset to BYTE to check 
    LDA PVS_BIT_LOOKIES,x     ;   4   15  value to compare to
    AND (ZP_PVS_POINTER),y    ;   5   20  do the compare ..
    BEQ SWITCH_POP_BSP_STACK  ;   2   22  oops not in visible set. gotta fly! - 23 to fizzle at this point...
    LDY #2                    ;   2   24
    LDA ZP_BSP_RAM_BANK       ;   3   30
    STA $0                    ;   3   33  restore the old RAM bank
    WALK_SEGMENT              ;   13  46  ok, let's go do stuff.. so +37 per little area to check ? hmmm.. 
DONE_BSP_STACK:
  rts
SWITCH_POP_BSP_STACK:
    LDA ZP_BSP_RAM_BANK       ;   3   30
    STA $0                    ;   3   33  restore the old RAM bank
POP_BSP_STACK:
  LDX ZP_BSP_STACK_PTR  ; 3   3
  BEQ DONE_BSP_STACK    ; 2   5   ; stack already at zero we good
  DEX                   ; 2   7
  LDA BSP_STACK_LOW,x   ; 4   11
  STA ZP_BSP            ; 3   14
  LDA BSP_STACK_HIGH,x  ; 4   18
  STA ZP_BSP+1          ; 3   21 
  STX ZP_BSP_STACK_PTR  ; 3   24  stash the stack pointer
  LDA (ZP_BSP)  ; 5   29
  TAX             ; 2   31 
  JMP (WALK_BSP_JUMPTABLE,x) ; 6  37

; WALL
; 0     BYTE  FLAG_JUMP - determines type of thing... 
; 1     BYTE  MAIN_AXIS
; 2     BYTE  LEFT
; 3     BYTE  RIGHT
; 4     BYTE  TEXTURE
; 5     BYTE  TAGS
;

DO_SEGMENT_X_FACE_MIN_NO_SKIP_SEG:  ; wall is vertical at some X facing west / left
    LDA #$C3               ;  2   2    its facing left, are we looking to the right? 
    AND ZP_VISIBLE_OCTANTS ;  3   5
    BEQ @WALL_X_MIN_FAIL   ;  2   7   8+19=27 cycles for first possible clipping  .. but this is redundant to just modifying the jumptable..
DO_SEGMENT_X_FACE_MIN:
    LDA (ZP_BSP),y  ;  5   12   X value of the split
    CLC             ;  2   14   this is to make the subtract 1 short - ZERO is now really <1/4 tile rather than being out... 
    SBC ZP_PLX      ;  3   17   'player' X
    BCS @WALL_X_MIN_OK ; 2   19  want it to definitely fail at zero, as at zero really am to the right or right on the wall...  
  @WALL_X_MIN_FAIL: ;  8/19 we're to the right of a wall facing left, we can't see it.. carry disabled
      TAY             ; 2   2
      ADC #5          ; 2   4 
      TYA             ; 2   6   
      WALK_SEGMENT    ; 13  19  ; y wasn't changed .. so adding 5 to the ZP address instead   clipped out maybe in 27/38
  @WALL_X_MIN_OK: ; 20  at least we're on correct side to see it maybe... carry enabled still
      BEQ @WALL_X_MIN_FAIL ; 2  22  wall is < 1/4 tile distance in X distance.. we're inside the wall or can't see it in distance..
      STA ZP_BSP_LX   ; 3   25  stash the X distance to left vertex of wall
      STA ZP_BSP_RX   ; 3   28  stash the X distance to right vertex of wall
      INY             ; 2   30  -> LEFT
      SBC ZP_PLY      ; 3   33
      BCS @WALL_X_MIN_LEFT_SOUTH   ; 2   35
    @WALL_X_MIN_LEFT_NORTH:   ; LEFT vertex is north of player.. Y distance is negative, carry disabled.. possible octants : 6-1 
        EOR #$FF        ;   2   35
        INC A           ;   2   37
        STA ZP_BSP_LY   ;   3   40    stash the magnitude of the LY distance, noting left is in quad 6 or 7 ..
        CMP ZP_BSP_LX   ;   3   43    compare magnitude with X distance.. 
        BCC @WALL_X_MIN_LNX ; 2  45   if borrow then X greater
        BNE @WALL_X_MIN_LNY ; 2  47 
      @WALL_X_MIN_LNE: ; 47   P->LEFT is nearly 45* NE between octants 6/7
          LDA #$C0      ; 2       49
          STA ZP_BSP_QUADS_CHECK  ; 3   52  woot is a start.. 
          LDA #192      ;   2   54
          STA ZP_BSP_BAM_LEFT ;   3   57
          BRA @WALL_X_MIN_RIGHT ; 3    60 
      @WALL_X_MIN_LNY: ; 48   P->LEFT is y major , octant 6 ..  Y is currently loaded into A .. so want to divide by y as it is larger..
          STA ZP_BSP_MATH_TEMP+1
          LDA ZP_BSP_LX ; 3   51
          STA ZP_BSP_MATH_TEMP
          JSR SIMPLE_DIVIDE_FRACTIONAL ; 6+ 




          LDX #$80        ; 2   50
      @WALL_X_MIN_LNX: ; 46/49   /P->LEFT is x major , octant 7 , need rule out nearly East
          ADC #2        ; 2   48/51

    @WALL_X_MIN_LEFT_SOUTH:   ; LEFT vertex is south of player, carry enabled   34
      WALK_SEGMENT              ; 13    51

  @WALL_X_MIN_RIGHT:

DO_SEGMENT_X_FACE_MAX:
  JMP POP_BSP_STACK ; until thing is actually defined, will effectively allow skip
  WALK_BSP
DO_SEGMENT_Y_FACE_MIN:
  JMP POP_BSP_STACK ; until thing is actually defined, will effectively allow skip
  WALK_BSP
DO_SEGMENT_Y_FACE_MAX:
  JMP POP_BSP_STACK ; until thing is actually defined, will effectively allow skip
  WALK_BSP
DO_DOOR_VERTICAL:
  JMP POP_BSP_STACK ; until thing is actually defined, will effectively allow skip
  WALK_BSP
DO_DOOR_HORIZONTAL:
  JMP POP_BSP_STACK ; until thing is actually defined, will effectively allow skip
  WALK_BSP
DO_DECORATION:
  JMP POP_BSP_STACK ; until thing is actually defined, will effectively allow skip
  WALK_BSP
;
;http://6502org.wikidot.com/software-math-intdiv#toc1
;16-bit / 8-bit = 8-bit quotient, 8-bit remainder (unsigned)
;Inputs:
;TH = bits 15 to 8 of the numerator
;TLQ = bits 7 to 0 of the numerator
;B = 8-bit denominator
;Outputs:
;TLQ = 8-bit quotient of T / B
;accumulator = remainder of T / B
;;
;   LDA TH
;   LDX #8
;   ASL TLQ
;L1 ROL
;   BCS L2
;   CMP B
;   BCC L3
;L2 SBC B
;;
;; The SEC is needed when the BCS L2 branch above was taken
;;
;   SEC
;L3 ROL TLQ
;   DEX
;   BNE L1
;


; do divide, expecting 8bit fraction / 255 of ZP_BSP_MATH_TEMP / ZP_BSP_MATH_TEMP+1 
; temp+1 should be larger.. duh
T = ZP_BSP_MATH_TEMP
B = ZP_BSP_MATH_TEMP+1

SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 47   /   105   =  114
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
  X8:
      ROL A   ; 2   2                     /           98
      TAX     ; 2   4         98
      SBC B   ; 3   7                                 NEG /
      BCS @END ;  2 9
      TXA     ; 2   11                                98
    @END: ; 10/11
  X7:
      ROL A   ; 2   2                                 196   /
      TAX     ; 2   4     196
      SBC B   ; 3   7                                  90   C
      BCS @END ;  2 9
      TXA     ; 2   11
    @END: ; 10/11
  X6:
      ROL A   ; 2   2                                 181   /
      TAX     ; 2   4     181
      SBC B   ; 3   7                                  76   C
      BCS @END ;  2 9
      TXA     ; 2   11
    @END: ; 10/11
  X5:
      ROL A   ; 2   2                                 153   /
      TAX     ; 2   4     153
      SBC B   ; 3   7                                  47   C
      BCS @END ;  2 9
      TXA     ; 2   11
    @END: ; 10/11
  X4:
      ROL A   ; 2   2                                  99   /
      TAX     ; 2   4     99
      SBC B   ; 3   7                                  NEG  /
      BCS @END ;  2 9
      TXA     ; 2   11                                 99
    @END: ; 10/11
  X3:
      ROL A   ; 2   2                                  198
      TAX     ; 2   4   198
      SBC B   ; 3   7                                   92  C
      BCS @END ;  2 9
      TXA     ; 2   11
    @END: ; 10/11
  X2:
      ROL A   ; 2   2                                  185  /                     
      TAX     ; 2   4   185 
      SBC B   ; 3   7                                   79  C
      BCS @END ;  2 9
      TXA     ; 2   11
    @END: ; 10/11
  X1:
      ROL A   ; 2   2                                  159  /
      TAX     ; 2   4
      SBC B   ; 3   7                                   53  C
      BCS @END ;  2 9
      TXA     ; 2   11
    @END: ; 10/11
  X0:
      ROL A   ; 2   2                                 107 !   

actually pretty close... 

; do divide, expecting 8bit fraction / 255 of ZP_BSP_MATH_TEMP / ZP_BSP_MATH_TEMP+1 
; temp+1 should be larger.. duh
T = ZP_BSP_MATH_TEMP
B = ZP_BSP_MATH_TEMP+1

SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 47   /   105   =  114
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        47   /
  X8:
      ROL A   ; 2   2        98   /       
      SBC B   ; 3   7       -8  248   /
  X7:
      ROL A   ; 2   2       240   C   
      SBC B   ; 3   7       135   C
  X6:
      ROL A   ; 2   2        15   C       
      SBC B   ; 3   7       166   /
  X5:
      ROL A   ; 2   2        76   C       
      SBC B   ; 3   7       227   /
  X4:
      ROL A   ; 2   2       198   C       
      SBC B   ; 3   7        93   C
  X3:
      ROL A   ; 2   2       187   /       
      SBC B   ; 3   7        81   C
  X2:
      ROL A   ; 2   2       163   /       
      SBC B   ; 3   7        57   C
  X1:
      ROL A   ; 2   2       115   /   <- !!!       


SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128 = 128 1/2
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;               128   /
      SBC B ;               255   /
  X7:
      ROL A ;               254   C
      SBC B ;               126   C
  X6:
      ROL A ;               253   /
      SBC B ;               124   C
  X5:
      ROL A ;               249   /
      SBC B ;               120   C
  X4:
      ROL A ;               241   /
      SBC B ;               112   C
  X3:
      ROL A ;               225   /
      SBC B ;                96   C
  X2:
      ROL A ;               193   /
      SBC B ;                64   C
  X1:
      ROL A ;               129   /   <- huh... 


SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                  1    128 = 2
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                         1
  X8:
      ROL A ;                 2   /
      SBC B ;               129   /
  X7:
      ROL A ;                 2   C
      SBC B ;               130   /
  X6:
      ROL A ;                 4   C
      SBC B ;               132   /
  X5:
      ROL A ;                 8   C
      SBC B ;               136   /
  X4:
      ROL A ;                16   C
      SBC B ;               144   /
  X3:
      ROL A ;                32   C
      SBC B ;               160   /
  X2:
      ROL A ;                64   C
      SBC B ;               192   /
  X1:
      ROL A ;               128   C   <- close/ish.. ? 

SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 1    128 = 2
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    SEC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        1    C
  X8:
      ROL A ;                3    /
      SBC B ;               130   /
  X7:
      ROL A ;                 4   C  
      SBC B ;               132   /
  X6:
      ROL A ;                 8   C
      SBC B ;               136   /
  X5:
      ROL A ;                16   C
      SBC B ;               144   /
  X4:
      ROL A ;                32   C
      SBC B ;               160   /
  X3:
      ROL A ;                64   C
      SBC B ;               192   /
  X2:
      ROL A ;               128   C
      SBC B ;                 0   C
  X1:
      ROL A ;                 1   / ?

SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 192    208  = 236
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    SEC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                       192   C
  X8:
      ROL A ;               129   C
      SBC B ;               177   /
  X7:
      ROL A ;                98   C
      SBC B ;               146   /
  X6:
      ROL A ;                36   C
      SBC B ;                84   /
  X5:
      ROL A ;               168   /
      SBC B ;               215   /
  X4:
      ROL A ;               174   C
      SBC B ;               222   /
  X3:
      ROL A ;               188   C
      SBC B ;               236   /   <- something something how many digits in divisor?
  X2:
      ROL A ;               216   C
      SBC B ;                 8   C
  X1:
      ROL A ;                  
SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 192    208 = 236
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                       192   /
  X8:
      ROL A ;               128   C
      SBC B ;               176   /
  X7:
      ROL A ;                96   C
      SBC B ;               144   /
  X6:
      ROL A ;                32   C
      SBC B ;                80   /
  X5:
      ROL A ;               160   /
      SBC B ;               207   /
  X4:
      ROL A ;               158   C
      SBC B ;               206   /
  X3:
      ROL A ;               156   C
      SBC B ;               204   /
  X2:
      ROL A ;               152   C
      SBC B ;               200   /
  X1:
      ROL A ;               144   ?

is weird it almost works despite muxing up the digits ... really shouldn't do that? 

    ; 192 / 208 = 236 as fraction ... 
    ;              ACC   C    ANS
    ;              192   /
    LDA #$FE
    STA ANS  ;                 254
    LDA T   ;      192 / 208 = 236 ...
    SEC 
X7:     
    ROL A ;        129  C   
    SBC B ;        177  /
    ROL ANS ;           C     252
X6:     
    ROL A ;         99  C
    SBC B ;        147  /
    ROL ANS ;           C     248
X5:     
    ROL A ;         39  C
    SBC B ;         87  / 
    ROL ANS ;           C     240
X4:     
    ROL A ;         175 /
    SBC B ;         222 /
    ROL ANS ;           C     224
X3:     
    ROL A ;         189 C
    SBC B ;         237 /
    ROL ANS ;           C     192
X2:     
    ROL A ;         219 C   
    SBC B ;          11 C
    ROL ANS ;           C     129
X1:     
    ROL A ;          23 /
    SBC B ;          70 /
    ROL ANS ;           C       3
X0:     
    ROL A ;         141 /
    SBC B ;         188 /
    ROL ANS ;                   6


    ; 192 / 208 = 236 as fraction ... 
    ;              ACC   C    ANS
    ;              192   /
    STZ ANS  ;                 0
    LDA T   ;      192 / 208 = 236 ...
    CLC 
X7:     
    ROL A ;        128  C   
    SBC B ;        176  /
    ROL ANS ;           /       0
X6:     
    ROL A ;         96  C
    SBC B ;        144  /
    ROL ANS ;           0       0
X5:     
    ROL A ;         32  C
    SBC B ;         80  / 
    ROL ANS ;                   0
X4:     
    ROL A ;         160 /
    SBC B ;         207 /
    ROL ANS ;                   0
X3:     
    ROL A ;         158 C
    SBC B ;         206 /
    ROL ANS ;                   0
X2:     
    ROL A ;         156 C   
    SBC B ;         204 /
    ROL ANS ;           /       0
X1:     
    ROL A ;         152 C
    SBC B ;         200 /
    ROL ANS ;           /       0
X0:     
    ROL A ;         144 C
    SBC B ;         192 /
    ROL ANS ;           /       0

    ; 192 / 208 = 236 as fraction ... 
    ;              ACC   C    ANS
    ;              192   /
    STZ ANS  ;                 0
    ;      192 / 208 = 236 ...
    LDA B   ;       208   /     0
    EOR #$FF;        47
    CLC     ;
X8:
    ADC T   ;       239   /
    ROL ANS ;             /     0
    ASL A   ;       222   C
X8:
    ADC T   ;       159   C
    ROL ANS ;             /     1
    ASL A   ;        62   C
X8:
    ADC T   ;       255   /
    ROL ANS ;             /     2
    ASL A   ;       254   C
X8:
    ADC T   ;       191   C
    ROL ANS ;             /     5
    ASL A   ;       126   C
X8:
    ADC T   ;        63   C
    ROL ANS ;             /     11
    ASL A   ;


    ; 192 / 208 = 236 as fraction ... 
    ;              ACC   C    ANS
    ;              192   /
    STZ ANS  ;                 0
    ;      192 / 208 = 236 ...
    LDA B   ;       208   /     0
    EOR #$FF;        47
    TAX     ;
    CLC     ;

X8:
    ADC T   ;       239   /
    ROL ANS ;             /    0
    TXA     ;        47
    ASL A   ;        94   /
    TAX     ;   94
X7:
    ADC T   ;        30  C
    ROL ANS ;            /     1
    TXA     ;         94
    ASL A   ;        188
    TAX     ;
X6:
    ADC T   ;        125 C
    ROL ANS ;            /     3
    TXA     ;   188
    ASL A   ;        120 C   
    TAX     ;
X5:
    ADC T   ;         57 C
    ROL ANS ;             /    7
    TXA     ;   120
    ASL A   ;        240 /
    TAX     ;
X4:
    ADC T   ;        176 C
    ROL ANS ;                 15
    TXA     ;   240
    ASL A   ;         224 C
    TAX     ;
X3:
    ADC T   ;         161 C
    ROL ANS ;             /   31
    TXA     ;   224
    ASL A   ;         192 C
    TAX     ;
X2:
    ADC T   ;         129 C
    ROL ANS ;             /   65
    TXA     ;   192
    ASL A   ;         128 C
    TAX     ;
X1:
    ADC T   ;          65 C
    ROL ANS ;             /   131
    TXA     ;   128
    ASL A   ;           0 C
    TAX     ;
X0:
    ADC T   ;         
    ROL ANS ; 
    TXA     ;
    ASL A   ;
    TAX     ;


X8:
    ADC T   ;        
    ROL ANS ;       
    ASL A   ;
X8:
    ADC T   ;        
    ROL ANS ;       
    ASL A   ;
X8:
    ADC T   ;        
    ROL ANS ;       
    ASL A   ;
X8:
    ADC T   ;        
    ROL ANS ;       
    ASL A   ;
X8:
    ADC T   ;        
    ROL ANS ;       
    ASL A   ;


SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;                  
      SBC B ;  
  X7:
      ROL A ;                  
      SBC B ;  
  X6:
      ROL A ;                  
      SBC B ;  
  X5:
      ROL A ;                  
      SBC B ;  
  X4:
      ROL A ;                  
      SBC B ;  
  X3:
      ROL A ;                  
      SBC B ;  
  X2:
      ROL A ;                  
      SBC B ;  
  X1:
      ROL A ;                  
SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;                  
      SBC B ;  
  X7:
      ROL A ;                  
      SBC B ;  
  X6:
      ROL A ;                  
      SBC B ;  
  X5:
      ROL A ;                  
      SBC B ;  
  X4:
      ROL A ;                  
      SBC B ;  
  X3:
      ROL A ;                  
      SBC B ;  
  X2:
      ROL A ;                  
      SBC B ;  
  X1:
      ROL A ;                  
SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;                  
      SBC B ;  
  X7:
      ROL A ;                  
      SBC B ;  
  X6:
      ROL A ;                  
      SBC B ;  
  X5:
      ROL A ;                  
      SBC B ;  
  X4:
      ROL A ;                  
      SBC B ;  
  X3:
      ROL A ;                  
      SBC B ;  
  X2:
      ROL A ;                  
      SBC B ;  
  X1:
      ROL A ;                  
SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;                  
      SBC B ;  
  X7:
      ROL A ;                  
      SBC B ;  
  X6:
      ROL A ;                  
      SBC B ;  
  X5:
      ROL A ;                  
      SBC B ;  
  X4:
      ROL A ;                  
      SBC B ;  
  X3:
      ROL A ;                  
      SBC B ;  
  X2:
      ROL A ;                  
      SBC B ;  
  X1:
      ROL A ;                  
SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;                  
      SBC B ;  
  X7:
      ROL A ;                  
      SBC B ;  
  X6:
      ROL A ;                  
      SBC B ;  
  X5:
      ROL A ;                  
      SBC B ;  
  X4:
      ROL A ;                  
      SBC B ;  
  X3:
      ROL A ;                  
      SBC B ;  
  X2:
      ROL A ;                  
      SBC B ;  
  X1:
      ROL A ;                  
SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;                  
      SBC B ;  
  X7:
      ROL A ;                  
      SBC B ;  
  X6:
      ROL A ;                  
      SBC B ;  
  X5:
      ROL A ;                  
      SBC B ;  
  X4:
      ROL A ;                  
      SBC B ;  
  X3:
      ROL A ;                  
      SBC B ;  
  X2:
      ROL A ;                  
      SBC B ;  
  X1:
      ROL A ;                  
SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;                  
      SBC B ;  
  X7:
      ROL A ;                  
      SBC B ;  
  X6:
      ROL A ;                  
      SBC B ;  
  X5:
      ROL A ;                  
      SBC B ;  
  X4:
      ROL A ;                  
      SBC B ;  
  X3:
      ROL A ;                  
      SBC B ;  
  X2:
      ROL A ;                  
      SBC B ;  
  X1:
      ROL A ;                  
SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;                  
      SBC B ;  
  X7:
      ROL A ;                  
      SBC B ;  
  X6:
      ROL A ;                  
      SBC B ;  
  X5:
      ROL A ;                  
      SBC B ;  
  X4:
      ROL A ;                  
      SBC B ;  
  X3:
      ROL A ;                  
      SBC B ;  
  X2:
      ROL A ;                  
      SBC B ;  
  X1:
      ROL A ;                  
SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;                  
      SBC B ;  
  X7:
      ROL A ;                  
      SBC B ;  
  X6:
      ROL A ;                  
      SBC B ;  
  X5:
      ROL A ;                  
      SBC B ;  
  X4:
      ROL A ;                  
      SBC B ;  
  X3:
      ROL A ;                  
      SBC B ;  
  X2:
      ROL A ;                  
      SBC B ;  
  X1:
      ROL A ;                  
SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;                  
      SBC B ;  
  X7:
      ROL A ;                  
      SBC B ;  
  X6:
      ROL A ;                  
      SBC B ;  
  X5:
      ROL A ;                  
      SBC B ;  
  X4:
      ROL A ;                  
      SBC B ;  
  X3:
      ROL A ;                  
      SBC B ;  
  X2:
      ROL A ;                  
      SBC B ;  
  X1:
      ROL A ;                  
SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;                  
      SBC B ;  
  X7:
      ROL A ;                  
      SBC B ;  
  X6:
      ROL A ;                  
      SBC B ;  
  X5:
      ROL A ;                  
      SBC B ;  
  X4:
      ROL A ;                  
      SBC B ;  
  X3:
      ROL A ;                  
      SBC B ;  
  X2:
      ROL A ;                  
      SBC B ;  
  X1:
      ROL A ;                  
SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;                  
      SBC B ;  
  X7:
      ROL A ;                  
      SBC B ;  
  X6:
      ROL A ;                  
      SBC B ;  
  X5:
      ROL A ;                  
      SBC B ;  
  X4:
      ROL A ;                  
      SBC B ;  
  X3:
      ROL A ;                  
      SBC B ;  
  X2:
      ROL A ;                  
      SBC B ;  
  X1:
      ROL A ;                  
SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;                  
      SBC B ;  
  X7:
      ROL A ;                  
      SBC B ;  
  X6:
      ROL A ;                  
      SBC B ;  
  X5:
      ROL A ;                  
      SBC B ;  
  X4:
      ROL A ;                  
      SBC B ;  
  X3:
      ROL A ;                  
      SBC B ;  
  X2:
      ROL A ;                  
      SBC B ;  
  X1:
      ROL A ;                  
SIMPLE_DIVIDE_FRACTIONAL:
    ;                                     C            T      B      
    ;                                                 64    128
    LDA TH    ; 3   10                                                                
    ; LDX #8 ... 
    CLC   ; ASL TLQ   set to eqiv         /
    ;                       ACC   C
    ;                        64   /
  X8:
      ROL A ;                  
      SBC B ;  
  X7:
      ROL A ;                  
      SBC B ;  
  X6:
      ROL A ;                  
      SBC B ;  
  X5:
      ROL A ;                  
      SBC B ;  
  X4:
      ROL A ;                  
      SBC B ;  
  X3:
      ROL A ;                  
      SBC B ;  
  X2:
      ROL A ;                  
      SBC B ;  
  X1:
      ROL A ;                  
