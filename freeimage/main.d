import freeimage;
import std.stdio;
import std.string;
import std.datetime;
import std.parallelism;

void create_image(string folder, int i)
{
    string filename = format("%s/test_%d.png", folder, i);
    auto img = new FreeImage(filename);
    img.create(640, 480);
    img.setPixel(100, 100, 255, 255, 0, 255);
    img.save();
    img.close();
}

void average_image(string folder, int i)
{ 
    string filename = format("%s/test_%d.png", folder, i);
    auto img = new FreeImage(filename);
    img.load();
    uint height = img.height();
    uint width = img.width();
    
    double r_avg = 0;
    double g_avg = 0;
    double b_avg = 0;

    long count = 0;
    char[4] pix;

    for(uint x = 1; x <= width; x++)
    {
        for(uint y = 1; y <= height; y++)
        {
            pix = img.getPixel(x, y);
            r_avg = (r_avg*count + uint(pix[0]))/(count + 1.0);
            g_avg = (g_avg*count + uint(pix[1]))/(count + 1.0);
            b_avg = (b_avg*count + uint(pix[2]))/(count + 1.0);
            count++;
        }
    }
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
    // Simple Usage
    auto img = new FreeImage("testImage.png");
    img.load();
    writeln("Dimensions: (", img.width(), ", ", img.height(), ")");

    auto rgba = img.getPixel(100, 100);
    writeln("RGBA at Pixel (100, 100): [", 
            int(rgba[0]), ", ", 
            int(rgba[1]), ", ", 
            int(rgba[2]), ", ", 
            int(rgba[3]), "]");

    // Generate 1000 images and calculate average RGB:
    generate_1000_images();
    generate_1000_images_parallel();
}


