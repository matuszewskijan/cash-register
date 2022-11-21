# frozen_string_literal: true

require 'spec_helper'
require './app/promotions/n_th_free'
require './app/cart'

RSpec.describe NThFree do
  def cart(product_amount = 1)
    cart = Cart.new
    cart.add_product('GR1', product_amount)
    cart
  end

  describe '#active?' do
    context 'when start date is after current time' do
      let(:promotion) do
        described_class.new(start_time: Time.now + 10,end_time: Time.now + 20, product_code: '', cart:, n: 2)
      end

      it 'return false' do
        expect(promotion.active?).to eq false
      end
    end

    context 'when end date is before current time' do
      let(:promotion) do
        described_class.new(start_time: Time.now - 30, end_time: Time.now - 20, product_code: '', cart:, n: 2)
      end

      it 'return false' do
        expect(promotion.active?).to eq false
      end
    end

    context 'when current time is between start and end time' do
      let(:promotion) do
        described_class.new(start_time: Time.now - 10, end_time: Time.now + 10, product_code: '', cart:, n: 2)
      end

      it 'return true' do
        expect(promotion.active?).to eq true
      end
    end
  end

  describe '#calculate_discounts' do
    let(:promotion) do
      described_class.new(
        start_time: Time.now - 3600,
        end_time: Time.now + 3600,
        product_code: 'gr1',
        cart: cart(5),
        n: 1
      )
    end

    context 'when n equals 1' do
      it 'does not change anything' do
        expect { promotion.calculate_discounts }.not_to change { promotion.products }
      end
    end

    context 'when n equals 2' do
      let(:promotion) do
        described_class.new(
          start_time: Time.now - 3600,
          end_time: Time.now + 3600,
          product_code: 'gr1',
          cart: cart(5),
          n: 2
        )
      end

      it 'makes every 2nd item free' do
        promotion.calculate_discounts

        expect(promotion.products.select { |p| p.discounted_price }.length).to eq 2
      end
    end

    context 'when n equals 5' do
      let(:promotion) do
        described_class.new(
          start_time: Time.now - 3600,
          end_time: Time.now + 3600,
          product_code: 'gr1',
          cart: cart(19),
          n: 5
        )
      end

      it 'makes every 5th item free' do
        promotion.calculate_discounts

        expect(promotion.products.count { |p| p.discounted_price }).to eq 3
      end
    end
  end
end
