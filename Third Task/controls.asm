.include "constants.inc"
.include "header.inc"

.segment "ZEROPAGE"
player_x: .res 1
player_y: .res 1
player_dir: .res 1
ppuctrl_settings: .res 1
pad1: .res 1
player_left_frame_counter: .res 1
player_right_frame_counter: .res 1
player_down_frame_counter: .res 1
player_up_frame_counter: .res 1
.exportzp player_x, player_y, pad1

.segment "CODE"
.proc irq_handler
  RTI
.endproc

.import read_controller1

.proc nmi_handler
  LDA #$00
  STA OAMADDR
  LDA #$02
  STA OAMDMA
	LDA #$00

	; read controller
	JSR read_controller1

  ; update tiles after DMA transfer
	; and after reading controller state
  JSR draw_player
  RTI
.endproc

.import reset_handler

.export main
.proc main

LDA #$00
STA player_left_frame_counter
LDA #$00
STA player_right_frame_counter
LDA #$00
STA player_down_frame_counter
LDA #$00
STA player_up_frame_counter

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


vblankwait:       ; wait for another vblank before continuing
  BIT PPUSTATUS
  BPL vblankwait

  LDA #%10010000  ; turn on NMIs, sprites use first pattern table
	STA ppuctrl_settings
  STA PPUCTRL
  LDA #%00011110  ; turn on screen
  STA PPUMASK

forever:
  JMP forever
  
.endproc

.proc draw_player
  ; save registers
  PHP
  PHA
  TXA
  PHA
  TYA
  PHA

  LDA pad1        ; Load button presses
  AND #BTN_LEFT   ; Filter out all but Left
  BEQ check_right ; If result is zero, left not pressed
  DEC player_x  ; If the branch is not taken, move player left
  JMP draw_left

check_right:
  LDA pad1
  AND #BTN_RIGHT
  BEQ check_up
  INC player_x
  JMP draw_right

check_up:
  LDA pad1
  AND #BTN_UP
  BEQ check_down
  DEC player_y
  JMP draw_up

check_down:
  LDA pad1
  AND #BTN_DOWN
  BEQ done_checking
  INC player_y
  JMP draw_down

 done_checking:
    LDA #$24
    STA $0201
    LDA #$25
    STA $0205
    LDA #$34
    STA $0209
    LDA #$35
    STA $020d
    JMP done_draw

 draw_left:
    LDA player_left_frame_counter
    CMP #$00
    BEQ set_left_frame_1
    CMP #$01
    BEQ set_left_frame_2
    CMP #$02
    BEQ set_left_frame_3

    ; If counter is not 0, 1, or 2, reset to 0
    LDA #$00
    STA player_left_frame_counter
    JMP done_draw

    set_left_frame_1:
      LDA #$0C
      STA $0201
      LDA #$0D
      STA $0205
      LDA #$1C
      STA $0209
      LDA #$1D
      STA $020D
      JMP done_draw

    set_left_frame_2:
      LDA #$08
      STA $0201
      LDA #$09
      STA $0205
      LDA #$18
      STA $0209
      LDA #$19
      STA $020D
      JMP done_draw

    set_left_frame_3:
      LDA #$0A
      STA $0201
      LDA #$0B
      STA $0205
      LDA #$1A
      STA $0209
      LDA #$1B
      STA $020D
      JMP done_draw

  draw_right:
    LDA player_right_frame_counter
    CMP #$00
    BEQ set_right_frame_1
    CMP #$01
    BEQ set_right_frame_2
    CMP #$02
    BEQ set_right_frame_3

    ; If counter is not 0, 1, or 2, reset to 0
    LDA #$00
    STA player_right_frame_counter
    JMP done_draw

    set_right_frame_1:
      LDA #$22
      STA $0201
      LDA #$23
      STA $0205
      LDA #$32
      STA $0209
      LDA #$33
      STA $020D
      JMP done_draw

    set_right_frame_2:
      LDA #$0E
      STA $0201
      LDA #$0F
      STA $0205
      LDA #$1E
      STA $0209
      LDA #$1F
      STA $020D
      JMP done_draw

    set_right_frame_3:
      LDA #$20
      STA $0201
      LDA #$21
      STA $0205
      LDA #$30
      STA $0209
      LDA #$31
      STA $020D
      JMP done_draw

  draw_down:
    LDA player_down_frame_counter
    CMP #$00
    BEQ set_down_frame_1
    CMP #$01
    BEQ set_down_frame_2
    CMP #$02
    BEQ set_down_frame_3

    ; If counter is not 0, 1, or 2, reset to 0
    LDA #$00
    STA player_down_frame_counter
    JMP done_draw

    set_down_frame_1:
      LDA #$24
      STA $0201
      LDA #$25
      STA $0205
      LDA #$34
      STA $0209
      LDA #$35
      STA $020D
      JMP done_draw

    set_down_frame_2:
      LDA #$26
      STA $0201
      LDA #$27
      STA $0205
      LDA #$36
      STA $0209
      LDA #$37
      STA $020D
      JMP done_draw

    set_down_frame_3:
      LDA #$28
      STA $0201
      LDA #$29
      STA $0205
      LDA #$38
      STA $0209
      LDA #$39
      STA $020D
      JMP done_draw

  draw_up:
  LDA player_up_frame_counter
    CMP #$00
    BEQ set_up_frame_1
    CMP #$01
    BEQ set_up_frame_2
    CMP #$02
    BEQ set_up_frame_3

    ; If counter is not 0, 1, or 2, reset to 0
    LDA #$00
    STA player_up_frame_counter
    JMP done_draw

    set_up_frame_1:
      LDA #$2A
      STA $0201
      LDA #$2B
      STA $0205
      LDA #$3A
      STA $0209
      LDA #$3B
      STA $020D
      JMP done_draw

    set_up_frame_2:
      LDA #$2E
      STA $0201
      LDA #$2F
      STA $0205
      LDA #$3E
      STA $0209
      LDA #$3F
      STA $020D
      JMP done_draw

    set_up_frame_3:
      LDA #$2C
      STA $0201
      LDA #$2D
      STA $0205
      LDA #$3C
      STA $0209
      LDA #$3D
      STA $020D
      JMP done_draw


  done_draw:

  ; store tile locations
  ; top left tile:
  LDA player_y
  STA $0200
  LDA player_x
  STA $0203

  ; top right tile (x + 8):
  LDA player_y
  STA $0204
  LDA player_x
  CLC
  ADC #$08
  STA $0207

  ; bottom left tile (y + 8):
  LDA player_y
  CLC
  ADC #$08
  STA $0208
  LDA player_x
  STA $020b

  ; bottom right tile (x + 8, y + 8)
  LDA player_y
  CLC
  ADC #$08
  STA $020c
  LDA player_x
  CLC
  ADC #$08
  STA $020f


  INC player_left_frame_counter
  INC player_right_frame_counter
  INC player_down_frame_counter
  INC player_up_frame_counter

  LDA #$00
  STA $0202
  STA $0206
  STA $020a
  STA $020e
  ; restore registers and return
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
