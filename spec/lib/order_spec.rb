require 'spec_helper'
require 'order'

describe Item do
  let(:order) { Order.new }

  describe '.new' do
    it 'creates an instance of Order' do
      expect(order).to be_an_instance_of(Order)
    end

    it 'initially assign empty array to items' do
      expect(order.items).to eq([])
    end
  end

  describe '.add_item' do
    let(:str_item) { "10 R12" }
    before { allow(Item).to receive(:new) }
    before { order.add_item(str_item) }

    it 'adds one Item to items' do
      expect(order.items.count).to eq(1)
    end
  end
end
