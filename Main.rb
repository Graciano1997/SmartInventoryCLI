$LOAD_PATH << '.'
require 'readline'
require 'Iventory'

BEGIN{ puts %{====================== WELCOME AT YARA MERCAT =========================== \n\n} }

class Main
  @@iventory=Iventory.new
  
  def initialize
    self.Menu

    loop do 
      puts "\n"
      input=Readline.readline("What operation would you like to do?, type help to see the available commands :",true)
      input=(input.strip.downcase).split
      
      return @@iventory.save_iventory if input.size==1 and input.include? "exit"
      self.help if input.size==1 and input.include? "help"
      self.validate_input(input)
    end
  end
 
 def validate_input(input)
  case input.size
    when 2
      @@iventory.view_items if ["list", "iventory"].all? { |word| input.include?(word) }
      @@iventory.reset_db if ["reset","iventory"].all? { |word| input.include?(word) }
      @@iventory.remove_item(input[1]) if input[0].include? "delete" and input[1].is_a?(String)
      @@iventory.promotion((input[1].delete("%")).to_f) if input[0].include? "promotion" and input[1].include?"%"  and input[0].is_a?(String)
    when 3
      @@iventory.promotion((input[2].delete("%")).to_f,input[1]) if input[0].include? "promotion" and input[1].is_a?(String) and  input[2].include?"%"  and input[0].is_a?(String)
      if input[0..1].all?(String) && input[2].is_a?(Numeric)
        puts "Wrong format! Please ensure to check the syntax of commands"
      else
        name=input[1]
        quantity=input[2]
        item=Item.new name, quantity

        @@iventory.add_item(item) if input[0].include? "new"
        @@iventory.update_item(item) if input[0].include? "update"
      end
    else
      puts %{Please ensure to enter with one the above command options}
  end
end

def Menu
  print <<EOF 
  Your Operations : \n  
           - Add new item to Iventory----------------------Eg: new banana 15 
           - Update an Item in the Iventory----------------Eg: update banana 5
           - Delete an Item in the Iventory----------------Eg: delete banana
           - See the Iventory List-------------------------Eg: list iventory
           - Reset the Iventory----------------------------Eg: reset iventory
           - Iventory Promotion----------------------------Eg: promotion 10%
           - promotion to an Item--------------------------Eg: promotion banana 10%
           - exit the app ---------------------------------Eg: exit
           \n
EOF
 end

  def help
    print <<EOF 
    Commands : \n  
           new <name> <quantity> 
           update <name> <quantity>
           delete <name>
           list iventory
           reset iventory
           promotion <number>%
           promotion <name> <number>%
           exit
           \n
EOF
  end
end

main=Main.new


END{ puts %{\n\n====================== THANKS, WE HOPE SEE YOU SOON ===========================} }
