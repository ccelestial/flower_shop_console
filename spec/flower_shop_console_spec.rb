require 'spec_helper'
require 'interface'
require "stringio"

describe do
  describe 'This test will show how the app performs' do
    before { allow_any_instance_of(Interface).to receive(:gets).and_return("10 R12", "15 L09", "13 T58", "14 R12", "10 X22", "x") }
    let(:interface) { Interface.new }

    it 'calls the Interface for users' do
      interface.open
    end
  end
end
