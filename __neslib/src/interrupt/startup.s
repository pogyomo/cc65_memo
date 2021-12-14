; vim: ft=ca65
; -------------------------------------------------------------------
; startup.s : Init system
; -------------------------------------------------------------------


; -------------------------------------------------------------------
; Import and export
    .import  _main
    .import  init_hander, end_handler
    .import  copydata

    .export  startup

    .include "nes.inc"


; -------------------------------------------------------------------
; Startup code
.code
.proc startup
    
    ; Init cpu stack pointer and disable irq
start:
    sei
    cld
    ldx #$40
    sta FRAMECTRL
    ldx #$ff
    txs
    inx
    stx PPUCTRL
    stx PPUMASK
    stx DMCFREQ

    ; Wait vbland twice
wait_vblank1:
    bit PPUSTATUS
    bpl wait_vblank1
wait_vblank2:
    bit PPUSTATUS
    bpl wait_vblank2

    ; Copy data to ram
    jsr copydata

    ; Use init_hander
    jsr init_hander

    ; Call main()
    jsr _main

    ; Use end_handler
    ; then, reset the system
    jsr end_handler
    jmp start

.endproc
