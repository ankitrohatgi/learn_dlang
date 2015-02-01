import graphicsmagick;
import std.stdio;
import std.string;
import std.datetime;
import std.parallelism;

void create_image(string folder, int i)
{
    string filename = format("%s/test_%d.png", folder, i);
    auto img = new GMImage();
    img.create(640, 480);
    GMColor col = { r: 255, g: 255, b: 0, a: 0 };
    img.setPixel(100, 100, col);
    img.syncPixels();
    img.write(filename);
    img.close();
}

void average_image(string folder, int i)
{ 
    string filename = format("%s/test_%d.png", folder, i);
    auto img = new GMImage();
    img.read(filename);
    uint height = img.height();
    uint width = img.width();
    
    double r_avg = 0;
    double g_avg = 0;
    double b_avg = 0;

    long count = height*width;
    GMColor pix;

    for(uint x = 1; x <= width; x++)
    {
        for(uint y = 1; y <= height; y++)
        {
            pix = img.getPixel(x, y);
            r_avg += uint(pix.r);
            g_avg += uint(pix.g);
            b_avg += uint(pix.b);
        }
    }
    r_avg = r_avg/count;
    g_avg = g_avg/count;
    b_avg = b_avg/count;
    img.close();
}

void generate_1000_images()
{
    auto startTime = Clock.currTime();
    for(int i = 0; i < 1000; i++)
    {
        create_image("img", i);
        average_image("img", i);
    }
    auto stopTime = Clock.currTime();
    auto diffTime = stopTime - startTime;
    writeln("Time taken for creating 1000 images: ", diffTime);
}

void generate_1000_images_parallel()
{
    int i[];
    i.length = 1000;
    for(int j = 0; j < 1000; j++)
    {
        i[j] = j;
    }

    auto startTime = Clock.currTime();
    foreach(img_index; parallel(i))
    {
        create_image("img_parallel", img_index);
        average_image("img_parallel", img_index);
    }
    auto stopTime = Clock.currTime();
    auto diffTime = stopTime - startTime;
    writeln("Time taken for creating 1000 images in parallel: ", diffTime);
}

void main()
{
    GraphicsMagick.init();
    // Simple Usage
    auto img = new GMImage();
    img.read("testImage.png");
    writeln("Dimensions: (", img.width(), ", ", img.height(), ")");

    auto rgba = img.getPixel(100, 100);
    writefln("RGBA at Pixel (100, 100): [%d, %d, %d, %d]", 
             rgba.r, rgba.g, rgba.b, rgba.a);

    // Generate 1000 images and calculate average RGB:
    generate_1000_images();
    generate_1000_images_parallel();

    GraphicsMagick.destroy();
}


