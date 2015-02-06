import ui.mainwindow;
import gtk.Main;

void main(string[] args)
{

	Main.init(args);
	auto myAppWindow = new MyAppWindow();
	Main.run();
}
