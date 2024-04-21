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

CINT              = $FF81
VSYNC_BIT         = $01
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
VERA_dc_video     = $9F29

.include "HFSinput.s"

default_irq_vector:  .addr 0 
VSYNC_counter:       .byte 0 
LINE_COUNTER: 		 .byte 0

;	The X16 KERNAL uses the following video memory layout:
; 	
; 	Addresses	Description
; 	$0:0000-$1:2BFF	320x240@256c Bitmap
; 	$1:2C00-$1:2FFF	unused (1024 bytes)
; 	$1:3000-$1:AFFF	Sprite Image Data (up to $1000 per sprite at 64x64 8-bit)
; 	$1:B000-$1:EBFF	Text Mode
; 	$1:EC00-$1:EFFF	unused (1024 bytes)
; 	$1:F000-$1:F7FF	Charset
; 	$1:F800-$1:F9BF	unused (448 bytes)
; 	$1:F9C0-$1:F9FF	VERA PSG Registers (16 x 4 bytes)
; 	$1:FA00-$1:FBFF	VERA Color Palette (256 x 2 bytes)
; 	$1:FC00-$1:FFFF	VERA Sprite Attributes (128 x 8 bytes)


custom_irq_handler: ; 2E12
   lda VERA_isr
   and #VSYNC_BIT
   BEQ :+
   INC VSYNC_counter
;   jmp (default_irq_vector)
;   STA VERA_data0
 : jmp (default_irq_vector)

start:
  lda IRQVec
  sta default_irq_vector
  lda IRQVec+1
  sta default_irq_vector+1
  sei ; disable IRQ while vector is changing
  lda #<custom_irq_handler
  sta IRQVec
  lda #>custom_irq_handler
  sta IRQVec+1
  lda #VSYNC_BIT ; make VERA only generate VSYNC IRQs
  sta VERA_ien
  cli ; enable IRQ now that vector is properly set

  JSR HFS_INIT_KEYMAP
  STZ HFS_KEYMAP+32 ;	sets spacebar to be exit key

FRAMELOOP:
	LDA VSYNC_counter
	CMP #2
	BCS :++
  : wai
    LDA VSYNC_counter
    CMP #2
	BCC :-
  :
  	STZ VSYNC_counter

  	STZ VERA_ctrl
  	STZ VERA_addr_low
  	LDA LINE_COUNTER
  	INC A
  	CMP #60
  	BCC :+
  	LDA #0
  	CLC
  : STA LINE_COUNTER
  	ADC #$B0
  	STA VERA_addr_high
  	LDA #$21
  	STA VERA_addr_bank

  	LDA LINE_COUNTER
  	STA VERA_data0

 ; 	JSR HFS_GET_KEYS
 
  	LDX #0
  : BIT HFS_KEYSTATE,X 
  	BPL :+
  	STX VERA_data0
  : INX 
  	BNE :--

  	BIT HFS_KEYSTATE ; entry 0 is for exiting..
  	BPL FRAMELOOP


CLEANUP_AND_EXIT:
   ; restore default IRQ vector
   sei
   lda default_irq_vector
   sta IRQVec
   lda default_irq_vector+1
   sta IRQVec+1
   cli   
;   jsr CINT we're not trashing screen mode this time so... ?
   rts