; vim: ft=ca65
; -------------------------------------------------------------------
; init_sys.s
; -------------------------------------------------------------------


; -------------------------------------------------------------------
; Import and export
.constructor init_sys
.import copydata

.include "nes.inc"


; -------------------------------------------------------------------
; Main code
.segment "ONCE"

init_sys:
    
; Disable irq
    sei           ; Ignore irq
    lda #$40
    sta FRAMECTRL ; Disable apu frame irq
    lda #$00
    sta PPUCTRL 
    sta PPUMASK
    sta DMCFREQ

; Wait vblank twice
@wait_vblank1:
    bit PPUSTATUS
    bpl @wait_vblank1
@wait_vblank2:
    bit PPUSTATUS
    bpl @wait_vblank2

; Clear ram except cpu stack ($0100-$01ff)
    lda #$00
    tax
@clear_ram:
    sta $0000, x
    sta $0200, x
    sta $0300, x
    sta $0400, x
    sta $0500, x
    sta $0600, x
    sta $0700, x

; Copy rw data to ram
    jsr copydata

; End of sub
    rts
