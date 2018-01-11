require_relative 'product_factory'
require_relative 'order'

class Interface
  def initialize
    @products = ProductFactory.get
    @order = Order.new
  end

  def open
    puts products_display

    get_order_items

    puts @order.items.map(&:product_code)
  end

  private

  def get_order_items
    puts "Enter quantity + code: (e.g. 10 R12): Finish by typing \"x\"."
    loop do
      input = gets.chomp

      @order.add_item(input)

      break if input.downcase == "x"
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
end
