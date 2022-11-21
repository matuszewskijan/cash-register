# frozen_string_literal: true

require 'spec_helper'
require './app/cart'

RSpec.describe Cart do
  let(:cart) { described_class.new }

  describe '#add_product' do
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
