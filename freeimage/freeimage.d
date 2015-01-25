module freeimage;

import std.stdio;
import std.string;

public class FreeImage
{
    private:
        string filename_;
        int height_;
        int width_;
        void *bitmapPtr;
        bool isOpen;

    public this(string filename)
    {
        filename_ = filename;
        isOpen = false;
    }

    ~this()
    {
        if(isOpen)
        {
            close();
        }
    }

    public void load()
    {
        if(isOpen) // already loaded!
        {
            return;
        }
        char[100] testStr;
        fimg_get_version(testStr.ptr); 
        // int status = fimg_read(&bitmapPtr, filename_.ptr);
        fimg_read(&bitmapPtr, std.string.toStringz(filename_));
        height_ = fimg_get_height(bitmapPtr);
        width_ = fimg_get_width(bitmapPtr);
        if(height_ <= 0 || width_ <= 0) 
        {
            throw new Exception(format("Error reading image %s", filename_));
        }
        isOpen = true;
    }

    public int height()
    {
        return height_;
    }

    public int width()
    {
        return width_;
    }

    public void close()
    {
        fimg_unload(bitmapPtr);
        isOpen = false;
    }

    public int[4] getPixel(int x, int y)
    {
        char[4] rgba;
        fimg_get_pixel_color(bitmapPtr, x, y, rgba.ptr);
        int[4] rgbaInt;
        rgbaInt[0] = rgba[0];
        rgbaInt[1] = rgba[1];
        rgbaInt[2] = rgba[2];
        rgbaInt[3] = rgba[3];
        return rgbaInt;
    }
}

extern(C)
{
    void fimg_get_version(char *val);
    int fimg_read(void **bitmapPtr, immutable(char)* filename);
    int fimg_get_height(void *bitmapPtr);
    int fimg_get_width(void *bitmapPtr);
    void fimg_get_pixel_color(void *bitmapPtr, uint x, uint y, char *rgba);
    void fimg_unload(void *bitmapPtr);
}
