#!/usr/bin/ruby
require 'gtk2'
require 'webkit'

uri = ARGV[0]
title = ARGV[1]
width = ARGV[2]
height = ARGV[3]

if width.to_i == 0
  width = 1024
end

if height.to_i == 0
  height = 768
end



webkit = WebKit::WebView.new
webkit.open uri

sw = Gtk::ScrolledWindow.new

window = Gtk::Window.new
window.title = title
window.resize width.to_i, height.to_i
window.window_position = Gtk::Window::POS_CENTER
window.default_height=height.to_i
window.default_width=width.to_i

# Exit when closing the window
window.signal_connect('destroy') { Gtk.main_quit }

sw.add webkit
window.add sw
window.show_all

webkit.signal_connect('script-alert') { |a,b,message| 
	system("#{message} &")
	#webkit.main_frame.exec_js("alert('Hello World')")
	true
}



Gtk.main