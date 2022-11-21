require './app/promotions'

class PriceCalculator
  attr_accessor :cart, :promotions

  def initialize(cart:)
    @cart = cart
    @promotions = Promotions.new(cart)
  end

  def process
    promotions.calculate_discounts
    cart.total_price = cart.products.sum { |p| p.discounted_price || p.price }
    cart.total_discounts = cart.products.select { |p| p.discounted_price }.sum { |p| p.price - p.discounted_price }
  end
end
