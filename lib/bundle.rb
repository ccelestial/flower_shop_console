class Bundle
  attr_accessor :quantity, :price

  def initialize args = {}
    @quantity = args[:quantity]
    @price = args[:price]
  end
end
