; -------------------------------------------------------------------
; nes.inc
; -------------------------------------------------------------------


; -------------------------------------------------------------------
; PPU define
PPUCTRL   = $2000
PPUMASK   = $2001
PPUSTATUS = $2002
OAMADDR   = $2003
OAMDATA   = $2003
PPUSCROLL = $2005
PPUADDR   = $2006
PPUDATA   = $2007
OAMDMA    = $4014


; -------------------------------------------------------------------
; APU define
PUL1DUTY  = $4000
PUL1SWEEP = $4001
PUL1TIMER = $4002
PUL1LEN   = $4003
PUL2DUTY  = $4004
PUL2SWEEP = $4005
PUL2TIMER = $4006
PUL2LEN   = $4007
TRILINEAR = $4008
TRITIMER  = $400a
TRILEN    = $400b
NOISEVOL  = $400c
NOISEPRD  = $400e
NOISELEN  = $400f
DMCFREQ   = $4010
DMCCTRL   = $4011
DMCADDR   = $4012
DMCLEN    = $4013
APUSTATUS = $4015
FRAMECTRL = $4017


; -------------------------------------------------------------------
; Input define
JOYPAD1   = $4016
JOYPAD2   = $4017
