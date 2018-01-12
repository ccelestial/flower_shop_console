require_relative 'invoice_item_bundle'

class InvoiceItem
  attr_accessor :order_item, :sub_total, :item_bundles, :state

  def initialize args={}
    @order_item = args[:order_item]
    @sub_total = args[:sub_total] || 0.0
    @item_bundles = args[:best_bundles] || Array.new
    @state = "valid"
  end

  def add_item_bundle quantity:, product_bundle_quantity:, price:
    @item_bundles << InvoiceItemBundle.new(quantity: quantity, product_bundle_quantity: product_bundle_quantity, price: price)
  end

  %w(valid invalid_product invalid_quantity).each do |state|
    define_method("#{state}!") do
      @state = state
    end

    define_method("#{state}?") do
      @state == state
    end
  end
end
