
 require 'ruby-nfc'  #importamos la libreria

class Rfid


    @@readers = NFC::Reader.all #creamos una variable de clase i la inicializamos con
   							 #una array de todos los lectores NFC del sistema

    
    def read_uid
    
    	@@readers[0].poll(Mifare::Classic::Tag) do |tag| #creamos un buccle que recorre readers
   													  #i detecta tarjetas Mifare classic
   	 
      	begin
   		 
   		 uid = tag.uid_hex.upcase  #guardamos el valor en formato hexadecimal y mayuscula
   		 return uid
   		 
   	   end
   	  end
       
   		 
    end   	 
   		 
end

if __FILE__ ==$0
    rf=Rfid.new
    puts "Apropi la targeta al lector"
    uid=rf.read_uid
    puts "Usuari: "+uid
end

