require './app/cash_register_cli'
require './app/cart'

puts 'Hello to Cash Register!'

cart = Cart.new(currency: 'EUR')
cli = CashRegisterCLI.new(cart)

puts cli.help
puts 'Currently available products are:'
puts cli.list

while true
  puts cli.prompt('> ')
end
