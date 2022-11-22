module Promotion
  def products
    cart.products.select { |p| p.code.downcase == product_code.downcase }
  end

  def active?
    start_time <= Time.now && end_time > Time.now
  end
end
