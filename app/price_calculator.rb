require './app/promotions'

class PriceCalculator
  attr_accessor :cart

  def initialize(cart:)
    @cart = cart
  end

  def process
    reset_discounts

    Promotions::LIST.each do |promotion|
      promotion.calculate_discounts!(cart.products)
    end
    cart.total_price = cart.products.sum { |p| p.discounted_price || p.price }
    cart.total_discounts = cart.products.select { |p| p.discounted_price }.sum { |p| p.price - p.discounted_price }
  end

  def reset_discounts
    cart.products.each { |p| p.discounted_price = nil }
  end
end
