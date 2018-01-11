require_relative 'product_factory'
require_relative 'order'
require_relative 'best_bundle'

class Interface
  def initialize
    @products = ProductFactory.get
    @order = Order.new
    @best_bundle = BestBundle.new
  end

  def open
    puts products_display

    get_order_items

    puts order_display
  end

  private

  def get_order_items
    puts "Enter quantity + code: (e.g. 10 R12): Finish by typing \"x\"."
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

  def order_display
    view = ["\nORDER SUMMARY:"]
    @order.items.each do |item|
      product = @products.select{ |p| p.code == item.product_code }.first

      if product.nil?
        view << "#{item.quantity} #{item.product_code} -> Invalid Product Code"
        next
      end

      bundles = product.bundles
      best_bundle = @best_bundle.get(bundles.map(&:quantity), item.quantity)

      if best_bundle.nil?
        view << "#{item.quantity} #{item.product_code} -> Invalid Quantity"
        next
      end

      sub_total = 0.0
      result = best_bundle.uniq.inject([]) do |result, bb|
        bundle_count = best_bundle.count(bb)
        total_bundle_price = (bundles.select{ |b| b.quantity == bb }.first.price * bundle_count).ceil(2)
        sub_total += total_bundle_price

        result << "\t#{bundle_count} x #{bb} $%.2f" % total_bundle_price
      end

      view << "#{item.quantity} #{item.product_code} $%.2f" % sub_total.ceil(2)
      view += result
    end
    view.join("\n")
  end
end
