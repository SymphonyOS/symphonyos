#!/usr/bin/ruby
require 'gtk2'
require 'webkit'

@app_menu_open = false
@files_menu_open = false

screen = Gdk::Screen.default

screen_width = screen.width
screen_height = screen.height

puts screen_width
puts screen_height

webkit = WebKit::WebView.new
webkit.open 'http://localhost:9000/'



window = Gtk::Window.new
window.title = 'Desktop'

# Center the window and resize
window.resize screen_width, screen_height
window.window_position = Gtk::Window::POS_CENTER

# Exit when closing the window
window.signal_connect('destroy') { Gtk.main_quit }


# Applications Button
#apps_btn = Gtk::Button.new("Apps", false)

apps_btn_img = Gtk::Image.new("/usr/local/symphony/img/apps_btn.png")
apps_btn = Gtk::EventBox.new.add(apps_btn_img)
apps_btn.add apps_btn_img
apps_btn_win = Gtk::Window.new
apps_btn_win.add apps_btn



apps_btn_win.type_hint="dock"
apps_btn_win.default_width = 125
apps_btn_win.default_height = 25
apps_btn_win.has_frame = false
apps_btn_y = screen_height - 25
apps_btn_win.move(0,0)
apps_btn_win.keep_above = true
apps_btn_win.stick

# Files Button
#files_btn = Gtk::Button.new("Files", false)
files_btn_img = Gtk::Image.new("/usr/local/symphony/img/files_btn.png")
files_btn = Gtk::EventBox.new.add(files_btn_img)

files_btn_win = Gtk::Window.new
files_btn_win.add files_btn


files_btn_win.type_hint="dock"
files_btn_win.default_width = 125
files_btn_win.default_height = 25
files_btn_win.has_frame = false
files_btn_y = screen_height - 25
files_btn_x = screen_width - 125
files_btn_win.move(files_btn_x,0)
files_btn_win.stick


# Apps Menu
apps_webkit = WebKit::WebView.new
apps_webkit.open 'http://localhost:9000/menu/apps'
apps_menu = Gtk::Window.new
apps_menu.add apps_webkit
apps_menu.title = 'Apps'
apps_menu_height = screen_height - 25
apps_menu.resize screen_width, apps_menu_height
apps_menu.window_position = Gtk::Window::POS_CENTER
apps_menu.type_hint="dropdown_menu"
apps_menu.decorated = false
apps_menu.move(0,0)


# Files Menu
files_webkit = WebKit::WebView.new
files_webkit.open 'http://localhost:9000/menu/files'
files_menu = Gtk::Window.new
files_menu.add files_webkit
files_menu.title = 'Files'
files_menu_height = screen_height - 25
files_menu.resize screen_width, files_menu_height
files_menu.window_position = Gtk::Window::POS_CENTER
files_menu.type_hint="dropdown_menu"
files_menu.decorated = false
files_menu.move(0,0)

# Add the webview to the window
window.add webkit
window.type_hint="desktop"
window.stick
window.default_height=screen_height
window.default_width=screen_width
#window.show_all
apps_btn_win.show_all
files_btn_win.show_all
# Execute javascript in view
#webkit.main_frame.exec_js("alert('Hello World')")


# Apps Menu Signal
apps_btn.signal_connect('button_press_event') { 
puts 'App Btn Clicked'
if @app_menu_open == false
apps_menu.show_all
files_menu.hide_all
@app_menu_open = true
@files_menu_open = false
else
apps_menu.hide_all
@app_menu_open = false
end
}


files_btn.signal_connect('button_press_event') { 
puts 'Files Btn Clicked'
if @files_menu_open == false
files_menu.show_all
apps_menu.hide_all
@app_menu_open = false
@files_menu_open = true
else
files_menu.hide_all
@files_menu_open = false
end
}


files_webkit.signal_connect('script-alert') { |a,b,message| 
	system("#{message} &")
	files_menu.hide_all
	apps_menu.hide_all
	@files_menu_open = false
	@app_menu_open = false
	true
}
apps_webkit.signal_connect('script-alert') { |a,b,message| 
	system("#{message} &")
	files_menu.hide_all
	apps_menu.hide_all
	@files_menu_open = false
	@app_menu_open = false
	true
}
Gtk.main
