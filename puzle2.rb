
require "ruby-nfc"
require "gtk3"
require "thread"
require_relative "Rfid.rb"


    @ed = Gdk::RGBA::new(1.0,0,0,1.0)
    @blue = Gdk::RGBA::new(0,0,1.0,1.0)
    @white = Gdk::RGBA::new(1.0,1.0,1.0,1.0)

    @uid=""
    @rf=Rfid.new
        
    @window = Gtk::Window.new("Lecotr Rfid")
    @window.set_size_request(800,200)
    @window.set_border_width(7)
    @window.set_window_position(:center)

    @window.signal_connect("delete-event") { |_widget| Gtk.main_quit }

    @grid = Gtk::Grid.new
  
                 
    @label = Gtk::Label.new("Please, login with your university card")
    @label.override_background_color(:normal, @@blue)
    @label.override_color(:normal, @@white)

    @grid.attach(@label, 0, 0, 2, 1)    

    @clear_button = Gtk::Button.new(:label=>"clear") 

    @grid.attach(@clear_button, 0, 1, 2, 1)

    @window.add(@grid)

    thraux

    @clear_button.signal_connect("clicked") do

            if @uid != ""

                @label.override_background_color(:normal,@blue)
                @label.set_text("Please, login with your university card")

               thraux
            end
        end

    def thraux

        t = Thread.new{
        read
        puts "thraux finished"
        t.exit
        }
    end
    

    def read

        puts "reading"

        @uid = @rf.read_uid
        Glib::Idle.add{show_uid}
        
    end


    def show_uid
    
        if @uid != ""
            @label.override_background_color(:normal,@red)
            @label.text=@uid.upcase
        end
    end


    @window.show_all   
    
    Gtk.main