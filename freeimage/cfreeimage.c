#include <stdio.h>
#include <FreeImage.h>
#include <string.h>

void fimg_get_version(char *val)
{
    const char *version = FreeImage_GetVersion();
    strcpy(val, version);
}

int fimg_read(void **bitmapPtr, const char *filename)
{
    printf("Reading %s\n", filename);
    printf("Len %d\n", strlen(filename));
    FREE_IMAGE_FORMAT formatInfo = FreeImage_GetFileType(filename, 0);
    if(formatInfo == FIF_UNKNOWN) 
    {
        formatInfo = FreeImage_GetFIFFromFilename(filename);
        if(formatInfo == FIF_UNKNOWN)
        {
            return -1;
        }
    }
    if(!FreeImage_FIFSupportsReading(formatInfo))
    {
        return -1;
    }
    FIBITMAP *fibitmap = FreeImage_Load(formatInfo, filename, 0);
    *bitmapPtr = fibitmap;
}

int fimg_get_height(void *bitmapPtr)
{
    FIBITMAP *fibitmap = (FIBITMAP*)bitmapPtr;
    return FreeImage_GetHeight(fibitmap);
}

int fimg_get_width(void *bitmapPtr)
{
    FIBITMAP *fibitmap = (FIBITMAP*)bitmapPtr;
    return FreeImage_GetWidth(fibitmap);
}

void fimg_get_pixel_color(void *bitmapPtr, unsigned int x, unsigned int y, char *rgba)
{
    FIBITMAP *fibitmap = (FIBITMAP*)bitmapPtr;
    RGBQUAD rgbquad;
    FreeImage_GetPixelColor(fibitmap, x, y, &rgbquad);
    rgba[0] = rgbquad.rgbRed;
    rgba[1] = rgbquad.rgbGreen;
    rgba[2] = rgbquad.rgbBlue;
    rgba[3] = rgbquad.rgbReserved;
}

void fimg_unload(void *bitmapPtr)
{
    FIBITMAP *fibitmap = (FIBITMAP*)bitmapPtr;
    FreeImage_Unload(fibitmap);
}
