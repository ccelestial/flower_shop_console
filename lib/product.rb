require_relative 'bundle'

class Product
  attr_accessor :name, :code, :bundles

  def initialize args = {}
    @name = args[:name]
    @code = args[:code]
    @bundles = Array.new

    build_bundles(args[:bundles]) if args[:bundles]
  end

  # bundle => hash, e.g. { quantity: 5, price: 6.99 }
  def add_bundle bundle
    @bundles << Bundle.new(quantity: bundle[:quantity], price:  bundle[:price])
  end

  private

  def build_bundles array_bundles
    array_bundles.each do |bundle|
      add_bundle(bundle)
    end
  end
end
