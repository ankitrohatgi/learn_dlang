#!/bin/bash
# 
if [ -f main ]
    then
        rm main
fi

gcc -O3 -c graphicsmagick_c.c -I /usr/include/GraphicsMagick
dmd -O -inline -release -c graphicsmagick.d
dmd -O -inline -release -c main.d
dmd -O -inline -release -c perf.d
dmd -O -inline -release -ofmain main.o graphicsmagick.o graphicsmagick_c.o -L-L/opt/local/lib -L-lGraphicsMagick
dmd -O -inline -release -ofperf perf.o graphicsmagick.o graphicsmagick_c.o -L-L/opt/local/lib -L-lGraphicsMagick
rm *.o
