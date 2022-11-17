class CashRegisterCLI
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
  ]

  def prompt(label)
    print(label)
    value = gets.chomp

    send(value.to_sym)
  end

  def help
    puts 'Available commands are:'
    puts '`exit`'
  end

  def method_missing(name, *args, &block)
    super
  rescue NoMethodError
    puts "Unkown method: #{name}"
  end
end
