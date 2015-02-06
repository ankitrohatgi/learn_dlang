module ui.graphicswidget;


import gdk.Color;
import gtk.DrawingArea;

public class GraphicsWidget : DrawingArea
{
    public this()
    {
        super(300, 300);
        auto c = new Color(255, 0, 0);
        modifyBg(GtkStateType.NORMAL, c);
    }
}
