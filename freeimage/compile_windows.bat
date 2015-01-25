REM TODO: This does not work!
gcc -c cfreeimage.c -I /opt/local/include
dmd -c freeimage.d
dmd -c main.d
dmd -ofmain main.o freeimage.o cfreeimage.o -L-L/opt/local/lib -L-lfreeimage
