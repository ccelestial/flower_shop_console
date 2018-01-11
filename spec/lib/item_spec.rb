require 'spec_helper'
require 'item'

describe Item do
  let(:str_item) { "10 R12" }
  let(:item) { Item.new(str_item) }

  describe '.new' do
    it 'creates an instance of Item' do
      expect(item).to be_an_instance_of(Item)
    end

    it 'assigns quantity from argument' do
      expect(item.quantity).to eq(10)
    end

    it 'assigns product_code from argument' do
      expect(item.product_code).to eq('R12')
    end
  end

  describe '.product_from_products' do
    before { allow_any_instance_of(Product).to receive(:name).and_return("Rose") }
    before { allow_any_instance_of(Product).to receive(:code).and_return("R12") }
    let(:products) { [ Product.new, Product.new ] }

    it 'returns the product.name with product_code from list of products' do
      expect(item.product_from_products(products).name).to eq("Rose")
    end

    it 'returns the product.code with product_code from list of products' do
      expect(item.product_from_products(products).code).to eq("R12")
    end
  end
end
