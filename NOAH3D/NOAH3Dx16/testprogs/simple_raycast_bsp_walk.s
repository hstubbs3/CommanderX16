; Wolf3D style BSP walk.. level is 64x64 tiles in 1/4th tile increments
; reserve Zero Page space during rendering - $0022-$007F  Available to the user
; will need to determine which to use , but can make it movable.. 

; this should be loaded aligned 256! 
ROT4:
  .byte $00, $10, $20, $30, $40, $50, $60, $70, $80, $90, $A0, $B0, $C0, $D0, $E0, $F0
  .byte $01, $11, $21, $31, $41, $51, $61, $71, $81, $91, $A1, $B1, $C1, $D1, $E1, $F1 
  .byte $02, $12, $22, $32, $42, $52, $62, $72, $82, $92, $A2, $B2, $C2, $D2, $E2, $F2
  .byte $03, $13, $23, $33, $43, $53, $63, $73, $83, $93, $A3, $B3, $C3, $D3, $E3, $F3
  .byte $04, $14, $24, $34, $44, $54, $64, $74, $84, $94, $A4, $B4, $C4, $D4, $E4, $F4
  .byte $05, $15, $25, $35, $45, $55, $65, $75, $85, $95, $A5, $B5, $C5, $D5, $E5, $F5
  .byte $06, $16, $26, $36, $46, $56, $66, $76, $86, $96, $A6, $B6, $C6, $D6, $E6, $F6
  .byte $07, $17, $27, $37, $47, $57, $67, $77, $87, $97, $A7, $B7, $C7, $D7, $E7, $F7
  .byte $08, $18, $28, $38, $48, $58, $68, $78, $88, $98, $A8, $B8, $C8, $D8, $E8, $F8
  .byte $09, $19, $29, $39, $49, $59, $69, $79, $89, $99, $A9, $B9, $C9, $D9, $E9, $F9
  .byte $0A, $1A, $2A, $3A, $4A, $5A, $6A, $7A, $8A, $9A, $AA, $BA, $CA, $DA, $EA, $FA
  .byte $0B, $1B, $2B, $3B, $4B, $5B, $6B, $7B, $8B, $9B, $AB, $BB, $CB, $DB, $EB, $FB
  .byte $0C, $1C, $2C, $3C, $4C, $5C, $6C, $7C, $8C, $9C, $AC, $BC, $CC, $DC, $EC, $FC
  .byte $0D, $1D, $2D, $3D, $4D, $5D, $6D, $7D, $8D, $9D, $AD, $BD, $CD, $DD, $ED, $FD
  .byte $0E, $1E, $2E, $3E, $4E, $5E, $6E, $7E, $8E, $9E, $AE, $BE, $CE, $DE, $EE, $FE
  .byte $0F, $1F, $2F, $3F, $4F, $5F, $6F, $7F, $8F, $9F, $AF, $BF, $CF, $DF, $EF, $FF
RANGEFIND:
  .byte $00, $02, $04, $04, $06, $06, $06, $06, $08, $08, $08, $08, $08, $08, $08, $08 ; 0 through 4bits 0-15
  .byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A ; 16-31
  .byte $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C ; 32-47
  .byte $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C ; 48-63
  .byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E ; 64-79
  .byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E ; 80-95
  .byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E ; 96-111
  .byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E ; 112-127
  .byte $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
  .byte $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
  .byte $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
  .byte $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
  .byte $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
  .byte $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
  .byte $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
  .byte $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
TOP4H: ; grab 4 bits starting at first 1bit and return in high nibble.. 
  .byte   0, 128, 128, 192, 128, 160, 192, 224, 128, 144, 160, 176, 192, 208, 224, 240  ; 0-15 
  .byte 128, 128, 144, 144, 160, 160, 176, 176, 192, 192, 208, 208, 224, 224, 240, 240  ; 16-31 - x8
  .byte 128, 128, 128, 128, 144, 144, 144, 144, 160, 160, 160, 160, 176, 176, 176, 176  ; 32-47 - x4
  .byte 192, 192, 192, 192, 208, 208, 208, 208, 224, 224, 224, 224, 240, 240, 240, 240  ; 48-63 - x4
  .byte 128, 128, 128, 128, 128, 128, 128, 128, 144, 144, 144, 144, 144, 144, 144, 144  ; 64-79 - x2
  .byte 160, 160, 160, 160, 160, 160, 160, 160, 176, 176, 176, 176, 176, 176, 176, 176  ; 
  .byte 192, 192, 192, 192, 192, 192, 192, 192, 208, 208, 208, 208, 208, 208, 208, 208
  .byte 224, 224, 224, 224, 224, 224, 224, 224, 240, 240, 240, 240, 240, 240, 240, 240
  .byte 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128  ; x1 
  .byte 144, 144, 144, 144, 144, 144, 144, 144, 144, 144, 144, 144, 144, 144, 144, 144
  .byte 160, 160, 160, 160, 160, 160, 160, 160, 160, 160, 160, 160, 160, 160, 160, 160
  .byte 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176
  .byte 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192
  .byte 208, 208, 208, 208, 208, 208, 208, 208, 208, 208, 208, 208, 208, 208, 208, 208
  .byte 224, 224, 224, 224, 224, 224, 224, 224, 224, 224, 224, 224, 224, 224, 224, 224
  .byte 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240
TOP4L: ; grab 4 bits starting at first 1bit and return in low nibble
  .byte 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
  .byte 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15
  .byte 8, 8, 8, 8, 9, 9, 9, 9, 10, 10, 10, 10, 11, 11, 11, 11
  .byte 12, 12, 12, 12, 13, 13, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15
  .byte 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9
  .byte 10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11
  .byte 12, 12, 12, 12, 12, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13
  .byte 14, 14, 14, 14, 14, 14, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15
  .byte 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
  .byte 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
  .byte 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10
  .byte 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11
  .byte 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12
  .byte 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13
  .byte 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14
  .byte 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15
IMPROPER: ; 0 if low nibble is less than high nibble... 
  .byte 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
  .byte 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
  .byte 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
  .byte 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
  .byte 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
  .byte 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
  .byte 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
  .byte 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2
DIVNIBBLE: ; BT
  ;       0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F
.byte 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255
.byte 255, 241, 128, 192, 128, 160, 192, 224, 128, 144, 160, 176, 192, 208, 224, 240
.byte 255, 128, 242, 192, 128, 160, 192, 224, 128, 144, 160, 176, 192, 208, 224, 240
.byte 255,  85, 170, 243, 171, 213, 128, 149, 171, 192, 213, 235, 128, 139, 149, 160
.byte 255,  64, 128, 192, 244, 160, 192, 224, 128, 144, 160, 176, 192, 208, 224, 240
.byte 255,  51, 102, 153, 204, 245, 154, 179, 205, 230, 128, 141, 154, 166, 179, 192
.byte 255,  42,  85, 128, 170, 213, 246, 149, 171, 192, 213, 235, 128, 139, 149, 160
.byte 255,  36,  73, 109, 146, 182, 219, 247, 146, 165, 183, 201, 219, 238, 128, 137
.byte 255,  32,  64,  96, 128, 160, 192, 224, 248, 144, 160, 176, 192, 208, 224, 240
.byte 255,  28,  56,  85, 113, 142, 170, 199, 227, 249, 142, 156, 171, 185, 199, 213
.byte 255,  25,  51,  76, 102, 128, 153, 179, 204, 230, 250, 141, 154, 166, 179, 192
.byte 255,  23,  46,  69,  93, 116, 139, 162, 186, 209, 232, 251, 140, 151, 163, 175
.byte 255,  21,  42,  64,  85, 106, 128, 149, 170, 192, 213, 234, 252, 139, 149, 160
.byte 255,  19,  39,  59,  78,  98, 118, 137, 157, 177, 196, 216, 236, 253, 138, 148
.byte 255,  18,  36,  54,  73,  91, 109, 128, 146, 164, 182, 201, 219, 237, 254, 137
.byte 255,  17,  34,  51,  68,  85, 102, 119, 136, 153, 170, 187, 204, 221, 238, 255

ATAN512:  ; returns 0=H/V to 64=45*
  ;     0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F   
  .byte  0,  0,  1,  1,  1,  2,  2,  2,  3,  3,  3,  3,  4,  4,  4,  5
  .byte  5,  5,  6,  6,  6,  7,  7,  7,  8,  8,  8,  9,  9,  9, 10, 10
  .byte 10, 10, 11, 11, 11, 12, 12, 12, 13, 13, 13, 14, 14, 14, 14, 15
  .byte 15, 15, 16, 16, 16, 17, 17, 17, 18, 18, 18, 18, 19, 19, 19, 20
  .byte 20, 20, 21, 21, 21, 21, 22, 22, 22, 23, 23, 23, 24, 24, 24, 24
  .byte 25, 25, 25, 26, 26, 26, 26, 27, 27, 27, 28, 28, 28, 28, 29, 29
  .byte 29, 30, 30, 30, 30, 31, 31, 31, 31, 32, 32, 32, 33, 33, 33, 33
  .byte 34, 34, 34, 34, 35, 35, 35, 35, 36, 36, 36, 36, 37, 37, 37, 38
  .byte 38, 38, 38, 39, 39, 39, 39, 40, 40, 40, 40, 41, 41, 41, 41, 42
  .byte 42, 42, 42, 42, 43, 43, 43, 43, 44, 44, 44, 44, 45, 45, 45, 45
  .byte 46, 46, 46, 46, 46, 47, 47, 47, 47, 48, 48, 48, 48, 48, 49, 49
  .byte 49, 49, 50, 50, 50, 50, 50, 51, 51, 51, 51, 51, 52, 52, 52, 52
  .byte 52, 53, 53, 53, 53, 53, 54, 54, 54, 54, 54, 55, 55, 55, 55, 55
  .byte 56, 56, 56, 56, 56, 57, 57, 57, 57, 57, 57, 58, 58, 58, 58, 58
  .byte 59, 59, 59, 59, 59, 59, 60, 60, 60, 60, 60, 61, 61, 61, 61, 61
  .byte 61, 62, 62, 62, 62, 62, 62, 63, 63, 63, 63, 63, 63, 64, 64, 64

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

.ifndef ZP_TMP 
ZP_TMP = $7F 
.endif 

; BSP format for WOLF3D
; SPLITNODE -  
; 0     BYTE  FLAG_JUMP - determines type of thing... 
; 1     BYTE  PVS
; 2     BYTE  MAIN_AXIS
; 3/4   ADDR  MIN_CHILD
; 5/6   ADDR  MAX_CHILD
; 7 bytes per splitnode .. at 6 bytes splitnode, 2 bytes leafnode 1 byte end_list and 6 bytes for a wall seg... 
; say 6 bytes / element - 8K banked = >1000 elements .. maybe PVS won't have to be banked? may not even be 256 PVS area
; LEAFNODE
;  0    BYTE  FLAG_JUMP - determines type of thing
;  1    BYTE  PVS_BIT
;  2    BYTE  PVS_BYTE
;  3    BYTE  AREA - used for sound, tracking connected areas.. nav meshing? PVS, whatever.. 
;  -    childs list of segments and stuff starts here... 
;  4 bytes + childs 
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
ZP_VIEW_ANGLE_PRECISE = BSP_ZP_START+20 ; BYTE 1 21
ZP_DIVLOOK = BSP_ZP_START+21 ; ADDRESS 2  23

.macro PREPDIVNIBBLE
  lda #>DIVNIBBLE
  sta ZP_DIVLOOK+1
.endmacro

.macro GET_ATAN_FROM_DIVA
    TAX           ; 2   2
    LDA ATAN512,X ; 4   6
.endmacro

CALC_FRAC256_FROM_16BIT: ; expects bottom_H in Y, bottomL in A, top_H in X and top_L in ZP_TMP
    STX ZP_TMP-1 ;  3   3
    LDX RANGEFIND,Y ;  3   7     4   7
    JMP @TABLE,X ;3   10    6   13
  @TABLE:
      .address @DO_B8BIT  ;   2   12
      .address @DO_B9BIT    ; 2   14
      .address @DO_B10BIT   ; 2   16
      .address @DO_B11BIT   ;   2   18
      .address @DO_B12BIT   ;   2   20
      .address @DO_B13BIT   ; 2   22
      .address @DO_B14BIT   ; 2   24
      .address @DO_B15BIT   ; 2   25
      .address @DO_B16BIT   ;   2   28  26B first stanza
  @RET_ZERO:  ;
      RTS
  @DO_B8BIT:  ; 13 
        TAX     ; 2   2
        LDY ZP_TMP  ;   3   9  get the top num 
        JMP CALC_FRAC256_FROM_8BIT
  @DO_B9BIT:
      TAX   ;   2   2
      LDA zP_TMP ; 3  5
      LSR ZP_TMP-1   ; 5  10
      ROR          ; 2  12
      TAY          ; 2  14
      TXA         ;  2  16
      LSR         ;   2   18
      AND #$80    ; 2   20
      ORA TOP4L,Y ; 4   24
      STA ZP_DIVLOOK ; 3  27
      LDA #16     ;   2   29
      BRA CONTINUE_CALCFRAC256 ; 3  32
  @DO_B10BIT:
      STY ZP_TMP-2 ; 3  3
      LSR ZP_TMP-2 ; 5  8
      ROR          ; 2  10
      LSR          ; 2  12
      AND #$80     ; 2  14
      TAX          ; 2  16  Bottom TOP$ in X for lookup 
      LDA ZP_TMP   ; 3  19
      LSR ZP_TMP-1 ; 5  24
      ROR          ; 2  26
      LSR ZP_TMP-1 ; 5  31
      ROR          ; 2  33
      TAY          ; 2  35 TOP in Y 
      TXA          ; 2  37
@CONTINUEB11:
      ORA TOP4L,Y  ; 4  41
      STA ZP_DIVLOOK ; 3 44
      LDA #16       ;   2   44
      BRA CONTINUE_CALCFRAC256 ; 3  47
  @DO_B11BIT:
      ASL 
      TYA
      ROL
      TAY   ;  2    8   BOTTOM TOP4 is in bottom of Y
      LDA ZP_TMP ; 3  11 doing top..  
      AND #$F8   ; 2  13  76543..
      ORA ZP_TMP-1 ; 3  16  76543A98
      ASL         ;   2   18
      ADC #0  ;       2   20  6543A987
      TAX    ;        2   24    X   has top flipped .. 
      LDA ROT4,Y    ; 4   28  A has TOP4 from bottom in TOP now
      LDY ROT4,X    ; 4   32  Y has top in correct order of bits 
      BRA @CONTINUEB11 ; 3  35 
 
CALC_FRAC256_CHECK_IMPROPER: ; 29+13=42 from 16low
        TAX             ; 2   2
        LDA (ZP_DIVLOOK) ; 5  7
        JMP (@BLT,X)  ;   6   13  

    @BLT:
        .address @EXP_EVEN
        .address @EXP_ONE
        .address @EXP_TWO 
        .address @EXP_THREE
        .address @EXP_FOUR
        .address @EXP_FIVE
        .address @EXP_SIX
        .address @EXP_SEVEN
      @EXP_SEVEN: ; 7 bits difference - 0,1 both ATAN=0
          LDA #0 ; 2  
          RTS   ;  
      @EXP_SIX: ;   6 bits difference - B could 8 bits and T 2 or B could be 7 and T 1 .. 
          AND #$C0   ;  2   2
          ASL        ;  2   4
          ADC #0     ;  2   6
          ASL        ;  2   8
          ADC #0     ;  2   10
          RTS       ;   6   16
      @EXP_FIVE: ; 5 bits difference .. DIV / 32 .. final answer is >8 
          LSR
      @EXP_FOUR: ; 4 bits diff .. /16
          LSR
      @EXP_THREE: ; 3 bits diff .. /8
          LSR
      @EXP_TWO: ; 2 bits diff .. /4
          LSR 
      @EXP_ONE: ; 1 bits diff .. /2
          LSR      
      @EXP_EVEN ; 0 bits diff .. /1
          RTS     ;   6   16 is between 6 and 16 +13 = 19/29 for check improper
CALC_FRAC256_FROM_8BIT: ; B in X, T in Y
        ORA TOP4H,Y ;   4   13  make the lookie value
        STA ZP_DIVLOOK ; 3  16  stash the look value.. then is 5 to do the lookup using it.. 
        LDA RANGEFIND,X ; 4   22  get range for bottom nibble 
    CONTINUE_CALCFRAC256:
        SEC   ;         2   18
        SBC RANGEFIND,Y ; 4   26  get range for top nibble
        BNE CALC_FRAC256_CHECK_IMPROPER ; 2 28
        LDA (ZP_DIVLOOK) ; 5  33
        RTS ;              6  39  <--- 39+13 = 52 best case for Low 


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

.macro WALK_BSP_FIND
    LDY #1
    LDA (ZP_BSP)
    TAX 
    JMP (WALK_BSP_FIND_LEAF_TABLE,X)
.endmacro

.macro WALK_SEGMENT 
  LDA (ZP_BSP),y  ; 5   5   ; set y and ZP_BSP correctly! 
  TAX             ; 2   7
  INY             ; 2   9
  JMP (WALK_SEGMENT_JUMPTABLE,x) ; 6  15
.endmacro


; prepare to do walk, create back-stack, identify current node for PVS
READ_WALK_BSP_FIND_LEAF:
  PREPDIVNIBBLE
  stz ZP_BSP_STACK_PTR  ; if stack ptr becomes neg we overflow .. 
  lda BSP_START   
  sta ZP_BSP
  lda BSP_sTART+1
  sta ZP_BSP+1
  WALK_BSP

WALK_BSP_FIND_LEAF_TABLE:
  .addr DO_LEAFNODE_FIND
  .addr DO_SPLITNODE_X_FIND
  .addr DO_SPLITNODE_Y_FIND

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

DO_LEAFNODE_FIND:
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

; SPLITNODE -  
; 0     BYTE  FLAG_JUMP - determines type of thing... 
; 1     BYTE  PVS
; 2     BYTE  MAIN_AXIS
; 3/4   ADDR  MIN_CHILD
; 5/6   ADDR  MAX_CHILD

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
