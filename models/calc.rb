require_relative('transaction.rb')
require_relative('merchant.rb')
require_relative('user.rb')
require('pg')

class Calc

  def initialize()
  end

  def self.total(transactions_array)
   total = transactions_array.inject(0){|sum, transaction| sum += transaction.amount()}
   return total
  end

end