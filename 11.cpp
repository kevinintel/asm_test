#include <vector>
#include <iostream>
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <cmath>
#include <time.h>
#include <cstdint>
#include <cstring>
#include <dlfcn.h>
#include <x86intrin.h>


int main(){
	char *error_str;
	void *handle;
	handle = dlopen ("./11.so", RTLD_LAZY);
    if (!handle) {
        fputs (dlerror(), stderr);
        exit(1);
    }

    void (*mm)(long,long,long*);
    mm =(void (*)(long,long,long*)) dlsym(handle, "_Z8sumstorellPl");
    if ((error_str = dlerror()) != NULL)  {
        fputs(error_str, stderr);
        exit(1);
    }

    long*a;
    a=(long *)malloc(1*sizeof(long));
    printf("===========asm==========\n");
    mm(3,5,a);
    printf("===========result %ld==========\n",*a);

    return 0;
}

/*
void sumstore(long x, long y,
long *dest) {
long t = x + y;
*dest = t;
}
*/
