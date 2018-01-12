require_relative 'best_bundle'
require_relative 'invoice_item'

class Invoice
  attr_accessor :invoice_items

  def initialize order, products
    @order = order
    @products = products
    @best_bundle = BestBundle.new
    @invoice_items = generate_invoice_items
  end

  private

  def generate_invoice_items
    invoice_items = []
    @order.items.each do |item|
      invoice_item = InvoiceItem.new(order_item: item)

      product = get_product(item.product_code)

      if product.nil?
        invoice_item.invalid_product!
        invoice_items << invoice_item
        next
      end

      best_bundle_for_item = get_best_bundle_for_item(product.bundles, item)

      if best_bundle_for_item.nil?
        invoice_item.invalid_quantity!
        invoice_items << invoice_item
        next
      end

      invoice_items << add_invoice_item_bundles(invoice_item, product, best_bundle_for_item)
    end
    invoice_items
  end

  def valid_product_code? product_code
    @products.map(&:product_code).include?(product_code)
  end

  def get_product product_code
    @products.select{ |p| p.code == product_code }.first
  end

  def get_best_bundle_for_item bundles, item
    @best_bundle.get(bundles.map(&:quantity), item.quantity)
  end

  def add_invoice_item_bundles invoice_item, product, best_bundle_for_item
    best_bundle_for_item.uniq.each do |product_bundle_quantity|
      quantity = best_bundle_for_item.count(product_bundle_quantity)
      price = (product.bundles.select{ |b| b.quantity == product_bundle_quantity }.first.price * quantity).ceil(2)

      invoice_item.add_item_bundle(quantity: quantity, product_bundle_quantity: product_bundle_quantity, price: price)
      invoice_item.sub_total += price
    end
    invoice_item
  end
end
