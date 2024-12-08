class Item
  attr_accessor :name
  attr_accessor :quantity
  attr_accessor :price

  def initialize(name,quantity,price=10)
    @name=name
    @quantity=quantity.to_f
    @price=price
  end
end