require('pg')
require_relative('../db/sql_runner.rb')
require_relative('transaction.rb')

class User

  attr_reader :id 
  attr_accessor :username, :funds, :monthly_limit

  def initialize(options)
    @id = options["id"].to_i unless options["id"].nil?
    @username = options["username"]
    @funds = options["funds"].to_i #becomes zero if no funds are included 
    @monthly_limit = options["monthly_limit"].to_i unless options["monthly_limit"].nil?
  end

  def save()
    sql_check = "SELECT * FROM users WHERE username = '#{@username}';"
    result_check = SqlRunner.run(sql_check)
    binding.pry
    return "This username already exists in the database" unless result_check.ntuples == 0
    sql = "INSERT INTO users (username, funds, monthly_limit) VALUES ('#{@username}', #{@funds}, #{@monthly_limit}) RETURNING *;"
    result = SqlRunner.run(sql)
    @id = result[0]["id"].to_i
    return nil
  end

  def self.all()
    sql = "SELECT * FROM users;"
    return User.get_all(sql)
  end

  def self.get_all(sql)
    result = SqlRunner.run(sql)
    return result.map{|user| User.new(user)}
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM users 
    WHERE id = #{id};"
    result = SqlRunner.run(sql)
    return User.new(result[0])
  end

  def self.delete_all()
    sql = "DELETE FROM users"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM users WHERE id = #{id}"
    SqlRunner.run(sql)
  end

  def self.update(options)
    sql = "UPDATE TABLE users SET
    username = '#{options["username"]}',
    funds = '#{options["funds"]}', 
    monthly_limit = #{options["monthly_limit"]}
    WHERE id = #{params["id"]};"
    SqlRunner.run(sql)
  end

  def transactions()
    sql = "SELECT * FROM transactions WHERE user_id = #{@id};"
    result = SqlRunner.run(sql)
    return result.map{|transaction| Transaction.new(transaction)}
  end

  def total()
   sql = "SELECT * FROM transactions WHERE user_id = #{@id};"
   result = SqlRunner.run(sql)
   transactions = result.map{|transaction| Transaction.new(transaction)}
   sum = 0
   for transaction in transactions 
    sum += transaction.amount()
   end
   return sum
  end

  def total_by_tag(tag_id)
    sql = "SELECT * FROM transactions WHERE user_id = #{@id} AND tag_id = #{tag_id};"
    result = SqlRunner.run(sql)
    transactions = result.map{|transaction| Transaction.new(transaction)}
    sum = 0
    for transaction in transactions 
     sum += transaction.amount()
    end
    return sum
  end

end