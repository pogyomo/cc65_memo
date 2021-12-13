; vim: ft=ca65
; ------------------------------------------------------------------------
; Import and export
; ------------------------------------------------------------------------
    .export  _and_ppu_ctrl, _or_ppu_ctrl, _and_ppu_mask, _or_ppu_mask
    .export  _set_vram_addr, _put_to_vram, _get_from_vram
    .export  _copy_to_vram, _copy_from_vram
    .export  _set_oam_addr, _put_to_oam, _copy_to_oam

    .import  popa

    .include "nes.inc"
    .include "zeropage.inc"




; ------------------------------------------------------------------------
; Varilable to use in function
; ------------------------------------------------------------------------
.bss

; Use in and(or)_ppu_ctrl(mask)
ppu_ctrl: .res $01
ppu_mask: .res $01

; Use in function about vram
is_read:  .res $01




; ------------------------------------------------------------------------
; Function about ppu
; ------------------------------------------------------------------------

; ------------------------------------------------------------------------
; void __fastcall__ and_ppu_ctrl(unsigned char value)
; ------------------------------------------------------------------------
.code
.proc _and_ppu_ctrl: near
    
    ; A && PPUCTRL -> PPUCTRL
    and ppu_ctrl
    sta PPUCTRL
    sta ppu_ctrl

    ; End of process
    rts

.endproc

; ------------------------------------------------------------------------
; void __fastcall__ or_ppu_ctrl(unsigned char value)
; ------------------------------------------------------------------------
.code
.proc _or_ppu_ctrl: near
    
    ; A || PPUCTRL -> PPUCTRL
    ora ppu_ctrl
    sta PPUCTRL
    sta ppu_ctrl

    ; End of process
    rts

.endproc

; ------------------------------------------------------------------------
; void __fastcall__ and_ppu_mask(unsigned char value)
; ------------------------------------------------------------------------
.code
.proc _and_ppu_mask: near
    
    ; A && PPUMASK -> PPUMASK
    and ppu_mask
    sta PPUMASK
    sta ppu_mask

    ; End of process
    rts

.endproc

; ------------------------------------------------------------------------
; void __fastcall__ or_ppu_mask(unsigned char value)
; ------------------------------------------------------------------------
.code
.proc _or_ppu_mask: near
    
    ; A && PPUMASK -> PPUMASK
    ora ppu_mask
    sta PPUMASK
    sta ppu_mask

    ; End of process
    rts

.endproc




; ------------------------------------------------------------------------
; Function about vram
; ------------------------------------------------------------------------

; ------------------------------------------------------------------------
; void __fastcall__ set_vram_addr(unsigned int addr)
; ------------------------------------------------------------------------
.code
.proc _set_vram_addr: near
    
    ; Set address
    stx PPUADDR
    sta PPUADDR

    ; Set flag
    lda #$01
    sta is_read

    ; End of process
    rts

.endproc

; ------------------------------------------------------------------------
; void __fastcall__ put_to_vram(unsigned char value)
; ------------------------------------------------------------------------
.code
.proc _put_to_vram: near
    
    ; Put a value
    sta PPUDATA

    ; End of process
    rts

.endproc

; ------------------------------------------------------------------------
; unsigned char __fastcall__ get_from_vram(void)
; ------------------------------------------------------------------------
.code
.proc _get_from_vram: near
    
    ; Check it is first to read vram
    ; If it is first read, read vram once before get value
    lda is_read
    beq @read
    lda PPUDATA
    lda #$00
    sta is_read

    ; Get a value
@read:
    lda PPUDATA

    ; Set x as 0 for return value
    ldx #$00

    ; End of process
    rts

.endproc

; ------------------------------------------------------------------------
; void __fastcall__ copy_to_vram(unsigned char num, unsigned int addr)
; ------------------------------------------------------------------------
.code
.proc _copy_to_vram: near
    
    ; Set pointer
    sta ptr1 + 0
    stx ptr1 + 1

    ; Set loop counter
    jsr popa ; a <- num
    tax
    inx

    ; Copy data to vram
    ldy #$00
@loop:
    lda (ptr1), y
    sta PPUDATA
    iny
    dex
    bne @loop

    ; End of process
    rts

.endproc

; ------------------------------------------------------------------------
; void __fastcall__ copy_from_vram(unsigned char num, unsigned int addr)
; ------------------------------------------------------------------------
.code
.proc _copy_from_vram: near
    
    ; Set pointer
    sta ptr1 + 0
    stx ptr1 + 1

    ; Check it is first to read vram
    ; If it is first read, read vram once before get value
    lda is_read
    beq @copy
    lda PPUDATA
    lda #$00
    sta is_read

    ; Set loop counter
@copy:
    jsr popa ; a <- num
    tax
    inx

    ; Copy data from vram
    ldy #$00
@loop:
    lda PPUDATA
    sta (ptr1), y
    iny
    dex
    bne @loop

    ; End of process
    rts

.endproc




; ------------------------------------------------------------------------
; Function about oam
; ------------------------------------------------------------------------

; ------------------------------------------------------------------------
; void __fastcall__ set_oam_addr(unsigned char addr)
; ------------------------------------------------------------------------
.code
.proc _set_oam_addr: near
    
    ; Set address
    sta OAMADDR

    ; End of process
    rts

.endproc

; ------------------------------------------------------------------------
; void __fastcall__ put_to_oam(unsigned char addr)
; ------------------------------------------------------------------------
.code
.proc _put_to_oam: near
    
    ; Put a value to oam
    sta OAMDATA

    ; End of process
    rts

.endproc

; ------------------------------------------------------------------------
; unsigned char __fastcall__ get_from_oam(void)
; ------------------------------------------------------------------------
.code
.proc _get_from_oam: near
    
    ; Put a value to oam
    lda OAMDATA

    ; Set x as 0 for return value
    ldx #$00

    ; End of process
    rts

.endproc

; ------------------------------------------------------------------------
; void __fastcall__ copy_to_oam(unsigned char addr)
; ------------------------------------------------------------------------
.code
.proc _copy_to_oam: near
    
    ; Copy data from memory to oam
    sta OAMDMA

    ; End of process
    rts

.endproc
