; vim: ft=ca65
; -------------------------------------------------------------------
; vectors.s : Define interrupt vecotr
; -------------------------------------------------------------------


; -------------------------------------------------------------------
; Import and export
    .import startup, nmi, irq


; -------------------------------------------------------------------
; Interrupt vecotr code
.segment "VECTORS"
    .word nmi
    .word startup
    .word irq
