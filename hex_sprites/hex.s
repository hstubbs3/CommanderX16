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

ACROSS_ROW_X_L: ; 0900  16 wide , 45* tilt ... this is added to go up row, sub for down row
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte $0, $FE, $FB, $F4, $EC, $E1, $D3, $C3, $B1, $9C, $85, $6B, $4F, $31, $10, $ED, $C8, $A0, $76, $4A, $1C, $EB, $B9, $84, $4D, $14, $D9, $9D, $5E, $1D, $DA, $96, $50, $8, $BE, $73, $26, $D7, $87, $36, $E3, $8F, $39, $E2, $8A, $31, $D7, $7B, $1F, $C2, $63, $4, $A5, $44, $E3, $81, $1F, $BC, $59, $F5, $91, $2D, $C8, $64, $0, $9B, $37, $D2, $6E, $A, $A6, $43, $E0, $7E, $1C, $BB, $5A, $FB, $9C, $3D, $E0, $84, $28, $CE, $75, $1D, $C6, $70, $1C, $C9, $78, $28, $D9, $8C, $41, $F7, $AF, $69, $25, $E2, $A1, $62, $26, $EB, $B2, $7B, $46, $14, $E3, $B5, $89, $5F, $37, $12, $EF, $CE, $B0, $94, $7A, $63, $4E, $3C, $2C, $1E, $13, $B, $4, $1, $0, $1, $4, $B, $13, $1E, $2C, $3C, $4E, $63, $7A, $94, $B0, $CE, $EF, $12, $37, $5F, $89, $B5, $E3, $14, $46, $7B, $B2, $EB, $26, $62, $A1, $E2, $25, $69, $AF, $F7, $41, $8C, $D9, $28, $78, $C9, $1C, $70, $C6, $1D, $75, $CE, $28, $84, $E0, $3D, $9C, $FB, $5A, $BB, $1C, $7E, $E0, $43, $A6, $A, $6E, $D2, $37, $9B, $0, $64, $C8, $2D, $91, $F5, $59, $BC, $1F, $81, $E3, $44, $A5, $4, $63, $C2, $1F, $7B, $D7, $31, $8A, $E2, $39, $8F, $E3, $36, $87, $D7, $26, $73, $BE, $8, $50, $96, $DA, $1D, $5E, $9D, $D9, $14, $4D, $84, $B9, $EB, $1C, $4A, $76, $A0, $C8, $ED, $10, $31, $4F, $6B, $85, $9C, $B1, $C3, $D3, $E1, $EC, $F4, $FB, $FE

ACROSS_ROW_X_H: ; 0A00
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte $10, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $E, $E, $E, $E, $E, $E, $D, $D, $D, $D, $D, $C, $C, $C, $C, $B, $B, $B, $B, $A, $A, $A, $9, $9, $9, $8, $8, $8, $7, $7, $7, $6, $6, $6, $5, $5, $5, $4, $4, $3, $3, $3, $2, $2, $1, $1, $1, $0, $0, $0, $FF, $FF, $FE, $FE, $FE, $FD, $FD, $FC, $FC, $FC, $FB, $FB, $FA, $FA, $FA, $F9, $F9, $F9, $F8, $F8, $F8, $F7, $F7, $F7, $F6, $F6, $F6, $F5, $F5, $F5, $F4, $F4, $F4, $F4, $F3, $F3, $F3, $F3, $F2, $F2, $F2, $F2, $F2, $F1, $F1, $F1, $F1, $F1, $F1, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F1, $F1, $F1, $F1, $F1, $F1, $F2, $F2, $F2, $F2, $F2, $F3, $F3, $F3, $F3, $F4, $F4, $F4, $F4, $F5, $F5, $F5, $F6, $F6, $F6, $F7, $F7, $F7, $F8, $F8, $F8, $F9, $F9, $F9, $FA, $FA, $FA, $FB, $FB, $FC, $FC, $FC, $FD, $FD, $FE, $FE, $FE, $FF, $FF, $00, $0, $0, $1, $1, $1, $2, $2, $3, $3, $3, $4, $4, $5, $5, $5, $6, $6, $6, $7, $7, $7, $8, $8, $8, $9, $9, $9, $A, $A, $A, $B, $B, $B, $B, $C, $C, $C, $C, $D, $D, $D, $D, $D, $E, $E, $E, $E, $E, $E, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F

ACROSS_ROW_Y_L: ; 0B00
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte $0,$B8,$71,$2A,$E4,$9D,$57,$10,$CA,$85,$40,$FB,$B7,$73,$30,$ED,$AB,$6A,$29,$E9,$AA,$6C,$2E,$F2,$B6,$7C,$42,$A,$D2,$9C,$66,$32,$0,$CE,$9D,$6E,$41,$14,$E9,$C0,$97,$71,$4B,$27,$5,$E4,$C5,$A8,$8C,$71,$58,$41,$2C,$18,$6,$F6,$E7,$DA,$CF,$C5,$BD,$B7,$B3,$B0,$AF,$B0,$B3,$B7,$BD,$C5,$CF,$DA,$E7,$F6,$6,$18,$2C,$41,$58,$71,$8C,$A8,$C5,$E4,$5,$27,$4B,$71,$97,$C0,$E9,$14,$41,$6E,$9D,$CE,$0,$32,$66,$9C,$D2,$A,$42,$7C,$B6,$F2,$2E,$6C,$AA,$E9,$29,$6A,$AB,$ED,$30,$73,$B7,$FB,$40,$85,$CA,$10,$57,$9D,$E4,$2A,$71,$B8,$0,$47,$8E,$D5,$1B,$62,$A8,$EF,$35,$7A,$BF,$4,$48,$8C,$CF,$12,$54,$95,$D6,$16,$55,$93,$D1,$D,$49,$83,$BD,$F5,$2D,$63,$99,$CD,$0,$31,$62,$91,$BE,$EB,$16,$3F,$68,$8E,$B4,$D8,$FA,$1B,$3A,$57,$73,$8E,$A7,$BE,$D3,$E7,$F9,$9,$18,$25,$30,$3A,$42,$48,$4C,$4F,$50,$4F,$4C,$48,$42,$3A,$30,$25,$18,$9,$F9,$E7,$D3,$BE,$A7,$8E,$73,$57,$3A,$1B,$FA,$D8,$B4,$8E,$68,$3F,$16,$EB,$BE,$91,$62,$31,$0,$CD,$99,$63,$2D,$F5,$BD,$83,$49,$D,$D1,$93,$55,$16,$D6,$95,$54,$12,$CF,$8C,$48,$4,$BF,$7A,$35,$EF,$A8,$62,$1B,$D5,$8E,$47

ACROSS_ROW_Y_H: ; 0C00 
;     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F  
.byte $0,$FF,$FF,$FF,$FE,$FE,$FE,$FE,$FD,$FD,$FD,$FC,$FC,$FC,$FC,$FB,$FB,$FB,$FB,$FA,$FA,$FA,$FA,$F9,$F9,$F9,$F9,$F9,$F8,$F8,$F8,$F8,$F8,$F7,$F7,$F7,$F7,$F7,$F6,$F6,$F6,$F6,$F6,$F6,$F6,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F6,$F6,$F6,$F6,$F6,$F6,$F6,$F7,$F7,$F7,$F7,$F7,$F8,$F8,$F8,$F8,$F8,$F9,$F9,$F9,$F9,$F9,$FA,$FA,$FA,$FA,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$00,$0,$0,$0,$1,$1,$1,$1,$2,$2,$2,$3,$3,$3,$3,$4,$4,$4,$4,$5,$5,$5,$5,$6,$6,$6,$6,$6,$7,$7,$7,$7,$8,$8,$8,$8,$8,$8,$9,$9,$9,$9,$9,$9,$9,$A,$A,$A,$A,$A,$A,$A,$A,$A,$A,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$A,$A,$A,$A,$A,$A,$A,$A,$A,$A,$9,$9,$9,$9,$9,$9,$9,$8,$8,$8,$8,$8,$8,$7,$7,$7,$7,$6,$6,$6,$6,$6,$5,$5,$5,$5,$4,$4,$4,$4,$3,$3,$3,$3,$2,$2,$2,$1,$1,$1,$1,$0,$0,$0

NEXT_ROW_X_L: ; 0D00 next row LEFT/up when added
.byte $0, $A9, $54, $0, $AE, $5D, $D, $BF, $73, $28, $DF, $98, $52, $E, $CC, $8C, $4E, $12, $D7, $9F, $69, $35, $3, $D3, $A6, $7B, $51, $2B, $6, $E4, $C4, $A6, $8B, $72, $5C, $48, $36, $27, $1A, $10, $8, $3, $0, $0, $2, $6, $D, $17, $23, $31, $42, $55, $6A, $83, $9D, $BA, $D9, $FA, $1E, $44, $6D, $97, $C4, $F3, $24, $58, $8D, $C5, $FE, $3A, $77, $B7, $F8, $3B, $80, $C7, $10, $5A, $A6, $F3, $42, $93, $E4, $38, $8D, $E3, $3A, $92, $EC, $47, $A2, $FF, $5D, $BB, $1B, $7B, $DB, $3D, $9F, $1, $64, $C8, $2B, $8F, $F4, $58, $BC, $21, $86, $EA, $4E, $B2, $16, $7A, $DD, $3F, $A2, $3, $64, $C5, $24, $83, $E1, $3E, $9A, $F5, $4F, $A8, $0, $56, $AB, $FF, $51, $A2, $F2, $40, $8C, $D7, $20, $67, $AD, $F1, $33, $73, $B1, $ED, $28, $60, $96, $CA, $FC, $2C, $59, $84, $AE, $D4, $F9, $1B, $3B, $59, $74, $8D, $A3, $B7, $C9, $D8, $E5, $EF, $F7, $FC, $FF, $FF, $FD, $F9, $F2, $E8, $DC, $CE, $BD, $AA, $95, $7C, $62, $45, $26, $5, $E1, $BB, $92, $68, $3B, $C, $DB, $A7, $72, $3A, $1, $C5, $88, $48, $7, $C4, $7F, $38, $EF, $A5, $59, $C, $BD, $6C, $1B, $C7, $72, $1C, $C5, $6D, $13, $B8, $5D, $0, $A2, $44, $E4, $84, $24, $C2, $60, $FE, $9B, $37, $D4, $70, $B, $A7, $43, $DE, $79, $15, $B1, $4D, $E9, $85, $22, $C0, $5D, $FC, $9B, $3A, $DB, $7C, $1E, $C1, $65, $A, $B0, $57

NEXT_ROW_X_H: ; 0E00
.byte $F8, $F7, $F7, $F7, $F6, $F6, $F6, $F5, $F5, $F5, $F4, $F4, $F4, $F4, $F3, $F3, $F3, $F3, $F2, $F2, $F2, $F2, $F2, $F1, $F1, $F1, $F1, $F1, $F1, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F1, $F1, $F1, $F1, $F1, $F1, $F2, $F2, $F2, $F2, $F2, $F3, $F3, $F3, $F3, $F4, $F4, $F4, $F5, $F5, $F5, $F5, $F6, $F6, $F6, $F7, $F7, $F7, $F8, $F8, $F8, $F9, $F9, $F9, $FA, $FA, $FB, $FB, $FB, $FC, $FC, $FD, $FD, $FD, $FE, $FE, $FE, $FF, $FF, $0, $0, $0, $1, $1, $2, $2, $2, $3, $3, $4, $4, $4, $5, $5, $5, $6, $6, $6, $7, $7, $8, $8, $8, $8, $9, $9, $9, $A, $A, $A, $B, $B, $B, $B, $C, $C, $C, $C, $D, $D, $D, $D, $D, $E, $E, $E, $E, $E, $E, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $F, $E, $E, $E, $E, $E, $E, $D, $D, $D, $D, $D, $C, $C, $C, $C, $B, $B, $B, $A, $A, $A, $A, $9, $9, $9, $8, $8, $8, $7, $7, $7, $6, $6, $6, $5, $5, $4, $4, $4, $3, $3, $2, $2, $2, $1, $1, $1, $0, $0, $FF, $FF, $FF, $FE, $FE, $FD, $FD, $FD, $FC, $FC, $FB, $FB, $FB, $FA, $FA, $FA, $F9, $F9, $F9, $F8, $F8

NEXT_ROW_Y_L: ; 0F00
.byte $33,$58,$7D,$A5,$CD,$F7,$23,$50,$7E,$AD,$DE,$10,$44,$78,$AE,$E4,$1C,$55,$8F,$CA,$6,$43,$81,$BF,$FE,$3F,$7F,$C1,$3,$46,$8A,$CD,$12,$57,$9C,$E2,$28,$6E,$B4,$FB,$42,$89,$D0,$17,$5E,$A5,$EC,$33,$7A,$C0,$6,$4C,$91,$D6,$1B,$5F,$A2,$E6,$28,$6A,$AB,$EB,$2B,$6A,$A8,$E5,$21,$5C,$97,$D0,$8,$3F,$75,$AA,$DE,$10,$41,$71,$A0,$CD,$F9,$24,$4D,$75,$9B,$C0,$E3,$5,$25,$44,$61,$7C,$96,$AE,$C5,$DA,$ED,$FF,$F,$1D,$29,$34,$3D,$44,$4A,$4D,$4F,$50,$4E,$4B,$46,$3F,$37,$2D,$21,$13,$4,$F3,$E0,$CC,$B6,$9E,$85,$6A,$4E,$30,$10,$EF,$CC,$A7,$82,$5A,$32,$8,$DC,$AF,$81,$52,$21,$EF,$BB,$87,$51,$1B,$E3,$AA,$70,$35,$F9,$BC,$7E,$40,$1,$C0,$80,$3E,$FC,$B9,$75,$32,$ED,$A8,$63,$1D,$D7,$91,$4B,$4,$BD,$76,$2F,$E8,$A1,$5A,$13,$CC,$85,$3F,$F9,$B3,$6E,$29,$E4,$A0,$5D,$19,$D7,$95,$54,$14,$D4,$95,$57,$1A,$DE,$A3,$68,$2F,$F7,$C0,$8A,$55,$21,$EF,$BE,$8E,$5F,$32,$6,$DB,$B2,$8A,$64,$3F,$1C,$FA,$DA,$BB,$9E,$83,$69,$51,$3A,$25,$12,$0,$F0,$E2,$D6,$CB,$C2,$BB,$B5,$B2,$B0,$AF,$B1,$B4,$B9,$C0,$C8,$D2,$DE,$EC,$FB,$C,$1F,$33,$49,$61,$7A,$95,$B1,$CF,$EF,$10

NEXT_ROW_Y_H: ; 1000
.byte $F6,$F6,$F6,$F6,$F6,$F6,$F7,$F7,$F7,$F7,$F7,$F8,$F8,$F8,$F8,$F8,$F9,$F9,$F9,$F9,$FA,$FA,$FA,$FA,$FA,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$0,$0,$0,$0,$1,$1,$1,$2,$2,$2,$2,$3,$3,$3,$3,$4,$4,$4,$4,$5,$5,$5,$5,$6,$6,$6,$6,$7,$7,$7,$7,$7,$8,$8,$8,$8,$8,$8,$9,$9,$9,$9,$9,$9,$A,$A,$A,$A,$A,$A,$A,$A,$A,$A,$A,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$B,$A,$A,$A,$A,$A,$A,$A,$A,$A,$A,$9,$9,$9,$9,$9,$9,$9,$8,$8,$8,$8,$8,$7,$7,$7,$7,$7,$6,$6,$6,$6,$5,$5,$5,$5,$5,$4,$4,$4,$3,$3,$3,$3,$2,$2,$2,$2,$1,$1,$1,$1,$0,$0,$0,$FF,$FF,$FF,$FF,$FE,$FE,$FE,$FD,$FD,$FD,$FD,$FC,$FC,$FC,$FC,$FB,$FB,$FB,$FB,$FA,$FA,$FA,$FA,$F9,$F9,$F9,$F9,$F8,$F8,$F8,$F8,$F8,$F7,$F7,$F7,$F7,$F7,$F7,$F6,$F6,$F6,$F6,$F6,$F6,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F4,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F5,$F6

TUB_WORLD: ; 32*64 = 2K ... is 1100 to 1900-1
.include "tub_world_hieghts_01.inc"

; 1900

OBJECT_LIST_Z_START_POINTERS: ; 1900
.res 256,0
OBJECT_LIST_BYTE0_ADDRLOW: ; 1A00 addr low
.res 256,0
OBJECT_LIST_BYTE1_MODE: ; 1B00 mode/addr bank
.res 256,0
OBJECT_LIST_BYTE2_X: ; 1C00 X position onscreen ( assumed positive for now)
.res 256,0
OBJECT_LIST_BYTE3_Y: ; 1D00 y position onscreen 
.res 256,0
OBJECT_LIST_BYTE4_ZFLIPS: ; 1E00 collision / z / flips
.res 256,0
OBJECT_LIST_BYTE5_SIZE: ; 1F00 size / pal offset
.res 256,0
OBJECT_LIST_BYTE6_NEXT: ; 2000 NEXT 
.res 256,0



WORLD_TO_CELL_XH: ; 2100
.byte 0,0,1,2,3,4,5,6,6,7,8,9,10,11,12,12,13,14,15,16,17,18,19,19,20,21,22,23,24,25,25,26,27,28,29,30,31,32,32,33,34,35,36,37,38,38,39,40,41,42,43,44,45,45,46,47,48,49,50,51,51,52,53,54,55,56,57,58,58,59,60,61,62,63,64,64,65,66,67,68,69,70,71,71,72,73,74,75,76,77,77,78,79,80,81,82,83,84,84,85,86,87,88,89,90,90,91,92,93,94,95,96,96,97,98,99,100,101,102,103,103,104,105,106,107,108,109,109,110,111,112,113,114,115,116,116,117,118,119,120,121,122,122,123,124,125,126,127,128,129,129,130,131,132,133,134,135,135,136,137,138,139,140,141,142,142,143,144,145,146,147,148,148,149,150,151,152,153,154,155,155,156,157,158,159,160,161,161,162,163,164,165,166,167,168,168,169,170,171,172,173,174,174,175,176,177,178,179,180,180,181,182,183,184,185,186,187,187,188,189,190,191,192,193,193,194,195,196,197,198,199,200,200,201,202,203,204,205,206,206,207,208,209,210,211,212,213,213,214,215,216,217,218,219,219,220
;.byte 0,0,1,2,3,4,5,6,6,7,8,9,10,11,12,12,13,14,15,16,17,18,19,19,20,21,22,23,24,25,25,26,27,28,29,30,31,32,32,33,34,35,36,37,38,38,39,40,41,42,43,44,45,45,46,47,48,49,50,51,51,52,53,54,55,56,57,58,58,59,60,61,62,63,64,64,65,66,67,68,69,70,71,71,72,73,74,75,76,77,77,78,79,80,81,82,83,84,84,85,86,87,88,89,90,90,91,92,93,94,95,96,96,97,98,99,100,101,102,103,103,104,105,106,107,108,109,109
;.res 128,128
WORLD_TO_CELL_XL:
.byte 0,221,187,153,118,84,50,15,237,203,169,134,100,66,31,253,219,184,150,116,82,47,13,235,200,166,132,97,63,29,251,216,182,148,113,79,45,10,232,198,164,129,95,61,26,248,214,180,145,111,77,42,8,230,195,161,127,93,58,24,246,211,177,143,108,74,40,6,227,193,159,124,90,56,21,243,209,175,140,106,72,37,3,225,191,156,122,88,53,19,241,206,172,138,104,69,35,1,222,188,154,119,85,51,17,238,204,170,135,101,67,32,254,220,186,151,117,83,48,14,236,202,167,133,99,64,30,252,217,183,149,115,80,46,12,233,199,165,130,96,62,28,249,215,181,146,112,78,43,9,231,197,162,128,94,59,25,247,212,178,144,110,75,41,7,228,194,160,126,91,57,23,244,210,176,141,107,73,39,4,226,192,157,123,89,54,20,242,208,173,139,105,70,36,2,223,189,155,121,86,52,18,239,205,171,137,102,68,34,255,221,187,152,118,84,50,15,237,203,168,134,100,65,31,253,219,184,150,116,81,47,13,234,200,166,132,97,63,29,250,216,182,148,113,79,45,10,232,198,163,129,95,61,26,248,214
;.byte 0,221,187,153,118,84,50,15,237,203,169,134,100,66,31,253,219,184,150,116,82,47,13,235,200,166,132,97,63,29,251,216,182,148,113,79,45,10,232,198,164,129,95,61,26,248,214,180,145,111,77,42,8,230,195,161,127,93,58,24,246,211,177,143,108,74,40,6,227,193,159,124,90,56,21,243,209,175,140,106,72,37,3,225,191,156,122,88,53,19,241,206,172,138,104,69,35,1,222,188,154,119,85,51,17,238,204,170,135,101,67,32,254,220,186,151,117,83,48,14,236,202,167,133,99,64,30,252
;.res 128,0
CELL_TO_WORLD_XH: ; 2200
.byte 0,1,2,3,4,5,6,8,9,10,11,12,13,15,16,17,18,19,20,21,23,24,25,26,27,28,30,31,32,33,34,35,36,38,39,40,41,42,43,45,46,47,48,49,50,51,53,54,55,56,57,58,60,61,62,63,64,65,66,68,69,70,71,72,73,75,76,77,78,79,80,81,83,84,85,86,87,88,90,91,92,93,94,95,96,98,99,100,101,102,103,105,106,107,108,109,110,112,113,114,115,116,117,118,120,121,122,123,124,125,127,128,129,130,131,132,133,135,136,137,138,139,140,142,143,144,145,146
CELL_TO_WORLD_XL: ; 2280
.byte 0,39,79,118,158,198,237,21,60,100,140,179,219,2,42,82,121,161,200,240,24,63,103,142,182,222,5,45,84,124,164,203,243,26,66,106,145,185,224,8,48,87,127,166,206,246,29,69,108,148,188,227,11,50,90,130,169,209,248,32,72,111,151,191,230,14,53,93,133,172,212,251,35,75,114,154,193,233,17,56,96,135,175,215,254,38,77,117,157,196,236,19,59,99,138,178,217,1,41,80,120,159,199,239,22,62,101,141,181,220,4,43,83,123,162,202,241,25,65,104,144,184,223,7,46,86,126,165

CELL_LOW_TO_WORLD_XH: ; 2300
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
CELL_LOW_TO_WORLD_XL: ; 2400
.byte 0,1,2,3,4,5,6,8,9,10,11,12,13,15,16,17,18,19,20,21,23,24,25,26,27,28,30,31,32,33,34,35,36,38,39,40,41,42,43,45,46,47,48,49,50,51,53,54,55,56,57,58,60,61,62,63,64,65,66,68,69,70,71,72,73,75,76,77,78,79,80,81,83,84,85,86,87,88,90,91,92,93,94,95,96,98,99,100,101,102,103,105,106,107,108,109,110,112,113,114,115,116,117,118,120,121,122,123,124,125,127,128,129,130,131,132,133,135,136,137,138,139,140,142,143,144,145,146,147,148,150,151,152,153,154,155,157,158,159,160,161,162,163,165,166,167,168,169,170,172,173,174,175,176,177,178,180,181,182,183,184,185,187,188,189,190,191,192,193,195,196,197,198,199,200,202,203,204,205,206,207,209,210,211,212,213,214,215,217,218,219,220,221,222,224,225,226,227,228,229,230,232,233,234,235,236,237,239,240,241,242,243,244,245,247,248,249,250,251,252,254,255,0,1,2,3,4,6,7,8,9,10,11,13,14,15,16,17,18,19,21,22,23,24,25,26,28,29,30,31,32,33,34,36,37,38

SPRITE_NUM_HIGH_NIBBLE: ; 2900
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

SPRITE_NUM_LOW_NIBBLE: ; 2A00
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

SCREEN_Y_TO_Z: ; 2B00
.byte 255,253,251,250,248,247,245,243,242,240,239,237,235,234,232,231,229,227,226,224,223,221,220,218,216,215,213,212,210,208,207,205,204,202,200,199,197,196,194,192,191,189,188,186,185,183,181,180,178,177,175,173,172,170,169,167,165,164,162,161,159,158,156,154,153,151,150,148,146,145,143,142,140,138,137,135,134,132,130,129,127,126,124,123,121,119,118,116,115,113,111,110,108,107,105,103,102,100,99,97,95,94,92,91,89,88,86,84,83,81,80,78,76,75,73,72,70,68,67,65,64,62,61,59,57,56,54,53,51,49,48,46,45,43,41,40,38,37,35,33,32,30,29,27,26,24,22,21,19,18,16,14,13,11,10,8,6,5,3,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

CONVERT_HEIGHTS_PIXELS: ; 2C00
;.byte 0,0,1,1,2,3,3,4,4,5,6,6,7,7,8,9,9,10,11,11,12,12,13,14,14,15,15,16,17,17,18,18,19,20,20,21,22,22,23,23,24,25,25,26,26,27,28,28,29,30,30,31,31,32,33,33,34,34,35,36,36,37,37,38,39,39,40,41,41,42,42,43,44,44,45,45,46,47,47,48,48,49,50,50,51,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,0,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52;,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52
.res 128,0
.res 128,0
CONVERT_HEIGHTS_PIXELS_SECONDARY: ; 2D00
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,2,3,3,4,4,5,6,6,7,8,8,9,9,10,11,11,12,12,13,14,14,15,15,16,17,17,18,19,19,20,20,21,22,22,23,23,24,25,25,26,26,27,28,28,29,30,30,31,31,32,33,33,34,34,35,36,36,37,38,38,39,39,40,41,41,42,42,43,44,44,45,45,46,47,47,48,49,49,50,50,51,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52,52


SUBCELL_X_COS_L:
.byte $0,$FF,$FF,$FF,$FE,$FE,$FD,$FC,$FB,$F9,$F8,$F6,$F4,$F3,$F1,$EE,$EC,$EA,$E7,$E4,$E1,$DE,$DB,$D8,$D4,$D1,$CD,$C9,$C5,$C1,$BD,$B9,$B5,$B0,$AB,$A7,$A2,$9D,$98,$93,$8E,$88,$83,$7E,$78,$73,$6D,$67,$61,$5C,$56,$50,$4A,$44,$3E,$38,$31,$2B,$25,$1F,$19,$12,$C,$6,$0,$F9,$F3,$ED,$E6,$E0,$DA,$D4,$CE,$C7,$C1,$BB,$B5,$AF,$A9,$A3,$9E,$98,$92,$8C,$87,$81,$7C,$77,$71,$6C,$67,$62,$5D,$58,$54,$4F,$4A,$46,$42,$3E,$3A,$36,$32,$2E,$2B,$27,$24,$21,$1E,$1B,$18,$15,$13,$11,$E,$C,$B,$9,$7,$6,$4,$3,$2,$1,$1,$0,$0,$0,$0,$0,$0,$0,$1,$1,$2,$3,$4,$6,$7,$9,$B,$C,$E,$11,$13,$15,$18,$1B,$1E,$21,$24,$27,$2B,$2E,$32,$36,$3A,$3E,$42,$46,$4A,$4F,$54,$58,$5D,$62,$67,$6C,$71,$77,$7C,$81,$87,$8C,$92,$98,$9E,$A3,$A9,$AF,$B5,$BB,$C1,$C7,$CE,$D4,$DA,$E0,$E6,$ED,$F3,$F9,$0,$6,$C,$12,$19,$1F,$25,$2B,$31,$38,$3E,$44,$4A,$50,$56,$5C,$61,$67,$6D,$73,$78,$7E,$83,$88,$8E,$93,$98,$9D,$A2,$A7,$AB,$B0,$B5,$B9,$BD,$C1,$C5,$C9,$CD,$D1,$D4,$D8,$DB,$DE,$E1,$E4,$E7,$EA,$EC,$EE,$F1,$F3,$F4,$F6,$F8,$F9,$FB,$FC,$FD,$FE,$FE,$FF,$FF,$FF
SUBCELL_X_COS_H:
.byte $1,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
SUBCELL_X_SIN_H:
.byte $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
SUBCELL_X_SIN_L:
.byte $0,$5,$A,$10,$15,$1B,$20,$25,$2B,$30,$35,$3B,$40,$45,$4A,$4F,$54,$59,$5E,$63,$68,$6D,$71,$76,$7B,$7F,$84,$88,$8C,$90,$94,$98,$9C,$A0,$A4,$A7,$AB,$AE,$B2,$B5,$B8,$BB,$BE,$C0,$C3,$C6,$C8,$CA,$CC,$CE,$D0,$D2,$D4,$D5,$D7,$D8,$D9,$DA,$DB,$DC,$DC,$DD,$DD,$DD,$DD,$DD,$DD,$DD,$DC,$DC,$DB,$DA,$D9,$D8,$D7,$D5,$D4,$D2,$D0,$CE,$CC,$CA,$C8,$C6,$C3,$C0,$BE,$BB,$B8,$B5,$B2,$AE,$AB,$A7,$A4,$A0,$9C,$98,$94,$90,$8C,$88,$84,$7F,$7B,$76,$71,$6D,$68,$63,$5E,$59,$54,$4F,$4A,$45,$40,$3B,$35,$30,$2B,$25,$20,$1B,$15,$10,$A,$5,$0,$FA,$F5,$EF,$EA,$E4,$DF,$DA,$D4,$CF,$CA,$C4,$BF,$BA,$B5,$B0,$AB,$A6,$A1,$9C,$97,$92,$8E,$89,$84,$80,$7B,$77,$73,$6F,$6B,$67,$63,$5F,$5B,$58,$54,$51,$4D,$4A,$47,$44,$41,$3F,$3C,$39,$37,$35,$33,$31,$2F,$2D,$2B,$2A,$28,$27,$26,$25,$24,$23,$23,$22,$22,$22,$22,$22,$22,$22,$23,$23,$24,$25,$26,$27,$28,$2A,$2B,$2D,$2F,$31,$33,$35,$37,$39,$3C,$3F,$41,$44,$47,$4A,$4D,$51,$54,$58,$5B,$5F,$63,$67,$6B,$6F,$73,$77,$7B,$80,$84,$89,$8E,$92,$97,$9C,$A1,$A6,$AB,$B0,$B5,$BA,$BF,$C4,$CA,$CF,$D4,$DA,$DF,$E4,$EA,$EF,$F5,$FA
SUBCELL_Y_COS_H:
.byte $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
SUBCELL_Y_COS_L:
.byte $9C,$9C,$9C,$9C,$9C,$9B,$9B,$9A,$99,$98,$98,$97,$96,$94,$93,$92,$90,$8F,$8D,$8C,$8A,$88,$86,$84,$82,$80,$7D,$7B,$79,$76,$74,$71,$6E,$6C,$69,$66,$63,$60,$5D,$5A,$57,$53,$50,$4D,$49,$46,$43,$3F,$3B,$38,$34,$31,$2D,$29,$26,$22,$1E,$1A,$17,$13,$F,$B,$7,$3,$0,$FC,$F8,$F4,$F0,$EC,$E8,$E5,$E1,$DD,$D9,$D6,$D2,$CE,$CB,$C7,$C4,$C0,$BC,$B9,$B6,$B2,$AF,$AC,$A8,$A5,$A2,$9F,$9C,$99,$96,$93,$91,$8E,$8B,$89,$86,$84,$82,$7F,$7D,$7B,$79,$77,$75,$73,$72,$70,$6F,$6D,$6C,$6B,$69,$68,$67,$67,$66,$65,$64,$64,$63,$63,$63,$63,$63,$63,$63,$63,$63,$64,$64,$65,$66,$67,$67,$68,$69,$6B,$6C,$6D,$6F,$70,$72,$73,$75,$77,$79,$7B,$7D,$7F,$82,$84,$86,$89,$8B,$8E,$91,$93,$96,$99,$9C,$9F,$A2,$A5,$A8,$AC,$AF,$B2,$B6,$B9,$BC,$C0,$C4,$C7,$CB,$CE,$D2,$D6,$D9,$DD,$E1,$E5,$E8,$EC,$F0,$F4,$F8,$FC,$0,$3,$7,$B,$F,$13,$17,$1A,$1E,$22,$26,$29,$2D,$31,$34,$38,$3B,$3F,$43,$46,$49,$4D,$50,$53,$57,$5A,$5D,$60,$63,$66,$69,$6C,$6E,$71,$74,$76,$79,$7B,$7D,$80,$82,$84,$86,$88,$8A,$8C,$8D,$8F,$90,$92,$93,$94,$96,$97,$98,$98,$99,$9A,$9B,$9B,$9C,$9C,$9C,$9C
SUBCELL_Y_SIN_H:
.byte $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
SUBCELL_Y_SIN_L:
.byte $0,$4,$8,$D,$11,$16,$1A,$1E,$23,$27,$2B,$30,$34,$38,$3C,$41,$45,$49,$4D,$51,$55,$59,$5D,$60,$64,$68,$6B,$6F,$72,$76,$79,$7C,$7F,$83,$86,$89,$8B,$8E,$91,$93,$96,$98,$9B,$9D,$9F,$A1,$A3,$A5,$A7,$A8,$AA,$AB,$AD,$AE,$AF,$B0,$B1,$B2,$B3,$B3,$B4,$B4,$B4,$B4,$B5,$B4,$B4,$B4,$B4,$B3,$B3,$B2,$B1,$B0,$AF,$AE,$AD,$AB,$AA,$A8,$A7,$A5,$A3,$A1,$9F,$9D,$9B,$98,$96,$93,$91,$8E,$8B,$89,$86,$83,$80,$7C,$79,$76,$72,$6F,$6B,$68,$64,$60,$5D,$59,$55,$51,$4D,$49,$45,$41,$3C,$38,$34,$30,$2B,$27,$23,$1E,$1A,$16,$11,$D,$8,$4,$0,$FB,$F7,$F2,$EE,$E9,$E5,$E1,$DC,$D8,$D4,$CF,$CB,$C7,$C3,$BE,$BA,$B6,$B2,$AE,$AA,$A6,$A2,$9F,$9B,$97,$94,$90,$8D,$89,$86,$83,$80,$7C,$79,$76,$74,$71,$6E,$6C,$69,$67,$64,$62,$60,$5E,$5C,$5A,$58,$57,$55,$54,$52,$51,$50,$4F,$4E,$4D,$4C,$4C,$4B,$4B,$4B,$4B,$4A,$4B,$4B,$4B,$4B,$4C,$4C,$4D,$4E,$4F,$50,$51,$52,$54,$55,$57,$58,$5A,$5C,$5E,$60,$62,$64,$67,$69,$6C,$6E,$71,$74,$76,$79,$7C,$80,$83,$86,$89,$8D,$90,$94,$97,$9B,$9F,$A2,$A6,$AA,$AE,$B2,$B6,$BA,$BE,$C3,$C7,$CB,$CF,$D4,$D8,$DC,$E1,$E5,$E9,$EE,$F2,$F7,$FB

MOVE_Y_H:
.byte $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
MOVE_Y_L:
.byte $8,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$6,$6,$6,$6,$6,$6,$6,$6,$6,$5,$5,$5,$5,$5,$5,$5,$4,$4,$4,$4,$4,$4,$3,$3,$3,$3,$3,$3,$2,$2,$2,$2,$2,$1,$1,$1,$1,$1,$0,$0,$0,$0,$0,$0,$FF,$FF,$FF,$FF,$FF,$FE,$FE,$FE,$FE,$FE,$FD,$FD,$FD,$FD,$FD,$FC,$FC,$FC,$FC,$FC,$FC,$FB,$FB,$FB,$FB,$FB,$FB,$FA,$FA,$FA,$FA,$FA,$FA,$FA,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$FA,$FA,$FA,$FA,$FA,$FA,$FA,$FB,$FB,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$FF,$0,$0,$0,$0,$0,$0,$1,$1,$1,$1,$1,$2,$2,$2,$2,$2,$3,$3,$3,$3,$3,$3,$4,$4,$4,$4,$4,$4,$5,$5,$5,$5,$5,$5,$5,$6,$6,$6,$6,$6,$6,$6,$6,$6,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7,$7
MOVE_X_H:
.byte $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
MOVE_X_L:
.byte $0,$0,$0,$0,$0,$0,$1,$1,$1,$1,$1,$1,$2,$2,$2,$2,$2,$2,$2,$3,$3,$3,$3,$3,$3,$3,$4,$4,$4,$4,$4,$4,$4,$5,$5,$5,$5,$5,$5,$5,$5,$5,$5,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$6,$5,$5,$5,$5,$5,$5,$5,$5,$5,$5,$4,$4,$4,$4,$4,$4,$4,$3,$3,$3,$3,$3,$3,$3,$2,$2,$2,$2,$2,$2,$2,$1,$1,$1,$1,$1,$1,$0,$0,$0,$0,$0,$0,$FF,$FF,$FF,$FF,$FF,$FE,$FE,$FE,$FE,$FE,$FE,$FD,$FD,$FD,$FD,$FD,$FD,$FD,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FB,$FB,$FB,$FB,$FB,$FB,$FB,$FA,$FA,$FA,$FA,$FA,$FA,$FA,$FA,$FA,$FA,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9,$FA,$FA,$FA,$FA,$FA,$FA,$FA,$FA,$FA,$FA,$FB,$FB,$FB,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$FF

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
FX_CTRL           = $9F29 ; DCSEL = 2
FX_CACHE_L        = $9F29 ; DCSEL = 6 
FX_CACHE_M        = $9F2A 
FX_CACHE_H        = $9F2B
FX_CACHE_U        = $9F2C 
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

A_CHAR            = $41
C_CHAR            = $43
D_CHAR            = $44
E_CHAR            = $45
I_CHAR            = $49
O_CHAR            = $4F
T_CHAR            = $54
W_CHAR            = $57
X_CHAR            = $58
Y_CHAR            = $59
Z_CHAR            = $5A

CLR               = $93

; 	$0800-$9EFF	BASIC program/variables; available to the user
WORLD_DATA = $6000 	;	so is %100 [Y 5 bits ] : [ab] 0 [X - 6 bits
SCREEN_buffer = $8000

; zero page layout $0022-$007F is available to user
ZP_PTR = $22 
SCRATCH_PTR = $7E

; global data ; 2E00
.byte $DE,$AD,$BE,$EF ; 0-3
default_irq_vector:  .addr 0 ; 4-5 
VSYNC_counter:       .byte 1 ; 6
camera_facing: 		 .byte 1 ; 7
camera_world_pos_XH:    .byte 44 ; 8
camera_world_pos_XL:       .byte 48 ; 9
camera_world_pos_YH:        .byte 15 ; A
camera_world_pos_YL:       .byte 128  ; B
camera_cell_x: 		 .byte 0 ; c
camera_cell_xl:       .byte 0 ; d
DEBUG_A: .byte 0  ; 12
DEBUG_B: .byte 0  ; 13
DEBUG_C: .byte 0
DEBUG_D: .byte 0
camera_cell_y: 		 .byte 0 ; e
camera_cell_yl:       .byte 0 ; f
MASTER_CLOCK:        .addr 0 ; 10-11

.macro stash_scratch
	STA (SCRATCH_PTR)
    INC SCRATCH_PTR
.endmacro

custom_irq_handler: ; 2E12
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
  LDX #32   ;   num pages to copy - 16 pages / 8K  - sprite addr 0-255
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

  ; initialize some waves 
  STZ ZP_PTR
  LDA #>TUB_WORLD
  STA ZP_PTR+1
  LDA #8
  STA ZP_PTR+2 ; for use as page counter.. 
  LDX #0
  : LDA (ZP_PTR),y ; grab world data
    CMP #128       ; is outside or inside tub? 
    BCS :+         ; skip this one 
    TXA 
    STA (ZP_PTR),y 
    INX
    CPX #15       
    BCS :++
  : INY
    BNE :--
    INC ZP_PTR+1
    DEC ZP_PTR+2
    BNE :--
    BRA :+++
  : LDA (ZP_PTR),y 
    CMP #128       ; is outside or inside tub? 
    BCS :+         ; skip this one 
    TXA 
    STA (ZP_PTR),y 
    DEX
    BEQ :--
  : INY
    BNE :--
    INC ZP_PTR+1
    DEC ZP_PTR+2
    BNE :--
  :
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
   STZ camera_facing

@camera_world_changed:
   ; copy over cell YL as-is
   LDA camera_world_pos_YL
   STA camera_cell_yl
   ; YH gets copied over .. 
   LDA camera_world_pos_YH
   STA camera_cell_y
   ; cellX = WORLDX*ratio - floor(cellY)/2
   ;  halve floor(cellY)
   LSR 
   STA $7F ; stash it for scratch
   LDA #0
   ROR
   STA $7E ; and there's the half.. 

   LDX camera_world_pos_XH 
   LDY camera_world_pos_XL
   CLC 
   LDA WORLD_TO_CELL_XH,Y ; that bit from pos_XL
   ADC WORLD_TO_CELL_XL,X ; plus the bit from pos_XH 
   TAY   ;  cellXL from ratio
   LDA WORLD_TO_CELL_XH,X 
   ADC #0 ; gotta do that carry and all .. 
   TAX   ; cellXH from ratio 

   TYA 
   SEC
   SBC $7E
   STA camera_cell_xl 
   TXA
   SBC $7F  
   STA camera_cell_x
   jmp @do_update

@camera_cell_changed: ; run through this more as a normalization step for camera..
   ; worldX = scaled(floor(cellY)/2 + cellX )
   LDA camera_cell_yl
   STA camera_world_pos_YL
   LDA camera_cell_y
   STA camera_world_pos_YH
   LSR
   TAX  ; high byte floor(Y)/2
   LDA #0
   ROR ; either is zero or 128 now ... either way, carry is cleared.
   ADC camera_cell_xl 
   TAY ; stash the low to byte 
   TXA ; high byte floor (Y)/2 .. ready for adding 
   ADC camera_cell_x
   TAX ; stash high byte ... carry _should_ be cleared unless X >255 ... ?
   LDA CELL_LOW_TO_WORLD_XL,Y
   ADC CELL_TO_WORLD_XL,X
   STA camera_world_pos_XL
   LDA CELL_LOW_TO_WORLD_XH,Y
   ADC CELL_TO_WORLD_XH,X
   STA camera_world_pos_XH
   ;  jmp @do_update ; superfluous currently. redundant even.. 


@do_update:

   ; clear the object list ... 
    STZ OBJECT_LIST_BYTE6_NEXT ; because we can't use zero anyway..
    LDX #0
    LDA #$0C ; is basis for all the z_flips <- this may change depending on orientation.. 
    : STZ OBJECT_LIST_Z_START_POINTERS,X
      STZ OBJECT_LIST_BYTE1_MODE,X          ; 16 color / low address 
      STZ OBJECT_LIST_BYTE2_X
      STA OBJECT_LIST_BYTE4_ZFLIPS,X
      INX 
      BNE :-

   jsr push_world_to_object_list

   LDX OBJECT_LIST_BYTE6_NEXT
   STX DEBUG_C   

   ;  write location datas.. 
   lda #248
   STA VERA_addr_low
   LDA #$FC
   STA VERA_addr_high
   LDA #$49
   STA VERA_addr_bank

 
   ldy #10
 : LDX camera_facing-1,y
   LDA SPRITE_NUM_LOW_NIBBLE,X 
   STA VERA_data0
   LDA SPRITE_NUM_HIGH_NIBBLE,X 
   STA VERA_data0
   dey
   BNE :-


   jsr draw_object_list


@FRAME_CHECK:
   wai
   lda VSYNC_counter
   beq @FRAME_CHECK
   stz VSYNC_counter
   CLC
   ADC MASTER_CLOCK
   TAX
   STA MASTER_CLOCK
   LDA MASTER_CLOCK+1
   ADC #0
   STA MASTER_CLOCK+1
   TXA
   AND #1 ; restrict to 30 fps.. don't care missed cycle. 
   BNE @FRAME_CHECK
   ; poll keyboard for input 
   jsr GETIN
   cmp #0
   beq @FRAME_CHECK
   cmp #$1D 	;	cursor right
   BNE :+
   INC camera_facing
   JMP @do_update
   :
   cmp  #$9D 	;	cursor left
   BNE :+
   DEC camera_facing
   JMP @do_update
 : cmp #$11; cursor down
   BNE :+
   LDX camera_facing
   SEC 
   LDA camera_world_pos_XL
   SBC MOVE_X_L,X 
   STA camera_world_pos_XL
   LDA camera_world_pos_XH
   SBC MOVE_X_H,X 
   STA camera_world_pos_XH
   CLC 
   LDA camera_world_pos_YL
   ADC MOVE_Y_L,X 
   STA camera_world_pos_YL
   LDA camera_world_pos_YH
   ADC MOVE_Y_H,X 
   STA camera_world_pos_YH
   jmp @camera_world_changed

 : cmp #$91 ; cursor up 
   BNE :+
   LDX camera_facing
   CLC 
   LDA camera_world_pos_XL
   ADC MOVE_X_L,X 
   STA camera_world_pos_XL
   LDa camera_world_pos_XH
   ADC MOVE_X_H,X 
   STA camera_world_pos_XH
   SEC 
   LDA camera_world_pos_YL
   SBC MOVE_Y_L,X 
   STA camera_world_pos_YL
   LDA camera_world_pos_YH
   SBC MOVE_Y_H,X 
   STA camera_world_pos_YH
   jmp @camera_world_changed

 : cmp  #E_CHAR ; cell up right
   BNE :+++
   LDA camera_cell_y
   BEQ :+
   DEC camera_cell_y
 : LDA camera_cell_x
   CMP #63
   BCS :+
   INC camera_cell_x
 : JMP @camera_cell_changed

 : cmp #W_CHAR ; cell up left 
   BNE :++
   LDA camera_cell_y
   BEQ :+
   DEC camera_cell_y
 : JMP @camera_cell_changed

 : cmp #A_CHAR ; cell left 
   BNE :++
   LDA camera_cell_x
   BEQ :+
   DEC camera_cell_x
 : JMP @camera_cell_changed

 : cmp #D_CHAR ; cell right 
   BNE :++
   LDA camera_cell_x 
   CMP #63
   BCS :+
   INC camera_cell_x
 : JMP @camera_cell_changed

 : cmp #X_CHAR ; cell down right  
   BNE :++
   LDA camera_cell_y
   CMP #30
   BCS :+
   INC camera_cell_y
 : JMP @camera_cell_changed

 : cmp  #Z_CHAR ; cell down left
   BNE :+++
   LDA camera_cell_y
   CMP #30
   BCS :+
   INC camera_cell_y
 : LDA camera_cell_x
   BEQ :+
   DEC camera_cell_x
 : JMP @camera_cell_changed

 : cmp #SPACE; 
   BNE :+
   STZ camera_cell_xl
   STZ camera_cell_yl
   JMP @camera_cell_changed

 : cmp #0 ; 
   BNE :+
   JMP @do_update

 : cmp #0 ; 
   BNE :+
   JMP @do_update

 : cmp #0 ; 
   BNE :+
   JMP @do_update


 : JMP @FRAME_CHECK

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


; CURRENT
push_world_to_object_list: ; as in.. let's try this again?? wait.. missing a STZ ZP_PTR... 
PWOL_TUB_PTR_AL   = ZP_PTR
PWOL_TUB_PTR_AH   = ZP_PTR+1
PWOL_TUB_PTR_BL   = ZP_PTR+2
PWOL_TUB_PTR_BH   = ZP_PTR+3
PWOL_CURRENT_XL   = ZP_PTR+4
PWOL_CURRENT_XH   = ZP_PTR+5
PWOL_CURRENT_YL   = ZP_PTR+6
PWOL_CURRENT_YH   = ZP_PTR+7
PWOL_ACROSS_ROW_XL= ZP_PTR+8
PWOL_ACROSS_ROW_XH= ZP_PTR+9
PWOL_ACROSS_ROW_YL= ZP_PTR+10
PWOL_ACROSS_ROW_YH= ZP_PTR+11
PWOL_NEXT_ROW_A_LEFT_XL  = ZP_PTR+12
PWOL_NEXT_ROW_A_LEFT_XH  = ZP_PTR+13
PWOL_NEXT_ROW_A_LEFT_YL  = ZP_PTR+14
PWOL_NEXT_ROW_A_LEFT_YH  = ZP_PTR+15
PWOL_NEXT_ROW_A_RIGHT_XL  = ZP_PTR+16
PWOL_NEXT_ROW_A_RIGHT_XH  = ZP_PTR+17
PWOL_NEXT_ROW_A_RIGHT_YL  = ZP_PTR+18
PWOL_NEXT_ROW_A_RIGHT_YH  = ZP_PTR+19
PWOL_NEXT_ROW_B_LEFT_XL  = ZP_PTR+20
PWOL_NEXT_ROW_B_LEFT_XH  = ZP_PTR+21
PWOL_NEXT_ROW_B_LEFT_YL  = ZP_PTR+22
PWOL_NEXT_ROW_B_LEFT_YH  = ZP_PTR+23
PWOL_NEXT_ROW_B_RIGHT_XL  = ZP_PTR+24
PWOL_NEXT_ROW_B_RIGHT_XH  = ZP_PTR+25
PWOL_NEXT_ROW_B_RIGHT_YL  = ZP_PTR+26
PWOL_NEXT_ROW_B_RIGHT_YH  = ZP_PTR+27
PWOL_Z_STARTS_PTR = ZP_PTR+28
PWOL_Z_STARTS_PTRH = ZP_PTR+29
PWOL_CONVERT_HEIGHTS = ZP_PTR+30
PWOL_CONVERT_HEIGHTSH= ZP_PTR+31
PWOL_CONVERT_HEIGHTS_SECONDARY = ZP_PTR+32
PWOL_CONVERT_HEIGHTS_SECONDARYH = ZP_PTR+33
PWOL_TRIES_COUNTER = ZP_PTR+34
PWOL_START_XL = ZP_PTR+35
PWOL_START_YL = ZP_PTR+36
PWOL_START_XH = ZP_PTR+37
PWOL_START_YH = ZP_PTR+38

PWOL_START_COS_XL = ZP_PTR+39
PWOL_START_COS_XH = ZP_PTR+40
PWOL_START_COS_YL = ZP_PTR+41
PWOL_START_COS_YH = ZP_PTR+42
PWOL_START_SIN_XL = ZP_PTR+43
PWOL_START_SIN_XH = ZP_PTR+44
PWOL_START_SIN_YL = ZP_PTR+45
PWOL_START_SIN_YH = ZP_PTR+46

PWOL_camera_cell_xl = ZP_PTR+47
PWOL_camera_cell_yl = ZP_PTR+48

TRY_AGAIN = 6
SCREEN_MID_X = 108
SCREEN_MID_Y =  80
SCREEN_OUT_RIGHT  = 164 ; right of middle is 116, +48 = 164
SCREEN_OUT_LEFT   =  36 ; left of middle is 100, -48=52-16=36 
SCREEN_OUT_TOP     = 24
SCREEN_OUT_BOTTOM  = 136

   LDA #>CONVERT_HEIGHTS_PIXELS_SECONDARY
   STA PWOL_CONVERT_HEIGHTS_SECONDARYH
   LDA #>CONVERT_HEIGHTS_PIXELS
   STA PWOL_CONVERT_HEIGHTSH
   LDA #>OBJECT_LIST_Z_START_POINTERS
   STA PWOL_Z_STARTS_PTRH

   LDX camera_facing


   LDA ACROSS_ROW_X_L,x    ; 0900  16 wide , 45* tilt ... this is added to go up row, sub for down row
   STA PWOL_ACROSS_ROW_XL  
   LDA ACROSS_ROW_X_H,x
   STA PWOL_ACROSS_ROW_XH
   LDA ACROSS_ROW_Y_L,x
   STA PWOL_ACROSS_ROW_YL
   LDA ACROSS_ROW_Y_H,x
   STA PWOL_ACROSS_ROW_YH

   CLC
   LDA NEXT_ROW_X_L,X  ; 0D00 next row LEFT/up when added
   STA PWOL_NEXT_ROW_A_LEFT_XL   ; -> next row is left, going up the screen ..  -1,-1
   ADC PWOL_ACROSS_ROW_XL   ; across row is for right , subtract to go left  +1 -> 0,1
   STA PWOL_NEXT_ROW_A_RIGHT_XL  ;  -> next row is right, going up the screen .. -1,-1
   LDA NEXT_ROW_X_H,x
   STA PWOL_NEXT_ROW_A_LEFT_XH
   ADC PWOL_ACROSS_ROW_XH
   STA PWOL_NEXT_ROW_A_RIGHT_XH

   CLC 
   LDA NEXT_ROW_Y_L,X  ; 0F00 next row LEFT/up when added
   STA PWOL_NEXT_ROW_A_LEFT_YL   ; -> next row is left, going up the screen
   ADC PWOL_ACROSS_ROW_YL   ; across row is for right   
   STA PWOL_NEXT_ROW_A_RIGHT_YL  ;  -> next row is right, going up the screen 
   LDA NEXT_ROW_Y_H,x
   STA PWOL_NEXT_ROW_A_LEFT_YH
   ADC PWOL_ACROSS_ROW_YH
   STA PWOL_NEXT_ROW_A_RIGHT_YH


; for zig B , the opposite of left/up is right/down.. so A_LEFT * -1 = B_RIGHT
   SEC ; flip A_LEFT X to B_RIGHT X
   LDA #0
   SBC PWOL_NEXT_ROW_A_LEFT_XL
   STA PWOL_NEXT_ROW_B_RIGHT_XL
   LDA #0
   SBC PWOL_NEXT_ROW_A_LEFT_XH
   STA PWOL_NEXT_ROW_B_RIGHT_XH

   SEC ; flip A_LEFT Y to B_RIGHT Y
   LDA #0
   SBC PWOL_NEXT_ROW_A_LEFT_YL
   STA PWOL_NEXT_ROW_B_RIGHT_YL
   LDA #0
   SBC PWOL_NEXT_ROW_A_LEFT_YH
   STA PWOL_NEXT_ROW_B_RIGHT_YH

   SEC ; flip A_RIGHT X to B_LEFT X 
   LDA #0
   SBC PWOL_NEXT_ROW_A_RIGHT_XL
   STA PWOL_NEXT_ROW_B_LEFT_XL
   LDA #0
   SBC PWOL_NEXT_ROW_A_RIGHT_XH
   STA PWOL_NEXT_ROW_B_LEFT_XH

   SEC ; flip A_RIGHT Y to B_LEFT Y 
   LDA #0
   SBC PWOL_NEXT_ROW_A_RIGHT_YL
   STA PWOL_NEXT_ROW_B_LEFT_YL
   LDA #0
   SBC PWOL_NEXT_ROW_A_RIGHT_YH
   STA PWOL_NEXT_ROW_B_LEFT_YH

   ;  set up tub pointer 
    STZ PWOL_TUB_PTR_AL
    LDA camera_cell_y
    LSR  ;  y pages of 128
    ROR PWOL_TUB_PTR_AL
    LSR  ; y pages of 64 ! 
    ROR PWOL_TUB_PTR_AL
    ADC #>TUB_WORLD
    STA PWOL_TUB_PTR_AH
    STA PWOL_TUB_PTR_BH
    LDA PWOL_TUB_PTR_AL
    STA PWOL_TUB_PTR_BL    


    STZ PWOL_CURRENT_XL
    LDA #SCREEN_MID_X-8
    STA PWOL_CURRENT_XH

    LDA camera_cell_x
    STA PWOL_CONVERT_HEIGHTS

    STZ PWOL_CURRENT_YL
    LDA #SCREEN_MID_Y-5
    CLC
    ADC (PWOL_CONVERT_HEIGHTS)
    STA PWOL_CURRENT_YH

    LDA camera_cell_xl
    LSR 
    LSR 
    LSR 
    LSR 
    SEC
    SBC #8
    BCS :++
    AND #7
    TAY
  : LDA PWOL_CURRENT_XL
    ADC SUBCELL_X_COS_L,X
    STA PWOL_CURRENT_XL
    LDA PWOL_CURRENT_XH
    ADC SUBCELL_X_COS_H,X
    STA PWOL_CURRENT_XH

    LDA PWOL_CURRENT_YL
    SBC SUBCELL_Y_SIN_L,X 
    STA PWOL_CURRENT_YL
    LDA PWOL_CURRENT_YH
    SBC SUBCELL_Y_SIN_H,X 
    STA PWOL_CURRENT_YH
    DEY 
    BNE :-   
  : BEQ :++
    TAY
  : LDA PWOL_CURRENT_XL
    SBC SUBCELL_X_COS_L,X
    STA PWOL_CURRENT_XL
    LDA PWOL_CURRENT_XH
    SBC SUBCELL_X_COS_H,X
    STA PWOL_CURRENT_XH

    LDA PWOL_CURRENT_YL
    ADC SUBCELL_Y_SIN_L,X 
    STA PWOL_CURRENT_YL
    LDA PWOL_CURRENT_YH
    ADC SUBCELL_Y_SIN_H,X 
    STA PWOL_CURRENT_YH
    DEY 
    BNE :-

  : LDA camera_cell_yl
    LSR 
    LSR 
    LSR 
    LSR 
    SBC #8
    BCS :++
    AND #7
    TAY
  : LDA PWOL_CURRENT_YL
    ADC SUBCELL_Y_COS_L,X
    STA PWOL_CURRENT_YL
    LDA PWOL_CURRENT_YH
    ADC SUBCELL_Y_COS_H,X
    STA PWOL_CURRENT_YH

    LDA PWOL_CURRENT_XL
    ADC SUBCELL_X_SIN_L,X 
    STA PWOL_CURRENT_XL
    LDA PWOL_CURRENT_XH
    ADC SUBCELL_X_SIN_H,X 
    STA PWOL_CURRENT_XH
    DEY 
    BNE :-
    BEQ :++
    TAY
  : LDA PWOL_CURRENT_YL
    SBC SUBCELL_Y_COS_L,X
    STA PWOL_CURRENT_YL
    LDA PWOL_CURRENT_YH
    SBC SUBCELL_Y_COS_H,X
    STA PWOL_CURRENT_YH
    LDA PWOL_CURRENT_XL
    SBC SUBCELL_X_SIN_L,X 
    STA PWOL_CURRENT_XL
    LDA PWOL_CURRENT_XH
    SBC SUBCELL_X_SIN_H,X 
    STA PWOL_CURRENT_XH
    DEY 
    BNE :-
  :

    LDA PWOL_CURRENT_XL
    STA PWOL_START_XL
    LDA PWOL_CURRENT_XH
    STA PWOL_START_XH

    LDA PWOL_CURRENT_YL
    STA PWOL_START_YL
    LDA PWOL_CURRENT_YH
    STA PWOL_START_YH

  @zigzag_A: ; going to right and up the screen, including where we are currently.. 
      LDY camera_cell_x   ;  eh voila! we haz pointer to ze row to start on .. woot!     
    @zigzag_A_right:
        CPY #64  ;  make sure we don't go outside level.. 
        BCS @ZAR_NEXT ; if we're outside we'll just skip is OK here
        LDA (PWOL_TUB_PTR_AL),y
        CMP #129
        BCS @ZAR_NEXT ; this isn't a valid spot in the level map.. 

        ; bytes 1 and 4 were updated when we cleared the object list
        INC OBJECT_LIST_BYTE6_NEXT ; is there objects left to use as next? 
        BNE :++
      : DEC OBJECT_LIST_BYTE6_NEXT ; so we can do this check again if out.. 
        rts ; @WHAT_THE_WHAT ; we shouldn't be outside the screen... 
      : LDX PWOL_CURRENT_YH ;  current screenY .. to calculate effective Z for the buffer 
        LDA SCREEN_Y_TO_Z,x 
        BEQ :-- ; we shouldn't be outside the screen... 
        STA PWOL_Z_STARTS_PTR  ; ok now that's primed to be at the start .. we want to grab whatever is at this buffer and save it to our new next..
        LDA (PWOL_Z_STARTS_PTR) ; get the current value here for the next ..
        LDX OBJECT_LIST_BYTE6_NEXT ; get index for this object
        STA OBJECT_LIST_BYTE6_NEXT,X ; old next becomes this object's next
        TXA ; push new next to the Z buffer spot
        STA (PWOL_Z_STARTS_PTR) ;  and the new next gets saved back the Z_starts... otay.. start filling in data..  
        ; bytes .1..4.6 filled in already.. 

        STZ OBJECT_LIST_BYTE0_ADDRLOW,X  ;   most of the time will be setting this anyway.. 
        LDA (PWOL_TUB_PTR_AL),y     ; get value of world at this point - 0-127=height, 128=wall, 129+ invalid
        BPL @ZAR_INSIDE_TUB 
      @ZAR_HIT_WALL_OUCH:
          STA OBJECT_LIST_BYTE0_ADDRLOW,X ; hit the wall, ouch.. write wall stuff
      @ZAR_INSIDE_TUB:
          STA PWOL_CONVERT_HEIGHTS; 0-128 valid as heights need convert to do sub though? 
          ;STA PWOL_CONVERT_HEIGHTS_SECONDARY ; this would be check to see if we're "extra tall" - wall is set to 128, 26 pixels smaller than would be.. 
          TYA
          AND #$0F
          ORA #$D0 ; #$D0
          STA OBJECT_LIST_BYTE5_SIZE,X ; 01.3456 done . 

          SEC        
          LDA PWOL_CURRENT_YH ; set er up
          SBC (PWOL_CONVERT_HEIGHTS)
          STA OBJECT_LIST_BYTE3_Y,X ; 01.34.6 filled in now 
          ;LDA #$D0
          ;STA OBJECT_LIST_BYTE5_SIZE,X ; 01.3456 done . 
          LDA PWOL_CURRENT_XH
          STA OBJECT_LIST_BYTE2_X,X    ; 0123456 OK - object is complete. 
     @ZAR_NEXT:
         ; calc next to the right.. 
         INY
         CLC
         LDA PWOL_CURRENT_XL
         ADC PWOL_ACROSS_ROW_XL
         STA PWOL_CURRENT_XL
         LDA PWOL_CURRENT_XH
         ADC PWOL_ACROSS_ROW_XH
         STA PWOL_CURRENT_XH
         TAX 
         CLC
         LDA PWOL_CURRENT_YL
         ADC PWOL_ACROSS_ROW_YL
         STA PWOL_CURRENT_YL
         LDA PWOL_CURRENT_YH
         ADC PWOL_ACROSS_ROW_YH
         STA PWOL_CURRENT_YH

         STX DEBUG_A
         STA DEBUG_B

         CPX #SCREEN_OUT_RIGHT
         BCS @ZAR_ZIG_LEFT_SWITCH
         CPX #SCREEN_OUT_LEFT
         BCC @ZAR_ZIG_LEFT_SWITCH
         CMP #SCREEN_OUT_TOP
         BCC @ZAR_ZIG_LEFT_SWITCH
         CMP #SCREEN_OUT_BOTTOM
         BCC @zigzag_A_right
     @ZAR_ZIG_LEFT_SWITCH: ;PWOL_NEXT_ROW_A_LEFT_XL   ; -> next row is left, going up the screen ..  +0,-1
         LDA #TRY_AGAIN
         STA PWOL_TRIES_COUNTER
;         INY
         SEC 
         LDA PWOL_TUB_PTR_AL
         SBC #64 ;   0,-1
         STA PWOL_TUB_PTR_AL
         LDA PWOL_TUB_PTR_AH
         SBC #0
         CMP #>TUB_WORLD ; are we inside the world still? 
         BCS :+
         JMP @zigzag_B
       : STA PWOL_TUB_PTR_AH

         CLC 
         LDA PWOL_CURRENT_XL
         ADC PWOL_NEXT_ROW_A_LEFT_XL
         STA PWOL_CURRENT_XL
         LDA PWOL_CURRENT_XH
         ADC PWOL_NEXT_ROW_A_LEFT_XH
         STA PWOL_CURRENT_XH
         TAX
         CLC 
         LDA PWOL_CURRENT_YL
         ADC PWOL_NEXT_ROW_A_LEFT_YL
         STA PWOL_CURRENT_YL
         LDA PWOL_CURRENT_YH
         ADC PWOL_NEXT_ROW_A_LEFT_YH
         STA PWOL_CURRENT_YH
         ; check if we're outside ..  

         CPX #SCREEN_OUT_RIGHT
         BCS @ZAR_ZIG_LEFT_SWITCH_TRY_AGAIN
         CPX #SCREEN_OUT_LEFT
         BCC @ZAR_ZIG_LEFT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_TOP
         BCC @ZAR_ZIG_LEFT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_BOTTOM
         BCC @zigzag_A_left
   @ZAR_ZIG_LEFT_SWITCH_TRY_AGAIN:
         DEC PWOL_TRIES_COUNTER 
         BNE @ZAR_ZIG_LEFT_SWITCH_TRY_AGAIN_GO_LEFT
         JMP @zigzag_B
   @ZAR_ZIG_LEFT_SWITCH_TRY_AGAIN_GO_LEFT:
         DEY
         SEC
         LDA PWOL_CURRENT_XL
         SBC PWOL_ACROSS_ROW_XL
         STA PWOL_CURRENT_XL
         LDA PWOL_CURRENT_XH
         SBC PWOL_ACROSS_ROW_XH
         STA PWOL_CURRENT_XH
         TAX 
         SEC
         LDA PWOL_CURRENT_YL
         SBC PWOL_ACROSS_ROW_YL
         STA PWOL_CURRENT_YL
         LDA PWOL_CURRENT_YH
         SBC PWOL_ACROSS_ROW_YH
         STA PWOL_CURRENT_YH
         CPX #SCREEN_OUT_RIGHT
         BCS @ZAR_ZIG_LEFT_SWITCH_TRY_AGAIN
         CPX #SCREEN_OUT_LEFT
         BCC @ZAR_ZIG_LEFT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_TOP
         BCC @ZAR_ZIG_LEFT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_BOTTOM
         BCS @ZAR_ZIG_LEFT_SWITCH_TRY_AGAIN
   @zigzag_A_left:
        CPY #64  ;  make sure we don't go outside level.. 
        BCS @ZAL_NEXT ; if we're outside we'll just skip is OK 
        LDA (PWOL_TUB_PTR_AL),y
        CMP #129
        BCS @ZAL_NEXT ; we're outside level. 

        ; bytes 1 and 4 were updated when we cleared the object list
        INC OBJECT_LIST_BYTE6_NEXT ; is there objects left to use as next? 
        BNE :++
      : DEC OBJECT_LIST_BYTE6_NEXT ; so we can do this check again if out.. 
        rts ; @WHAT_THE_WHAT ; we shouldn't be outside the screen... 
      : LDX PWOL_CURRENT_YH ;  current screenY .. to calculate effective Z for the buffer 
        LDA SCREEN_Y_TO_Z,x 
        BEQ :-- ; we shouldn't be outside the screen... 
        STA PWOL_Z_STARTS_PTR  ; ok now that's primed to be at the start .. we want to grab whatever is at this buffer and save it to our new next..
        LDA (PWOL_Z_STARTS_PTR) ; get the current value here for the next ..
        LDX OBJECT_LIST_BYTE6_NEXT ; get index for this object
        STA OBJECT_LIST_BYTE6_NEXT,X ; old next becomes this object's next
        TXA ; push new next to the Z buffer spot
        STA (PWOL_Z_STARTS_PTR) ;  and the new next gets saved back the Z_starts... otay.. start filling in data..  
        ; bytes .1..4.6 filled in already.. 

        STZ OBJECT_LIST_BYTE0_ADDRLOW,X  ;   most of the time will be setting this anyway.. 
        LDA (PWOL_TUB_PTR_AL),y     ; get value of world at this point - 0-127=height, 128=wall, 129+ invalid
        BPL @ZAL_INSIDE_TUB 
      @ZAL_HIT_WALL_OUCH:
          STA OBJECT_LIST_BYTE0_ADDRLOW,X ; hit the wall, ouch.. write wall stuff
      @ZAL_INSIDE_TUB:
          ;STA PWOL_CONVERT_HEIGHTS_SECONDARY ; this would be check to see if we're "extra tall" - wall is set to 128, 26 pixels smaller than would be.. 
          STA PWOL_CONVERT_HEIGHTS; 0-128 valid as heights need convert to do sub though? 
          TYA
          AND #$0F
          ORA #$D0 ; #$D0
          STA OBJECT_LIST_BYTE5_SIZE,X ; 01.3456 done . 

          SEC        
          LDA PWOL_CURRENT_YH ; set er up
          SBC (PWOL_CONVERT_HEIGHTS)
          STA OBJECT_LIST_BYTE3_Y,X ; 01.34.6 filled in now 
        ;  LDA #$D0
        ;  STA OBJECT_LIST_BYTE5_SIZE,X ; 01.3456 done . 
          LDA PWOL_CURRENT_XH
          STA OBJECT_LIST_BYTE2_X,X    ; 0123456 OK - object is complete. 
     @ZAL_NEXT:
         ; calc next to the LEFT 
         DEY
         SEC
         LDA PWOL_CURRENT_XL
         SBC PWOL_ACROSS_ROW_XL
         STA PWOL_CURRENT_XL
         LDA PWOL_CURRENT_XH
         SBC PWOL_ACROSS_ROW_XH
         STA PWOL_CURRENT_XH
         TAX 
         SEC
         LDA PWOL_CURRENT_YL
         SBC PWOL_ACROSS_ROW_YL
         STA PWOL_CURRENT_YL
         LDA PWOL_CURRENT_YH
         SBC PWOL_ACROSS_ROW_YH
         STA PWOL_CURRENT_YH

         STX DEBUG_A
         STA DEBUG_B

         CPX #SCREEN_OUT_RIGHT
         BCS @ZAL_ZIG_RIGHT_SWITCH
         CPX #SCREEN_OUT_LEFT
         BCC @ZAL_ZIG_RIGHT_SWITCH
         CMP #SCREEN_OUT_TOP
         BCC @ZAL_ZIG_RIGHT_SWITCH
         CMP #SCREEN_OUT_BOTTOM
         BCC @zigzag_A_left
     @ZAL_ZIG_RIGHT_SWITCH: ; up/right is +1,+1  from where we is right now .. 
         LDA #TRY_AGAIN
         STA PWOL_TRIES_COUNTER
         INY
         SEC 
         LDA PWOL_TUB_PTR_AL
         SBC #64
         STA PWOL_TUB_PTR_AL
         LDA PWOL_TUB_PTR_AH
         SBC #0
         CMP #>TUB_WORLD ; are we inside the world still? 
         BCS :+
         JMP @zigzag_B
       : STA PWOL_TUB_PTR_AH


         CLC 

         LDA PWOL_CURRENT_XL
         ADC PWOL_NEXT_ROW_A_RIGHT_XL
         STA PWOL_CURRENT_XL

         LDA PWOL_CURRENT_XH
         ADC PWOL_NEXT_ROW_A_RIGHT_XH
         STA PWOL_CURRENT_XH
         TAX


         CLC 
         LDA PWOL_CURRENT_YL
         ADC PWOL_NEXT_ROW_A_RIGHT_YL
         STA PWOL_CURRENT_YL
         LDA PWOL_CURRENT_YH
         ADC PWOL_NEXT_ROW_A_RIGHT_YH
         STA PWOL_CURRENT_YH

         CPX #SCREEN_OUT_RIGHT
         BCS @ZAL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         CPX #SCREEN_OUT_LEFT
         BCC @ZAL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_TOP
         BCC @ZAL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_BOTTOM
         BCS @ZAL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         JMP @zigzag_A_right
   @ZAL_ZIG_RIGHT_SWITCH_TRY_AGAIN:
         DEC PWOL_TRIES_COUNTER 
         BEQ @zigzag_B
   @ZAL_ZIG_RIGHT_SWITCH_TRY_AGAIN_GO_RIGHT:
         INY
         CLC
         LDA PWOL_CURRENT_XL
         ADC PWOL_ACROSS_ROW_XL
         STA PWOL_CURRENT_XL
         LDA PWOL_CURRENT_XH
         ADC PWOL_ACROSS_ROW_XH
         STA PWOL_CURRENT_XH
         TAX 
         CLC
         LDA PWOL_CURRENT_YL
         ADC PWOL_ACROSS_ROW_YL
         STA PWOL_CURRENT_YL
         LDA PWOL_CURRENT_YH
         ADC PWOL_ACROSS_ROW_YH
         STA PWOL_CURRENT_YH

         CPX #SCREEN_OUT_RIGHT
         BCS @ZAL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         CPX #SCREEN_OUT_LEFT
         BCC @ZAL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_TOP
         BCC @ZAL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_BOTTOM
         BCS @ZAL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         JMP @zigzag_A_right



  @zigzag_B: ; going to left and down the screen, including where we are currently.. 
     ; RTS
      SEC 
      LDA PWOL_START_XL
      SBC PWOL_ACROSS_ROW_XL
      STA PWOL_CURRENT_XL
      LDA PWOL_START_XH
      SBC PWOL_ACROSS_ROW_XH
      STA PWOL_CURRENT_XH
  

      SEC
      LDA PWOL_START_YL
      SBC PWOL_ACROSS_ROW_YL
      STA PWOL_CURRENT_YL
      LDA PWOL_START_YH
      SBC PWOL_ACROSS_ROW_YH
      STA PWOL_CURRENT_YH

      LDY camera_cell_x   ;  eh voila! we haz pointer to ze row to start on .. woot!     
      DEY ; start left

   @zigzag_B_left:
        CPY #64  ;  make sure we don't go outside level.. 
        BCS @ZBL_NEXT ; if we're outside we'll just skip is OK 
        LDA (PWOL_TUB_PTR_BL),y
        CMP #129
        BCS @ZBL_NEXT ; we're outside level. 

        ; bytes 1 and 4 were updated when we cleared the object list
        INC OBJECT_LIST_BYTE6_NEXT ; is there objects left to use as next? 
        BNE :++
      : DEC OBJECT_LIST_BYTE6_NEXT ; so we can do this check again if out.. 
        rts ; @WHAT_THE_WHAT ; we shouldn't be outside the screen... 
      : LDX PWOL_CURRENT_YH ;  current screenY .. to calculate effective Z for the buffer 
        LDA SCREEN_Y_TO_Z,x 
        BEQ :-- ; we shouldn't be outside the screen... 
        STA PWOL_Z_STARTS_PTR  ; ok now that's primed to be at the start .. we want to grab whatever is at this buffer and save it to our new next..
        LDA (PWOL_Z_STARTS_PTR) ; get the current value here for the next ..
        LDX OBJECT_LIST_BYTE6_NEXT ; get index for this object
        STA OBJECT_LIST_BYTE6_NEXT,X ; old next becomes this object's next
        TXA ; push new next to the Z buffer spot
        STA (PWOL_Z_STARTS_PTR) ;  and the new next gets saved back the Z_starts... otay.. start filling in data..  
        ; bytes .1..4.6 filled in already.. 

        STZ OBJECT_LIST_BYTE0_ADDRLOW,X  ;   most of the time will be setting this anyway.. 
        LDA (PWOL_TUB_PTR_BL),y     ; get value of world at this point - 0-127=height, 128=wall, 129+ invalid
        BPL @ZBL_INSIDE_TUB 
      @ZBL_HIT_WALL_OUCH:
          STA OBJECT_LIST_BYTE0_ADDRLOW,X ; hit the wall, ouch.. write wall stuff
      @ZBL_INSIDE_TUB:
          STA PWOL_CONVERT_HEIGHTS; 0-128 valid as heights need convert to do sub though? 
          ;STA PWOL_CONVERT_HEIGHTS_SECONDARY ; this would be check to see if we're "extra tall" - wall is set to 128, 26 pixels smaller than would be.. 
          TYA
          AND #$0F
          ORA #$D0 ; #$D0
          STA OBJECT_LIST_BYTE5_SIZE,X ; 01.3456 done . 

          SEC        
          LDA PWOL_CURRENT_YH ; set er up
          SBC (PWOL_CONVERT_HEIGHTS)
          STA OBJECT_LIST_BYTE3_Y,X ; 01.34.6 filled in now 
        ;  LDA #$D0
        ;  STA OBJECT_LIST_BYTE5_SIZE,X ; 01.3456 done . 
          LDA PWOL_CURRENT_XH
          STA OBJECT_LIST_BYTE2_X,X    ; 0123456 OK - object is complete. 
     @ZBL_NEXT:
         ; calc next to the LEFT 
         DEY
         SEC
         LDA PWOL_CURRENT_XL
         SBC PWOL_ACROSS_ROW_XL
         STA PWOL_CURRENT_XL
         LDA PWOL_CURRENT_XH
         SBC PWOL_ACROSS_ROW_XH
         STA PWOL_CURRENT_XH
         TAX 
         SEC
         LDA PWOL_CURRENT_YL
         SBC PWOL_ACROSS_ROW_YL
         STA PWOL_CURRENT_YL
         LDA PWOL_CURRENT_YH
         SBC PWOL_ACROSS_ROW_YH
         STA PWOL_CURRENT_YH

         STX DEBUG_A
         STA DEBUG_B

         CPX #SCREEN_OUT_RIGHT
         BCS @ZBL_ZIG_RIGHT_SWITCH
         CPX #SCREEN_OUT_LEFT
         BCC @ZBL_ZIG_RIGHT_SWITCH
         CMP #SCREEN_OUT_TOP
         BCC @ZBL_ZIG_RIGHT_SWITCH
         CMP #SCREEN_OUT_BOTTOM
         BCC @zigzag_B_left
     @ZBL_ZIG_RIGHT_SWITCH: ; DOWN/LEFT to start right is is 0,+1  from where we is right now .. 
         ;INY
         ;INY
         LDA #TRY_AGAIN
         STA PWOL_TRIES_COUNTER
         CLC
         LDA PWOL_TUB_PTR_BL
         ADC #64
         STA PWOL_TUB_PTR_BL
         LDA PWOL_TUB_PTR_BH
         ADC #0
         CMP #>TUB_WORLD+8
         BCC :+
         rts
       : STA PWOL_TUB_PTR_BH


         CLC 

         LDA PWOL_CURRENT_XL
         ADC PWOL_NEXT_ROW_B_RIGHT_XL
         STA PWOL_CURRENT_XL

         LDA PWOL_CURRENT_XH
         ADC PWOL_NEXT_ROW_B_RIGHT_XH
         STA PWOL_CURRENT_XH
         TAX


         CLC 
         LDA PWOL_CURRENT_YL
         ADC PWOL_NEXT_ROW_B_RIGHT_YL
         STA PWOL_CURRENT_YL
         LDA PWOL_CURRENT_YH
         ADC PWOL_NEXT_ROW_B_RIGHT_YH
         STA PWOL_CURRENT_YH

         CPX #SCREEN_OUT_RIGHT
         BCS @ZBL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         CPX #SCREEN_OUT_LEFT
         BCC @ZBL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_TOP
         BCC @ZBL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_BOTTOM
         BCS @ZBL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         JMP @zigzag_B_right
   @ZBL_ZIG_RIGHT_SWITCH_TRY_AGAIN:
         DEC PWOL_TRIES_COUNTER 
         BNE @ZBL_ZIG_RIGHT_SWITCH_TRY_AGAIN_GO_RIGHT
   @ZBL_RTS:
      rts
   @ZBL_ZIG_RIGHT_SWITCH_TRY_AGAIN_GO_RIGHT:
         INY
         CLC
         LDA PWOL_CURRENT_XL
         ADC PWOL_ACROSS_ROW_XL
         STA PWOL_CURRENT_XL
         LDA PWOL_CURRENT_XH
         ADC PWOL_ACROSS_ROW_XH
         STA PWOL_CURRENT_XH
         TAX 
         CLC
         LDA PWOL_CURRENT_YL
         ADC PWOL_ACROSS_ROW_YL
         STA PWOL_CURRENT_YL
         LDA PWOL_CURRENT_YH
         ADC PWOL_ACROSS_ROW_YH
         STA PWOL_CURRENT_YH

         CPX #SCREEN_OUT_RIGHT
         BCS @ZBL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         CPX #SCREEN_OUT_LEFT
         BCC @ZBL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_TOP
         BCC @ZBL_ZIG_RIGHT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_BOTTOM
         BCS @ZBL_ZIG_RIGHT_SWITCH_TRY_AGAIN

    @zigzag_B_right:
        CPY #64  ;  make sure we don't go outside level.. 
        BCS @ZBR_NEXT ; if we're outside we'll just skip is OK 
        LDA (PWOL_TUB_PTR_BL),y
        CMP #129
        BCS @ZBR_NEXT ; we're outside level. 

        ; bytes 1 and 4 were updated when we cleared the object list
        INC OBJECT_LIST_BYTE6_NEXT ; is there objects left to use as next? 
        BNE :++
      : DEC OBJECT_LIST_BYTE6_NEXT ; so we can do this check again if out.. 
        rts ; @WHAT_THE_WHAT ; we shouldn't be outside the screen... 
      : LDX PWOL_CURRENT_YH ;  current screenY .. to calculate effective Z for the buffer 
        LDA SCREEN_Y_TO_Z,x 
        BEQ :-- ; we shouldn't be outside the screen... 
        STA PWOL_Z_STARTS_PTR  ; ok now that's primed to be at the start .. we want to grab whatever is at this buffer and save it to our new next..
        LDA (PWOL_Z_STARTS_PTR) ; get the current value here for the next ..
        LDX OBJECT_LIST_BYTE6_NEXT ; get index for this object
        STA OBJECT_LIST_BYTE6_NEXT,X ; old next becomes this object's next
        TXA ; push new next to the Z buffer spot
        STA (PWOL_Z_STARTS_PTR) ;  and the new next gets saved back the Z_starts... otay.. start filling in data..  
        ; bytes .1..4.6 filled in already.. 

        STZ OBJECT_LIST_BYTE0_ADDRLOW,X  ;   most of the time will be setting this anyway.. 
        LDA (PWOL_TUB_PTR_BL),y     ; get value of world at this point - 0-127=height, 128=wall, 129+ invalid
        BPL @ZBR_INSIDE_TUB 
      @ZBR_HIT_WALL_OUCH:
          STA OBJECT_LIST_BYTE0_ADDRLOW,X ; hit the wall, ouch.. write wall stuff
      @ZBR_INSIDE_TUB:
          STA PWOL_CONVERT_HEIGHTS; 0-128 valid as heights need convert to do sub though? 
          ;STA PWOL_CONVERT_HEIGHTS_SECONDARY ; this would be check to see if we're "extra tall" - wall is set to 128, 26 pixels smaller than would be.. 
          TYA
          AND #$0F
          ORA #$D0 ; #$D0
          STA OBJECT_LIST_BYTE5_SIZE,X ; 01.3456 done . 

          SEC        
          LDA PWOL_CURRENT_YH ; set er up
          SBC (PWOL_CONVERT_HEIGHTS)
          STA OBJECT_LIST_BYTE3_Y,X ; 01.34.6 filled in now 
          ;LDA #$D0
          ;STA OBJECT_LIST_BYTE5_SIZE,X ; 01.3456 done . 
          LDA PWOL_CURRENT_XH
          STA OBJECT_LIST_BYTE2_X,X    ; 0123456 OK - object is complete. 
     @ZBR_NEXT:
         ; calc next to the right.. 
         INY
         CLC
         LDA PWOL_CURRENT_XL
         ADC PWOL_ACROSS_ROW_XL
         STA PWOL_CURRENT_XL
         LDA PWOL_CURRENT_XH
         ADC PWOL_ACROSS_ROW_XH
         STA PWOL_CURRENT_XH
         TAX 
         CLC
         LDA PWOL_CURRENT_YL
         ADC PWOL_ACROSS_ROW_YL
         STA PWOL_CURRENT_YL
         LDA PWOL_CURRENT_YH
         ADC PWOL_ACROSS_ROW_YH
         STA PWOL_CURRENT_YH

         STX DEBUG_A
         STA DEBUG_B

         CPX #SCREEN_OUT_RIGHT
         BCS @ZBR_ZIG_LEFT_SWITCH
         CPX #SCREEN_OUT_LEFT
         BCC @ZBR_ZIG_LEFT_SWITCH
         CMP #SCREEN_OUT_TOP
         BCC @ZBR_ZIG_LEFT_SWITCH
         CMP #SCREEN_OUT_BOTTOM
         BCC @zigzag_B_right
     @ZBR_ZIG_LEFT_SWITCH: ;PWOL_NEXT_ROW_A_LEFT_XL   ; -> next row is left, going down the screen ..  +1,+1
         LDA #TRY_AGAIN
         STA PWOL_TRIES_COUNTER
        DEY ; have to go this to match where the thing is going .. 0,0
         CLC 
         LDA PWOL_TUB_PTR_BL
         ADC #64 ;   0,-1
         STA PWOL_TUB_PTR_BL
         LDA PWOL_TUB_PTR_BH
         ADC #0
         CMP #>TUB_WORLD+8
         BCC :+
         rts
       : STA PWOL_TUB_PTR_BH

         CLC 
         LDA PWOL_CURRENT_XL
         ADC PWOL_NEXT_ROW_B_LEFT_XL
         STA PWOL_CURRENT_XL
         LDA PWOL_CURRENT_XH
         ADC PWOL_NEXT_ROW_B_LEFT_XH
         STA PWOL_CURRENT_XH
         TAX
         CLC 
         LDA PWOL_CURRENT_YL
         ADC PWOL_NEXT_ROW_B_LEFT_YL
         STA PWOL_CURRENT_YL
         LDA PWOL_CURRENT_YH
         ADC PWOL_NEXT_ROW_B_LEFT_YH
         STA PWOL_CURRENT_YH
         ; check if we're outside ..  

         CPX #SCREEN_OUT_RIGHT
         BCS @ZBR_ZIG_LEFT_SWITCH_TRY_AGAIN
         CPX #SCREEN_OUT_LEFT
         BCC @ZBR_ZIG_LEFT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_TOP
         BCC @ZBR_ZIG_LEFT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_BOTTOM
         BCS @ZBR_ZIG_LEFT_SWITCH_TRY_AGAIN
         jmp @zigzag_B_left
   @ZBR_ZIG_LEFT_SWITCH_TRY_AGAIN:
         DEC PWOL_TRIES_COUNTER 
         BNE @ZBR_ZIG_LEFT_SWITCH_TRY_AGAIN_GO_LEFT
   @ZBR_RTS:
         rts
   @ZBR_ZIG_LEFT_SWITCH_TRY_AGAIN_GO_LEFT:
         DEY
         SEC
         LDA PWOL_CURRENT_XL
         SBC PWOL_ACROSS_ROW_XL
         STA PWOL_CURRENT_XL
         LDA PWOL_CURRENT_XH
         SBC PWOL_ACROSS_ROW_XH
         STA PWOL_CURRENT_XH
         TAX 
         SEC
         LDA PWOL_CURRENT_YL
         SBC PWOL_ACROSS_ROW_YL
         STA PWOL_CURRENT_YL
         LDA PWOL_CURRENT_YH
         SBC PWOL_ACROSS_ROW_YH
         STA PWOL_CURRENT_YH
         CPX #SCREEN_OUT_RIGHT
         BCS @ZBR_ZIG_LEFT_SWITCH_TRY_AGAIN
         CPX #SCREEN_OUT_LEFT
         BCC @ZBR_ZIG_LEFT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_TOP
         BCC @ZBR_ZIG_LEFT_SWITCH_TRY_AGAIN
         CMP #SCREEN_OUT_BOTTOM
         BCS @ZBR_ZIG_LEFT_SWITCH_TRY_AGAIN
         JMP @zigzag_B_left

draw_object_list:
    STZ VERA_ctrl
    STZ VERA_addr_low
    lda #(>VRAM_sprite_attributes)+1
    sta VERA_addr_high
    lda #$11
    sta VERA_addr_bank
    STZ ZP_PTR
    LDA #>OBJECT_LIST_Z_START_POINTERS
    STA ZP_PTR+1
    LDY #96 ; num sprites can write
  @NEXT_Z: ; Z=0 is invalid...
      INC ZP_PTR
      BNE @Z_LOOP
      : LDA VERA_data0
        LDA VERA_data0
        STZ VERA_data0
        STZ VERA_data0
        LDA VERA_data0
        LDA VERA_data0
        LDA VERA_data0
        LDA VERA_data0
        DEY
        BNE :-

      rts
  @Z_LOOP:
      LDA (ZP_PTR) ; get our first victim
      TAX
      LDA #0
      STA (ZP_PTR) ; zero this Z_next for now 
      TXA
     @OBJ_LOOP:
         TAX
         BEQ @NEXT_Z ; got a bum next pointer there ... 
         LDA OBJECT_LIST_BYTE0_ADDRLOW,X
         STA VERA_data0
         LDA OBJECT_LIST_BYTE1_MODE,x
         STA VERA_data0
         LDA OBJECT_LIST_BYTE2_X,x
         STA VERA_data0
;         CMP #216
  ;       LDA #0
 ;        BCC :+
 ;        LDA #$FF
  ;     : STA VERA_data0
         STZ VERA_data0
         LDA OBJECT_LIST_BYTE3_Y,x
         STA VERA_data0
;         CMP #161
 ;        LDA #0
  ;       BCC :+
   ;      LDA #$FF
    ;   : STA VERA_data0
         STZ VERA_data0
         LDA OBJECT_LIST_BYTE4_ZFLIPS,x
         STA VERA_data0
         LDA OBJECT_LIST_BYTE5_SIZE,x
         STA VERA_data0
         LDA OBJECT_LIST_BYTE6_NEXT,x
         DEY ; decrement that Y 
         BNE @OBJ_LOOP ; still sprite slots left.. woot!
         STA (ZP_PTR) ; oops.. save that last thing and exit..
         RTS
     


test_sprite_data:
; first 16 sprites reserved ... 
;      0   1   2   3   4   5   6  7
;     add,mod, XL, XH, YL, YH,msk,hwp
.byte  66,$00,100,  0,72,  0,$0C,$50  ;  cursor middle - 8x8  sprite 0
.byte  16,$00, 12,  0,  0,  0,$0C,$30  ;  border top - 64x8    sprite 1
.byte  16,$00, 76,  0,SCREEN_OUT_TOP,  0,$0C,$30  ;  border top - 64x8    sprite 2
.byte  16,$00,140,  0,  0,  0,$0C,$30  ;  border top - 64x8    sprite 3

.byte  16,$00, 12,  0,153,  0,$0F,$30  ;  border bottom - 64x8  sprite 4
.byte  16,$00, 76,  0,SCREEN_OUT_BOTTOM,  0,$0F,$30  ;  border bottom - 64x8  sprite 5
.byte  16,$00,140,  0,153,  0,$0F,$30  ;  border bottom - 64x8  sprite 6

.byte  16,$00,  0,  0, 16,  0,$0C,$C0  ;  border left    8x64   sprite 7
.byte  16,$00,SCREEN_OUT_LEFT+8,  0, 80,  0,$0C,$C0  ;  border left    8x64   sprite 8
.byte  16,$00,208,  0, 16,  0,$0F,$C0  ;  border left    8x64   sprite 9
.byte  16,$00,SCREEN_OUT_RIGHT,  0, 80,  0,$0F,$C0  ;  border left    8x64   sprite A
.byte  49,$00,140,  0,109,  0,$0C,$00  ; sprite B   bearing  Label
;.byte  58,$00,140,  0,118,  0,$0c,$30  ; sprite C   WORLD
;.byte  50,$00,140,  0,136,  0,$0c,$30  ; sprite D   Cell
.byte  33,$00,148,  0,109,  0,$0C,$00  ; 0 test    sprite 0E   bearing
.byte  34,$00,156,  0,109,  0,$0C,$00  ; 1 test    sprite 0F
.byte  39,$00,140,  0,127,  0,$0C,$00  ; 6 test    sprite 10   world XH
.byte  40,$00,148,  0,127,  0,$0C,$00  ; 7 test    sprite 11   
.byte  41,$00,156,  0,127,  0,$0C,$00  ; 8 test    sprite 12   world Xl
.byte  42,$00,164,  0,127,  0,$0C,$00  ; 9 test    sprite 13
.byte  43,$00,176,  0,127,  0,$0C,$00  ; A test    sprite 14   world YH
.byte  44,$00,184,  0,127,  0,$0C,$00  ; B test    sprite 15
.byte  45,$00,192,  0,127,  0,$0C,$00  ; C test    sprite 16   world Yl
.byte  46,$00,200,  0,127,  0,$0C,$00  ; D test    sprite 17
.byte  35,$00,140,  0,145,  0,$0C,$00  ; 2 test    sprite 18   Cell X 
.byte  36,$00,148,  0,145,  0,$0C,$00  ; 3 test    sprite 19   
.byte  47,$00,156,  0,145,  0,$0C,$00  ; E test    sprite 1A   X Subcell
.byte  47,$00,164,  0,145,  0,$0C,$00  ; E test    sprite 1A   
.byte  37,$00,176,  0,100,  0,$0C,$00  ; 4 test    sprite 1C   DEBUG_A
.byte  38,$00,184,  0,100,  0,$0C,$00  ; 5 test    sprite 1D   
.byte  48,$00,192,  0,100,  0,$0C,$00  ; F test    sprite 1E   DEBUG_B
.byte  48,$00,200,  0,100,  0,$0C,$00  ; F test    sprite 1F
.byte  33,$00,192,  0, 91,  0,$0C,$00  ; 0 test    sprite 0E   DEBUG_C
.byte  33,$00,200,  0, 91,  0,$0C,$00  ; 0 test    sprite 0E   

test_optimal_pal_data:
;      GB   R  $1:FA00-$1:FBFF   VERA Color Palette (256 x 2 bytes)
.byte $00,$00  ; 0 - black/transparent
.byte $c8,$0f  ; 1 #ffcc88

.byte $04,$06  ; 2 #660044
.byte $00,$0C  ; 3  #cc0000
.byte $F0,$0C  ; 4#ccff00
.byte $42,$03
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
.byte $0E, $9E, $E9, $9E, $E9, $9E, $E9, $9E   ;  11

.repeat 13
    .byte $EE, $EE, $EE, $EE, $EE, $EE, $EE, $E0    ;  12
    .byte $0E, $EE, $66, $EE, $EE, $66, $EE, $EE    ;     
    .byte $EE, $66, $EE, $66, $66, $EE, $66, $E0    ;  
    .byte $06, $EE, $EE, $EE, $EE, $EE, $EE, $66    ;  
.endrepeat

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

.byte $00, $11, $11, $00   ; F   sprite addr 48
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $00, $11, $11, $00
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $01, $00, $00, $00
.byte $00, $00, $00, $00   

.byte $00, $00, $00, $00  ;  bearing label   sprite addr 49
.byte $00, $00, $01, $00
.byte $00, $00, $10, $00
.byte $00, $01, $00, $00
.byte $00, $10, $00, $00
.byte $01, $00, $00, $00
.byte $11, $11, $11, $00
.byte $00, $00, $00, $00

; cell position label sprite addr 50-57
.byte $00,$FF,$00,$FF,$FF,$00,$FF,$00,$00,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 
.byte $FF,$00,$00,$FF,$00,$00,$FF,$00,$00,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00   
.byte $FF,$00,$00,$FF,$FF,$00,$FF,$00,$00,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00   
.byte $FF,$00,$00,$FF,$00,$00,$FF,$00,$00,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00   
.byte $00,$FF,$00,$FF,$FF,$00,$FF,$FF,$00,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00   
;      01, 23, 45, 67, 89, AF, CD, EF, 01, 23, 45, 67, 89, AF, CD, EF, 01, 23, 45, 67, 89, AF, CD, EF, 01, 23, 45, 67, 89, AF, CD, EF
;     XH                               $XL                            ___  __  YH                              YL
.byte $10,$10,$10,$10,$00,$00,$00,$00,$10,$10,$10,$00,$00,$00,$00,$00,$00,$00,$10,$10,$10,$10,$00,$00,$00,$00,$10,$10,$10,$00,$00,$00  
.byte $01,$00,$11,$10,$00,$00,$00,$00,$01,$00,$10,$00,$00,$00,$00,$00,$00,$00,$01,$00,$11,$10,$00,$00,$00,$00,$01,$00,$10,$00,$00,$00  
.byte $10,$10,$10,$10,$00,$00,$00,$00,$10,$10,$11,$10,$00,$00,$00,$00,$00,$00,$01,$00,$10,$10,$00,$00,$00,$00,$01,$00,$11,$10,$00,$00  

; world position label 58-65
;     XH                 $XL                  ___  ___  YH                  YL
.byte $FF,$00,$00,$00,$FF,$00,$00,$FF,$00,$00,$FF,$FF,$00,$00,$FF,$00,$00,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00   
.byte $FF,$00,$00,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$00,$FF,$00,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00   
.byte $FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$FF,$00,$00,$FF,$00,$00,$FF,$00,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00   
.byte $FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$00,$FF,$00,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00   
.byte $00,$FF,$00,$FF,$00,$00,$00,$FF,$00,$00,$FF,$00,$FF,$00,$FF,$FF,$00,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00   
;      01, 23, 45, 67, 89, AF, CD, EF, 01, 23, 45, 67, 89, AF, CD, EF, 01, 23, 45, 67, 89, AF, CD, EF, 01, 23, 45, 67, 89, AF, CD, EF
;     XH                               $XL                            ___  __  YH                              YL
.byte $10,$10,$10,$10,$00,$00,$00,$00,$10,$10,$10,$00,$00,$00,$00,$00,$00,$00,$10,$10,$10,$10,$00,$00,$00,$00,$10,$10,$10,$00,$00,$00  
.byte $01,$00,$11,$10,$00,$00,$00,$00,$01,$00,$10,$00,$00,$00,$00,$00,$00,$00,$01,$00,$11,$10,$00,$00,$00,$00,$01,$00,$10,$00,$00,$00  
.byte $10,$10,$10,$10,$00,$00,$00,$00,$10,$10,$11,$10,$00,$00,$00,$00,$00,$00,$01,$00,$10,$10,$00,$00,$00,$00,$01,$00,$11,$10,$00,$00  

; directional cursor reminder... 16x16 - 66-69

.byte $00, $10, $00, $10, $01, $11, $11, $00
.byte $00, $10, $00, $10, $01, $00, $00, $00
.byte $00, $10, $10, $10, $01, $11, $00, $00
.byte $00, $10, $10, $10, $01, $00, $00, $00
.byte $00, $01, $01, $00, $01, $11, $11, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00
.byte $01, $11, $00, $00, $00, $01, $11, $00
.byte $10, $00, $10, $01, $10, $01, $00, $01
.byte $11, $11, $10, $01, $10, $01, $00, $01
.byte $10, $00, $10, $00, $00, $01, $11, $10
.byte $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $11, $11, $10, $01, $00, $01, $00
.byte $00, $00, $01, $00, $00, $10, $10, $00
.byte $00, $00, $10, $00, $00, $01, $00, $00
.byte $00, $01, $00, $00, $00, $10, $10, $00
.byte $00, $11, $11, $10, $01, $00, $01, $00

.repeat 58 ; 128-70
    .res 32,$80
.endrepeat

; alernate tile graphic to use for tub wall .. 128 to 159 16x64
.repeat 32
    .byte $16, $16, $16, $16, $16, $16, $16, $16
    .byte $61, $61, $61, $61, $61, $61, $61, $61
.endrepeat
