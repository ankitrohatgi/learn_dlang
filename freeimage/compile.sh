#!/bin/bash

if [ -f main ]
    then
        rm main
fi

gcc -c cfreeimage.c
dmd -c freeimage.d
dmd -c main.d
dmd -ofmain main.o freeimage.o cfreeimage.o -L-lfreeimage

rm *.o
