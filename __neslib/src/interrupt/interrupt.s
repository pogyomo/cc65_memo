; vim: ft=ca65
; -------------------------------------------------------------------
; interrupt.s : Control nmi/irq
; -------------------------------------------------------------------


; -------------------------------------------------------------------
; Import and export
    .import nmi_handler, irq_handler

    .export nmi, irq


; -------------------------------------------------------------------
; Nmi code
.code
.proc nmi
    
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

.endproc


; -------------------------------------------------------------------
; Irq code
.code
.proc irq
    
    ; Escape a, x, y register
    pha
    tya
    pha
    txa
    pha

    ; Use nmi_handler
    jsr irq_handler

    ; Restore a, x, y register
    pla
    tax
    pla
    tay
    pla

    ; End of irq
    rti

.endproc
