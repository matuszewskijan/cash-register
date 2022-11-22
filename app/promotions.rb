# frozen_string_literal: true

Dir['./app/promotions/*.rb'].each { |file| require file }

class Promotions
  attr_accessor :cart, :promotions

  LIST = [
    NThFree.new(
      start_time: Time.now,
      end_time: Time.now + 3600,
      product_code: 'GR1',
      n: 2
    ),
    FlatPriceDiscount.new(
      start_time: Time.now,
      end_time: Time.now + 3600,
      product_code: 'SR1',
      n: 3,
      discounted_price: 4.5
    ),
    PercentageDiscount.new(
      start_time: Time.now,
      end_time: Time.now + 3600,
      product_code: 'CF1',
      n: 5,
      discount: 10
    )
  ].freeze

  def self.calculate_discounts(cart_products)
    promotions.each { |p| p.calculate_discounts(cart_products) }
  end
end
