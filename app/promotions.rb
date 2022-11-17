# frozen_string_literal: true

Dir["./app/promotions/*.rb"].each {|file| require file }

class Promotions
  attr_accessor :cart, :promotions

  def initialize(cart)
    @cart = cart
    @promotions = [
      NThFree.new(
        start_time: Time.now,
        end_time: Time.now + 3600,
        product_code: 'GR1',
        products: cart.products,
        n: 2
      ),
      FlatPriceDiscount.new(
        start_time: Time.now,
        end_time: Time.now + 3600,
        product_code: 'SR1',
        products: cart.products,
        n: 3,
        discounted_price: 4.5
      ),
      PercentageDiscount.new(
        start_time: Time.now,
        end_time: Time.now + 3600,
        product_code: 'CF1',
        products: cart.products,
        n: 5,
        discount: 10
      )
    ]
  end

  def calculate_discounts
    promotions.select(&:active?).each(&:calculate_discounts)
    @cart.products = promotions.flat_map(&:products)
  end
end
