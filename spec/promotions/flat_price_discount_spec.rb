# frozen_string_literal: true

require 'spec_helper'
require './app/promotions/flat_price_discount'
require './app/cart'

RSpec.describe FlatPriceDiscount do
  def cart(product_amount = 1)
    cart = Cart.new
    cart.add_product('SR1', product_amount)
    cart
  end

  describe '#active?' do
    context 'when start date is after current time' do
      let(:promotion) do
        described_class.new(
          start_time: Time.now + 10, end_time: Time.now + 20, product_code: '', n: 2, discounted_price: 4.5
        )
      end

      it 'return false' do
        expect(promotion.active?).to eq false
      end
    end

    context 'when end date is before current time' do
      let(:promotion) do
        described_class.new(
          start_time: Time.now - 30, end_time: Time.now - 20, product_code: '', n: 2, discounted_price: 4.5
        )
      end

      it 'return false' do
        expect(promotion.active?).to eq false
      end
    end

    context 'when current time is between start and end time' do
      let(:promotion) do
        described_class.new(
          start_time: Time.now - 10,end_time: Time.now + 10, product_code: '', n: 2, discounted_price: 4.5
        )
      end

      it 'return true' do
        expect(promotion.active?).to eq true
      end
    end
  end

  describe '#calculate_discounts!' do
    let(:promotion) do
      described_class.new(
        start_time: Time.now - 3600,
        end_time: Time.now + 3600,
        product_code: 'sR1',
        cart: cart(5),
        n: 1,
        discounted_price: 4.5
      )
    end

    context 'when n is smaller or equal to products count' do
      let(:current_cart) { cart(5) }

      let(:promotion) do
        described_class.new(
          start_time: Time.now - 3600,
          end_time: Time.now + 3600,
          product_code: 'sR1',
          n: 5,
          discounted_price: 4.5
        )
      end

      it 'sets new discounted price on all items' do
        promotion.calculate_discounts!(current_cart.products)

        expect(current_cart.products.all? { |p| p.discounted_price == 4.5}).to eq true
      end
    end

    context 'when n is greater than products count' do
      let(:current_cart) { cart(3) }

      let(:promotion) do
        described_class.new(
          start_time: Time.now - 3600,
          end_time: Time.now + 3600,
          product_code: 'sR1',
          n: 4,
          discounted_price: 4.5
        )
      end

      it 'does not change products' do
        promotion.calculate_discounts!(current_cart.products)


        expect(current_cart.products.all? { |p| p.discounted_price == nil}).to eq true
      end
    end
  end
end
