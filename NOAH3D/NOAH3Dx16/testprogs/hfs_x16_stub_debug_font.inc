; now we're at RAM address $0810 - there's 240 bytes from here to next page boundary.. code to load bank files could go here later...
; for now, want to be sure we end at page boundary

;
DECODE_DEBUG_FONT_TO_VRAM:  ; 080D debug font start at top of VRAM $0000 .. debug blank $10
  stz $9F29 ; 080D  3 bytes   clear DCSEL set addr 0 
  stz $9F20 ; 0810  3 bytes     vera addr low
  stz $9F21 ; 0813  3 bytes     high
  lda #$10  ; 0816  2 bytes     for increment
  sta $9F22 ; 0818  3           bank
  ldy #56 ; 081B  start of font data .. 
  @DECODE_DEBUG_FONT_TO_VRAM:
      stz $9f23 ; 081D 3 bytes.. top row of tile
      ldx #5 ; 0820   2 bytes
      @DECODE_DEBUG_FONT_TO_VRAM_INNER:
        lda $0800,y ; 0822  2 bytes
        sta $9f23 ; 0824  3 bytes
        iny ; 0827    1             -4 copies of this loop = -20    63
        dex ; 0828  +1 byte     64
        bne @DECODE_DEBUG_FONT_TO_VRAM_INNER ; 0829   +2 bytes     66  
      stz $9f23 ; 0831  3   039 2    row 6
      stz $9f23 ; 0834  3
      tya ;   0837  1
      bne @DECODE_DEBUG_FONT_TO_VRAM      ;   0838  2
  jmp INIT ; 0840   3   - 
END_DEBUG_FONT_TO_VRAM: ; 0843  




























HFS_DEBUG_FONT_1BPP: ; is 8x5 font, 16*5=80 bytes hex digits 0-F .. 
.byte %00111100 ; 0    0847     3C
.byte %01000110 ; 46
.byte %01010010 ; 52
.byte %01100010 ; 62
.byte %00111100 ; 3C
.byte %00000100 ; 1     084C
.byte %00000100
.byte %00000100
.byte %00000100
.byte %00000100
.byte %00111100 ; 2     0851
.byte %01000010
.byte %00001100
.byte %00010000
.byte %01111110
.byte %00111100 ; 3     0856
.byte %01000010
.byte %00001100
.byte %01000010
.byte %00111100
.byte %01000010 ; 4     085b
.byte %01000010
.byte %01111110
.byte %00000010
.byte %00000010
.byte %01111110 ; 5     0860
.byte %01000000
.byte %01111100
.byte %00000010
.byte %00111100
.byte %00111100 ; 6
.byte %01000000
.byte %01111000
.byte %01000110
.byte %00111100
.byte %00111100 ; 7     0865
.byte %00000100
.byte %00001000
.byte %00010000
.byte %00010000
.byte %00111100 ; 8     086a
.byte %01000010
.byte %00111100
.byte %01000010
.byte %00111100
.byte %00111100 ; 9     086f
.byte %01000010
.byte %00111110
.byte %00000010
.byte %00000010
.byte %00011000 ; A     0874
.byte %00100100
.byte %01111110
.byte %01000010
.byte %01000010
.byte %01111000 ; B     0879
.byte %01000100
.byte %01111000
.byte %01000110
.byte %01111000
.byte %00111100 ; C     087e
.byte %01000010
.byte %01000000
.byte %01000010
.byte %00111100
.byte %01111000 ; D     0883
.byte %01000100
.byte %01000010
.byte %01000100
.byte %01111000
.byte %01111110 ; E     0888
.byte %01000000
.byte %01111000
.byte %01000000
.byte %01111110
.byte %01111110 ; F     088d
.byte %01000000
.byte %01111000
.byte %01000000
.byte %01000000  
.byte %00111110 ; G     0892
.byte %01000000 
.byte %01001110 
.byte %01000010 
.byte %00111110 
.byte %01000010 ; H     0897
.byte %01000010 
.byte %01111110 
.byte %01000010 
.byte %01000010 
.byte %01111110 ; I     089C
.byte %00010000 
.byte %00010000 
.byte %00010000 
.byte %01111110 
.byte %01111110 ; J     08A1
.byte %00001000 
.byte %00001000 
.byte %01001000 
.byte %00110000 
.byte %01001000 ; K     08A6
.byte %01010000 
.byte %01110000 
.byte %01001000 
.byte %01000100 
.byte %01000000 ; L     08AB
.byte %01000000 
.byte %01000000 
.byte %01000000 
.byte %01111110 
.byte %01100110 ; M     08B0
.byte %01011010 
.byte %01011010 
.byte %01000010 
.byte %01000010 
.byte %01000010 ; N     08B5
.byte %01100010 
.byte %01010010 
.byte %01001010 
.byte %01000110 
.byte %00111100 ; O     08BA
.byte %01000010 
.byte %01000010 
.byte %01000010 
.byte %00111100 
.byte %01111100 ; P     08BF
.byte %01000010 
.byte %01111100 
.byte %01000000 
.byte %01000000 
.byte %00111100 ; Q     08C4
.byte %01000010 
.byte %01001010 
.byte %01000100 
.byte %00111010 
.byte %01111100 ; R     08C9
.byte %01000110 
.byte %01111000 
.byte %01000100 
.byte %01000010 
.byte %00111100 ; S     08CE
.byte %01100010 
.byte %00011000 
.byte %01000110 
.byte %00111100 
.byte %01111110 ; T     08D3
.byte %00001000 
.byte %00001000 
.byte %00001000 
.byte %00001000 
.byte %01000010 ; U     08D8
.byte %01000010 
.byte %01000010 
.byte %01000110 
.byte %00111010 
.byte %01000010 ; V     08DD
.byte %01000010 
.byte %00100100 
.byte %00100100 
.byte %00011000 
.byte %01000010 ; W     08E2
.byte %01000010 
.byte %01011010 
.byte %01011010 
.byte %00100100 
.byte %01000010 ; X     08E7
.byte %00100100 
.byte %00011000 
.byte %00100100 
.byte %01000010 
.byte %01000010 ; Y     08EC
.byte %00100100 
.byte %00011000 
.byte %00010000 
.byte %00010000 
.byte %01111110 ; Z     08F1
.byte %00000110 
.byte %00011000 
.byte %01100000 
.byte %01111110 
.byte %00000000 ; space     08F6
.byte %00000000 
.byte %00000000 
.byte %00000000 
.byte %00000000 
.byte %00101000 ; #
.byte %01111100 
.byte %00101000 
.byte %01111100 
.byte %00101000 
.byte %00000000 ; hyphen    
.byte %00000000 
.byte %01111110 
.byte %00000000 
.byte %00000000 
.byte %00011000 ; pipe     
.byte %00011000 
.byte %00000000 
.byte %00011000 
.byte %00011000 

