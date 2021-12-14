; vim: ft=ca65
; -------------------------------------------------------------------
; crt0.s
; -------------------------------------------------------------------




; -------------------------------------------------------------------
; Import and export
.export   _init, _exit
.import   _main

.export   __STARTUP__ : absolute = 1
.import   __STACK_START__, __STACK_SIZE__
.import   NES_MAPPER, NES_PRG_BANKS, NES_CHR_BANKS, NES_MIRRORING

.import   copydata
.import   init_handler, end_handler, irq_handler, nmi_handler

.include  "zeropage.inc"
.include  "nes.inc"




; -------------------------------------------------------------------
; Header
.segment "HEADER"
    .byte $4e, $45, $53, $1a
    .byte <NES_PRG_BANKS
    .byte <NES_CHR_BANKS
    .byte <NES_MIRRORING | (<NES_MAPPER<<4)
    .byte <NES_MAPPER & $f0
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

; Init cc65 argument stack pointer
    lda #<(__STACK_START__ + __STACK_SIZE__)
    sta sp + 0
    lda #>(__STACK_START__ + __STACK_SIZE__)
    sta sp + 1

; Wait vblank twice
@wait_vblank1:
    bit PPUSTATUS
    bpl @wait_vblank1
@wait_vblank2:
    bit PPUSTATUS
    bpl @wait_vblank2

; Copy data from rom to ram
; Before use initlib or donelib, this should be called
; because condes will be placed in data segment (see condes.s)
    jsr copydata 

; Use init_handler
    jsr init_handler

; Call main()
    jsr _main

_exit:

; Exit from main and use init_handler, then restart
    jsr end_handler
    jmp _init  




; -------------------------------------------------------------------
; NMI code
_nmi:
    
; Escape a, x, y register
    pha
    tya
    pha
    txa
    pha

; Use nmi_handler
    jsr nmi_handler

; Restore a, x, y register
    pla
    tax
    pla
    tay
    pla

; End of nmi
    rti




; -------------------------------------------------------------------
; IRQ code
_irq:
    
; Escape a, x, y register
    pha
    tya
    pha
    txa
    pha

; Use irq_handler
    jsr irq_handler

; Restore a, x, y register
    pla
    tax
    pla
    tay
    pla

; End of irq
    rti




; -------------------------------------------------------------------
; Interruption vector
.segment "VECTORS"
    .word _nmi
    .word _init
    .word _irq
