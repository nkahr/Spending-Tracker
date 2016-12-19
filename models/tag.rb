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

  def self.find_by_id(id)
    sql = "SELECT * FROM tags 
    WHERE id = #{id};"
    result = SqlRunner.run(sql)
    return Tag.new(result[0])
  end

  def self.sort()
    tags = Tag.all()
    tags.sort!{|tag1, tag2| tag1.label <=> tag2.label}
    return tags
  end

end