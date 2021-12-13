#include "graphics.h"


int main(void) {
    and_ppu_ctrl(0b00000000);
    or_ppu_ctrl(0b10000000);
    while(1);
    return 0;
}
