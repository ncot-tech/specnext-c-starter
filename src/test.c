 /* This is just a test, to give the compiler something to do */
 /* Obviously delete this file! */

#include <arch/zxn.h>
#include <z80.h>
#include <input.h>
#include <stdlib.h>

int main(void)
{
   z80_outp(0x123b,0x03);

   char *addr = 0x00;
   for (int i = 0; i < 16384; i++) {
      *(addr+i) = 0x0E;
   }

   z80_outp(0x123b,0x43);
   addr = 0x00;
   for (int i = 0; i < 16384; i++) {
      *(addr+i) = 0xFF;
   }

   z80_outp(0x123b,0x83);
   addr = 0x00;
   for (int i = 0; i < 16384; i++) {
      *(addr+i) = 0x03;
   }
   // Endless loop
   while(1);

   return 0;
}

  /* C source end */