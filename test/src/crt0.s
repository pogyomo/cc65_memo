; -------------------------------------------------------------------
; crt0.s
; -------------------------------------------------------------------


; -------------------------------------------------------------------
; Import and export
.export   _init, _exit
.import   _main

.export   __STARTUP__ : absolute = 1
.import   __STACK_START__, __STACK_SIZE__

.import   initlib, donelib

.include  "zeropage.inc"


; -------------------------------------------------------------------
; Startup code
.segment  "STARTUP"

_init:

; Init cpu stack pointer and disenable decimal mode
    ldx #$ff
    txs
    cld

; Init cc65 argument stack pointer
    lda #<(__STACK_START__ + __STACK_SIZE__)
    sta sp + 0
    lda #>(__STACK_START__ + __STACK_SIZE__)
    sta sp + 1

; Init system
    jsr initlib

; Call main()
    jsr _main

_exit:

; Exit from main and goto _init
    jsr donelib
    jmp _init
