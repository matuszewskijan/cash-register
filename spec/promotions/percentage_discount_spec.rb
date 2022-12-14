# frozen_string_literal: true

require 'spec_helper'
require './app/promotions/percentage_discount'
require './app/cart'

RSpec.describe PercentageDiscount do
  def cart(product_amount = 1)
    cart = Cart.new
    cart.add_product('CF1', product_amount)
    cart
  end

  let(:product_code) { 'cf1' }

  describe '#active?' do
    context 'when start date is after current time' do
      let(:promotion) do
        described_class.new(
          start_time: Time.now + 10, end_time: Time.now + 20, product_code:, n: 2, discount: 33
        )
      end

      it 'return false' do
        expect(promotion.active?).to eq false
      end
    end

    context 'when end date is before current time' do
      let(:promotion) do
        described_class.new(
          start_time: Time.now - 30, end_time: Time.now - 20, product_code:, n: 2, discount: 33
        )
      end

      it 'return false' do
        expect(promotion.active?).to eq false
      end
    end

    context 'when current time is between start and end time' do
      let(:promotion) do
        described_class.new(
          start_time: Time.now - 10, end_time: Time.now + 10, product_code:, n: 2, discount: 33
        )
      end

      it 'return true' do
        expect(promotion.active?).to eq true
      end
    end
  end

  describe '#calculate_discounts' do
    let(:current_cart) { cart(5) }
    let(:promotion) do
      described_class.new(
        start_time: Time.now - 3600,
        end_time: Time.now + 3600,
        product_code: 'cf1',
        n: 1,
        discount: 33
      )
    end

    context 'when n is smaller or equal to products count' do
      let(:current_cart) { cart(5) }
      let(:promotion) do
        described_class.new(
          start_time: Time.now - 3600,
          end_time: Time.now + 3600,
          product_code: 'cf1',
          n: 5,
          discount: 33
        )
      end

      it 'sets new discounted price on all items' do
        promotion.calculate_discounts!(current_cart.products)

        expect(current_cart.products.all? { |p| p.price > p.discounted_price }).to eq true
      end

      it 'calculates proper discounted price' do
        promotion.calculate_discounts!(current_cart.products)

        expect(current_cart.products[0].discounted_price).to eq current_cart.products[0].price * 0.67
      end
    end

    context 'when n is greater than products count' do
      let(:current_cart) { cart(3) }
      let(:promotion) do
        described_class.new(
          start_time: Time.now - 3600,
          end_time: Time.now + 3600,
          product_code: 'cf1',
          n: 4,
          discount: 33
        )
      end

      it 'does not change products' do
        expect { promotion.calculate_discounts!(current_cart.products) }.not_to change { current_cart.products }
      end
    end
  end
end
