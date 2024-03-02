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

ACROSS_ROW_X_H: ; 0900  16 wide , 45* tilt
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte $10, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $E, $E, $E, $E, $E, $E, $D, $D, $D, $D, $D, $C, $C, $C, $C, $B, $B, $B, $B, $A, $A, $A, $9, $9, $9, $8, $8, $8, $7, $7, $7, $6, $6, $6, $5, $5, $5, $4, $4, $3, $3, $3, $2, $2, $1, $1, $1, $0, $0, $0, $FF, $FF, $FE, $FE, $FE, $FD, $FD, $FC, $FC, $FC, $FB, $FB, $FA, $FA, $FA, $F9, $F9, $F9, $F8, $F8, $F8, $F7, $F7, $F7, $F6, $F6, $F6, $F5, $F5, $F5, $F4, $F4, $F4, $F4, $F3, $F3, $F3, $F3, $F2, $F2, $F2, $F2, $F2, $F1, $F1, $F1, $F1, $F1, $F1, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F1, $F1, $F1, $F1, $F1, $F1, $F2, $F2, $F2, $F2, $F2, $F3, $F3, $F3, $F3, $F4, $F4, $F4, $F4, $F5, $F5, $F5, $F6, $F6, $F6, $F7, $F7, $F7, $F8, $F8, $F8, $F9, $F9, $F9, $FA, $FA, $FA, $FB, $FB, $FC, $FC, $FC, $FD, $FD, $FE, $FE, $FE, $FF, $FF, $00, $0, $0, $1, $1, $1, $2, $2, $3, $3, $3, $4, $4, $5, $5, $5, $6, $6, $6, $7, $7, $7, $8, $8, $8, $9, $9, $9, $A, $A, $A, $B, $B, $B, $B, $C, $C, $C, $C, $D, $D, $D, $D, $D, $E, $E, $E, $E, $E, $E, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F

ACROSS_ROW_X_L: ; 0A00
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte $0, $FE, $FB, $F4, $EC, $E1, $D3, $C3, $B1, $9C, $85, $6B, $4F, $31, $10, $ED, $C8, $A0, $76, $4A, $1C, $EB, $B9, $84, $4D, $14, $D9, $9D, $5E, $1D, $DA, $96, $50, $8, $BE, $73, $26, $D7, $87, $36, $E3, $8F, $39, $E2, $8A, $31, $D7, $7B, $1F, $C2, $63, $4, $A5, $44, $E3, $81, $1F, $BC, $59, $F5, $91, $2D, $C8, $64, $0, $9B, $37, $D2, $6E, $A, $A6, $43, $E0, $7E, $1C, $BB, $5A, $FB, $9C, $3D, $E0, $84, $28, $CE, $75, $1D, $C6, $70, $1C, $C9, $78, $28, $D9, $8C, $41, $F7, $AF, $69, $25, $E2, $A1, $62, $26, $EB, $B2, $7B, $46, $14, $E3, $B5, $89, $5F, $37, $12, $EF, $CE, $B0, $94, $7A, $63, $4E, $3C, $2C, $1E, $13, $B, $4, $1, $0, $1, $4, $B, $13, $1E, $2C, $3C, $4E, $63, $7A, $94, $B0, $CE, $EF, $12, $37, $5F, $89, $B5, $E3, $14, $46, $7B, $B2, $EB, $26, $62, $A1, $E2, $25, $69, $AF, $F7, $41, $8C, $D9, $28, $78, $C9, $1C, $70, $C6, $1D, $75, $CE, $28, $84, $E0, $3D, $9C, $FB, $5A, $BB, $1C, $7E, $E0, $43, $A6, $A, $6E, $D2, $37, $9B, $0, $64, $C8, $2D, $91, $F5, $59, $BC, $1F, $81, $E3, $44, $A5, $4, $63, $C2, $1F, $7B, $D7, $31, $8A, $E2, $39, $8F, $E3, $36, $87, $D7, $26, $73, $BE, $8, $50, $96, $DA, $1D, $5E, $9D, $D9, $14, $4D, $84, $B9, $EB, $1C, $4A, $76, $A0, $C8, $ED, $10, $31, $4F, $6B, $85, $9C, $B1, $C3, $D3, $E1, $EC, $F4, $FB, $FE

ACROSS_ROW_Y_H: ; 0B00 
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte $0, $0, $0, $0, $1, $1, $1, $1, $2, $2, $2, $3, $3, $3, $3, $4, $4, $4, $4, $5, $5, $5, $5, $6, $6, $6, $6, $6, $7, $7, $7, $7, $8, $8, $8, $8, $8, $8, $9, $9, $9, $9, $9, $9, $9, $A, $A, $A, $A, $A, $A, $A, $A, $A, $A, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $A, $A, $A, $A, $A, $A, $A, $A, $A, $A, $9, $9, $9, $9, $9, $9, $9, $8, $8, $8, $8, $8, $8, $7, $7, $7, $7, $6, $6, $6, $6, $6, $5, $5, $5, $5, $4, $4, $4, $4, $3, $3, $3, $3, $2, $2, $2, $1, $1, $1, $1, $0, $0, $0, $0, $FF, $FF, $FF, $FE, $FE, $FE, $FE, $FD, $FD, $FD, $FC, $FC, $FC, $FC, $FB, $FB, $FB, $FB, $FA, $FA, $FA, $FA, $F9, $F9, $F9, $F9, $F9, $F8, $F8, $F8, $F8, $F8, $F7, $F7, $F7, $F7, $F7, $F6, $F6, $F6, $F6, $F6, $F6, $F6, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F6, $F6, $F6, $F6, $F6, $F6, $F6, $F7, $F7, $F7, $F7, $F7, $F8, $F8, $F8, $F8, $F8, $F9, $F9, $F9, $F9, $F9, $FA, $FA, $FA, $FA, $FB, $FB, $FB, $FB, $FC, $FC, $FC, $FC, $FD, $FD, $FD, $FE, $FE, $FE, $FE, $FF, $FF, $FF

ACROSS_ROW_Y_L: ; 0C00
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte $0, $47, $8E, $D5, $1B, $62, $A8, $EF, $35, $7A, $BF, $4, $48, $8C, $CF, $12, $54, $95, $D6, $16, $55, $93, $D1, $D, $49, $83, $BD, $F5, $2D, $63, $99, $CD, $0, $31, $62, $91, $BE, $EB, $16, $3F, $68, $8E, $B4, $D8, $FA, $1B, $3A, $57, $73, $8E, $A7, $BE, $D3, $E7, $F9, $9, $18, $25, $30, $3A, $42, $48, $4C, $4F, $50, $4F, $4C, $48, $42, $3A, $30, $25, $18, $9, $F9, $E7, $D3, $BE, $A7, $8E, $73, $57, $3A, $1B, $FA, $D8, $B4, $8E, $68, $3F, $16, $EB, $BE, $91, $62, $31, $0, $CD, $99, $63, $2D, $F5, $BD, $83, $49, $D, $D1, $93, $55, $16, $D6, $95, $54, $12, $CF, $8C, $48, $4, $BF, $7A, $35, $EF, $A8, $62, $1B, $D5, $8E, $47, $0, $B8, $71, $2A, $E4, $9D, $57, $10, $CA, $85, $40, $FB, $B7, $73, $30, $ED, $AB, $6A, $29, $E9, $AA, $6C, $2E, $F2, $B6, $7C, $42, $A, $D2, $9C, $66, $32, $0, $CE, $9D, $6E, $41, $14, $E9, $C0, $97, $71, $4B, $27, $5, $E4, $C5, $A8, $8C, $71, $58, $41, $2C, $18, $6, $F6, $E7, $DA, $CF, $C5, $BD, $B7, $B3, $B0, $AF, $B0, $B3, $B7, $BD, $C5, $CF, $DA, $E7, $F6, $6, $18, $2C, $41, $58, $71, $8C, $A8, $C5, $E4, $5, $27, $4B, $71, $97, $C0, $E9, $14, $41, $6E, $9D, $CE, $0, $32, $66, $9C, $D2, $A, $42, $7C, $B6, $F2, $2E, $6C, $AA, $E9, $29, $6A, $AB, $ED, $30, $73, $B7, $FB, $40, $85, $CA, $10, $57, $9D, $E4, $2A, $71, $B8

NEXT_ROW_X_H: ; 0D00
.byte $F8, $F7, $F7, $F7, $F6, $F6, $F6, $F5, $F5, $F5, $F4, $F4, $F4, $F4, $F3, $F3, $F3, $F3, $F2, $F2, $F2, $F2, $F2, $F1, $F1, $F1, $F1, $F1, $F1, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F1, $F1, $F1, $F1, $F1, $F1, $F2, $F2, $F2, $F2, $F2, $F3, $F3, $F3, $F3, $F4, $F4, $F4, $F5, $F5, $F5, $F5, $F6, $F6, $F6, $F7, $F7, $F7, $F8, $F8, $F8, $F9, $F9, $F9, $FA, $FA, $FB, $FB, $FB, $FC, $FC, $FD, $FD, $FD, $FE, $FE, $FE, $FF, $FF, $0, $0, $0, $1, $1, $2, $2, $2, $3, $3, $4, $4, $4, $5, $5, $5, $6, $6, $6, $7, $7, $8, $8, $8, $8, $9, $9, $9, $A, $A, $A, $B, $B, $B, $B, $C, $C, $C, $C, $D, $D, $D, $D, $D, $E, $E, $E, $E, $E, $E, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $E, $E, $E, $E, $E, $E, $D, $D, $D, $D, $D, $C, $C, $C, $C, $B, $B, $B, $A, $A, $A, $A, $9, $9, $9, $8, $8, $8, $7, $7, $7, $6, $6, $6, $5, $5, $4, $4, $4, $3, $3, $2, $2, $2, $1, $1, $1, $0, $0, $FF, $FF, $FF, $FE, $FE, $FD, $FD, $FD, $FC, $FC, $FB, $FB, $FB, $FA, $FA, $FA, $F9, $F9, $F9, $F8, $F8

NEXT_ROW_X_L: ; 0E00
.byte $0, $A9, $54, $0, $AE, $5D, $D, $BF, $73, $28, $DF, $98, $52, $E, $CC, $8C, $4E, $12, $D7, $9F, $69, $35, $3, $D3, $A6, $7B, $51, $2B, $6, $E4, $C4, $A6, $8B, $72, $5C, $48, $36, $27, $1A, $10, $8, $3, $0, $0, $2, $6, $D, $17, $23, $31, $42, $55, $6A, $83, $9D, $BA, $D9, $FA, $1E, $44, $6D, $97, $C4, $F3, $24, $58, $8D, $C5, $FE, $3A, $77, $B7, $F8, $3B, $80, $C7, $10, $5A, $A6, $F3, $42, $93, $E4, $38, $8D, $E3, $3A, $92, $EC, $47, $A2, $FF, $5D, $BB, $1B, $7B, $DB, $3D, $9F, $1, $64, $C8, $2B, $8F, $F4, $58, $BC, $21, $86, $EA, $4E, $B2, $16, $7A, $DD, $3F, $A2, $3, $64, $C5, $24, $83, $E1, $3E, $9A, $F5, $4F, $A8, $0, $56, $AB, $FF, $51, $A2, $F2, $40, $8C, $D7, $20, $67, $AD, $F1, $33, $73, $B1, $ED, $28, $60, $96, $CA, $FC, $2C, $59, $84, $AE, $D4, $F9, $1B, $3B, $59, $74, $8D, $A3, $B7, $C9, $D8, $E5, $EF, $F7, $FC, $FF, $FF, $FD, $F9, $F2, $E8, $DC, $CE, $BD, $AA, $95, $7C, $62, $45, $26, $5, $E1, $BB, $92, $68, $3B, $C, $DB, $A7, $72, $3A, $1, $C5, $88, $48, $7, $C4, $7F, $38, $EF, $A5, $59, $C, $BD, $6C, $1B, $C7, $72, $1C, $C5, $6D, $13, $B8, $5D, $0, $A2, $44, $E4, $84, $24, $C2, $60, $FE, $9B, $37, $D4, $70, $B, $A7, $43, $DE, $79, $15, $B1, $4D, $E9, $85, $22, $C0, $5D, $FC, $9B, $3A, $DB, $7C, $1E, $C1, $65, $A, $B0, $57

NEXT_ROW_Y_H: ; 0F00
.byte $9, $9, $9, $9, $9, $9, $8, $8, $8, $8, $8, $7, $7, $7, $7, $7, $6, $6, $6, $6, $5, $5, $5, $5, $5, $4, $4, $4, $3, $3, $3, $3, $2, $2, $2, $2, $1, $1, $1, $1, $0, $0, $0, $FF, $FF, $FF, $FF, $FE, $FE, $FE, $FD, $FD, $FD, $FD, $FC, $FC, $FC, $FC, $FB, $FB, $FB, $FB, $FA, $FA, $FA, $FA, $F9, $F9, $F9, $F9, $F8, $F8, $F8, $F8, $F8, $F7, $F7, $F7, $F7, $F7, $F7, $F6, $F6, $F6, $F6, $F6, $F6, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F6, $F6, $F6, $F6, $F6, $F6, $F6, $F7, $F7, $F7, $F7, $F7, $F8, $F8, $F8, $F8, $F8, $F9, $F9, $F9, $F9, $FA, $FA, $FA, $FA, $FA, $FB, $FB, $FB, $FC, $FC, $FC, $FC, $FD, $FD, $FD, $FD, $FE, $FE, $FE, $FE, $FF, $FF, $FF, $0, $0, $0, $0, $1, $1, $1, $2, $2, $2, $2, $3, $3, $3, $3, $4, $4, $4, $4, $5, $5, $5, $5, $6, $6, $6, $6, $7, $7, $7, $7, $7, $8, $8, $8, $8, $8, $8, $9, $9, $9, $9, $9, $9, $A, $A, $A, $A, $A, $A, $A, $A, $A, $A, $A, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $B, $A, $A, $A, $A, $A, $A, $A, $A, $A, $A, $9

NEXT_ROW_Y_L: ; 1000
.byte $CC, $A7, $82, $5A, $32, $8, $DC, $AF, $81, $52, $21, $EF, $BB, $87, $51, $1B, $E3, $AA, $70, $35, $F9, $BC, $7E, $40, $1, $C0, $80, $3E, $FC, $B9, $75, $32, $ED, $A8, $63, $1D, $D7, $91, $4B, $4, $BD, $76, $2F, $E8, $A1, $5A, $13, $CC, $85, $3F, $F9, $B3, $6E, $29, $E4, $A0, $5D, $19, $D7, $95, $54, $14, $D4, $95, $57, $1A, $DE, $A3, $68, $2F, $F7, $C0, $8A, $55, $21, $EF, $BE, $8E, $5F, $32, $6, $DB, $B2, $8A, $64, $3F, $1C, $FA, $DA, $BB, $9E, $83, $69, $51, $3A, $25, $12, $0, $F0, $E2, $D6, $CB, $C2, $BB, $B5, $B2, $B0, $AF, $B1, $B4, $B9, $C0, $C8, $D2, $DE, $EC, $FB, $C, $1F, $33, $49, $61, $7A, $95, $B1, $CF, $EF, $10, $33, $58, $7D, $A5, $CD, $F7, $23, $50, $7E, $AD, $DE, $10, $44, $78, $AE, $E4, $1C, $55, $8F, $CA, $6, $43, $81, $BF, $FE, $3F, $7F, $C1, $3, $46, $8A, $CD, $12, $57, $9C, $E2, $28, $6E, $B4, $FB, $42, $89, $D0, $17, $5E, $A5, $EC, $33, $7A, $C0, $6, $4C, $91, $D6, $1B, $5F, $A2, $E6, $28, $6A, $AB, $EB, $2B, $6A, $A8, $E5, $21, $5C, $97, $D0, $8, $3F, $75, $AA, $DE, $10, $41, $71, $A0, $CD, $F9, $24, $4D, $75, $9B, $C0, $E3, $5, $25, $44, $61, $7C, $96, $AE, $C5, $DA, $ED, $FF, $F, $1D, $29, $34, $3D, $44, $4A, $4D, $4F, $50, $4E, $4B, $46, $3F, $37, $2D, $21, $13, $4, $F3, $E0, $CC, $B6, $9E, $85, $6A, $4E, $30, $10, $EF


SPRITE_NUM_HIGH_NIBBLE:
.res 16, 33
.res 16, 34
.res 16, 35
.res 16, 36
.res 16, 37
.res 16, 38
.res 16, 39
.res 16, 40
.res 16, 41
.res 16, 42
.res 16, 43
.res 16, 44
.res 16, 45
.res 16, 46
.res 16, 47
.res 16, 48

SPRITE_NUM_LOW_NIBBLE:
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48
.byte 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48

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
  LDX #7   ;   num pages to copy 
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
  LDA #255
  STA VERA_addr_low
  lda #>VRAM_sprite_attributes
  sta VERA_addr_high
  lda #$19   ;  decrement 1 bank 1
  sta VERA_addr_bank
  LDX #255
  :
    LDA test_sprite_data,X 
    STA VERA_data0 
    DEX 
    BNE :- 
   LDA test_sprite_data,X 
   STA VERA_data0 

  ; write custom palette data  - 16 colors only for now.. $1:FA00-$1:FBFF   VERA Color Palette (256 x 2 bytes) 
  LDX #31
  STX VERA_addr_low
  LDA #$FA
  STA VERA_addr_high
  LDA #$19
  STA VERA_addr_bank
  :
    LDA test_optimal_pal_data,X 
    STA VERA_data0
    DEX 
    BNE :-
  LDA test_optimal_pal_data,X 
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
   lda #128
   STA VERA_addr_low
   LDA #$FC
   STA VERA_addr_high
   LDA #$41
   STA VERA_addr_bank
   ldx camera_facing
   LDA SPRITE_NUM_HIGH_NIBBLE,X 
   STA VERA_data0
   LDA SPRITE_NUM_LOW_NIBBLE,X 
   STA VERA_data0

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
	STZ VERA_addr_low
    lda #>VRAM_sprite_attributes+1
    sta VERA_addr_high
    lda #$11
    sta VERA_addr_bank

  
    ; load increments and set start position...
    LDX camera_facing
    TXA 
    EOR #$80
    STA ZP_PTR+17
    ; increments across rows
    STZ ZP_PTR+16   ; 	set quad jump index

    STZ ZP_PTR+12 	;	next row  start XL at ZP_PTR+12
    STZ ZP_PTR+14 	;	next row  start YL at ZP_PTR+14
 
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

    LDA #$50
    STA ZP_PTR+30

    LDY #96		;	amount of sprites we can write max
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

   LDX #8
  	LDA ZP_PTR+12 	;
  	STA ZP_PTR 		;	current row XL

    CLC  ; clear before doing 16bit add!
    ADC ZP_PTR+8
    STA ZP_PTR+12 	;	next row XL 
    LDA ZP_PTR+13 	;
    STA ZP_PTR+1  ;  current row XH
    ADC ZP_PTR+9  ;
    STA ZP_PTR+13    ;  next row XH

    LDA ZP_PTR+1
    CMP #201
    BCS @next_quad 		;	off screen

    CLC  ; clear before doing 16bit add!
    LDA ZP_PTR+14 	
    STA ZP_PTR+2 	;	current row YL
    ADC ZP_PTR+10 	
    STA ZP_PTR+14 	;	next row YL
    LDA ZP_PTR+15 
    STA ZP_PTR+3
    ADC ZP_PTR+11    
    STA ZP_PTR+15    ;  next row YH 

    LDA ZP_PTR+3
    CMP #153 	
    BCS @next_quad;	off screen 
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
      LDA #$50 			; 	16x8 no palette offset
      LDA ZP_PTR+30;
      STA VERA_data0
    ; increment X
    CLC  ; clear before doing 16bit add!
      LDA ZP_PTR 	;	load X_l

      ADC ZP_PTR+4 	
      STA ZP_PTR

      LDA ZP_PTR+1
      ADC ZP_PTR+5
      CMP #208
      BCS @next_row		; covers negatives even.. 
      STA ZP_PTR+1
    ; increment Y
    CLC  ; clear before doing 16bit add!

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
    CLC  ; clear before doing 16bit add!
    LDA ACROSS_ROW_X_L,X 
    STA ZP_PTR+4 	; 	ZP_PTR+4 = spriteX increment Low byte
    STA ZP_PTR+12
    LDA ACROSS_ROW_X_H,X 
    STA ZP_PTR+5 	;	ZP_PTR+4 = spriteX increment high byte
    ADC #100
    STA ZP_PTR+13
    CLC  ; clear before doing 16bit add!
    LDA ACROSS_ROW_Y_L,X 
    STA ZP_PTR+6 	; 	ZP_PTR+6 = spriteY increment low byte
    STA ZP_PTR+14
    LDA ACROSS_ROW_Y_H,X 
    STA ZP_PTR+7 	; 	ZP_PTR+3 = spriteY increment 
    ADC #132
    STA ZP_PTR+15
    jmp @quad_loop
@quad_2: ; invert next row - start 1 row up 
	LDX ZP_PTR+17

    CLC  ; clear before doing 16bit add!
    LDA NEXT_ROW_X_L,X 
    STA ZP_PTR+8 	; 	ZP_PTR+4 = spriteX increment Low byte
    STA ZP_PTR+12
    STA ZP_PTR+18
    LDA NEXT_ROW_X_H,X 
    STA ZP_PTR+9 	;	ZP_PTR+4 = spriteX increment high byte
    ADC #100
    STA ZP_PTR+13
    STA ZP_PTR+19

    CLC  ; clear before doing 16bit add!
    LDA NEXT_ROW_Y_L,X 
    STA ZP_PTR+10 	; 	ZP_PTR+6 = spriteY increment low byte
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

    CLC  ; clear before doing 16bit add!   
    LDA ACROSS_ROW_X_L,X 
    STA ZP_PTR+4 	; 	ZP_PTR+4 = spriteX increment Low byte
    ADC ZP_PTR+18
    STA ZP_PTR+12
    LDA ACROSS_ROW_X_H,X 
    STA ZP_PTR+5 	;	ZP_PTR+4 = spriteX increment high byte
    ADC ZP_PTR+19
    STA ZP_PTR+13

    CLC  ; clear before doing 16bit add!
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
.res 8, 0  ; sprite B 
.res 8, 0  ; sprite C
.res 8, 0  ; sprite D 
.res 8, 0  ; sprite E 
.res 8, 0  ; sprite F
.byte  33,$00,  8,  0,  9,  0,$0C,$00  ; 0 test    sprite 10   bearing
.byte  34,$00, 16,  0,  9,  0,$0C,$00  ; 1 test    sprite 11
.byte  35,$00,  8,  0, 18,  0,$0C,$00  ; 2 test    sprite 12   Cell X 
.byte  36,$00, 16,  0, 18,  0,$0C,$00  ; 3 test    sprite 13   
.byte  37,$00, 28,  0, 18,  0,$0C,$00  ; 4 test    sprite 14   Cell Y
.byte  38,$00, 36,  0, 18,  0,$0C,$00  ; 5 test    sprite 15   
.byte  39,$00,  8,  0, 27,  0,$0C,$00  ; 6 test    sprite 16   world XH
.byte  40,$00, 16,  0, 27,  0,$0C,$00  ; 7 test    sprite 17   
.byte  41,$00, 28,  0, 27,  0,$0C,$00  ; 8 test    sprite 18   world Xl
.byte  42,$00, 36,  0, 27,  0,$0C,$00  ; 9 test    sprite 19
.byte  43,$00, 52,  0, 27,  0,$0C,$00  ; A test    sprite 1A   world YH
.byte  44,$00, 60,  0, 27,  0,$0C,$00  ; B test    sprite 1B
.byte  45,$00, 72,  0, 27,  0,$0C,$00  ; C test    sprite 1C   world Yl
.byte  46,$00, 80,  0, 27,  0,$0C,$00  ; D test    sprite 1D
.byte  47,$00,120,  0,  9,  0,$0C,$00  ; E test    sprite 1E   unused counters
.byte  48,$00,128,  0,  9,  0,$0C,$00  ; F test    sprite 1F

test_optimal_pal_data:
;      GB   R  $1:FA00-$1:FBFF   VERA Color Palette (256 x 2 bytes)
.byte $00,$00  ; 0 - black/transparent
.byte $EC,$0F  ; 1 - cream
.byte $04,$06  ; 2 #660044
.byte $00,$0C  ; 3  #cc0000
.byte $F0,$0C  ; 4#ccff00
.byte $c8,$0f  ; 5 #ffcc88
.byte $60,$0c   ; 6  #cc6600
.byte $40,$08   ; 7 #884400
.byte $c0,$0c   ; 8 #cccc00
.byte $6a,$02   ; 9 #2266aa mid blue
.byte $c0,$00   ; A #00cc00
.byte $ac,$07   ; B #77aacc light blue
.byte $c0,$00   ; C #0000c0 dark blue
.byte $0c,$0c   ; D #cc00cc
.byte $88,$08   ; E #888888
.byte $22,$02   ; F #222222

test_vram_data:
test_cell_sprite: 	;	is 16x64x16 bit = 512 bytes   sprite addr = 0 
; 	   01   23   45   67   89   AB   CD   EF
.byte $CC, $C9, $CC, $C9, $CC, $C9, $CC, $C0    ;  0
.byte $09, $9B, $99, $9B, $99, $9B, $99, $9C    ;  1
.byte $CB, $BC, $BB, $BC, $BB, $BC, $BB, $B0    ;  2
.byte $0C, $C9, $CC, $C9, $CC, $C9, $CC, $CC    ;  3
.byte $C9, $9B, $99, $9B, $99, $9B, $99, $90    ;  4
.byte $0B, $BC, $BB, $BC, $BB, $BC, $BB, $BC    ;  5
.byte $CC, $C9, $CC, $C9, $CC, $C9, $CC, $C0    ;  6
.byte $09, $9B, $99, $9B, $99, $9B, $99, $9C    ;  7
.byte $CB, $BC, $BB, $BC, $BB, $BC, $BB, $B0    ;  8 ; 45* is 9.5 .. 
.byte $0C, $09, $0C, $09, $0C, $09, $0C, $0C    ;  9
.byte $09, $90, $09, $90, $09, $90, $09, $90   ;  10
.byte $90, $09, $90, $09, $90, $09, $90, $09   ; 11
.res 32, 0  ;  5 lines zeroed


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

HEX_DISPLAY_FONT:       ; 8x8x16 color = 32 bytes ... sprite addr 33+ ($0440)
;     01   23   45   67
.byte $00, $11, $11, $00   ; 0
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $00, $00, $00, $00
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $00, $11, $11, $00   ; 0 /

.byte $00, $00, $00, $00 ; 1
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $00, $00, $00
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $00, $00, $00

.byte $00, $11, $11, $00   ; 2
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $11, $11, $00
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $00, $11, $11, $00   

.byte $00, $11, $11, $00   ; 3
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $11, $11, $00
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $11, $11, $00   

.byte $00, $00, $00, $00   ; 4
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $00, $11, $11, $00
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $00, $00, $00   

.byte $00, $11, $11, $00   ; 5
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $00, $11, $11, $00
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $11, $11, $00   

.byte $00, $11, $11, $00   ; 6
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $00, $11, $11, $00
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $00, $11, $11, $00   

.byte $00, $01, $01, $00 ; 7
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $00, $00, $00
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $00, $00, $00

.byte $00, $11, $11, $00   ; 8
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $00, $11, $11, $00
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $00, $11, $11, $00   

.byte $00, $11, $11, $00   ; 9
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $00, $11, $11, $00
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $11, $11, $00   

.byte $00, $11, $11, $00   ; A
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $00, $11, $11, $00
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $00, $00, $00, $00   


.byte $00, $00, $00, $00   ; B
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $00, $11, $11, $00
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $00, $11, $11, $00   

.byte $00, $11, $11, $00   ; C
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $00, $00, $00, $00
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $00, $11, $11, $00   

.byte $00, $00, $00, $00   ; D
.byte $00, $00, $00, $10
.byte $00, $00, $00, $10
.byte $00, $11, $11, $00
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $01, $00, $00, $10
.byte $00, $11, $11, $00   

.byte $00, $11, $11, $00   ; E
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $00, $11, $11, $00
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $00, $11, $11, $00   

.byte $00, $11, $11, $00   ; F
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $00, $11, $11, $00
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $00, $00, $00, $00   
