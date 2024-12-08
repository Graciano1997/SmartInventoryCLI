require_relative './Item'
require 'json'

module Crud
  @iventory_db=nil
  attr_accessor :file_name

  def fetch_data(file_name)
    @iventory_db=[]
    data_db=[]

    if File.exist?(file_name)
      @file_name=file_name
      File.open(file_name,"r") do |file|
        file.each_line do |line|
          data_db << JSON.parse("#{line}",symbolize_names: true)
        end
      end
    end

    if data_db.size > 0
      data_db.each do |item|
        iventory_item=Item.new(item[:name],item[:quantity],item[:price])
        @iventory_db << iventory_item
      end
    end
  end

  def configure_db(db)    
    # @iventory_db=db    
    self.file_config("iventory_db.txt","w")
  end

  def export_db
    @iventory_db
  end

  def file_config(file_name,mode)
    if !File.exist?(file_name)
      @file_name=file_name
      File.new(file_name,mode)
      puts "\n--- Iventory Database Initialized Successfully! ---\n\n"
    end  
  end

  def add_item(item)
    last_item=self.search_item(item)    
    last_item.quantity += item.quantity and puts %Q{ Item already exist! \n and Updated successfully the quantity }  if last_item
    @iventory_db.push(item) and puts %Q{ Created Successfuly! } if not last_item
  end

  def update_item(item)
    item_to_update = self.search_item(item)
    item_to_update.quantity +=item.quantity and puts %{Updated Successfully the quantity!} if item_to_update
    puts %{Could not update, please ensure the existance of this item} if not item_to_update
  end

  def search_item(item)

    @iventory_db.each do |iventory_item|
      return iventory_item if item.is_a?(Item) and iventory_item.name==item.name  
      return iventory_item if item.is_a?(String) and iventory_item.name==item
    end
    return false
  end

  def remove_item(item)
    item_to_remove = self.search_item(item)
    @iventory_db.delete(item_to_remove) and puts %{Removed Successfully!} if item_to_remove
    puts %{Could not remove, please ensure the existance of this item} if not item_to_remove
  end

  def reset_db
    @iventory_db=[] and puts %{The Database was successfully reseted!}
    @iventory_file=File.new("iventory_db.txt","w")

    if @iventory_file
      @iventory_file.syswrite("")      
      puts "\n The Iventory was successfully reseted!"
    else
      puts "\n Could not reset successfully the Iventory db_file"
    end
  end

  def view_items
    puts ""
    puts "*********************INVENTORY_LIST***************************"
    puts ""
    @iventory_db.each{|item| puts "Name: #{item.name.capitalize}  | Quantity: #{item.quantity} | Price: #{item.price} USD"}
    puts ""
    puts "******************Total Items #{@iventory_db.count} *******************"
    puts ""
  end

  def save_iventory
    db_file=File.new("iventory_db.txt","w")

    @iventory_db.each do |item|
      db_file.syswrite({name:item.name, price:item.price, quantity:item.quantity}.to_json+"\n")
    end
    puts "Iventory was Saved Successfully!"
  end
end