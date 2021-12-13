#include "graphics.h"


int main(void) {
    int a, b;
    set_vram_addr(0x2000);
    copy_from_vram(0xff, 0x0200);
    copy_from_vram(0xff, 0x0300);
    while(1);
    return 0;
}
