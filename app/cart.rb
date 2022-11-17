# frozen_string_literal: true

PRODUCTS = [
  {
    code: 'GR1',
    name:	'Green Tea',
    price: 3.11
  },
  {
    code: 'SR1',
    name:	'Strawberries',
    price: 5.00
  },
  {
    code: 'CF1',
    name:	'Coffee',
    price: 11.23
  }
].freeze

class Cart
  attr_accessor :products

  def initialize
    @products = []
  end

  def add_product(name, amount = 1)
    product = PRODUCTS.find { |p| p[:name].downcase == name.downcase || p[:code].downcase == name.downcase }

    return 'Unkown product' unless product

    amount.times do
      products << product
    end
  end
end
