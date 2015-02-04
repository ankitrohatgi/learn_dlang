/*
 * This file is part of gtkD.
 *
 * gtkD is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * gtkD is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with gtkD; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110, USA
 */

import gtk.MainWindow;
import gtk.Label;
import gtk.Main;
import gtk.MenuBar;
import gtk.VBox;
import gtk.MenuItem;
import gtk.Menu;

class HelloWorld : MainWindow
{
	this()
	{
		super("GtkD");
        setDefaultSize(800,600);
        
        auto vbox = new VBox(false, 0);

        auto menuBar = new MenuBar();

        // File menu
        auto fileMenuItem = new MenuItem("File");

        auto fileMenu = new Menu(); 
        auto testMenuItem = new MenuItem("Test");
        auto test2MenuItem = new MenuItem("Test2");
        fileMenu.append(testMenuItem);
        fileMenu.append(test2MenuItem);
        fileMenuItem.setSubmenu(fileMenu);

        menuBar.append(fileMenuItem);
        
        // Pack items
        vbox.packStart(menuBar, false, false, 0);
        vbox.add(new Label("Hello World"));

        add(vbox);
		showAll();
	}

}

void main(string[] args)
{

	Main.init(args);
	new HelloWorld();
	Main.run();

}
