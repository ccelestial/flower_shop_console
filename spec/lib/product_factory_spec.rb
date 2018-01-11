require 'spec_helper'
require 'product_factory'

describe ProductFactory do
  describe '#get' do
    before {
      allow(ArrayProducts).to receive(:get).and_return([
        {
          name: "Roses",
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

    it 'returns array of products count equal to ArrayProducts' do
      expect(ProductFactory.get.count).to eq(1)
    end

    it 'returns array of products with name same as ArrayProducts' do
      expect(ProductFactory.get.first.name).to eq("Roses")
    end

    it 'returns array of products with bundle.count equal to ArrayProducts' do
      expect(ProductFactory.get.first.bundles.count).to eq(2)
    end
  end
end
