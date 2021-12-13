; -------------------------------------------------------------------
; crt0.s
; -------------------------------------------------------------------


; -------------------------------------------------------------------
; Import and export
.export   _init, _exit
.import   _main

.export   __STARTUP__ : absolute = 1
.import   __STACK_START__, __STACK_SIZE__

.import   initlib, donelib, copydata

.include  "zeropage.inc"
.include  "nes.inc"


; -------------------------------------------------------------------
; Header
.segment "HEADER"
    .byte $4e, $45, $53, $1a
    .byte 2
    .byte 0
    .byte 0
    .byte 0
    .byte $00, $00, $00, $00
    .byte $00, $00, $00, $00


; -------------------------------------------------------------------
; Startup code
.segment  "STARTUP"

_init:

; Init cpu stack pointer and disable irq
    sei           ; Ignore irq
    cld           ; Disable decimal mode
    ldx #$40
    sta FRAMECTRL ; Disable apu frame irq
    ldx #$ff
    txs
    inx           ; x = 0
    sta PPUCTRL   ; Disenable nmi
    sta PPUMASK   ; Disenable rendering
    sta DMCFREQ   ; Disenable dmc irq

; Clear ram
    txa           ; a = x = 0
@clear_ram:
    sta $0000, x
    sta $0100, x
    sta $0200, x
    sta $0300, x
    sta $0400, x
    sta $0500, x
    sta $0600, x
    sta $0700, x
    inx
    bne @clear_ram

; Wait vblank twice
@wait_vblank1:
    bit PPUSTATUS
    bpl @wait_vblank1
@wait_vblank2:
    bit PPUSTATUS
    bpl @wait_vblank2

; Init cc65 argument stack pointer
    lda #<(__STACK_START__ + __STACK_SIZE__)
    sta sp + 0
    lda #>(__STACK_START__ + __STACK_SIZE__)
    sta sp + 1

; Init read/write data and use constructor
; It may init mapper, driver or etc
    jsr copydata ; Before use initlib or donelib, this should be called
                 ; because condes will be placed in data segment (see condes.s)
    jsr initlib

; Call main()
    jsr _main

_exit:

; Exit from main and use destructor, then restart
    jsr donelib ; Use destructor
    jmp _init   ; Restart

_nmi:
_irq:
    rti


; -------------------------------------------------------------------
; Interruption vector
.segment "VECTORS"
    .word _nmi
    .word _init
    .word _irq
