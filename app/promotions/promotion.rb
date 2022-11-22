module Promotion
  def select_products(cart_products)
    cart_products.select { |p| p.code.downcase == product_code.downcase }
  end

  def active?
    start_time <= Time.now && end_time > Time.now
  end
end
