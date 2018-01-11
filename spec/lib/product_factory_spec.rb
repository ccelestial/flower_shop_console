require 'spec_helper'
require 'product_factory'

describe ProductFactory do
  describe '#get' do
    before {
      allow(ArrayProducts).to receive(:get).and_return([
        {
          name: "Rose",
          code: "R12",
          bundles: [
            {
              quantity: 5,
              price: 6.99
            },
            {
              quantity: 10,
              price: 12.99
            },
          ]
        },
      ])
    }

    it 'returns array of products equal to number of ArrayProducts.get' do
      expect(ProductFactory.get.count).to eq(1)
    end

    it 'returns array of products with bundles' do
      expect(ProductFactory.get.first.name).to eq("Rose")
    end
  end
end
