#!/bin/bash
# 

# Edit this to point to the correct folder in ./src/
PROG_DIR='tests'
PROG_NAME='tests'

# Change this as needed:
export PKG_CONFIG_PATH='/usr/local/share/pkgconfig' 
SRC_PATH='src'
CC='gcc'
CFLAGS="-O3 -I /opt/local/include"
DC='dmd'
DCFLAGS="-O -inline -release `pkg-config --cflags gtkd-2`"
LIB_PATH='-L-L/opt/local/lib -L-L/usr/local/lib'

if [ -f ${PROG_NAME} ]
    then
        rm ${PROG_NAME}
fi

cd ${SRC_PATH}

if [ "$1" == "--clean" ]; then
    rm *.o
    exit;
fi

if [ "$1" == "--rebuild" ]; then
    rm *.o
fi

if [ "$1" == "--help" ]; then
    echo "Simple script to build code in D language that also depends on some C code."
    exit;
fi

# Object Files
objectFiles=()

# C files
echo ""
echo "Compiling C files:"
for file in $(find . -type f -name "*.c" -print); do
    
    flname=$(basename $file .c)
    objname="${flname}_${#objectFiles[@]}.o"
    objectFiles+=($objname)

    if [ $file -nt $objname ]; then
        echo "    $file"
        ${CC} ${CFLAGS} -o $objname -c $file
    fi
done


# D files
echo ""
echo "Compiling D files:"
for file in $(find . -type f -name "*.d" -print); do

    flname=$(basename $file .d)
    objname="${flname}_${#objectFiles[@]}.o"
    objectFiles+=($objname)

    if [ $file -nt $objname ]; then
        echo "    $file"
        ${DC} ${DCFLAGS} -of$objname -c $file
    fi
done


# Link:
echo ""
echo "Linking... "
${DC} ${DC_FLAGS} -of../${PROG_NAME} ${objectFiles[@]} \
    ${LIB_PATH} \
    -L-lgtkd-2 -L-ldl

echo "Done."
echo ""
