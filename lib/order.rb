require_relative 'item'

class Order
  attr_accessor :items

  def initialize
    @items = Array.new
  end

  # str_item => string, e.g. "10 R12"
  def add_item str_item
    @items << Item.new(str_item)
  end
end
