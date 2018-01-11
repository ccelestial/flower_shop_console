require 'spec_helper'
require 'interface'

describe Interface do
  describe '.new' do
    before { allow(ProductFactory).to receive(:get) }

    it 'creates an instance of Interface' do
      interface = Interface.new
      expect(interface).to be_an_instance_of(Interface)
    end

    it 'creates products instance variable' do
      expect(ProductFactory).to receive(:get)
      Interface.new
    end
  end
end
