module graphicsmagick;

import std.string;

public class GraphicsMagick
{
    public static void init()
    {
        gm_initialize_magick();
    }

    public static void destroy()
    {
        gm_destroy_magick();
    }
}

struct GMColor
{
    char r;
    char g;
    char b;
    char a;
}

public class GMImage
{
    private:
        void *imagePtr;
        void *imageInfoPtr;
        uint imageWidth;
        uint imageHeight;
        bool isOpen;
        void *pixelPacketPtr;

    public this()
    {
        isOpen = false;
    }

    ~this()
    {
    }

    public void close()
    {
        if(isOpen)
        {
            gm_destroy(imageInfoPtr, imagePtr);
        }
        isOpen = false;
    }

    public void read(string filename)
    {
        if(isOpen)
        {
            close();
        }
        int status = gm_read(&imageInfoPtr, &imagePtr, std.string.toStringz(filename));
        if (status < 0)
        {
            throw new Exception(format("Cannot read image %s", filename));
        }
        imageWidth = gm_width(imagePtr);
        imageHeight = gm_height(imagePtr);
        if(imageWidth == 0 || imageHeight == 0)
        {
            throw new Exception(format("Cannot read image %s", filename));
        }

        // read all the pixels into memory
        status = gm_get_pixels(imagePtr, &pixelPacketPtr, 0, 0, imageWidth, imageHeight);
        if(status < 0)
        {
            throw new Exception(format("Cannot read image %s", filename));
        }
        isOpen = true;
    }

    public void write(string filename)
    {
        if(gm_write(imageInfoPtr, imagePtr, std.string.toStringz(filename)) < 0)
        {
            throw new Exception(format("Error weiting image %s", filename));
        }
    }

    public uint height()
    {
        return imageHeight;
    }

    public uint width()
    {
        return imageWidth;
    }

    public void create(uint width, uint height)
    {
        int status = gm_create(&imageInfoPtr, &imagePtr, width, height);
        if(status < 0)
        {
            throw new Exception(format("Cannot create image!"));
        }

        imageWidth = width;
        imageHeight = height;

        // read all the pixels into memory
        status = gm_get_pixels(imagePtr, &pixelPacketPtr, 0, 0, imageWidth, imageHeight);
        if(status < 0)
        {
            throw new Exception(format("Cannot read created image!"));
        }
        isOpen = true;
    }

    public GMColor getPixel(uint x, uint y)
    {
        GMColor rgba;
        gm_get_pixel(imagePtr, pixelPacketPtr, x, y, &rgba);
        return rgba;
    }

    public void setPixel(uint x, uint y, GMColor rgba)
    {
        char [4] crgba = [rgba.r, rgba.g, rgba.b, rgba.a];
        gm_set_pixel(imagePtr, pixelPacketPtr, x, y, crgba.ptr);
    }

    public void syncPixels()
    {
        gm_sync_pixels(imagePtr);
    }
}

extern(C) 
{
    void gm_initialize_magick();
    void gm_destroy_magick();

    int gm_read(void **imageInfoPtr, void **imagePtr, immutable(char)* filename);
    int gm_write(void *imageInfoPtr, void *imagePtr, immutable(char)* filename);
    int gm_create(void **imageInfoPtr, void **imagePtr, uint width, uint height);
    uint gm_height(void *imagePtr);
    uint gm_width(void *imagePtr);
    void gm_destroy(void *imageInfoPtr, void *imagePtr);
    int gm_get_pixels(void *imagePtr, void **pixelPacket, long x, long y, ulong columns, ulong rows);
    void gm_get_pixel(void *imagePtr, void *pixelPacketPtr, uint x, uint y, GMColor *rgba);
    void gm_set_pixel(void *imagePtr, void *pixelPacketPtr, uint x, uint y, char *rgba);
    void gm_sync_pixels(void *imagePtr);

}
