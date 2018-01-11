require 'spec_helper'
require 'bundle'

describe Bundle do
  describe '.new' do
    let(:bundle_hash) {
      {
        quantity: 5,
        price: 6.99
      }
    }
    let(:bundle) { Bundle.new(bundle_hash)}

    it 'creates an instance of Bundle' do
      expect(bundle).to be_an_instance_of(Bundle)
    end

    it 'assigns quantity from argument' do
      expect(bundle.quantity).to eq(5)
    end

    it 'assigns price from argument' do
      expect(bundle.price).to eq(6.99)
    end
  end
end
