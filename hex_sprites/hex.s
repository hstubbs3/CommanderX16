; 	080D
jmp start ; 	3 bytes 
;	0810 	- 240 bytes available for stuff that doesn't need alignment 
.repeat 28
	.byte $DE,$AD,$BE,$EF
.endrepeat
SCRATCH128:
.repeat 32
	.byte $DE,$AD,$BE,$EF
.endrepeat

ACROSS_ROW_X_H: ; 0900
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte $10,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $E
.byte  $E,  $E,  $E,  $E,  $E,  $D,  $D,  $D,  $D,  $D,  $C,  $C,  $C,  $C,  $B,  $B
.byte  $B,  $B,  $A,  $A,  $A,  $9,  $9,  $9,  $8,  $8,  $8,  $7,  $7,  $7,  $6,  $6
.byte  $6,  $5,  $5,  $5,  $4,  $4,  $3,  $3,  $3,  $2,  $2,  $1,  $1,  $1,  $0,  $0
.byte  $0, $FF, $FF, $FE, $FE, $FE, $FD, $FD, $FC, $FC, $FC, $FB, $FB, $FA, $FA, $FA
.byte $F9, $F9, $F9, $F8, $F8, $F8, $F7, $F7, $F7, $F6, $F6, $F6, $F5, $F5, $F5, $F4
.byte $F4, $F4, $F4, $F3, $F3, $F3, $F3, $F2, $F2, $F2, $F2, $F2, $F1, $F1, $F1, $F1
.byte $F1, $F1, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
.byte $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F1
.byte $F1, $F1, $F1, $F1, $F1, $F2, $F2, $F2, $F2, $F2, $F3, $F3, $F3, $F3, $F4, $F4
.byte $F4, $F4, $F5, $F5, $F5, $F6, $F6, $F6, $F7, $F7, $F7, $F8, $F8, $F8, $F9, $F9
.byte $F9, $FA, $FA, $FA, $FB, $FB, $FC, $FC, $FC, $FD, $FD, $FE, $FE, $FE, $FF, $FF
.byte $00,  $0,  $0,  $1,  $1,  $1,  $2,  $2,  $3,  $3,  $3,  $4,  $4,  $5,  $5,  $5
.byte  $6,  $6,  $6,  $7,  $7,  $7,  $8,  $8,  $8,  $9,  $9,  $9,  $A,  $A,  $A,  $B
.byte  $B,  $B,  $B,  $C,  $C,  $C,  $C,  $D,  $D,  $D,  $D,  $D,  $E,  $E,  $E,  $E
.byte  $E,  $E,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F

ACROSS_ROW_X_L: ; 0A00
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte  $0, $FE, $FB, $F4, $EC, $E1, $D3, $C3, $B1, $9C, $85, $6B, $4F, $31, $10, $ED
.byte $C8, $A0, $76, $4A, $1C, $EB, $B9, $84, $4D, $14, $D9, $9D, $5E, $1D, $DA, $96
.byte $50,  $8, $BE, $73, $26, $D7, $87, $36, $E3, $8F, $39, $E2, $8A, $31, $D7, $7B
.byte $1F, $C2, $63,  $4, $A5, $44, $E3, $81, $1F, $BC, $59, $F5, $91, $2D, $C8, $64
.byte  $0, $9B, $37, $D2, $6E,  $A, $A6, $43, $E0, $7E, $1C, $BB, $5A, $FB, $9C, $3D
.byte $E0, $84, $28, $CE, $75, $1D, $C6, $70, $1C, $C9, $78, $28, $D9, $8C, $41, $F7
.byte $AF, $69, $25, $E2, $A1, $62, $26, $EB, $B2, $7B, $46, $14, $E3, $B5, $89, $5F
.byte $37, $12, $EF, $CE, $B0, $94, $7A, $63, $4E, $3C, $2C, $1E, $13,  $B,  $4,  $1
.byte  $0,  $1,  $4,  $B, $13, $1E, $2C, $3C, $4E, $63, $7A, $94, $B0, $CE, $EF, $12
.byte $37, $5F, $89, $B5, $E3, $14, $46, $7B, $B2, $EB, $26, $62, $A1, $E2, $25, $69
.byte $AF, $F7, $41, $8C, $D9, $28, $78, $C9, $1C, $70, $C6, $1D, $75, $CE, $28, $84
.byte $E0, $3D, $9C, $FB, $5A, $BB, $1C, $7E, $E0, $43, $A6,  $A, $6E, $D2, $37, $9B
.byte  $0, $64, $C8, $2D, $91, $F5, $59, $BC, $1F, $81, $E3, $44, $A5,  $4, $63, $C2
.byte $1F, $7B, $D7, $31, $8A, $E2, $39, $8F, $E3, $36, $87, $D7, $26, $73, $BE,  $8
.byte $50, $96, $DA, $1D, $5E, $9D, $D9, $14, $4D, $84, $B9, $EB, $1C, $4A, $76, $A0
.byte $C8, $ED, $10, $31, $4F, $6B, $85, $9C, $B1, $C3, $D3, $E1, $EC, $F4, $FB, $FE

ACROSS_ROW_Y_H: ; 0B00
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte  $0,  $0,  $0,  $0,  $0,  $0,  $1, $1, $1, $1, $1, $2, $2, $2, $2, $2, $3, $3, $3, $3, $3, $3, $4, $4, $4, $4, $4, $4, $5, $5, $5, $5, $5, $5, $5, $6, $6, $6, $6, $6, $6, $6, $6, $6, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $8, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $6, $6, $6, $6, $6, $6, $6, $6, $6, $5, $5, $5, $5, $5, $5, $5, $4, $4, $4, $4, $4, $4, $3, $3, $3, $3, $3, $3, $2, $2, $2, $2, $2, $1, $1, $1, $1, $1, $0, $0, $0, $0, $0, $0, $FF, $FF, $FF, $FF, $FF, $FE, $FE, $FE, $FE, $FE, $FD, $FD, $FD, $FD, $FD, $FC, $FC, $FC, $FC, $FC, $FC, $FB, $FB, $FB, $FB, $FB, $FB, $FA, $FA, $FA, $FA, $FA, $FA, $FA, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $FA, $FA, $FA, $FA, $FA, $FA, $FA, $FB, $FB, $FB, $FB, $FB, $FB, $FC, $FC, $FC, $FC, $FC, $FC, $FD, $FD, $FD, $FD, $FD, $FE, $FE, $FE, $FE, $FE, $FF, $FF, $FF, $FF, $FF

ACROSS_ROW_Y_L: ; 0C00
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte  $0, $32, $64, $96, $C8, $FA, $2C, $5E, $8F, $C0, $F1, $22, $52, $82
.byte $B1, $E1,  $F, $3D, $6B, $98, $C5, $F1, $1C, $47, $71, $9B, $C3 
.byte $EB, $13, $39, $5F, $84, $A8, $CB, $ED,  $E, $2F, $4E, $6C, $8A
.byte $A6, $C2, $DC, $F5,  $E, $25, $3B, $50, $64, $76, $88, $98, $A7
.byte $B5, $C2, $CE, $D8, $E1, $E9, $F0, $F6, $FA, $FD, $FF,  $0, $FF
.byte $FD, $FA, $F6, $F0, $E9, $E1, $D8, $CE, $C2, $B5, $A7, $98, $88
.byte $76, $64, $50, $3B, $25,  $E, $F5, $DC, $C2, $A6, $8A, $6C, $4E
.byte $2F, $E, $ED, $CB, $A8, $84, $5F, $39, $13, $EB, $C3, $9B, $71, $47, $1C, $F1, $C5, $98, $6B, $3D, $F, $E1, $B1, $82, $52, $22, $F1, $C0, $8F, $5E, $2C, $FA, $C8, $96, $64, $32, $0, $CD, $9B, $69, $37, $5, $D3, $A1, $70, $3F, $E, $DD, $AD, $7D, $4E, $1E, $F0, $C2, $94, $67, $3A, $E, $E3, $B8, $8E, $64, $3C, $14, $EC, $C6, $A0, $7B, $57, $34, $12, $F1, $D0, $B1, $93, $75, $59, $3D, $23, $A, $F1, $DA, $C4, $AF, $9B, $89, $77, $67, $58, $4A, $3D, $31, $27, $1E, $16, $F, $9, $5, $2, $0, $0, $0, $2, $5, $9, $F, $16, $1E, $27, $31, $3D, $4A, $58, $67, $77, $89, $9B, $AF, $C4, $DA, $F1, $A, $23, $3D, $59, $75, $93, $B1, $D0, $F1, $12, $34, $57, $7B, $A0, $C6, $EC, $14, $3C, $64, $8E, $B8, $E3, $E, $3A, $67, $94, $C2, $F0, $1E, $4E, $7D, $AD, $DD, $E, $3F, $70, $A1, $D3, $5, $37, $69, $9B, $CD


NEXT_ROW_X_H:
; 		0 	1 	2 	3 		4 	5 	6 	7 		8 	9 	A 	B 		C 	D 	E 	F
.byte $F8, $F7, $F7, $F7, $F6, $F6, $F6, $F5, $F5, $F5, $F4, $F4, $F4, $F4, $F3, $F3
.byte $F3, $F3, $F2, $F2, $F2, $F2, $F2, $F1, $F1, $F1, $F1, $F1, $F1, $F0, $F0, $F0
.byte $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
.byte $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F1, $F1, $F1, $F1, $F1, $F1
.byte $F2, $F2, $F2, $F2, $F2, $F3, $F3, $F3, $F3, $F4, $F4, $F4, $F5, $F5, $F5, $F5
.byte $F6, $F6, $F6, $F7, $F7, $F7, $F8, $F8, $F8, $F9, $F9, $F9, $FA, $FA, $FB, $FB
.byte $FB, $FC, $FC, $FD, $FD, $FD, $FE, $FE, $FE, $FF, $FF,  $0,  $0,  $0,  $1,  $1
.byte  $2,  $2,  $2,  $3,  $3,  $4,  $4,  $4,  $5,  $5,  $5,  $6,  $6,  $6,  $7,  $7
.byte  $8,  $8,  $8,  $8,  $9,  $9,  $9,  $A,  $A,  $A,  $B,  $B,  $B,  $B,  $C,  $C
.byte  $C,  $C,  $D,  $D,  $D,  $D,  $D,  $E,  $E,  $E,  $E,  $E,  $E,  $F,  $F,  $F
.byte  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F , $F
.byte  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $F,  $E,  $E,  $E,  $E,  $E,  $E
.byte  $D,  $D,  $D,  $D,  $D,  $C,  $C,  $C,  $C,  $B,  $B,  $B,  $A,  $A,  $A,  $A
.byte  $9,  $9,  $9,  $8,  $8,  $8,  $7,  $7,  $7,  $6,  $6,  $6,  $5,  $5,  $4,  $4
.byte  $4,  $3,  $3,  $2,  $2,  $2,  $1,  $1,  $1,  $0,  $0, $FF, $FF, $FF, $FE, $FE
.byte $FD, $FD, $FD, $FC, $FC, $FB, $FB, $FB, $FA, $FA, $FA, $F9, $F9, $F9, $F8, $F8

NEXT_ROW_X_L:
.byte $0, $A9, $54, $0, $AE, $5D, $D, $BF, $73, $28, $DF, $98, $52, $E, $CC, $8C, $4E, $12, $D7, $9F, $69, $35, $3, $D3, $A6, $7B, $51, $2B, $6, $E4, $C4, $A6, $8B, $72, $5C, $48, $36, $27, $1A, $10, $8, $3, $0, $0, $2, $6, $D, $17, $23, $31, $42, $55, $6A, $83, $9D, $BA, $D9, $FA, $1E, $44, $6D, $97, $C4, $F3, $24, $58, $8D, $C5, $FE, $3A, $77, $B7, $F8, $3B, $80, $C7, $10, $5A, $A6, $F3, $42, $93, $E4, $38, $8D, $E3, $3A, $92, $EC, $47, $A2, $FF, $5D, $BB, $1B, $7B, $DB, $3D, $9F, $1, $64, $C8, $2B, $8F, $F4, $58, $BC, $21, $86, $EA, $4E, $B2, $16, $7A, $DD, $3F, $A2, $3, $64, $C5, $24, $83, $E1, $3E, $9A, $F5, $4F, $A8, $0, $56, $AB, $FF, $51, $A2, $F2, $40, $8C, $D7, $20, $67, $AD, $F1, $33, $73, $B1, $ED, $28, $60, $96, $CA, $FC, $2C, $59, $84, $AE, $D4, $F9, $1B, $3B, $59, $74, $8D, $A3, $B7, $C9, $D8, $E5, $EF, $F7, $FC, $FF, $FF, $FD, $F9, $F2, $E8, $DC, $CE, $BD, $AA, $95, $7C, $62, $45, $26, $5, $E1, $BB, $92, $68, $3B, $C, $DB, $A7, $72, $3A, $1, $C5, $88, $48, $7, $C4, $7F, $38, $EF, $A5, $59, $C, $BD, $6C, $1B, $C7, $72, $1C, $C5, $6D, $13, $B8, $5D, $0, $A2, $44, $E4, $84, $24, $C2, $60, $FE, $9B, $37, $D4, $70, $B, $A7, $43, $DE, $79, $15, $B1, $4D, $E9, $85, $22, $C0, $5D, $FC, $9B, $3A, $DB, $7C, $1E, $C1, $65, $A, $B0, $57

NEXT_ROW_Y_H:
.byte $6, $6, $6, $6, $6, $6, $6, $6, $6, $5, $5, $5, $5, $5, $5, $5, $4, $4, $4, $4, $4, $4, $3, $3, $3, $3, $3, $3, $2, $2, $2, $2, $2, $1, $1, $1, $1, $1, $0, $0, $0, $0, $0, $FF, $FF, $FF, $FF, $FF, $FE, $FE, $FE, $FE, $FE, $FD, $FD, $FD, $FD, $FD, $FD, $FC, $FC, $FC, $FC, $FC, $FC, $FB, $FB, $FB, $FB, $FB, $FB, $FA, $FA, $FA, $FA, $FA, $FA, $FA, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $F9, $FA, $FA, $FA, $FA, $FA, $FA, $FA, $FB, $FB, $FB, $FB, $FB, $FB, $FC, $FC, $FC, $FC, $FC, $FC, $FD, $FD, $FD, $FD, $FD, $FE, $FE, $FE, $FE, $FE, $FF, $FF, $FF, $FF, $FF, $0, $0, $0, $0, $0, $1, $1, $1, $1, $1, $2, $2, $2, $2, $2, $2, $3, $3, $3, $3, $3, $3, $4, $4, $4, $4, $4, $4, $5, $5, $5, $5, $5, $5, $5, $6, $6, $6, $6, $6, $6, $6, $6, $6, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7, $7

NEXT_ROW_Y_L:
.byte $ED, $D3, $B9, $9D, $80, $62, $44, $24, $3, $E2, $BF, $9C, $77, $52, $2C, $6, $DE, $B6, $8D, $63, $39, $E, $E2, $B6, $89, $5C, $2E, $0, $D1, $A2, $72, $42, $12, $E1, $B0, $7F, $4D, $1B, $EA, $B8, $85, $53, $21, $EF, $BC, $8A, $58, $26, $F4, $C2, $91, $60, $2E, $FE, $CD, $9D, $6D, $3E, $F, $E0, $B2, $85, $58, $2B, $0, $D4, $AA, $80, $57, $2E, $6, $DF, $B9, $94, $6F, $4C, $29, $7, $E6, $C6, $A7, $89, $6B, $4F, $34, $1A, $1, $E9, $D3, $BD, $A8, $95, $83, $72, $62, $53, $45, $39, $2E, $24, $1B, $13, $D, $8, $4, $1, $0, $0, $1, $3, $6, $B, $11, $18, $21, $2A, $35, $41, $4E, $5D, $6C, $7D, $8F, $A2, $B6, $CB, $E2, $F9, $12, $2C, $46, $62, $7F, $9D, $BB, $DB, $FC, $1D, $40, $63, $88, $AD, $D3, $F9, $21, $49, $72, $9C, $C6, $F1, $1D, $49, $76, $A3, $D1, $FF, $2E, $5D, $8D, $BD, $ED, $1E, $4F, $80, $B2, $E4, $15, $47, $7A, $AC, $DE, $10, $43, $75, $A7, $D9, $B, $3D, $6E, $9F, $D1, $1, $32, $62, $92, $C1, $F0, $1F, $4D, $7A, $A7, $D4, $FF, $2B, $55, $7F, $A8, $D1, $F9, $20, $46, $6B, $90, $B3, $D6, $F8, $19, $39, $58, $76, $94, $B0, $CB, $E5, $FE, $16, $2C, $42, $57, $6A, $7C, $8D, $9D, $AC, $BA, $C6, $D1, $DB, $E4, $EC, $F2, $F7, $FB, $FE, $FF, $FF, $FE, $FC, $F9, $F4, $EE, $E7, $DE, $D5, $CA, $BE, $B1, $A2, $93, $82, $70, $5D, $49, $34, $1D, $6

TUB_WORLD:
.include "tub_world.inc"
;constants

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

VSYNC_BIT         = $01

; VRAM Addresses
;   Address range Description
;   $00000 - $1F9BF Video RAM   - 129,424 bytes -> 126K is 129,024 (1F800)
;   $1F9C0 - $1F9FF PSG registers
;   $1FA00 - $1FBFF Palette
;   $1FC00 - $1FFFF Sprite attributes

VRAM_UNRESERVED   = $1A000      ; 
; sprite starts must be 32byte aligned...
; only can go to 126K ... 
VRAM_palette      = $1FA00      ;  
VRAM_sprite_attributes = $1FC00

SPRITES_ONLY_VGA = $41



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

; 	$0800-$9EFF	BASIC program/variables; available to the user
WORLD_DATA = $6000 	;	so is %100 [Y 5 bits ] : [ab] 0 [X - 6 bits
SCREEN_buffer = $8000

; zero page layout $0022-$007F is available to user
ZP_PTR = $22 
SCRATCH_PTR = $7E

; global data
.byte $DE,$AD,$BE,$EF
default_irq_vector:  .addr 0
VSYNC_counter:       .byte 1
camera_facing: 		 .byte 1

camera_cell_x: 		 .byte 32
camera_cell_y: 		 .byte 15

.macro stash_scratch
	STA (SCRATCH_PTR)
    INC SCRATCH_PTR
.endmacro

custom_irq_handler:
   lda VERA_isr
   and #VSYNC_BIT
   beq @continue ; non-VSYNC IRQ, no tick update
   inc VSYNC_counter
@continue:
   ; continue to default IRQ handler
   jmp (default_irq_vector)
   ; RTI will happen after jump

start:
  ; start of program - init globals
  lda IRQVec
  sta default_irq_vector
  lda IRQVec+1
  sta default_irq_vector+1
  stz VERA_dc_video   ; disable display
  lda #43 ; set scale for bitmap mode - going for 215x161 mode
  sta VERA_dc_hscale
  sta VERA_dc_vscale
  ; for now no L0 or L1 

  ; let's stick that test sprite data into VRAM at zero for now.. 
  stz VERA_ctrl
  stz VERA_addr_low
  stz VERA_addr_high
  lda #$10
  sta VERA_addr_bank
  ; load test VRAM data

  ; is 512 bytes at test_cell_sprite label
  ldy #0

  LDA #<test_vram_data
  STA ZP_PTR
  LDA #>test_vram_data
  STA ZP_PTR+1
  LDX #5   ;   num pages to copy 
  BRA :++
  : 
     INC ZP_PTR+1
    :
      LDA (ZP_PTR),Y
      STA VERA_data0
      INY
      BNE :-
     DEX 
     BNE :--

  ; write sprite test data 
  LDA #128
  STA VERA_addr_low
  lda #>VRAM_sprite_attributes
  sta VERA_addr_high
  lda #$19   ;  decrement 1 bank 1
  sta VERA_addr_bank
  LDX #128
  :
    LDA test_sprite_data,X 
    STA VERA_data0 
    DEX 
    BNE :- 
   LDA test_sprite_data,X 
   STA VERA_data0 

  ; enable display 
  stz VERA_ctrl
  lda #SPRITES_ONLY_VGA
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

  ; main loop here... 
   STz camera_facing

@do_update:
   jsr draw_test

@FRAME_CHECK:
   lda #4
  @frame_A:
   wai
   ldy VSYNC_counter
   beq @frame_A
   stz VSYNC_counter
   DEC A
   BNE @frame_A
   ; poll keyboard for input 
   jsr GETIN
   cmp #0
   beq @FRAME_CHECK
   cmp #$1D 	;	cursor right
   BNE :+
   DEC camera_facing
   BRA @do_update
   :
   cmp  #$9D 	;	cursor left
   BNE @do_update
   INC camera_facing
   BRA @do_update

@cleanup_and_exit:
   ; restore default IRQ vector
   sei
   lda default_irq_vector
   sta IRQVec
   lda default_irq_vector+1
   sta IRQVec+1
   cli   
   jsr CINT
   rts

; all the objects need to get into a structure to be drawn at each screen Y..
; need object type, screenX .. store back to front .. track # objects to be drawn ?
; there's 120 lines on screen.. up to say 32 objects per line would need about 8K RAM for the list.. each line needs 64 bytes

draw_test:
	lda #128
	STA VERA_addr_low
    lda #>VRAM_sprite_attributes
    sta VERA_addr_high
    lda #$11
    sta VERA_addr_bank

  
    ; load increments and set start position...
    LDX camera_facing
    TXA 
    CLC
    ADC #128
    STA ZP_PTR+17
    ; increments across rows
    STZ ZP_PTR+16   ; 	is driving me nuts so .. 
    LDA #128
    STA ZP_PTR+12 	;	next row  start XL at ZP_PTR+12
    STA ZP_PTR+14 	;	next row  start YL at ZP_PTR+14
    LDA #100
    STA ZP_PTR+13 	;	next row start at XH ZP_PTR+13
    LDA #132
 	STA ZP_PTR+15 	;	next row start YH at ZP_PTR+15


    LDA ACROSS_ROW_X_L,X 
    STA ZP_PTR+4 	; 	ZP_PTR+4 = spriteX increment Low byte
    LDA ACROSS_ROW_X_H,X 
    STA ZP_PTR+5 	;	ZP_PTR+4 = spriteX increment high byte
    LDA ACROSS_ROW_Y_L,X 
    STA ZP_PTR+6 	; 	ZP_PTR+6 = spriteY increment low byte
    LDA ACROSS_ROW_Y_H,X 
    STA ZP_PTR+7 	; 	ZP_PTR+3 = spriteY increment 
    ; increments o next rows 
    LDA NEXT_ROW_X_L,X 
    STA ZP_PTR+8 	; 	ZP_PTR+4 = spriteX increment Low byte
    LDA NEXT_ROW_X_H,X 
    STA ZP_PTR+9 	;	ZP_PTR+4 = spriteX increment high byte
    LDA NEXT_ROW_Y_L,X 
    STA ZP_PTR+10 	; 	ZP_PTR+6 = spriteY increment low byte
    LDA NEXT_ROW_Y_H,X 
    STA ZP_PTR+11	; 	ZP_PTR+3 = spriteY increment 

    LDA #16
    STA ZP_PTR+30

    LDY #112		;	amount of sprites we can write max
  @quad_loop:
   LDX #8
   STX $7F
  	bra @do_row
  @next_row:
      DEY
      BNE @do_row
      rts
  @do_row:      
      DEC $7F
      BEQ @next_quad

   LDX #27
  	LDA ZP_PTR+12 	;
  	STA ZP_PTR 		;	current row XL
    ADC ZP_PTR+8
    STA ZP_PTR+12 	;	next row XL 
    LDA ZP_PTR+13 	;
    CMP #201
    BCS @next_quad 		;	off screen
    STA ZP_PTR+1 	;	current row XH
    ADC ZP_PTR+9 	;
    STA ZP_PTR+13 	;	next row XH

    LDA ZP_PTR+14 	
    STA ZP_PTR+2 	;	current row YL
    ADC ZP_PTR+10 	
    STA ZP_PTR+14 	;	next row YL
    LDA ZP_PTR+15 
    CMP #153 	
    BCS @next_quad;	off screen 
    STA ZP_PTR+3
    ADC ZP_PTR+11 	
    STA ZP_PTR+15 	;	next row YH 
  @forward_row_loop:
      STZ VERA_data0 ; 	address 12:5
      STZ VERA_data0 ;  mode  | address 16:13
      LDA ZP_PTR+1 	
      STA VERA_data0 ; 	X 7:0
      STZ VERA_data0 ; 	X 9:8
      LDA ZP_PTR+3  ; 	spriteY
      STA VERA_data0 ;  Y 7:0
      STZ VERA_data0 ; 	Y 9:8
      LDA #$0C 
      STA VERA_data0 	; 	3 z depth no flip
      LDA #$10 			; 	16x8 no palette offset
      LDA ZP_PTR+30;
      STA VERA_data0
    ; increment X
      LDA ZP_PTR 	;	load X_l
      ADC ZP_PTR+4 	
      STA ZP_PTR

      LDA ZP_PTR+1
      ADC ZP_PTR+5
      CMP #208
      BCS @next_row		; covers negatives even.. 
      STA ZP_PTR+1
    ; increment Y
      LDA ZP_PTR+2 	;
      ADC ZP_PTR+6
      STA ZP_PTR+2

      LDA ZP_PTR+3
      ADC ZP_PTR+7
      CMP #153
      BCS @next_row		; 	 covers negatives even.. 
      STA ZP_PTR+3
      DEX 
      BEQ @next_row
      DEY
      BNE @forward_row_loop 
  @end:
     rts

  @next_quad: 
  	  inc ZP_PTR+30
  	  LDX ZP_PTR+16 	;	
  	  TXA 
  	  CLC 
  	  ADC #2
  	  STA ZP_PTR+16
  	  jmp (@t_quads,X) 	; 
  	@t_quads:
  	  .addr @quad_1
  	  .addr @quad_2
  	  .addr @quad_3
  	  .addr @end
  @quad_1: 	;	need invert across row to make next bits . next row stays same
	LDX ZP_PTR+17
    LDA ACROSS_ROW_X_L,X 
    STA ZP_PTR+4 	; 	ZP_PTR+4 = spriteX increment Low byte
    ADC #128
    STA ZP_PTR+12
    LDA ACROSS_ROW_X_H,X 
    STA ZP_PTR+5 	;	ZP_PTR+4 = spriteX increment high byte
    ADC #100
    STA ZP_PTR+13
    LDA ACROSS_ROW_Y_L,X 
    STA ZP_PTR+6 	; 	ZP_PTR+6 = spriteY increment low byte
    ADC #128
    STA ZP_PTR+14
    LDA ACROSS_ROW_Y_H,X 
    STA ZP_PTR+7 	; 	ZP_PTR+3 = spriteY increment 
    ADC #132
    STA ZP_PTR+15
    jmp @quad_loop
@quad_2: ; invert next row - start 1 row up 
	LDX ZP_PTR+17
    LDA NEXT_ROW_X_L,X 
    STA ZP_PTR+8 	; 	ZP_PTR+4 = spriteX increment Low byte
    ADC #128
    STA ZP_PTR+12
    STA ZP_PTR+18

    LDA NEXT_ROW_X_H,X 
    STA ZP_PTR+9 	;	ZP_PTR+4 = spriteX increment high byte
    ADC #100
    STA ZP_PTR+13
    STA ZP_PTR+19

    LDA NEXT_ROW_Y_L,X 
    STA ZP_PTR+10 	; 	ZP_PTR+6 = spriteY increment low byte
    ADC #128
    STA ZP_PTR+14
    STA ZP_PTR+20

    LDA NEXT_ROW_Y_H,X 
    STA ZP_PTR+11 	; 	ZP_PTR+3 = spriteY increment 
    ADC #132
    STA ZP_PTR+15
    STA ZP_PTR+21
    jmp @quad_loop
@quad_3: ; restore across row and increment .. 
	LDX camera_facing
    LDA ACROSS_ROW_X_L,X 
    STA ZP_PTR+4 	; 	ZP_PTR+4 = spriteX increment Low byte
    ADC ZP_PTR+18
    STA ZP_PTR+12
    LDA ACROSS_ROW_X_H,X 
    STA ZP_PTR+5 	;	ZP_PTR+4 = spriteX increment high byte
    ADC ZP_PTR+19
    STA ZP_PTR+13
    LDA ACROSS_ROW_Y_L,X 
    STA ZP_PTR+6 	; 	ZP_PTR+6 = spriteY increment low byte
    ADC ZP_PTR+20
    STA ZP_PTR+14
    LDA ACROSS_ROW_Y_H,X 
    STA ZP_PTR+7 	; 	ZP_PTR+3 = spriteY increment 
    ADC ZP_PTR+21
    STA ZP_PTR+15
    jmp @quad_loop

draw_world:
  ; clear first entry for each line... 
  STZ ZP_PTR 
  LDA #>SCREEN_buffer
  STA ZP_PTR+1
  LDX #30
  LDA #0
  @loop:
    TAY
    STA (ZP_PTR),y 	;	set first buffer entry for line mod 4 = 0 
    LDY #64 		; 	move buffer pointer to next line
    STA (ZP_PTR),y 	;	set first buffer entry for line mode 4 =1 
    LDY #128 		; 	move buffer pointer to next line
    STA (ZP_PTR),y 	;	set first buffer entry for line mode 4 =2
    LDY #192 		; 	move buffer pointer to next line
    STA (ZP_PTR),y 	;	set first buffer entry for line mode 4 =3 
    INC ZP_PTR+1 	;	next page plz
    DEX  
    BNE @loop
  ; fetch bearing data .. 
  LDA camera_facing
  ASL 
  TAX
  jmp (@T_BEARINGS,X)
@T_BEARINGS:
	.addr BEARING_ZERO
	.addr BEARING_ONE
	.addr BEARING_TWO

BEARING_ZERO:
    LDA #112 ; starting at screen Y=112 
  @E_loop:
    STA ZP_PTR+2 ; stash the Y we're working at... 
      STZ ZP_PTR   ; zero this out to use pointer .. 
      LSR 
      ROR ZP_PTR ; 
      LSR
      ROR ZP_PTR ; because is 64 avail for each 
      ORA #>SCREEN_buffer ; making pointer woot! 
      STA ZP_PTR+1 ; ZP_PTR points to the line.. 
      LDY #0 	;	set to first offset in that buffer.. we'll add other objects to the lines later so this will always be null object
      LDA #8 	;   start at X=0
    @E_loopE:
        TAX
        LDA #2 	;	water type
        STA (ZP_PTR),y 
        iny 
        TXA ;	get X value
        STA (ZP_PTR),y 
        iny 
        CLC
        adc #16
        CMP #136
        BCC @E_loopE 	;kk
      LDA #0
      STA (ZP_PTR),y ; stash zero value to end the thing
      LDA ZP_PTR+2
      SBC #15 	;	borrow is set ...
      BCS @E_loop ; still spots left on screen.. otay
    jmp update_screen 
BEARING_ONE:
BEARING_TWO: ; 30 degrees .. 
    LDA #116 ; starting at screen Y=112 
  @E_loop:
    STA ZP_PTR+2 ; stash the Y we're working at... 
      STZ ZP_PTR   ; zero this out to use pointer .. 
      LSR 
      ROR ZP_PTR ; 
      LSR
      ROR ZP_PTR ; because is 64 avail for each 
      ORA #>SCREEN_buffer ; making pointer woot! 
      STA ZP_PTR+1 ; ZP_PTR points to the line.. 
      LDY #0 	;	set to first offset in that buffer.. we'll add other objects to the lines later so this will always be null object
      LDA #12 	;   start at X=0
    @E_loopE:
        TAX
        LDA #2 	;	water type
        STA (ZP_PTR),y 
        iny 
        TXA ;	get X value
        STA (ZP_PTR),y 
        iny 
        CLC
        adc #28
        CMP #136
        BCC @E_loopE 	;kk
      LDA #0
      STA (ZP_PTR),y ; stash zero value to end the thing
      LDA ZP_PTR+2
      SBC #13 	;	borrow is set ...
      BCS @E_loop ; still spots left on screen.. otay
    jmp update_screen 

  rts 

update_screen:
  stz VERA_addr_low
  lda #>VRAM_sprite_attributes
  sta VERA_addr_high
  lda #$11
  sta VERA_addr_bank
    LDA #119
    STA ZP_PTR+2 ; stash line we at .. 
      STZ ZP_PTR
      LSR 
      ROR ZP_PTR ; 
      LSR
      ROR ZP_PTR ; because is 64 avail for each 
      ORA #>SCREEN_buffer ; making pointer woot! 
      STA ZP_PTR+1 ; ZP_PTR points to the line.. 
  @y_line_loop:
      LDY #0 ; set to check that first point .. 
      dec ZP_PTR+2
    @do_check_line:
        LDA (ZP_PTR),Y ;	get type 
        INY 
        TAX 
        JMP (@T_objtypes,X) ; 
    @T_objtypes:
        .addr @end_line 
        .addr @do_water 
    @do_water:
      stz VERA_data0 	; 	address 12:5
      STZ VERA_data0 	; 	4bit color address 16:13
      LDA (ZP_PTR),Y  	;	get the X
      iny 
      STA VERA_data0 	;	X 
      STZ VERA_data0 	;	 X 
      LDA ZP_PTR+2
      STA VERA_data0 	;	y
      STZ VERA_data0 	; 	y
      LDA #$0C 
      STA VERA_data0 	; 	3 z depth no flip
      LDA #$D0 			; 	16x64 no palette offset
      STA VERA_data0
      bra @do_check_line
    @end_line:
        SEC 
        LDA ZP_PTR
        SBC #64
        STA ZP_PTR
        LDA ZP_PTR+1
        SBC #0
        STA ZP_PTR+1
        CMP #>SCREEN_buffer
        BCS @y_line_loop
rts

test_sprite_data:
; first 16 sprites reserved ... 
;      0   1   2   3   4   5   6  7
;     add,mod, XL, XH, YL, YH,msk,hwp
.byte  32,$00,104,  0,132,  0,$0C,$00  ;  cursor middle - 8x8  sprite 0
.byte  16,$00, 12,  0,  0,  0,$0C,$30  ;  border top - 64x8    sprite 1
.byte  16,$00, 76,  0,  0,  0,$0C,$30  ;  border top - 64x8    sprite 2
.byte  16,$00,140,  0,  0,  0,$0C,$30  ;  border top - 64x8    sprite 3

.byte  16,$00, 12,  0,153,  0,$0F,$30  ;  border bottom - 64x8  sprite 4
.byte  16,$00, 76,  0,153,  0,$0F,$30  ;  border bottom - 64x8  sprite 5
.byte  16,$00,140,  0,153,  0,$0F,$30  ;  border bottom - 64x8  sprite 6

.byte  16,$00,  0,  0, 16,  0,$0C,$C0  ;  border left    8x64   sprite 7
.byte  16,$00,  0,  0, 80,  0,$0C,$C0  ;  border left    8x64   sprite 8
.byte  16,$00,208,  0, 16,  0,$0F,$C0  ;  border left    8x64   sprite 9
.byte  16,$00,208,  0, 80,  0,$0F,$C0  ;  border left    8x64   sprite A

.res 40, 0


test_vram_data:
test_cell_sprite: 	;	is 16x64x16 bit = 512 bytes   sprite addr = 0 
; 	   01   23   45   67   89   AB   CD   EF
.byte $00, $00, $66, $66, $66, $66, $00, $00 	; 	0
.byte $00, $66, $EE, $EE, $EE, $EE, $66, $00  	;	1
.byte $06, $EE, $EE, $EE, $EE, $EE, $EE, $60 	;	2
.byte $6E, $EE, $EE, $EE, $EE, $EE, $EE, $E6 	;	3
.byte $6E, $EE, $EE, $EE, $EE, $EE, $EE, $E6 	;	4
.byte $66, $EE, $EE, $EE, $EE, $EE, $E6, $66 	;	5
.byte $66, $66, $EE, $EE, $EE, $EE, $66, $66 	;	6
.byte $EE, $66, $66, $66, $66, $66, $66, $EE 	;	7

.byte $EE, $EE, $66, $66, $66, $66, $EE, $EE 	; 	8
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	12
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	16
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	20
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	24
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	28
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	32
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	36
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	40
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	44
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	48
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	52
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	56
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63

.byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE 	; 	60
.byte $EE, $EE, $66, $EE, $EE, $66, $EE, $EE 	;  	61
.byte $EE, $66, $EE, $66, $66, $EE, $66, $EE 	; 	62
.byte $66, $EE, $EE, $EE, $EE, $EE, $EE, $66 	; 	63   512 bytes - next sprite addr = 16


test_border:
.repeat 64
   .res 4, $0B
   .res 4, $B0
.endrepeat

test_cross_hair_8x8:    ;  8x8x16 color = 32 bytes ; sprite 32
;     01   23   45   67
.byte $11, $00, $00, $11
.byte $10, $00, $00, $01
.byte $00, $00, $00, $00
.byte $00, $01, $10, $00
.byte $00, $01, $10, $00
.byte $00, $00, $00, $00
.byte $10, $00, $00, $01
.byte $11, $00, $00, $11
