# frozen_string_literal: true

require './app/products'
require './app/price_calculator'

class CashRegisterCLI
  attr_accessor :cart, :price_calculator

  def initialize(cart)
    @cart = cart
    @price_calculator = PriceCalculator.new(cart:)
  end

  def prompt(command)
    value = command.split

    return if value.length == 0

    if value.length == 1
      send(value[0].to_sym)
    else
      send(value[0].to_sym, *value[1..])
    end
  end

  def help
    <<~HELP
      Available commands are:
      `help`: display all commands
      `exit`
      `list`: display list with all available products
      `add CODE AMOUNT`: amount could be skipped if only one added, eg. `add strawberries 4`
      `total`: see what is already added to cart
    HELP
  end

  def list
    Products::LIST.map { |p| p.format(without_price: true) }
  end

  def add(name, amount = 1)
    @cart.add_product(name, amount.to_i)
    price_calculator.process
    total
  end

  def total
    products = @cart.products.map(&:format).join("\n")

    "#{products}\nTotal amount: #{@cart.total_price}. Discount amount: #{@cart.total_discounts}."
  end

  def method_missing(name, *args, &block)
    super
  rescue NoMethodError
    puts "Unkown method: #{name}"
  end
end
