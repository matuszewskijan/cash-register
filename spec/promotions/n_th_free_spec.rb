# frozen_string_literal: true

require 'spec_helper'
require './app/promotions/n_th_free'
require './app/cart'

RSpec.describe NThFree do
  def cart(product_amount)
    cart = Cart.new
    cart.add_product('GR1', product_amount)
    cart
  end

  describe '#calculate_discounts' do
    context 'with n equal to 2' do
      let(:promotion) do
        described_class.new(
          start_time: Time.now - 3600,
          end_time: Time.now + 3600,
          product_code: 'gr1',
          products: cart(5).products,
          n: 2
        )
      end

      it 'makes every 2nd item free' do
        promotion.calculate_discounts

        expect(promotion.products.select { |p| p[:discounted_price] }.length).to eq 2
      end
    end

    context 'with n equal to 5' do
      let(:promotion) do
        described_class.new(
          start_time: Time.now - 3600,
          end_time: Time.now + 3600,
          product_code: 'gr1',
          products: cart(19).products,
          n: 5
        )
      end

      it 'makes every 5th item free' do
        promotion.calculate_discounts

        expect(promotion.products.count { |p| p[:discounted_price] }).to eq 3
      end
    end
  end
end
