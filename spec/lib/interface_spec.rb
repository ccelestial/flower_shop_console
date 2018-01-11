require 'spec_helper'
require 'interface'
require "stringio"

describe Interface do
  describe '.new' do
    before { allow(ProductFactory).to receive(:get) }
    before { allow(Order).to receive(:new) }

    it 'creates an instance of Interface' do
      interface = Interface.new
      expect(interface).to be_an_instance_of(Interface)
    end

    it 'calls ProductFactory to get products' do
      expect(ProductFactory).to receive(:get)
      Interface.new
    end

    it 'creates new Order' do
      expect(Order).to receive(:new)
      Interface.new
    end
  end

  describe '.open' do
    before { allow(ProductFactory).to receive(:get).and_return([]) }
    before { allow_any_instance_of(Product).to receive(:name) }
    before { allow_any_instance_of(Product).to receive(:code) }
    before { allow_any_instance_of(Product).to receive(:bundles).and_return([]) }
    before { allow_any_instance_of(Order).to receive(:add_item) }
    before { allow_any_instance_of(Interface).to receive(:gets).and_return("10 R12", "x") }
    let(:interface) { Interface.new }

    it 'calls Order.add_item when inputing order' do
      expect_any_instance_of(Order).to receive(:add_item)
      interface.open
    end
  end
end
