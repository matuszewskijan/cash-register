require './app/cash_register_cli'
require './app/cart'

puts 'Hello to Cash Register!'
puts '`help` will show you all available commands'
puts 'Currently available products are:'

cart = Cart.new
cli = CashRegisterCLI.new(cart:)

puts CashRegisterCLI::PRODUCTS
puts cli.help

while true
  cli.prompt('> ')
end
