# frozen_string_literal: true

require 'spec_helper'
require './app/cart'

RSpec.describe Cart do
  let(:cart) { described_class.new }

  describe '#add_product' do
    context 'when known product' do
      it 'adds product to the cart' do
        expect { cart.add_product('strawberries') }.to change(cart.products, :count).by(1)
      end
    end

    context 'with higher amount' do
      it 'adds products to the cart' do
        expect { cart.add_product('strawberries', 5) }.to change(cart.products, :count).by(5)
      end
    end

    context 'when unkown product' do
      it 'does not add product to the cart' do
        expect { cart.add_product('unkown') }.not_to change(cart.products, :count)
      end

      it 'returns warning message' do
         expect(cart.add_product('unkown')).to eq 'Unkown product'
      end
    end
  end

  describe '#remove_product' do
    before { cart.add_product('strawberries', 5) }

    context 'when known product' do
      it 'removes product from cart' do
        expect { cart.remove_product('strawberries') }.to change(cart.products, :count).by(-1)
      end
    end

    context 'with higher amount' do
      it 'removes products to the cart' do
        expect { cart.remove_product('strawberries', 6) }.to change(cart.products, :count).by(-5)
      end
    end

    context 'when unkown product' do
      it 'does not remove products from cart' do
        expect { cart.remove_product('strawberries') }.to change(cart.products, :count)
      end

      it 'returns warning message' do
         expect(cart.add_product('unkown')).to eq 'Unkown product'
      end
    end
  end

  describe '#calculate_price' do
    it 'sums prices of all products' do
      cart.add_product('strawberries', 5)
      expect(cart.calculate_price).to eq 5.00 * 5
    end
  end
end
