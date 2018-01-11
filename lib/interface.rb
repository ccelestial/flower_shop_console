require_relative 'product_factory'

class Interface
  def initialize
    @products = ProductFactory.get
  end

  def open
    puts products_display
  end

  private

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
