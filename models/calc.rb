require_relative('transaction.rb')
require_relative('merchant.rb')
require_relative('user.rb')
require('pg')
require 'date'

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

  def self.sort_by_amount_asc(transactions_array)
    transactions_array.sort!{|transaction1, transaction2| transaction1.amount <=> transaction2.amount}
    return transactions_array
  end

  def self.sort_by_amount_desc(transactions_array)
    transactions_array.sort!{|transaction1, transaction2| transaction2.amount <=> transaction1.amount}
    return transactions_array
  end

  def self.sort_by_date(transactions_array)
    transactions_array.sort!{|transaction1, transaction2| Date.parse(transaction1.time) <=> Date.parse(transaction2.time)}
    return transactions_array
  end

  def self.group_by_month(transactions_array)
    dates = transactions_array.map{|transaction| Date.parse(transaction.time)}
    dates_by_year = dates.group_by(&:year)
    dates_by_month = dates_by_year.map{|year, date| [year, date.group_by{|date| date.month}]}
    return dates_by_month
  end

end