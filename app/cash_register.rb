require './app/cash_register_cli'

puts 'Hello to Cash Register!'
puts '`help` will show you all available commands'
puts 'Currently available products are:'
puts CashRegisterCLI::PRODUCTS
puts CashRegisterCLI.new.help

while true
  CashRegisterCLI.new.prompt('> ')
end
