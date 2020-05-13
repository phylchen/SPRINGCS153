#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]) {

        set_prior(5);

        int i, k;
        for(i = 0; i < 1000; i++) {
                asm("nop");
                for (k = 0; k < 1000; k++) {
                        asm("nop");
                }
	printf(1, "Program 2 finished loop %d\n",i);
        }
	printf(1, "Program 2 finished\n");
        exit(0);
};
