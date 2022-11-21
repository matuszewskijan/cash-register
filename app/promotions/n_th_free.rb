class NThFree
  attr_accessor :start_time, :end_time, :n, :cart, :product_code

  # NOTE: Every n-th product will be free
  def initialize(start_time:, end_time:, product_code:, n:, cart:)
    @start_time = start_time
    @end_time = end_time
    @cart = cart
    @n = n
    @product_code = product_code
  end

  def products
    cart.products.select { |p| p[:code].downcase == product_code.downcase }
  end

  def active?
    start_time <= Time.now && end_time > Time.now
  end

  def calculate_discounts
    return if n == 1 # It'd make all items free, I am not sure if that makes any sense

    (products.length / n).times do |i|
      products[(n * i) + 1][:discounted_price] = 0
    end
  end
end
