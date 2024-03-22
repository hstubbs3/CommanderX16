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
FX_MULT           = $9F2C ; DCSEL = 2
FX_CACHE_L        = $9F29 ; DCSEL = 6 
FX_CACHE_M        = $9F2A 
FX_CACHE_H        = $9F2B
FX_CACHE_U        = $9F2C 
;   Current Field | Sprites Enable | Layer1 Enable  |Layer0 Enable 
; NTSC/RGB: 240P  | NTSC: Chroma Disable / RGB: HV Sync Output Mode

VERA_dc_hscale    = $9F2A
VERA_dc_vscale    = $9F2B

; Kernal
CHROUT            = $FFD2
GETIN             = $FFE4
CINT              = $FF81

ZP_PTR = $22

start:

  ; let's stick that test sprite data into VRAM at zero for now.. 
  stz VERA_ctrl
  stz VERA_addr_low
  stz VERA_addr_high
  lda #$10
  sta VERA_addr_bank
  ; load test VRAM data

  ; is 512 bytes at test_cell_sprite label
  ldy #0

  LDA #<SPRITE_DATA
  STA ZP_PTR
  LDA #>SPRITE_DATA
  STA ZP_PTR+1
  LDX #128   ;   num pages to copy - in this case, 8 per 64x64 x 16 sprite.. 
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

     LDA #$41
     STA VERA_dc_video

  STZ VERA_addr_low
  LDA #$FC
  STA VERA_addr_high
  LDA #$11
  sta VERA_addr_bank
;  LDA #32
;  STA VERA_dc_hscale
;  STA VERA_dc_vscale

  STZ ZP_PTR ; addrlow 
  STZ ZP_PTR+1 ; addrhigh
  STZ ZP_PTR+2 ; x low
  STZ ZP_PTR+3 ; x high
  STZ ZP_PTR+4 ; y low 
  STZ ZP_PTR+5 ; y high

  LDX #16
: CLC 
  LDA ZP_PTR
  STA VERA_data0 	;	addr low
  ADC #64
  STA ZP_PTR
  LDA ZP_PTR+1
  STA VERA_data0 	;	mode / addr high
  ADC #0
  STA ZP_PTR+1
  LDA ZP_PTR+2
  STA VERA_data0 	;	x low
  ADC #64
  STA ZP_PTR+2
  TAY
  LDA ZP_PTR+3
  STA VERA_data0 	;	x high
  ADC #0
  STA ZP_PTR+3
  LDA ZP_PTR+4
  STA VERA_data0 	;	y low
  LDA ZP_PTR+5
  stA VERA_data0 	;	y high
  LDA #$0C  			;	enable 
  sta VERA_data0
  LDA #$F1 			;	64x64 palette offset 1 
  sta VERA_data0

  LDA ZP_PTR+2
  CMP #2
  BNE :+  
  CPY #192 
  BNE :+
  LDA ZP_PTR+4
  ADC #64
  STA ZP_PTR+4
  LDA ZP_PTR+5
  ADC #0
  STA ZP_PTR+5
: DEX 
  BNE :--



WAIT:
  wai
  JSR GETIN
  cmp #32 ; space 
  BNE :+
  nop
: cmp #13 ; return
  BNE WAIT
  JSR CINT
  rts

SPRITE_ATTRIBUTES:
;     addrl,mod, Xl, Xh, Yl, Yh,Zflip,sz/off
.byte     0,  0,  0,  0,  0,  0,  $0C, $F0 ; offset zero left half
.byte    64,  0, 64,  0,  0,  0,  $0C, $F0 ; offset zero second half
.byte   128,  0,128,  0,  0,  0,  $0C, $F1 ; 
.byte   192,  0,128,  0,  0,  0,  $0C, $F1 ; 

SPRITE_DATA:
.include "spider_128x64_4bit_perc.inc"
