; Wolf3D style BSP walk.. level is 64x64 tiles in 1/4th tile increments
; reserve Zero Page space during rendering - $0022-$007F  Available to the user
; will need to determine which to use , but can make it movable.. 
.ifndef BSP_ZP_START
  BSP_ZP_START = $22
.endif
; BSP_stack uses only 128 entries because seriously how complicated should a level be? adds 1 cycle if page crossed..
; these are all conditionally defined so that the calling application can redefine these in low-RAM. 
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

; BSP tree itself must fit somewhere in memory without needing bank switching - either within a bank or occupying low ram
.addr BSP_START

; BSP format for WOLF3D
;           SPLITNODE     SEGMENT           DOOR      DECORATION    
; 0   BYTE  FLAG_JUMP - see below 
; 1   BYTE  MAIN_AXIS - in 1/4 tiles ( 1 meter )      X_PINNED      
; 2   ADDR  MIN_CHILD   BYTE  LEFT_POINT              Y_PINNED      
; 3         ....        BYTE  RIGHT_POINT             HEIGHT
; 4   ADDR  MAX_CHILD   BYTE  TEXTURE                 WIDTH
; 5         ....        BYTE  AREA         STATE      STATE
; 6                                  BYTE  AREA_MIN   TEXTURE
; 7                                  BYTE  AREA_MAX   
; so splitnode is only 6bytes.. end seg would be 1 byte... so up to ~42 walls and things within the area
; DECORATION - could be NPC, animated, or just something odd that needs some further handling but essentially
; is just a transparent thing needed to be added to the list at this point ( they don't move.. )
; could possibly not be transparent, may depend on state? then it would blot out whatever it clips... could be useful?
;   potentially extensible to stairs, 3D objects, etc.. that can be contained in the BSP tree OK 

ZP_BSP_STACK_PTR = BSP_ZP_START ; byte  1   1
ZP_BSP = BSP_ZP_START+1   ; address   2     3
ZP_PLX = BSP_ZP_START+3   ; byte      1     4
ZP_PLX_SUB = BSP_ZP_START+4 ; byte    1     5
ZP_PLY = BSP_ZP_START+5   ; byte      1     6
ZP_PLY_SUB = BSP_ZP_START+6 ; byte    1     7
ZP_BSP_TMP1 = BSP_ZP_START+7  ; byte  1     8
ZP_BSP_TMP2 = BSP_ZP_START+8  ; byte  1     9

.macro WALK_BSP
  LDY #0          ; 2   2   
  LDA (ZP_BSP),y  ; 5   7
  TAX             ; 2   9
  JMP (WALK_BSP_JUMPTABLE,x) ; 6  15
.endmacro

.macro WALK_SEGMENT 
  LDA (ZP_BSP),y  ; 5   5   ; set y and ZP_BSP correctly! 
  TAX             ; 2   7
  JMP (WALK_BSP_JUMPTABLE,x) ; 6  13
.endmacro

; routine to setup variables needed for the walk 
READY_WALK_BSP:
  stz ZP_BSP_STACK_PTR  ; if stack ptr becomes neg we overflow .. 
  lda BSP_START   
  sta ZP_BSP
  lda BSP_sTART+1
  sta ZP_BSP+1
  WALK_BSP

WALK_BSP_JUMPTABLE:
  .addr POP_BSP_STACK           ; 0000 0000   really is END_SEGMENTS but ya know OK 
  .addr DO_NODE_SPLIT_X         ; 0000 0010
  .addr DO_NODE_SPLIT_Y         ; 0000 0100
  .addr DO_SEGMENT_X_FACE_MIN   ; 0000 0110
  .addr DO_SEGMENT_X_FACE_MAX   ; 0000 1000
  .addr DO_SEGMENT_Y_FACE_MIN   ; 0000 1010
  .addr DO_SEGMENT_Y_FACE_MAX   ; 0000 1100
  .addr DO_DOOR_VERTICAL        ; 0000 1110
  .addr DO_DOOR_HORIZONTAL      ; 0001 0000
  .addr DO_DECORATION           ; 0001 0010 

SKIP_SEG_TYPE: ; used to skip segments that won't be visible at all, like if facing North can't see walls facing north. 
    TYA
    CLC
    ADC #6
    TAY
    WALK_SEGMENT

DONE_BSP_STACK:
  rts
POP_BSP_STACK:
  LDX ZP_BSP_STACK_PTR  ; 3   3
  BEQ DONE_BSP_STACK    ; 2   5   ; stack already at zero we good
  DEX                   ; 2   7
  LDA BSP_STACK_LOW,x   ; 4   11
  STA ZP_BSP            ; 3   14
  LDA BSP_STACK_HIGH,x  ; 4   18
  STA ZP_BSP+1          ; 3   21 
  STX ZP_BSP_STACK_PTR  ; 3   24  stash the stack pointer
  WALK_BSP
DO_NODE_SPLIT_X:
  LDX ZP_BSP_STACK_PTR ; 3  3
  INY             ;   2   5
  LDA (ZP_BSP),Y  ;   5   10   where split along X 
  INY             ;   2   12  switch to the next Y while at it..
  CMP ZP_PLX      ;   3   15
  BMI NODE_X_PLAYER_MAX   ; 2   17
NODE_X_PLAYER_MIN: ; on min side, min side is closer.. stack far, go to near next
  LDA (ZP_BSP),Y  ;   5   22
  STA ZP_BSP_TMP1 ;   3   25
  INY             ;   2   27
  LDA (ZP_BSP),Y  ;   5   32
  STA ZP_BSP_TMP2 ;   3   35  
  INX             ;   2   37
  BMI NXP_MIN_SKIP_STACK  ;   2   39  hit end of the BSP stack, no more stacking.. 
  INY             ;   2   41
  LDA (ZP_BSP),Y  ;   5   46
  STA BSP_STACK_LOW,x ;   4   50
  INY             ;   2   52
  LDA (ZP_BSP),Y  ;   5   57
  STA BSP_STACK_HIGH,x ;   4   61
  STX ZP_BSP_STACK_PTR ;  3   64
NXP_MIN_SKIP_STACK: ;   40 / 64
  lda ZP_BSP_TMP1     ;   3     /67
  sta ZP_BSP          ;   3     /70
  lda ZP_BSP_TMP2     ;   3     /73
  sta ZP_BSP+1        ;   3     /76
  WALK_BSP            ;   15    /91   91 cycles to process BSP node .. +24 per far node needed to reach.. 
NODE_X_PLAYER_MAX: ; 18   on max side, so max side closer, stack near, go to FAR
  INY                   ; 2   20  prep the next y- NEAR_l
  INX                   ; 2   22
  BMI NXP_MAX_SKIP_STACK ; 2  24
  LDA (ZP_BSP),y          ; 5 29
  STA BSP_STACK_LOW,x     ; 4   33
  INY                     ; 2   35  near_h
  LDA (ZP_BSP),y          ; 5   40
  STA BSP_STACK_HIGH,x    ; 4   44
  STX ZP_BSP_STACK_PTR  ;   3   47
  DEY                     ; 2   49  back to near_l ... alternatives here all suck .. copy code or spend cycles to jump.. this splits difference..
NXP_MAX_SKIP_STACK: ; 25 / 49
  INY               ; 2   /51   with or without skip, now near_h 
  INY               ; 2   /53   now far_l
  LDA (ZP_BSP),y    ; 5   /58
  TAX               ; 2   /60
  INY               ; 2   /62
  LDA (ZP_BSP),y    ; 2   /67
  STX ZP_BSP        ; 3   /70
  STA ZP_BSP+1      ; 3   /73
  WALK_BSP          ; 15  /88   88   cycles through node if on the max side of node.. ok.. so 100/node ... 

DO_NODE_SPLIT_Y:
  JMP POP_BSP_STACK ; until thing is actually defined, will effectively allow skip
  WALK_BSP
; Segment is horizontal and faces NORTH 
DO_SEGMENT_X_FACE_MIN: 
    ; JMP POP_BSP_STACK ; until thing is actually defined, will effectively allow skip
    INY               ; 2   2
    SEC               ; 2   4  
    LDA (ZP_BSP),y    ; 5   9   Y the segment is at.. if player is SOUTH they can not see this segment.. 
    SBC ZP_PLY        ; 3   12
    BPL SXF_MIN_MIN_SIDE ; 2   14
  SXF_MIN_UNSEEN: 
      tya           ; 2   16
      adc #5        ; 2   18
      tay           ; 2   20
      WALK_SEGMENT  ; 13  33  NEXT SEGMENT PLEASE!
  SXF_MIN_MIN_SIDE: ; 15  borrow not set, carry still set! 
      STA ZP_BSP_LY   ; 3   18  BSP_TMP1 is ydiff 
      STA ZP_BSP_RY   ; +3  +3
      INY               ; 2   20
      LDA (ZP_BSP),y    ; 5   25  grab left point - eastern most side, MAX side.. 
      INY               ; 2   27
      SBC ZP_PLX        ; 3   30  subtract player X 
      BPL SXF_MIN_LEFT_EAST ; 2 32  
    SXF_MIN_LEFT_WEST:  ; left point is WEST of player .. borrow set, value is neg

    SXF_MIN_LEFT_EAST:  ; 33  left point is east of player
        STA ZP_BSP_LX   ; 3   36  BSP_TMP2 is xdiff - left
        CMP ZP_BSP_LY   ; 3   39  compare with the ydiff to yield octant 0/1
        BMI SXF_MIN_LEFT_OCT_ONE ; 2   41
      SXF_MIN_LEFT_OCT_ZERO:
          LDA (ZP_BSP),Y    ; 5   46  grab right point - western most side, MIN side
          SBC ZP_PLX        ; 3   49
          BPL SXF_MIN_LEFT_ZERO_RIGHT_EAST  ; 2   51
        SXF_MIN_LEFT_ZERO_RIGHT_WEST: ; Right point is west of player .. borrow set, value is neg
            EOR #$FF          ; 2   53  
            INC A             ; 2   55  
            STA ZP_BSP_RX   ; 3   58  BSP_TMP3 is xdiff - right
            CMP ZP_BSP_LY   ; 3   61
            BPL SXF_MIN_LEFT_ZERO_RIGHT_THREE ; 2   63  
          SXF_MIN_LEFT_ZERO_RIGHT_TWO: ; 63+3   66
              LDA ZP_OCTS_VISIBLE   ; 3   69 (giggity)
              AND #$07              ; 2   71
              BNE SXF_MIN_L_ZERO_R_TWO_VISIBLE ; 2  73
              TYA           ; 2   75  INY - texture INY - area - INYA - next flags 
              ADC #3        ; 2   77
              tay           ; 2   79
              WALK_SEGMENT  ; 13  92  poof! we out
            SXF_MIN_L_ZERO_R_TWO_VISIBLE:   ; 74  calc angles / screen X, clip/scale woot! 


          SXF_MIN_LEFT_ZERO_RIGHT_THREE: ;  64+3  67
              LDA ZP_OCTS_VISIBLE   ; 3   69 (giggity)
              AND #$0F              ; 2   71
              BNE SXF_MIN_L_ZERO_R_THREE_VISIBLE ; 2  73
              TYA           ; 2   75  INY - texture INY - area - INYA - next flags 
              ADC #3        ; 2   77
              tay           ; 2   79
              WALK_SEGMENT  ; 13  92  poof! we out
            SXF_MIN_L_ZERO_R_THREE_VISIBLE:   ; 74  calc angles / screen X, clip/scale woot! 




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
