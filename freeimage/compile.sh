#!/bin/bash

if [ -f main ]
    then
        rm main
fi

gcc -O3 -c cfreeimage.c
dmd -O -inline -release -c freeimage.d
dmd -O -inline -release -c main.d
dmd -O -inline -release -ofmain main.o freeimage.o cfreeimage.o -L-lfreeimage

rm *.o
