require_relative('transaction.rb')
require_relative('merchant.rb')
require_relative('user.rb')
require_relative('../db/sql_runner.rb')
require('pg')
require ('date')

class Calc

  def self.total(transactions_array)
   total = transactions_array.inject(0){|sum, transaction| sum += transaction.amount()}
   return total.round(2)
  end

  def self.total_by_id(transactions_array, id)
    selection = transactions_array.find_all{|transaction| transaction.tag_id == id}
    return Calc.total(selection).round(2)
  end

  def self.sort_by(attribute, transactions_array)
    case attribute
    when "amount_asc"
      transactions_array.sort!{|transaction1, transaction2| transaction1.amount <=> transaction2.amount}
    when "amount_desc"
      transactions_array.sort!{|transaction1, transaction2| transaction2.amount <=> transaction1.amount}
    when "date"
      transactions_array.sort!{|transaction1, transaction2| Date.parse(transaction1.time) <=> Date.parse(transaction2.time)}
    end
    return transactions_array
  end

  def self.group_by_month(transactions_array)
    dates = transactions_array.map{|transaction| Date.parse(transaction.time)}
    dates_by_year = dates.group_by(&:year)
    dates_by_month = Hash[dates_by_year.map{|year, date| [year, date.group_by{|date| date.month}]}]
    return dates_by_month
  end

  def self.find_by_month(transactions_array, month, year)
    transactions_by_month = transactions_array.find_all{|t| t.time.include?("#{year}-#{month}")}
    return transactions_by_month
  end

  def self.amount_spent_this_month(user)
    today = Time.new.to_s.split(" ").first.split("-")
    year = today[0].to_i
    month = today[1].to_i
    t_this_month = Calc.find_by_month(user.transactions, month, year) #returns all transactions in current month
    total_spent = t_this_month.inject(0){|sum, transaction| sum += transaction.amount()}
    return total_spent.round(2)
  end

  def self.percentage_of_limit_spent(user)
    total = Calc.amount_spent_this_month(user)
    limit = user.monthly_limit
    percentage = total.to_f/limit.to_f * 100.0
    return percentage.round(1)
  end

  #checks whether user has visited and updates funds by monthly_income depending on how many months it has been
  def self.has_visited_this_month?(user, date, pay_day) #time object
    day_inc = pay_day - 1
    date -= (day_inc*24*60*60) 
    user_id = user.id
    sql = "SELECT * FROM visits WHERE id = (SELECT MAX(id) FROM visits) AND user_id = #{user_id};"
    result = SqlRunner.run(sql)
    unless result.ntuples == 0
      last_date = Date.parse(result[0]["date"])
      months = (date.year * 12 + date.month) - (last_date.year * 12 + last_date.month)
      return true if months == 0 
      user.add_funds(months*user.monthly_income)
    end
    sql2 = "INSERT INTO visits (date, user_id) VALUES ('#{date.to_s.split(" ").first}', #{user_id})"
    SqlRunner.run(sql2)
  end

  def self.spending_per_day(user)
    transactions = user.transactions
    data = []
    Date::DAYNAMES.each do |day|
      t_in_day = transactions.find_all{|t| Date.parse(t.time).strftime("%A") == day}
      total_in_day = t_in_day.inject(0){|sum, t| sum += t.amount}
      data.push(total_in_day.round(2))
    end
    return data
  end


end