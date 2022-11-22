# frozen_string_literal: true

require 'money'
require './app/inventory/products'

class Cart
  attr_accessor :products, :currency
  attr_writer :total_price, :total_discounts

  def initialize(currency: 'EUR', products: [], total_price: 0, total_discounts: 0)
    @products = products
    @currency = currency
    @total_price = total_price
    @total_discounts = total_discounts
  end

  def reset!
    @products = []
    @total_price = 0
    @total_discounts = 0
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
    Money.from_cents(@total_price, currency).format
  end

  def total_discounts
    Money.from_cents(@total_discounts, currency).format
  end
end
