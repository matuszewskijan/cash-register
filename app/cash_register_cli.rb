class CashRegisterCLI
  attr_accessor :basket

  def initialize(cart)
    @cart = cart
  end

  def prompt(label)
    print(label)
    value = gets.chomp.split

    if value.length == 1
      send(value[0].to_sym)
    else
      send(value[0].to_sym, *value[1..])
    end
  end

  def help
    puts 'Available commands are:'
    puts '`exit`'
    puts '`add CODE|NAME AMOUNT`: amount could be skipped if only one added'
  end

  def add(name, amount = 1)
    @cart.add_product(name, amount)
  end

  def method_missing(name, *args, &block)
    super
  rescue NoMethodError
    puts "Unkown method: #{name}"
  end
end
