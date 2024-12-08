require_relative './Item'
require_relative './Crud'

class Iventory
  
  include Crud  
  
  def initialize
    # @db=[]
    self.configure_db(@db)
    self.fetch_data("iventory_db.txt")
  end

  def promotion(percentage,product_name = false)
    @current_db=self.export_db
    if not product_name
      puts "Promotion, Successfully done.  \n All the product of the Iventory received #{percentage}% of discount " if @current_db.each{|item| item.price=item.price - (item.price)*percentage/100}  
    else 

      product_to_promove=self.search_item(product_name)

      if product_to_promove
        product_to_promove.price-=(product_to_promove.price)*percentage/100
        puts "Promotion, Successfully done.\n The #{product_to_promove.name} received #{percentage}% of discount"
      else
        puts "Could not find the #{product_name} in the Iventory List \n Please run > list iventory "    
      end
    end
  end
end