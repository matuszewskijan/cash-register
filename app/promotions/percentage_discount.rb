class PercentageDiscount
  attr_accessor :start_time, :end_time, :n, :products, :discount

  # NOTE: All products after buying N products will have different price
  def initialize(start_time:, end_time:, product_code:, n:, products:, discount:)
    @start_time = start_time
    @end_time = end_time
    @products = products.select { |p| p[:code].downcase == product_code.downcase }
    @n = n
    @discount = discount
  end

  def active?
    start_time <= Time.now && end_time > Time.now
  end

  def calculate_discounts
    return unless products.length >= n

    products.each { |p| p[:discounted_price] = p[:price] * ((100 - discount) / 100.0) }
  end
end