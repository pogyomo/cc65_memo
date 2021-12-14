; vim: ft=ca65
; -------------------------------------------------------------------
; handler.s : Call function from table that made by condes
; -------------------------------------------------------------------


; -------------------------------------------------------------------
; Import and export
    .export init_handler, end_handler
    .export irq_handler, nmi_handler
    .export handler


; -------------------------------------------------------------------
; Init handler code
.code
.proc init_handler
    
    ; Get number of function
    ; If there is no function, exit
    ldy #<(__INIT_HANDLER_COUNT__ * 2)
    bne get_address
    rts

    ; Get table address
get_address:
    lda #<(__INIT_HANDLER_TABLE__) ; Get low byte of address
    ldx #>(__INIT_HANDLER_TABLE__) ; Get high byte of address

    ; Call handler
    jmp handler


.endproc


; -------------------------------------------------------------------
; End handler code
.code
.proc end_handler
    
    ; Get number of function
    ; If there is no function, exit
    ldy #<(__END_HANDLER_COUNT__ * 2)
    bne get_address
    rts

    ; Get table address
get_address:
    lda #<(__END_HANDLER_TABLE__) ; Get low byte of address
    ldx #>(__END_HANDLER_TABLE__) ; Get high byte of address

    ; Call handler
    jmp handler


.endproc


; -------------------------------------------------------------------
; Irq handler code
.code
.proc irq_handler
    
    ; Get number of function
    ; If there is no function, exit
    ldy #<(__IRQ_HANDLER_COUNT__ * 2)
    bne get_address
    rts

    ; Get table address
get_address:
    lda #<(__IRQ_HANDLER_TABLE__) ; Get low byte of address
    ldx #>(__IRQ_HANDLER_TABLE__) ; Get high byte of address

    ; Call handler
    jmp handler


.endproc


; -------------------------------------------------------------------
; Nmi handler code
.code
.proc nmi_handler
    
    ; Get number of function
    ; If there is no function, exit
    ldy #<(__NMI_HANDLER_COUNT__ * 2)
    bne get_address
    rts

    ; Get table address
get_address:
    lda #<(__NMI_HANDLER_TABLE__) ; Get low byte of address
    ldx #>(__NMI_HANDLER_TABLE__) ; Get high byte of address

    ; Call handler
    jmp handler


.endproc


; -------------------------------------------------------------------
; Handler code
.data
.proc handler

    ; Write table address
    sta fetch1 + 2 ; Store low byte of address
    stx fetch1 + 3 ; Store high byte of address
    sta fetch2 + 2 ; Store low byte of address
    stx fetch2 + 3 ; Store high byte of address

    ; Get low byte of function address
fetch1:
    dey
    lda $ffff, y
    sta call_function + 2

    ; Get high byte of function address
fetch2:
    dey
    lda $ffff, y
    sta call_function + 1

    ; Store current y register
    sty index + 1

    ; Call function
call_function:
    jsr $ffff

    ; Restore y register and detect end
    ; If it isn't end, go to fetch1 to get function address
index:
    ldy #$ff
    bne fetch1
    rts

.endproc
