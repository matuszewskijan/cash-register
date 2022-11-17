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
    product = find_product(name)

    return 'Unkown product' unless product

    amount.times do
      products << product
    end
  end

  private

  def find_product(name)
    name = name.downcase

    PRODUCTS.find { |p| p[:name].downcase == name || p[:code].downcase == name }
  end
end
