# frozen_string_literal: true

require './app/inventory/product'

module Products
  LIST = [
    Product.new(code: 'GR1', name: 'Green Tea', price: 311),
    Product.new(code: 'SR1', name: 'Strawberries', price: 500),
    Product.new(code: 'CF1', name:	'Coffee', price: 1123)
  ].freeze

  def self.find(code)
    code = code.downcase

    Products::LIST.find { |p| p.code.downcase == code }
  end
end
