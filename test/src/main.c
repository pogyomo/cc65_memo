#include "graphics.h"
#include "input.h"


unsigned char pal[] = {
    0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
    0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
    0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
    0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
};


void set_palette(unsigned char *);


int main(void) {

    set_palette(pal);

    // Loop
    while(1);
    return 0;
}


void set_palette(unsigned char *ptr) {
    set_vram_addr(0x3f00);
    copy_to_vram(ptr, 0x10);
}
