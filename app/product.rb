# frozen_string_literal: true

require 'money'

class Product
  attr_accessor :code, :name, :price

  def initialize(code:, name:, price:)
    @code = code
    @name = name
    @price = Money.from_cents(price, 'EUR')
  end
end
