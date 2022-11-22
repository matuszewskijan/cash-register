# frozen_string_literal: true

require './app/promotions/promotion'

class FlatPriceDiscount
  include Promotion

  attr_accessor :start_time, :end_time, :n, :discounted_price, :product_code

  # NOTE: All products after buying N products will have different price
  def initialize(start_time:, end_time:, product_code:, n:, discounted_price:)
    @start_time = start_time
    @end_time = end_time
    @n = n
    @discounted_price = discounted_price
    @product_code = product_code
  end

  def calculate_discounts!(cart_products)
    return unless active?

    products = select_products(cart_products)

    return unless products.length >= n

    products.each { |p| p.discounted_price = discounted_price }
  end
end
