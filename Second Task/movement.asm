.include "constants.inc"
.include "header.inc"

.segment "ZEROPAGE"
player_x: .res 1
player_y: .res 1
player_dir: .res 1
player_frame: .res 1  

player_x2: .res 1
player_y2: .res 1
player_dir2: .res 1
player_frame2: .res 1 

player_x3: .res 1
player_y3: .res 1
player_dir3: .res 1
player_frame3: .res 1 

player_x4: .res 1
player_y4: .res 1
player_dir4: .res 1
player_frame4: .res 1 

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

  ; update tiles *after* DMA transfer
  JSR draw_player


  STA $2005
  STA $2005
  RTI
.endproc

.import reset_handler

.export main
.proc main

    ;left
    LDA #$68
    STA player_x
    LDA #$70
    STA player_y
    ;right
    LDA #$88
    STA player_x2
    LDA #$70
    STA player_y2
    ;up
    LDA #$78
    STA player_x3
    LDA #$60
    STA player_y3
    ;down
    LDA #$78
    STA player_x4
    LDA #$80
    STA player_y4

  LDA #$00
  STA player_frame

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

vblankwait:       ; wait for another vblank before continuing
  BIT PPUSTATUS
  BPL vblankwait

  LDA #%10010000  ; turn on NMIs, sprites use first pattern table
  STA PPUCTRL
  LDA #%00011110  ; turn on screen
  STA PPUMASK

forever:
  JSR draw_player

  LDX #$FF
delay_loop:
  DEX
  BNE delay_loop
  
  JMP forever
.endproc


.proc draw_player
  PHP
  PHA
  TXA
  PHA
  TYA
  PHA

sprite_one:
  ;walking left
  LDA #$0C
  STA $0201
  LDA #$0D
  STA $0205
  LDA #$1C
  STA $0209
  LDA #$1D
  STA $020D

  LDA #%00000000
  STA $0202
  STA $0206
  STA $020A
  STA $020E

  ;walking right
  LDA #$22
  STA $0211
  LDA #$23
  STA $0215
  LDA #$32
  STA $0219
  LDA #$33
  STA $021D

  LDA #%00000000
  STA $0212
  STA $0216
  STA $021A
  STA $021E

; walking up
  LDA #$2A
  STA $0221
  LDA #$2B
  STA $0225
  LDA #$3A
  STA $0229
  LDA #$3B
  STA $022D

  LDA #%00000000
  STA $0222
  STA $0226
  STA $022A
  STA $022E

  ; walking down
  LDA #$24
  STA $0231
  LDA #$25
  STA $0235
  LDA #$34
  STA $0239
  LDA #$35
  STA $023D

  LDA #%00000000
  STA $0232
  STA $0236
  STA $023A
  STA $023E

  LDX #$FF  ; Initialize X with a higher value for a slower animation
delay_loop:
  DEX
  BNE delay_loop

sprite_two: 
  ; walking left
  LDA #$08
  STA $0201
  LDA #$09
  STA $0205
  LDA #$18
  STA $0209
  LDA #$19
  STA $020D

  LDA #%00000000
  STA $0202
  STA $0206
  STA $020A
  STA $020E

  ; walking right
  LDA #$0E
  STA $0211
  LDA #$0F
  STA $0215
  LDA #$1E
  STA $0219
  LDA #$1F
  STA $021D

  LDA #%00000000
  STA $0212
  STA $0216
  STA $021A
  STA $021E

  ; walking up
  LDA #$2E
  STA $0221
  LDA #$2F
  STA $0225
  LDA #$3E
  STA $0229
  LDA #$3F
  STA $022D

  LDA #%00000000
  STA $0222
  STA $0226
  STA $022A
  STA $022E

  ; walking down
  LDA #$26
  STA $0231
  LDA #$27
  STA $0235
  LDA #$36
  STA $0239
  LDA #$37
  STA $023D

  LDA #%00000000
  STA $0232
  STA $0236
  STA $023A
  STA $023E
LDX #$FF  ; Initialize X with a higher value for a slower animation
delay_loop2:
  DEX
  BNE delay_loop2

sprite_three:
  ; walking left
  LDA #$0A
  STA $0201
  LDA #$0B
  STA $0205
  LDA #$1A
  STA $0209
  LDA #$1B
  STA $020D

  LDA #%00000000
  STA $0202
  STA $0206
  STA $020A
  STA $020E

  ; walking right
  LDA #$20
  STA $0211
  LDA #$21
  STA $0215
  LDA #$30
  STA $0219
  LDA #$31
  STA $021d

  LDA #%00000000
  STA $0212
  STA $0216
  STA $021A
  STA $021E

  ; walking up
  LDA #$2C
  STA $0221
  LDA #$2D
  STA $0225
  LDA #$3C
  STA $0229
  LDA #$3D
  STA $022d

  LDA #%00000000
  STA $0222
  STA $0226
  STA $022A
  STA $022E

  ; walking down
  LDA #$28
  STA $0231
  LDA #$29
  STA $0235
  LDA #$38
  STA $0239
  LDA #$39
  STA $023D

  LDA #%00000000
  STA $0232
  STA $0236
  STA $023A
  STA $023E

  LDX #$FF  ; Initialize X with a higher value for a slower animation
delay_loop3:
  DEX
  BNE delay_loop3

end_update_player:
  ; store tile locations
  ; top left tile:
  LDA player_y
  STA $0200
  LDA player_x
  STA $0203

  LDA player_y2
  STA $0210
  LDA player_x2
  STA $0213

  LDA player_y3
  STA $0220
  LDA player_x3
  STA $0223

  LDA player_y4
  STA $0230
  LDA player_x4
  STA $0233

  ; top right tile (x + 8):
  LDA player_y
  STA $0204
  LDA player_x
  CLC
  ADC #$08
  STA $0207

  LDA player_y2
  STA $0214
  LDA player_x2
  CLC
  ADC #$08
  STA $0217

  LDA player_y3
  STA $0224
  LDA player_x3
  CLC
  ADC #$08
  STA $0227

  LDA player_y4
  STA $0234
  LDA player_x4
  CLC
  ADC #$08
  STA $0237

  ; bottom left tile (y + 8):
  LDA player_y
  CLC
  ADC #$08
  STA $0208
  LDA player_x
  STA $020b

  LDA player_y2
  CLC
  ADC #$08
  STA $0218
  LDA player_x2
  STA $021b

  LDA player_y3
  CLC
  ADC #$08
  STA $0228
  LDA player_x3
  STA $022b

  LDA player_y4
  CLC
  ADC #$08
  STA $0238
  LDA player_x4
  STA $023b

  ; bottom right tile (x + 8, y + 8)
  LDA player_y
  CLC
  ADC #$08
  STA $020c
  LDA player_x
  CLC
  ADC #$08
  STA $020f

  LDA player_y2
  CLC
  ADC #$08
  STA $021c
  LDA player_x2
  CLC
  ADC #$08
  STA $021f

  LDA player_y3
  CLC
  ADC #$08
  STA $022c
  LDA player_x3
  CLC
  ADC #$08
  STA $022f

  LDA player_y4
  CLC
  ADC #$08
  STA $023c
  LDA player_x4
  CLC
  ADC #$08
  STA $023f

  update_frame:
  INC player_frame
  CPX #$03
  BNE end_update_frame
  LDA #$01
  STA player_frame

end_update_frame:

  PLA
  TAY
  PLA
  TAX
  PLA
  PLP
  RTS
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

.segment "CHR"
.incbin "Tileset.chr"
