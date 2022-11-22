# frozen_string_literal: true

require './app/promotions/promotion'

class NThFree
  include Promotion

  attr_accessor :start_time, :end_time, :n, :product_code

  # NOTE: Every n-th product will be free
  def initialize(start_time:, end_time:, product_code:, n:)
    @start_time = start_time
    @end_time = end_time
    @n = n
    @product_code = product_code
  end

  def calculate_discounts!(cart_products)
    return unless active?

    products = select_products(cart_products)

    return if n == 1 # It'd make all items free, I am not sure if that makes any sense

    (products.length / n).times do |i|
      products[(n * i) + 1].discounted_price = 0
    end
  end
end
