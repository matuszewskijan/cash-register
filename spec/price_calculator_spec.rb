# frozen_string_literal: true

require 'spec_helper'
require './app/price_calculator'
require './app/cart'

RSpec.describe PriceCalculator do
  def prepare_cart
    cart = Cart.new
    cart.add_product('GR1', 6)
    cart.add_product('SR1', 3)
    cart.add_product('CF1', 1)
    cart
  end

  describe '#process' do
    subject(:calculator) { described_class.new(cart: prepare_cart) }

    let(:cart) { calculator.cart }

    context 'when some products removed from cart after calculation' do
      before { calculator.process }

      it 'calculate proper promotions' do
        cart.remove_product('gr1', 3)
        calculator.process
        expect(cart.products.select { |p| p.code == 'GR1' && !p.discounted_price.nil? }.length).to eq 1
      end
    end

    it 'calculate promotions for green tea' do
      calculator.process

      expect(cart.products.select { |p| p.code == 'GR1' && !p.discounted_price.nil? }.length).to eq 3
    end

    it 'calculate promotions for strawberries' do
      calculator.process
      strawberries = cart.products.select { |p| p.code == 'SR1' }

      expect(strawberries.length).to be > 0
      expect(strawberries.all? { |s| s.discounted_price == 4.5 }).to eq true
    end

    it 'does not calculate promotions for coffee' do
      calculator.process
      coffee = cart.products.select { |p| p.code == 'CF1' }

      expect(coffee.length).to be > 0
      expect(coffee.all? { |s| s.discounted_price.nil? }).to eq true
    end
  end
end
