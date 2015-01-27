#!/bin/bash
# 
# FreeImage was installed using macports on Mac

if [ -f main ]
    then
        rm main
fi

gcc -O3 -c cfreeimage.c -I /opt/local/include
dmd -O -inline -release -c freeimage.d
dmd -O -inline -release -c main.d
dmd -ofmain main.o freeimage.o cfreeimage.o -L-L/opt/local/lib -L-lfreeimage

rm *.o
