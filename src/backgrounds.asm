.import main
.import vblankwait
.export load_background
.export load_background2

.proc load_background
    ; save registers
  PHP
  PHA
  TXA
  PHA
  TYA
  PHA

  LDA #$20             ; Load the high byte of $2006 address
  STA $2006            ; Write to PPU (resetting the high/low latch)
  LDA #$00             ; Load the low byte of $2006 address
  STA $2006            ; Write to PPU

  LDX #$00             ; Initialize X for the background array index
  LDY #$00

LoadBackgroundLoop:

  LDA background, X
  AND #%11000000
  CMP #%00000000
  BEQ PrintTile1
  CMP #%01000000
  BEQ PrintTile2
  CMP #%10000000
  BEQ PrintTile3
  CMP #%11000000
  BEQ PrintTile4

PrintTile1:
  LDA #$00
  STA $2007
  STA $2007
  JMP SecondPair

PrintTile2:
  LDA #$20
  STA $2007
  STA $2007
  JMP SecondPair

PrintTile3:
  LDA #$08
  STA $2007
  STA $2007
  JMP SecondPair

PrintTile4:
  LDA #$22
  STA $2007
  STA $2007

SecondPair:
  LDA background, X
  AND #%00110000
  CMP #%00000000
  BEQ PrintTile1S
  CMP #%00010000
  BEQ PrintTile2S
  CMP #%00100000
  BEQ PrintTile3S
  CMP #%00110000
  BEQ PrintTile4S

PrintTile1S:
  LDA #$00
  STA $2007
  STA $2007
  JMP ThirdPair

PrintTile2S:
  LDA #$20
  STA $2007
  STA $2007
  JMP ThirdPair

PrintTile3S:
  LDA #$08
  STA $2007
  STA $2007
  JMP ThirdPair

PrintTile4S:
  LDA #$22
  STA $2007
  STA $2007

ThirdPair:
  LDA background, X
  AND #%00001100
  CMP #%00000000
  BEQ PrintTile1T
  CMP #%00000100
  BEQ PrintTile2T
  CMP #%00001000
  BEQ PrintTile3T
  CMP #%00001100
  BEQ PrintTile4T

PrintTile1T:
  LDA #$00
  STA $2007
  STA $2007
  JMP FourthPair

PrintTile2T:
  LDA #$20
  STA $2007
  STA $2007
  JMP FourthPair

PrintTile3T:
  LDA #$08
  STA $2007 
  STA $2007
  JMP FourthPair

PrintTile4T:
  LDA #$22
  STA $2007
  STA $2007

FourthPair:
  LDA background, X
  AND #%00000011
  CMP #%00000000
  BEQ PrintTile1F
  CMP #%00000001
  BEQ PrintTile2F
  CMP #%00000010
  BEQ PrintTile3F
  CMP #%00000011
  BEQ PrintTile4F

PrintTile1F:
  LDA #$00
  STA $2007
  STA $2007
  JMP FinishByte

PrintTile2F:
  LDA #$20
  STA $2007
  STA $2007
  JMP FinishByte

PrintTile3F:
  LDA #$08
  STA $2007
  STA $2007
  JMP FinishByte

PrintTile4F:
  LDA #$22
  STA $2007
  STA $2007

FinishByte:

  INX
  CPX #$78
  BEQ SecondNameTable
  JMP LoadBackgroundLoop  ; Branch back if not finished  


SecondNameTable:
  LDA #$24             ; Load the high byte of $2006 address
  STA $2406            ; Write to PPU (resetting the high/low latch)
  LDA #$00             ; Load the low byte of $2006 address
  STA $2406            ; Write to PPU

NextBackground:

  LDA background2, Y
  AND #%11000000
  CMP #%00000000
  BEQ PrintTile1b
  CMP #%01000000
  BEQ PrintTile2b
  CMP #%10000000
  BEQ PrintTile3b
  CMP #%11000000
  BEQ PrintTile4b

PrintTile1b:
  LDA #$00
  STA $2407
  STA $2407
  JMP SecondPairb

PrintTile2b:
  LDA #$20
  STA $2407
  STA $2407
  JMP SecondPairb

PrintTile3b:
  LDA #$08
  STA $2407
  STA $2407
  JMP SecondPairb

PrintTile4b:
  LDA #$22
  STA $2407
  STA $2407

SecondPairb:
  LDA background2, Y
  AND #%00110000
  CMP #%00000000
  BEQ PrintTile1Sb
  CMP #%00010000
  BEQ PrintTile2Sb
  CMP #%00100000
  BEQ PrintTile3Sb
  CMP #%00110000
  BEQ PrintTile4Sb

PrintTile1Sb:
  LDA #$00
  STA $2407
  STA $2407
  JMP ThirdPairb

PrintTile2Sb:
  LDA #$20
  STA $2407
  STA $2407
  JMP ThirdPairb

PrintTile3Sb:
  LDA #$08
  STA $2407
  STA $2407
  JMP ThirdPairb

PrintTile4Sb:
  LDA #$22
  STA $2407
  STA $2407

ThirdPairb:
  LDA background2, Y
  AND #%00001100
  CMP #%00000000
  BEQ PrintTile1Tb
  CMP #%00000100
  BEQ PrintTile2Tb
  CMP #%00001000
  BEQ PrintTile3Tb
  CMP #%00001100
  BEQ PrintTile4Tb

PrintTile1Tb:
  LDA #$00
  STA $2407
  STA $2407
  JMP FourthPairb

PrintTile2Tb:
  LDA #$20
  STA $2407
  STA $2407
  JMP FourthPairb

PrintTile3Tb:
  LDA #$08
  STA $2407 
  STA $2407
  JMP FourthPairb

PrintTile4Tb:
  LDA #$22
  STA $2407
  STA $2407

FourthPairb:
  LDA background2, Y
  AND #%00000011
  CMP #%00000000
  BEQ PrintTile1Fb
  CMP #%00000001
  BEQ PrintTile2Fb
  CMP #%00000010
  BEQ PrintTile3Fb
  CMP #%00000011
  BEQ PrintTile4Fb

PrintTile1Fb:
  LDA #$00
  STA $2407
  STA $2407
  JMP FinishByteb

PrintTile2Fb:
  LDA #$20
  STA $2407
  STA $2407
  JMP FinishByteb

PrintTile3Fb:
  LDA #$08
  STA $2407
  STA $2407
  JMP FinishByteb

PrintTile4Fb:
  LDA #$22
  STA $2407
  STA $2407

FinishByteb:

  INY
  CPY #$78
  BEQ EndStage1
  JMP NextBackground

EndStage1:

PLA
TAY
PLA
TAX
PLA
PLP
RTS
.endproc


.proc load_background2

  PHP
  PHA
  TXA
  PHA
  TYA
  PHA

  LDA $2002
  LDA #$20             ; Load the high byte of $2006 address
  STA $2006            ; Write to PPU (resetting the high/low latch)
  LDA #$00             ; Load the low byte of $2006 address
  STA $2006            ; Write to PPU

  LDX #$00             ; Initialize X for the background array index
  LDY #$00

LoadStage2:

  LDA background, X
  AND #%11000000
  CMP #%00000000
  BEQ PrintTile1c
  CMP #%01000000
  BEQ PrintTile2c
  CMP #%10000000
  BEQ PrintTile3c
  CMP #%11000000
  BEQ PrintTile4c

PrintTile1c:
  LDA #$02
  STA $2007
  STA $2007
  JMP SecondPairc

PrintTile2c:
  LDA #$4A
  STA $2007
  STA $2007
  JMP SecondPairc

PrintTile3c:
  LDA #$0A
  STA $2007
  STA $2007
  JMP SecondPairc

PrintTile4c:
  LDA #$26
  STA $2007
  STA $2007

SecondPairc:
  LDA background, X
  AND #%00110000
  CMP #%00000000
  BEQ PrintTile1Sc
  CMP #%00010000
  BEQ PrintTile2Sc
  CMP #%00100000
  BEQ PrintTile3Sc
  CMP #%00110000
  BEQ PrintTile4Sc

PrintTile1Sc:
  LDA #$02
  STA $2007
  STA $2007
  JMP ThirdPairc

PrintTile2Sc:
  LDA #$4A
  STA $2007
  STA $2007
  JMP ThirdPairc

PrintTile3Sc:
  LDA #$0A
  STA $2007
  STA $2007
  JMP ThirdPairc

PrintTile4Sc:
  LDA #$26
  STA $2007
  STA $2007

ThirdPairc:
  LDA background, X
  AND #%00001100
  CMP #%00000000
  BEQ PrintTile1Tc
  CMP #%00000100
  BEQ PrintTile2Tc
  CMP #%00001000
  BEQ PrintTile3Tc
  CMP #%00001100
  BEQ PrintTile4Tc

PrintTile1Tc:
  LDA #$02
  STA $2007
  STA $2007
  JMP FourthPairc

PrintTile2Tc:
  LDA #$4A
  STA $2007
  STA $2007
  JMP FourthPairc

PrintTile3Tc:
  LDA #$0A
  STA $2007 
  STA $2007
  JMP FourthPairc

PrintTile4Tc:
  LDA #$26
  STA $2007
  STA $2007

FourthPairc:
  LDA background, X
  AND #%00000011
  CMP #%00000000
  BEQ PrintTile1Fc
  CMP #%00000001
  BEQ PrintTile2Fc
  CMP #%00000010
  BEQ PrintTile3Fc
  CMP #%00000011
  BEQ PrintTile4Fc

PrintTile1Fc:
  LDA #$02
  STA $2007
  STA $2007
  JMP FinishBytec

PrintTile2Fc:
  LDA #$4A
  STA $2007
  STA $2007
  JMP FinishBytec

PrintTile3Fc:
  LDA #$0A
  STA $2007
  STA $2007
  JMP FinishBytec

PrintTile4Fc:
  LDA #$26
  STA $2007
  STA $2007

FinishBytec:

  INX
  CPX #$78
  BEQ NextBackground2
  JMP LoadStage2  ; Branch back if not finished  

NextBackground2:

  LDA background2, Y
  AND #%11000000
  CMP #%00000000
  BEQ PrintTile1d
  CMP #%01000000
  BEQ PrintTile2d
  CMP #%10000000
  BEQ PrintTile3d
  CMP #%11000000
  BEQ PrintTile4d

PrintTile1d:
  LDA #$02
  STA $2407
  STA $2407
  JMP SecondPaird

PrintTile2d:
  LDA #$4A
  STA $2407
  STA $2407
  JMP SecondPaird

PrintTile3d:
  LDA #$0A
  STA $2407
  STA $2407
  JMP SecondPaird

PrintTile4d:
  LDA #$26
  STA $2407
  STA $2407

SecondPaird:
  LDA background2, Y
  AND #%00110000
  CMP #%00000000
  BEQ PrintTile1Sd
  CMP #%00010000
  BEQ PrintTile2Sd
  CMP #%00100000
  BEQ PrintTile3Sd
  CMP #%00110000
  BEQ PrintTile4Sd

PrintTile1Sd:
  LDA #$02
  STA $2407
  STA $2407
  JMP ThirdPaird

PrintTile2Sd:
  LDA #$4A
  STA $2407
  STA $2407
  JMP ThirdPaird

PrintTile3Sd:
  LDA #$0A
  STA $2407
  STA $2407
  JMP ThirdPaird

PrintTile4Sd:
  LDA #$26
  STA $2407
  STA $2407

ThirdPaird:
  LDA background2, Y
  AND #%00001100
  CMP #%00000000
  BEQ PrintTile1Td
  CMP #%00000100
  BEQ PrintTile2Td
  CMP #%00001000
  BEQ PrintTile3Td
  CMP #%00001100
  BEQ PrintTile4Td

PrintTile1Td:
  LDA #$02
  STA $2407
  STA $2407
  JMP FourthPaird

PrintTile2Td:
  LDA #$4A
  STA $2407
  STA $2407
  JMP FourthPaird

PrintTile3Td:
  LDA #$0A
  STA $2407 
  STA $2407
  JMP FourthPaird

PrintTile4Td:
  LDA #$26
  STA $2407
  STA $2407

FourthPaird:
  LDA background2, Y
  AND #%00000011
  CMP #%00000000
  BEQ PrintTile1Fd
  CMP #%00000001
  BEQ PrintTile2Fd
  CMP #%00000010
  BEQ PrintTile3Fd
  CMP #%00000011
  BEQ PrintTile4Fd

PrintTile1Fd:
  LDA #$02
  STA $2407
  STA $2407
  JMP FinishByted

PrintTile2Fd:
  LDA #$4A
  STA $2407
  STA $2407
  JMP FinishByted

PrintTile3Fd:
  LDA #$0A
  STA $2407
  STA $2407
  JMP FinishByted

PrintTile4Fd:
  LDA #$26
  STA $2407
  STA $2407

FinishByted:

  INY
  CPY #$78
  BEQ EndStage2
  JMP NextBackground2

EndStage2:
  ; restore registers and return
PLA
TAY
PLA
TAX
PLA
PLP
RTS
.endproc


background:
  .byte %01010101, %01010101, %01010101, %01010101
  .byte %01010101, %01010101, %01010101, %01010101
  .byte %01000000, %00000000, %00001111, %11111111
  .byte %01000000, %00000000, %00001111, %11111111
  .byte %01001100, %11111100, %11001100, %00001110
  .byte %01001100, %11111100, %11001100, %00001110
  .byte %01001100, %11001100, %11001110, %11001110
  .byte %01001100, %11001100, %11001110, %11001110
  .byte %01111100, %11001110, %11111110, %11111110
  .byte %01111100, %11001110, %11111110, %11111110
  .byte %01110000, %11001010, %10101010, %10101010
  .byte %01110000, %11001010, %10101010, %10101010
  .byte %01110011, %11001111, %11101111, %11111011
  .byte %01110011, %11001111, %11101111, %11111011
  .byte %01111011, %00001100, %11001100, %00111011
  .byte %01111011, %00001100, %11001100, %00111011
  .byte %01111011, %11111100, %11111100, %00110011
  .byte %01111011, %11111100, %11111100, %00110011
  .byte %01101010, %00001100, %00000000, %00110011
  .byte %01101010, %00001100, %00000000, %00110011
  .byte %01001111, %11001100, %00111111, %00110011
  .byte %01001111, %11001100, %00111111, %00110011
  .byte %01001100, %00001100, %00110000, %00110011
  .byte %01001100, %00001100, %00110000, %00110011
  .byte %01111111, %11001111, %11110000, %00000011
  .byte %01111111, %11001111, %11110000, %00000011
  .byte %00000000, %00000000, %00000000, %11111111
  .byte %00000000, %00000000, %00000000, %11111111
  .byte %01010101, %01010101, %01010101, %01010101
  .byte %01010101, %01010101, %01010101, %01010101

background2:
  .byte %01010101, %01010101, %01010101, %01010101
  .byte %01010101, %01010101, %01010101, %01010101
  .byte %11111111, %11111111, %11111111, %11110000
  .byte %11111111, %11111111, %11111111, %11110000
  .byte %00001100, %11111100, %11001100, %00000001
  .byte %00001100, %11111100, %11001100, %00000001
  .byte %00001100, %11001100, %11001110, %11001101
  .byte %00001100, %11001100, %11001110, %11001101
  .byte %00111100, %11001110, %11111110, %11111101
  .byte %00111100, %11001110, %11111110, %11111101
  .byte %00110000, %11001010, %10101010, %10101001
  .byte %00110000, %11001010, %10101010, %10101001
  .byte %00110011, %11001111, %11101111, %11111001
  .byte %00110011, %11001111, %11101111, %11111001
  .byte %00111011, %00000000, %11001100, %00111001
  .byte %00111011, %00000000, %11001100, %00111001
  .byte %00111011, %11111100, %11111100, %00110001
  .byte %00111011, %11111100, %11111100, %00110001
  .byte %00101010, %00001100, %00000000, %00110001
  .byte %00101010, %00001100, %00000000, %00110001
  .byte %00001111, %11001100, %00111111, %00110001
  .byte %00001111, %11001100, %00111111, %00110001
  .byte %00001100, %00000000, %00110000, %00110001
  .byte %00001100, %00000000, %00110000, %00110001
  .byte %00111111, %11001111, %11110000, %00000001
  .byte %00111111, %11001111, %11110000, %00000001
  .byte %00111111, %11001111, %11110000, %00000001
  .byte %00111111, %11001111, %11110000, %00000001
  .byte %01010101, %01010101, %01010101, %01010101
  .byte %01010101, %01010101, %01010101, %01010101

