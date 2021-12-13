#ifndef __GRAPHICS_H__
#define __GRAPHICS_H__


// --------------------------------------------------------
// Function about ppu
// --------------------------------------------------------

// --------------------------------------------------------
// Summary  : Value && PPUCTRL -> PPUCTRL
// Argument : Value to use caluculate
// Return   : None
// --------------------------------------------------------
void __fastcall__ and_ppu_ctrl(unsigned char value);

// --------------------------------------------------------
// Summary  : Value || PPUCTRL -> PPUCTRL
// Argument : Value to use caluculate
// Return   : None
// --------------------------------------------------------
void __fastcall__ or_ppu_ctrl(unsigned char value);

// --------------------------------------------------------
// Summary  : Value && PPUMASK -> PPUMASK
// Argument : Value to use caluculate
// Return   : None
// --------------------------------------------------------
void __fastcall__ and_ppu_mask(unsigned char value);

// --------------------------------------------------------
// Summary  : Value || PPUMASK -> PPUMASK
// Argument : Value to use caluculate
// Return   : None
// --------------------------------------------------------
void __fastcall__ or_ppu_mask(unsigned char value);


// --------------------------------------------------------
// Function about oam
// --------------------------------------------------------

// --------------------------------------------------------
// Summary  : Set oam address with 1byte value
// Argument : A value of address to set
// Return   : None
// --------------------------------------------------------
void __fastcall__ set_oam_addr(unsigned char addr);

// --------------------------------------------------------
// Summary  : Put a value to oam with selected address
// Argument : A value to put to oam
// Return   : None
// --------------------------------------------------------
void __fastcall__ put_to_oam(unsigned char value);

// --------------------------------------------------------
// Summary  : Get a value from oam with selected address
// Argument : None
// Return   : A value that got from oam
// --------------------------------------------------------
unsigned char __fastcall__ get_from_oam(void);

// --------------------------------------------------------
// Summary  : Copy data to oam using dma
// Argument : A value of high data address
//            Low address is fixed by $00
// Return   : None
// --------------------------------------------------------
void __fastcall__ copy_to_oam(unsigned char addr);


#endif
