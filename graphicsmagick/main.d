import graphicsmagick;
import std.stdio;

void main()
{
    GraphicsMagick.init();
     
    auto img = new GMImage();
    img.read("testImage.png");
    writefln("Width = %d, Height = %d", img.width(), img.height());
    GMColor px = img.getPixel(100, 100);
    writefln("RGBA at (100, 100): (%d, %d, %d, %d)", px.r, px.g, px.b, px.a);
    GMColor red;
    red.r = 255; red.g = 13; red.b = 255; red.a = 0;
    img.setPixel(100, 100, red);
    img.syncPixels();
    img.write("a2.png");
    GraphicsMagick.destroy();
}
