; vim: ft=ca65
; ------------------------------------------------------------------------
; Import and export
; ------------------------------------------------------------------------
    .export  _get_joypad1, _get_joypad2

    .include "nes.inc"
    .include "zeropage.inc"




; ------------------------------------------------------------------------
; Variable to use in function
; ------------------------------------------------------------------------
.bss

; Temp of input
joypad_temp: .res $01




; ------------------------------------------------------------------------
; Function about joypad
; ------------------------------------------------------------------------

; ------------------------------------------------------------------------
; unsigned char __fastcall__ get_joypad1(void)
; ------------------------------------------------------------------------
.code
.proc _get_joypad1: near
    
    ; Init I/O port
    ldx #$01
    stx JOYPAD1
    dex
    stx JOYPAD1

    ; Init variable
    stx joypad_temp

    ; Get input
    ldy #$08
@loop:
    lda JOYPAD1
    ror a
    rol joypad_temp
    dey
    bne @loop

    ; Prepare return value
    lda joypad_temp
    ldx #$00

    ; End of process
    rts

.endproc

; ------------------------------------------------------------------------
; unsigned char __fastcall__ get_joypad2(void)
; ------------------------------------------------------------------------
.code
.proc _get_joypad2: near
    
    ; Init I/O port
    ldx #$01
    stx JOYPAD1
    dex
    stx JOYPAD1

    ; Init variable
    stx joypad_temp

    ; Get input
    ldy #$08
@loop:
    lda JOYPAD2
    ror a
    rol joypad_temp
    dey
    bne @loop

    ; Prepare return value
    lda joypad_temp
    ldx #$00

    ; End of process
    rts

.endproc
