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
    GMColor red = { r: 255, g: 13, b: 255, a: 0 };
    img.setPixel(100, 100, red);
    img.syncPixels();
    img.write("a2.png");

    // Create a new image:
    auto nimg = new GMImage();
    nimg.create(800, 600);
    writefln("New image: Width = %d, Height = %d", nimg.width(), nimg.height());
    
    nimg.setPixel(100, 100, red);
    nimg.syncPixels();
    nimg.write("newimage.png");

    GraphicsMagick.destroy();
}
