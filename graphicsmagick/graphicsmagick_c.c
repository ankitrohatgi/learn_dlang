#include <magick/api.h>
#include <string.h>
#include <stdio.h>

void gm_initialize_magick()
{
    InitializeMagick(NULL);
}

void gm_destroy_magick()
{
    DestroyMagick();
}

int gm_read(void **imageInfoPtr, void **imagePtr, const char *filename)
{
    // ImageInfo
    ImageInfo *imageInfo;
    imageInfo = CloneImageInfo(0);
    strcpy(imageInfo->filename, filename);

    // ExceptionInfo
    ExceptionInfo exception;
    GetExceptionInfo(&exception);    

    // ReadImage
    Image *image = ReadImage(imageInfo, &exception);
    if(image == (Image *)NULL)
    {
        CatchException(&exception);
        return -1;
    }

    // Return Ptr
    *imagePtr = image;
    *imageInfoPtr = imageInfo;

    return 0;
}

int gm_write(void *imageInfoPtr, void *imagePtr, const char *filename)
{
    // ImageInfo
    ImageInfo *imageInfo = (ImageInfo*)imageInfoPtr;
    strcpy(imageInfo->filename, filename);
    
    printf("Writing %s - %lu\n", imageInfo->filename, strlen(imageInfo->filename));
    // WriteImage
    Image *image = (Image*)imagePtr;
    strcpy(image->filename, filename);
    if(!WriteImage(imageInfo, image))
    {
        CatchException(&image->exception);
        return -1;
    }

    return 0;
}

unsigned int gm_height(void *imagePtr)
{
    Image *image = (Image*)imagePtr;
    return image->rows;
}

unsigned int gm_width(void *imagePtr)
{
    Image *image = (Image*)imagePtr;
    return image->columns;
}

void gm_destroy(void *imageInfoPtr, void *imagePtr)
{
    Image *image = (Image*)imagePtr;
    ImageInfo *imageInfo = (ImageInfo*)imageInfoPtr;
    
    DestroyImageInfo(imageInfo);
    DestroyImage(image);
}

int gm_get_pixels(void *imagePtr, void **pixelPacketPtr, long x, long y, unsigned long columns, unsigned long rows)
{
    Image *image = (Image*)imagePtr;
    PixelPacket *pixelPacket = GetImagePixels(image, x, y, columns, rows);
    if(pixelPacket == (PixelPacket*)NULL)
    {
        return -1;
    }
    *pixelPacketPtr = pixelPacket;
    return 0;
}

void gm_get_pixel(void *imagePtr, void *pixelPacketPtr, unsigned int x, unsigned int y, char *rgba)
{
    PixelPacket *pixelPacket = (PixelPacket*)pixelPacketPtr;
    unsigned int width = gm_width(imagePtr);
    size_t index = y*width + x;
    rgba[0] = pixelPacket[index].red;
    rgba[1] = pixelPacket[index].green;
    rgba[2] = pixelPacket[index].blue;
    rgba[3] = pixelPacket[index].opacity;
}

void gm_set_pixel(void *imagePtr, void *pixelPacketPtr, unsigned int x, unsigned int y, char *rgba)
{
    PixelPacket *pixelPacket = (PixelPacket*)pixelPacketPtr;
    unsigned int width = gm_width(imagePtr);
    size_t index = y*width + x;
    pixelPacket[index].red = rgba[0];
    pixelPacket[index].green = rgba[1];
    pixelPacket[index].blue = rgba[2];
    pixelPacket[index].opacity = rgba[3];
}


void gm_sync_pixels(void *imagePtr)
{
    Image *image = (Image*)imagePtr;
    SyncImagePixels(image);
}


