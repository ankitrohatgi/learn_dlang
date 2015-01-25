module freeimage;

import std.stdio;
import std.string;


public class FreeImage
{
    private:
        string filename_;
        uint height_;
        uint width_;
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
        fimg_read(&bitmapPtr, std.string.toStringz(filename_));
        height_ = fimg_get_height(bitmapPtr);
        width_ = fimg_get_width(bitmapPtr);
        if(height_ <= 0 || width_ <= 0) 
        {
            throw new Exception(format("Error reading image %s", filename_));
        }
        isOpen = true;
    }

    public void create(uint width, uint height)
    {
        fimg_create(&bitmapPtr, width, height);
        height_ = height;
        width_ = width;
        isOpen = true;
    }

    public void save()
    {
        fimg_save(bitmapPtr, std.string.toStringz(filename_));
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

    public char[4] getPixel(uint x, uint y)
    {
        char[4] rgba;
        fimg_get_pixel_color(bitmapPtr, x, height_ - y - 1, rgba.ptr);
        return rgba;
    }

    public void setPixel(uint x, uint y, char r, char g, char b, char a = 255)
    {
        char[4] rgba;
        rgba[0] = r;
        rgba[1] = g;
        rgba[2] = b;
        rgba[3] = a;
        fimg_set_pixel_color(bitmapPtr, x, height_ - y - 1, rgba.ptr);
    }
}

extern(C)
{
    void fimg_get_version(char *val);
    int fimg_read(void **bitmapPtr, immutable(char)* filename);
    void fimg_create(void **bitmapPtr, uint width, uint height); 
    void fimg_save(void *bitmapPtr, immutable(char)* filename);
    uint fimg_get_height(void *bitmapPtr);
    uint fimg_get_width(void *bitmapPtr);
    void fimg_get_pixel_color(void *bitmapPtr, uint x, uint y, char *rgba);
    void fimg_set_pixel_color(void *bitmapPtr, uint x, uint y, char *rgba);
    void fimg_unload(void *bitmapPtr);
}
