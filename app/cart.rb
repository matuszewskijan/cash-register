# frozen_string_literal: true

require './app/products'

class Cart
  attr_accessor :products, :promotions
  attr_writer :total_price, :total_discounts

  def initialize
    @products = []
    @price = 0
  end

  def calculate_price
    @products.sum { |p| p[:discounted_price] || p[:price] }
  end

  def add_product(code, amount = 1)
    product = Products.find(code)

    return 'Unkown product' unless product

    amount.times do
      products << product.clone # Without `clone` all products will be the same object in memory
    end
  end

  def remove_product(code, amount = 1)
    product = Products.find(code)

    return 'Unkown product' unless product

    amount.times do
      index = products.find_index { |p| p.code == product.code }
      products.delete_at(index) if index
    end
  end

  def total_price
    @total_price.round(2)
  end

  def total_discounts
    @total_discounts.round(2)
  end
end
