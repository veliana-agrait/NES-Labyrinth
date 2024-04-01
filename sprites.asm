.include "constants.inc"
.include "header.inc"

.segment "CODE"
.proc irq_handler
  RTI
.endproc

.proc nmi_handler
  LDA #$00
  STA OAMADDR
  LDA #$02
  STA OAMDMA
    LDA #$00
    STA $2005
    STA $2005
  RTI
.endproc

.import reset_handler

.export main
.proc main
  ; write a palette
  LDX PPUSTATUS
  LDX #$3f
  STX PPUADDR
  LDX #$00
  STX PPUADDR

load_palettes:
  LDA palettes,X
  STA PPUDATA
  INX
  CPX #$20
  BNE load_palettes

  ; write sprite data
  LDX #$00
load_sprites:
  LDA sprites,X
  STA $0200,X
  INX
  CPX #$C0
  BNE load_sprites

  ; metal block 
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$50
	STA PPUADDR
	LDX #$20
	STX PPUDATA
  
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$51
	STA PPUADDR
	LDX #$21
	STX PPUDATA

  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$70
	STA PPUADDR
	LDX #$30
	STX PPUDATA
    
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$71
	STA PPUADDR
	LDX #$31
	STX PPUDATA

  ; broken metal block 
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$52
	STA PPUADDR
	LDX #$26
	STX PPUDATA
  
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$53
	STA PPUADDR
	LDX #$27
	STX PPUDATA

  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$72
	STA PPUADDR
	LDX #$36
	STX PPUDATA
    
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$73
	STA PPUADDR
	LDX #$37
	STX PPUDATA

  ; brick block 
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$90
	STA PPUADDR
	LDX #$22
	STX PPUDATA
  
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$91
	STA PPUADDR
	LDX #$23
	STX PPUDATA

  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$B0
	STA PPUADDR
	LDX #$32
	STX PPUDATA
    
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$B1
	STA PPUADDR
	LDX #$33
	STX PPUDATA

  ; broken brick block 
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$92
	STA PPUADDR
	LDX #$24
	STX PPUDATA
  
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$93
	STA PPUADDR
	LDX #$25
	STX PPUDATA

  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$B2
	STA PPUADDR
	LDX #$34
	STX PPUDATA
    
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$B3
	STA PPUADDR
	LDX #$35
	STX PPUDATA

  ; bush 
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$D0
	STA PPUADDR
	LDX #$08
	STX PPUDATA
  
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$D1
	STA PPUADDR
	LDX #$09
	STX PPUDATA

  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$F0
	STA PPUADDR
	LDX #$18
	STX PPUDATA
    
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$F1
	STA PPUADDR
	LDX #$19
	STX PPUDATA

  ; overgrown bush 
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$D2
	STA PPUADDR
	LDX #$0A
	STX PPUDATA
  
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$D3
	STA PPUADDR
	LDX #$0B
	STX PPUDATA

  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$F2
	STA PPUADDR
	LDX #$1A
	STX PPUDATA
    
  LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$F3
	STA PPUADDR
	LDX #$1B
	STX PPUDATA

  ; tunnel blocks

  LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$11
	STA PPUADDR
	LDX #$2C
	STX PPUDATA
  
  LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$31
	STA PPUADDR
	LDX #$3C
	STX PPUDATA

  LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$12
	STA PPUADDR
	LDX #$2B
	STX PPUDATA
    
  LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$32
	STA PPUADDR
	LDX #$3B
	STX PPUDATA

  ; attribute tables

  LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$D4
	STA PPUADDR
	LDA #%11110000
	STA PPUDATA

  LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$DC
	STA PPUADDR
	LDA #%10100101
	STA PPUDATA

  LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$E4
	STA PPUADDR
	LDA #%00000101
	STA PPUDATA

vblankwait:       ; wait for another vblank before continuing
  BIT PPUSTATUS
  BPL vblankwait

  LDA #%10010000  ; turn on NMIs, sprites use first pattern table
  STA PPUCTRL
  LDA #%00011110  ; turn on screen
  STA PPUMASK

forever:
  JMP forever
.endproc

.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler

.segment "RODATA"
palettes:
  ; Background Palette
  .byte $0f, $00, $00, $00
  .byte $0f, $07, $06, $16
  .byte $0f, $1A, $2A, $25
  .byte $0f, $00, $10, $20

  ; Sprite Palette
  .byte $0f, $16, $36, $04
  .byte $0f, $00, $00, $00
  .byte $0f, $00, $00, $00
  .byte $0f, $00, $00, $00

sprites:
  .byte $50, $08, $00, $50
  .byte $50, $09, $00, $58
  .byte $58, $18, $00, $50
  .byte $58, $19, $00, $58

  .byte $50, $0A, $00, $60
  .byte $50, $0B, $00, $68
  .byte $58, $1A, $00, $60
  .byte $58, $1B, $00, $68

  .byte $50, $0C, $00, $70
  .byte $50, $0D, $00, $78
  .byte $58, $1C, $00, $70
  .byte $58, $1D, $00, $78

  .byte $60, $0E, $00, $50
  .byte $60, $0F, $00, $58
  .byte $68, $1E, $00, $50
  .byte $68, $1F, $00, $58

  .byte $60, $20, $00, $60
  .byte $60, $21, $00, $68
  .byte $68, $30, $00, $60
  .byte $68, $31, $00, $68

  .byte $60, $22, $00, $70
  .byte $60, $23, $00, $78
  .byte $68, $32, $00, $70
  .byte $68, $33, $00, $78

  .byte $70, $24, $00, $50
  .byte $70, $25, $00, $58
  .byte $78, $34, $00, $50
  .byte $78, $35, $00, $58

  .byte $70, $26, $00, $60
  .byte $70, $27, $00, $68
  .byte $78, $36, $00, $60
  .byte $78, $37, $00, $68

  .byte $70, $28, $00, $70
  .byte $70, $29, $00, $78
  .byte $78, $38, $00, $70
  .byte $78, $39, $00, $78

  .byte $80, $2A, $00, $50
  .byte $80, $2B, $00, $58
  .byte $88, $3A, $00, $50
  .byte $88, $3B, $00, $58

  .byte $80, $2C, $00, $60
  .byte $80, $2D, $00, $68
  .byte $88, $3C, $00, $60
  .byte $88, $3D, $00, $68

  .byte $80, $2E, $00, $70
  .byte $80, $2F, $00, $78
  .byte $88, $3E, $00, $70
  .byte $88, $3F, $00, $78


.segment "CHR"
.incbin "Tileset.chr"