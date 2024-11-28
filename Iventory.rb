require_relative './Item'

class Iventory

  def initialize
    @db=[]
  end

  def add_item(name,quantity)
    
    new_item=Item.new(name,quantity)

    item_already_Exists=false

    @db.each do |item|
      item_already_Exists=true if(item.name==name)
    end

    @db.push(new_item) if(!item_already_Exists)

    puts "Item Already Exists in the Iventory" if(item_already_Exists)
  end

  def update_item(name,quantity)
    @db.each do |item|
      item.quantity+=quantity if(item.name==name)      
    end
  end

  def remove_item(name)
    @db.each  do |item|
      @db.delete(item) if(item.name==name)      
    end
  end

  def view_items
    puts "*********************INVENTORY_LIST***************************"
    puts ""
    @db.each{|item| puts "Name: #{item.name} Quantity: #{item.quantity}"}
    puts ""
    puts "******************Total Items #{@db.count} *******************"
  end
end

Iventory_repo=Iventory.new()

Iventory_repo.add_item("Banana",20)
 Iventory_repo.view_items
#  Iventory_repo.remove_item("Banana")
 Iventory_repo.add_item("Banana",20)
Iventory_repo.view_items

