; vim: ft=ca65
; -------------------------------------------------------------------
; graphics.s
; -------------------------------------------------------------------


; -------------------------------------------------------------------
; Import and export
    .export  _set_oam_addr, _put_to_oam, _copy_to_oam
    .export  _and_ppu_ctrl, _or_ppu_ctrl, _and_ppu_mask, _or_ppu_mask

    .include "nes.inc"


; -------------------------------------------------------------------
; Varilable to use in function
.bss

; Use in and(or)_ppu_ctrl(mask)
ppu_ctrl: .res $01
ppu_mask: .res $01


; -------------------------------------------------------------------
; void __fastcall__ and_ppu_ctrl(unsigned char value)
.code
.proc _and_ppu_ctrl: near
    
    ; A && PPUCTRL -> PPUCTRL
    and ppu_ctrl
    sta PPUCTRL
    sta ppu_ctrl

    ; End of process
    rts

.endproc


; -------------------------------------------------------------------
; void __fastcall__ or_ppu_ctrl(unsigned char value)
.code
.proc _or_ppu_ctrl: near
    
    ; A || PPUCTRL -> PPUCTRL
    ora ppu_ctrl
    sta PPUCTRL
    sta ppu_ctrl

    ; End of process
    rts

.endproc


; -------------------------------------------------------------------
; void __fastcall__ and_ppu_mask(unsigned char value)
.code
.proc _and_ppu_mask: near
    
    ; A && PPUMASK -> PPUMASK
    and ppu_mask
    sta PPUMASK
    sta ppu_mask

    ; End of process
    rts

.endproc


; -------------------------------------------------------------------
; void __fastcall__ or_ppu_mask(unsigned char value)
.code
.proc _or_ppu_mask: near
    
    ; A && PPUMASK -> PPUMASK
    ora ppu_mask
    sta PPUMASK
    sta ppu_mask

    ; End of process
    rts

.endproc


; -------------------------------------------------------------------
; void __fastcall__ set_oam_addr(unsigned char addr)
.code
.proc _set_oam_addr: near
    
    ; Set address
    sta OAMADDR

    ; End of process
    rts

.endproc


; -------------------------------------------------------------------
; void __fastcall__ put_to_oam(unsigned char addr)
.code
.proc _put_to_oam: near
    
    ; Put a value to oam
    sta OAMDATA

    ; End of process
    rts

.endproc


; -------------------------------------------------------------------
; unsigned char __fastcall__ get_from_oam(void)
.code
.proc _get_from_oam: near
    
    ; Put a value to oam
    lda OAMDATA

    ; End of process
    rts

.endproc


; -------------------------------------------------------------------
; void __fastcall__ copy_to_oam(unsigned char addr)
.code
.proc _copy_to_oam: near
    
    ; Copy data from memory to oam
    sta OAMDMA

    ; End of process
    rts

.endproc
