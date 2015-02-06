module ui.mainwindow;

import gtk.MainWindow;
import gtk.MenuBar;
import gtk.Menu;
import gtk.MenuItem;
import gtk.VBox;
import gtk.HBox;
import gtk.Label;
import gtk.MessageDialog;

public class MyAppWindow : MainWindow
{
    private VBox _vbox;

    public this()
    {
        super("MyApp");
        setDefaultSize(800, 600);
        setPosition(GtkWindowPosition.POS_CENTER);
        _vbox = new VBox(false, 0);
        createMenus();
        createWidgets();
        add(_vbox);
        showAll();
    }

    private void createMenus()
    {
        auto menuBar = new MenuBar();

        auto fileMenu = new Menu();
        auto openFileMenuItem = new MenuItem("Open");
        auto quitAppMenuItem = new MenuItem("Quit");
        quitAppMenuItem.addOnActivate(&quit);
        fileMenu.append(openFileMenuItem);
        fileMenu.append(quitAppMenuItem);
        
        auto fileMenuHeading = new MenuItem("File");
        fileMenuHeading.setSubmenu(fileMenu);

        menuBar.append(fileMenuHeading);

        _vbox.packStart(menuBar, false, false, 0);
    }

    private void quit(MenuItem menuItem)
    {
        MessageDialog d = new MessageDialog(this, 
                                            GtkDialogFlags.MODAL, 
                                            MessageType.INFO, ButtonsType.OK, "Test Message!");
        d.run();
        d.destroy();
    }

    private void createWidgets()
    {
        auto hbox = new HBox(false, 0);
        hbox.packStart(new Label("hello"), true, true, 10);
        hbox.packEnd(new Label("sidebar"), false, false, 10);
        _vbox.add(hbox);
    }
}
