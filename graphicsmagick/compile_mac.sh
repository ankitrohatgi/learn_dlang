#!/bin/bash
# 
if [ -f main ]
    then
        rm main
fi

gcc -O3 -c graphicsmagick_c.c -I /opt/local/include/GraphicsMagick -pipe -Os -Wall -D_THREAD_SAFE
dmd -O -inline -release -c graphicsmagick.d
dmd -O -inline -release -c main.d
dmd -O -inline -release -ofmain main.o graphicsmagick.o graphicsmagick_c.o -L-L/opt/local/lib -L-lGraphicsMagick -L-llcms2 -L-ltiff -L-lfreetype -L-ljasper -L-ljpeg -L-lpng16 -L-llzma -L-lbz2 -L-lxml2 -L-lz -L-lm -L-lpthread -L-lpng

rm *.o
