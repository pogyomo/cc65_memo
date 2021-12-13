#include "graphics.h"
#include "input.h"


int main(void) {
    or_ppu_ctrl(0b10000000);
    while(1);
    return 0;
}
