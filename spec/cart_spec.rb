# frozen_string_literal: true

require 'spec_helper'
require './app/cart'

RSpec.describe Cart do
  describe '#reset!' do
    subject(:cart) { described_class.new(products: [1, 2, 3], total_price: 3, total_discounts: 3) }

    it 'removes all products' do
      expect { cart.reset! }.to change(cart, :products).to([])
    end

    it 'sets total_price to 0' do
      expect { cart.reset! }.to change(cart, :total_price).to('€0.00')
    end

    it 'sets discounted_price to 0' do
      expect { cart.reset! }.to change(cart, :total_discounts).to('€0.00')
    end
  end

  describe '#add_product' do
    subject(:cart) { described_class.new }

    context 'when known product' do
      it 'adds product to the cart' do
        expect { cart.add_product('sr1') }.to change(cart.products, :count).by(1)
      end
    end

    context 'with higher amount' do
      it 'adds products to the cart' do
        expect { cart.add_product('sr1', 5) }.to change(cart.products, :count).by(5)
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
    subject(:cart) { described_class.new }

    before { cart.add_product('sr1', 5) }

    context 'when known product' do
      it 'removes product from cart' do
        expect { cart.remove_product('sr1') }.to change(cart.products, :count).by(-1)
      end
    end

    context 'with higher amount' do
      it 'removes products to the cart' do
        expect { cart.remove_product('sr1', 6) }.to change(cart.products, :count).by(-5)
      end
    end

    context 'when unkown product' do
      it 'does not remove products from cart' do
        expect { cart.remove_product('sr1') }.to change(cart.products, :count)
      end

      it 'returns warning message' do
         expect(cart.add_product('unkown')).to eq 'Unkown product'
      end
    end
  end
end
