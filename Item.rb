class Item
  attr_accessor :name
  attr_accessor :quantity

  def initialize(name,quantity)
    @name=name
    @quantity=quantity
  end
end