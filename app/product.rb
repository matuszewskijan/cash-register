# frozen_string_literal: true

require 'money'

Money.locale_backend = nil

class Product
  attr_accessor :code, :name, :price, :discounted_price

  def initialize(code:, name:, price:)
    @code = code
    @name = name
    @price = price
  end

  def format(without_price: false)
    if without_price
      "#{name} (#{code})"
    else
      "#{name} - #{Money.from_cents(discounted_price || price, 'EUR').format}"
    end
  end
end
