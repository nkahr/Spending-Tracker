require('pg')
require_relative('../db/sql_runner.rb')

class Transaction

  attr_reader :id 
  attr_accessor :user_id, :merchant_id, :amount

  def initialize(options)
    @id = options["id"].to_i unless options["id"].nil?
    @user_id = options["user_id"]
    @merchant_id = options["merchant_id"]
    @amount = options["amount"].to_i
  end

  def save()
    sql = "INSERT INTO transactions (user_id, merchant_id, amount) VALUES (#{@user_id}, #{@merchant_id}, #{@amount}) RETURNING *;"
    result = SqlRunner.run(sql)
    @id = result[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM transactions;"
    return Transaction.get_all(sql)
  end

  def self.get_all(sql)
    result = SqlRunner.run(sql)
    return result.map{|transaction| Transaction.new(transaction)}
  end

  def merchant()
    sql ="SELECT * FROM merchants WHERE id = #{@merchant_id} ;"
    result = SqlRunner.run(sql)[0]
    return Merchant.new(result)
  end

end