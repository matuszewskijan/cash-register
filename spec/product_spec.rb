# frozen_string_literal: true

require 'spec_helper'
require './app/inventory/product'

RSpec.describe Product do
  describe '#format' do
    subject(:product) { described_class.new(code: 'tt', name: 'test', price: 1000) }

    context 'when without_price is true' do
      it 'return only name and code' do
        expect(product.format(without_price: true)).to eq "test (tt)"
      end
    end

    context 'when without_price is false' do
      it 'return name and prices' do
        expect(product.format).to eq "test - €10.00"
      end
    end
  end
end
