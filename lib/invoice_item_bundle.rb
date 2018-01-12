class InvoiceItemBundle
  attr_accessor :quantity, :product_bundle_quantity, :price

  def initialize args={}
    @quantity = args[:quantity]
    @product_bundle_quantity = args[:product_bundle_quantity]
    @price = args[:price]
  end
end
