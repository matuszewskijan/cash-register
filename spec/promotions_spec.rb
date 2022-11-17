# frozen_string_literal: true

require 'spec_helper'
require './app/promotions'
require './app/cart'

RSpec.describe Promotions do
  def prepare_cart
    cart = Cart.new
    cart.add_product('GR1', 6)
    cart.add_product('SR1', 3)
    cart.add_product('CF1', 1)
    cart
  end

  describe '#calculate_discounts' do
    let(:promotions) { described_class.new(prepare_cart) }
    let(:cart_products) { promotions.cart.products }

    it 'it calculate promotions for green tea' do
      promotions.calculate_discounts

      expect(cart_products.select { |p| p[:code] == 'GR1' && p[:discounted_price] != nil}.length).to eq 3
    end

    it 'calculate promotions for strawberries' do
      promotions.calculate_discounts
      strawberries = cart_products.select { |p| p[:code] == 'SR1' }

      expect(strawberries.length).to be > 0
      expect(strawberries.all? { |s| s[:discounted_price] == 4.5 }).to eq true
    end

    it 'does not calculate promotions for coffee' do
      promotions.calculate_discounts
      coffee = cart_products.select { |p| p[:code] == 'CF1' }

      expect(coffee.length).to be > 0
      expect(coffee.all? { |s| s[:discounted_price] == nil }).to eq true
    end
  end
end
