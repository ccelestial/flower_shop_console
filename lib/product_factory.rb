require './data/array_products'
require_relative 'product'

class ProductFactory
  def self.get
    @@products ||= ArrayProducts.get.map do |product_hash|
      Product.new(product_hash)
    end
  end
end
