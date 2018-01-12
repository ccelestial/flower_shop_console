require_relative 'product_factory'
require_relative 'order'
require_relative 'invoice'

class Interface
  def initialize
    @products = ProductFactory.get
    @order = Order.new
  end

  def open
    puts products_display

    puts "Enter quantity + code: (e.g. 10 R12): Finish by typing \"x\"."

    get_order_items

    @invoice = Invoice.new(@order, @products)

    puts invoice_display
  end

  private

  def get_order_items
    loop do
      input = gets.chomp

      break if input.downcase == "x"
      @order.add_item(input)
    end
  end

  def products_display
    view = ["Welcome to FlowerShop Console App\n\nPRODUCTS:\nNAME\tCODE \tBUNDLES\n"]
    view += @products.map do |product|
      "#{product.name}\t#{product.code}\t" +
      product.bundles.map do |bundle|
        "#{bundle.quantity} @ $#{bundle.price}\n"
      end.join("\t\t")
    end
    view.join("#{27.times.map{ "-" }.join}\n") + "\n"
  end

  def invoice_display
    display = "\nORDER SUMMARY:\n"
    @invoice.invoice_items.each do |invoice_item|
      display += "#{invoice_item.order_item.quantity} #{invoice_item.order_item.product_code} "

      if invoice_item.invalid_product?
        display += "#=> Invalid Product Code\n"
        next
      end

      if invoice_item.invalid_quantity?
        display += "#=> Invalid Order Quantity\n"
        next
      end

      display += "$%.2f\n" % invoice_item.sub_total

      invoice_item.item_bundles.each do |item_bundle|
        display += "\t#{item_bundle.quantity} x #{item_bundle.product_bundle_quantity} $%.2f\n" % item_bundle.price
      end
    end
    display
  end
end
