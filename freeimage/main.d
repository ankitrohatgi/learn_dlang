import freeimage;
import std.stdio;

void main()
{
    for(int i = 0; i < 100; i++) 
    {
        writeln("iteration: ", i);
        auto img = new FreeImage("/home/arohatgi/Pictures/fedora21.png");
        img.load();
        writeln("Dimensions: (", img.height(), ", ", img.width(), ")");
        writeln("RGBA at Pixel (100, 100): ", img.getPixel(100, 100));
        img.close();
    }
}
