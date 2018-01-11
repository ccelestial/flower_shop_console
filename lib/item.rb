class Item
  attr_accessor :quantity, :product_code

  # str_item => string, e.g. "10 R12"
  def initialize str_item
    @quantity, @product_code = str_item.split(" ")
    @quantity = @quantity.to_i
    @product_code = @product_code.upcase
  end

  def product_from_products products
    products.select do |product|
      product.code == product_code
    end.first
  end
end
