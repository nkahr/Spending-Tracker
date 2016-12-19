require('pg')
require_relative('../db/sql_runner.rb')

class Merchant

  attr_reader :id, :name

  def initialize(options)
    @id = options["id"].to_i unless options["id"].nil?
    @name = options["name"]
  end

  def save()
    sql = "INSERT INTO merchants (name) VALUES ('#{@name}') RETURNING *;"
    result = SqlRunner.run(sql)
    @id = result[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM merchants;"
    return Merchant.get_all(sql)
  end

  def self.get_all(sql)
    result = SqlRunner.run(sql)
    return result.map{|merchant| Merchant.new(merchant)}
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM merchants 
    WHERE id = #{id};"
    result = SqlRunner.run(sql)
    return Merchant.new(result[0])
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM merchants WHERE id = #{id}"
    SqlRunner.run(sql)
  end

  def self.sort() #make drop down menu alphabetical
    merchants = Merchant.all()
    merchants.sort!{|merchant1, merchant2| merchant1.name <=> merchant2.name}
    return merchants
  end

end