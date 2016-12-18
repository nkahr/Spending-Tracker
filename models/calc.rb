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

  def self.total_by_id(transactions_array, id)
    selection = transactions_array.find_all{|transaction| transaction.tag_id == id}
    return Calc.total(selection)
  end

end