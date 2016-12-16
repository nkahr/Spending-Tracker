require_relative('../db/sql_runner.rb')
class Tag 

  attr_reader :id
  attr_accessor :label

  def initialize(options)
    @id = options["id"].to_i unless options["id"].nil? #nil if no tag is given 
    @label = options["label"]
  end

  def save()
    sql = "INSERT INTO tags (label) VALUES ('#{@label}') RETURNING *;"
    result = SqlRunner.run(sql)
    @id = result[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM tags;"
    return Tag.get_all(sql)
  end

  def self.get_all(sql)
    result = SqlRunner.run(sql)
    return result.map{|tag| Tag.new(tag)}
  end


end