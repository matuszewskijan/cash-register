# frozen_string_literal: true

require 'spec_helper'
require './app/cart'

RSpec.describe Cart do
  let(:basket) { described_class.new }

  describe '#add_product' do
    context 'when known product' do
      it 'adds product to the cart' do
        expect { basket.add_product('strawberries') }.to change(basket.products, :count).by(1)
      end
    end

    context 'with higher amount' do
      it 'adds products to the cart' do
        expect { basket.add_product('strawberries', 5) }.to change(basket.products, :count).by(5)
      end
    end

    context 'when unkown product' do
      it 'does not add product to the cart' do
        expect { basket.add_product('strawberries') }.to change(basket.products, :count).by(1)
      end

      it 'returns warning message' do
         expect(basket.add_product('unkown')).to eq 'Unkown product'
      end
    end
  end
end
