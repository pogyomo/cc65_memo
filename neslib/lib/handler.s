; -------------------------------------------------------------------
; handler.s
;   This code come from cc65/libsrc/condes.s
; -------------------------------------------------------------------




; -------------------------------------------------------------------
; Import and export
    .export init_handler, end_handler
    .export irq_handler, nmi_handler

    .import __INIT_HANDLER_TABLE__, __INIT_HANDLER_COUNT__
    .import __END_HANDLER_TABLE__, __END_HANDLER_COUNT__
    .import __IRQ_HANDLER_TABLE__, __IRQ_HANDLER_COUNT__
    .import __NMI_HANDLER_TABLE__, __NMI_HANDLER_COUNT__




; -------------------------------------------------------------------
; Init handler
.segment "ONCE"
.proc init_handler
    
    ldy #<(__INIT_HANDLER_COUNT__ * 2)
    beq exit
    lda #<__INIT_HANDLER_TABLE__
    ldx #>__INIT_HANDLER_TABLE__
    jmp call_func
exit:
    rts

.endproc




; -------------------------------------------------------------------
; End handler
.segment "ONCE"
.proc end_handler
    
    ldy #<(__END_HANDLER_COUNT__ * 2)
    beq exit
    lda #<__END_HANDLER_TABLE__
    ldx #>__END_HANDLER_TABLE__
    jmp call_func
exit:
    rts

.endproc




; -------------------------------------------------------------------
; IRQ handler
.segment "ONCE"
.proc irq_handler
    
    ldy #<(__IRQ_HANDLER_COUNT__ * 2)
    beq exit
    lda #<__IRQ_HANDLER_TABLE__
    ldx #>__IRQ_HANDLER_TABLE__
    jmp call_func
exit:
    rts

.endproc




; -------------------------------------------------------------------
; NMI handler
.segment "ONCE"
.proc nmi_handler
    
    ldy #<(__NMI_HANDLER_COUNT__ * 2)
    beq exit
    lda #<__NMI_HANDLER_TABLE__
    ldx #>__NMI_HANDLER_TABLE__
    jmp call_func
exit:
    rts

.endproc




; -------------------------------------------------------------------
; Call func
.segment "DATA"
.proc call_func
    
    sta fetch1 + 1
    stx fetch1 + 2
    sta fetch2 + 1
    stx fetch2 + 2
loop:
    dey
fetch1:
    lda $ffff, y
    sta jmpvec + 2
    dey
fetch2:
    lda $ffff, y
    sta jmpvec + 1
    sty index + 1
jmpvec:
    jsr $ffff
index:
    ldy #$ff
    bne loop
    rts

.endproc
