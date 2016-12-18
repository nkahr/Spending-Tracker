require('pg')
require_relative('../db/sql_runner.rb')

class Transaction

  attr_reader :id 
  attr_accessor :user_id, :merchant_id, :amount, :time, :tag_id

  def initialize(options)
    @id = options["id"].to_i unless options["id"].nil?
    @time = options["time"]
    @user_id = options["user_id"].to_i
    @merchant_id = options["merchant_id"].to_i
    @tag_id = options["tag_id"].to_i #maybe include unless options["tag_id"].nil?
    @amount = options["amount"].to_i
  end

  def save()
    sql = "INSERT INTO transactions (time, user_id, merchant_id, tag_id, amount) VALUES ('#{@time}', #{@user_id}, #{@merchant_id}, #{@tag_id}, #{@amount}) RETURNING *;"
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

  def tag()
    sql ="SELECT * FROM tags WHERE id = #{@tag_id} ;"
    result = SqlRunner.run(sql)[0]
    return Tag.new(result)
  end


  def self.find_by_id(id)
    sql = "SELECT * FROM transactions 
    WHERE id = #{id};"
    result = SqlRunner.run(sql)
    return Transaction.new(result[0])
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM transactions WHERE id = #{id}"
    SqlRunner.run(sql)
  end

  def self.update(options)
    sql = "UPDATE transactions SET 
      amount = '#{options['amount']}',
      tag_id = '#{options['tag_id']}',
      time = '#{options['time']}',
      merchant_id = #{options['merchant_id']},
      user_id = #{options['user_id']}
      WHERE id = #{options['id']};"
    SqlRunner.run(sql)
  end


end