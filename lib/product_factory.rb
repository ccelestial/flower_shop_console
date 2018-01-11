require './data/array_products'
require 'product'

class ProductFactory
  def self.get
    @@products ||= ArrayProducts.get.map do |product_hash|
      Product.new(product_hash)
    end
  end
end
