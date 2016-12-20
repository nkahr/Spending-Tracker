class StandingOrder

  attr_accessor :id, :first_payment, :times_paid, :user_id, :merchant_id, :tag_id, :amount, :note

  def initialize(options)
    @id = options["id"].to_i unless options["id"].nil?
    @first_payment = options["first_payment"]
    @times_paid = options["times_paid"].to_i #defaults to zero 
    @user_id = options["user_id"].to_i
    @merchant_id = options["merchant_id"].to_i
    @tag_id = options["tag_id"].to_i #maybe include unless options["tag_id"].nil?
    @amount = options["amount"].to_f
    @note = options["note"].nil? ? "" : options["note"]
  end

  def save()
    sql = "INSERT INTO standing_orders (first_payment, user_id, merchant_id, tag_id, amount, note) VALUES ('#{@first_payment}', #{@user_id}, #{@merchant_id}, #{@tag_id}, #{@amount}, '#{@note}') RETURNING *;"
    result = SqlRunner.run(sql)
    @id = result[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM standing_orders;"
    return StandingOrder.get_all(sql)
  end

  def self.get_all(sql)
    result = SqlRunner.run(sql)
    return result.map{|standing_order| StandingOrder.new(standing_order)}
  end

  def update()
    sql = "UPDATE standing_orders SET
    note = '#{@note}',
    amount = #{@amount}, 
    first_payment = '#{@first_payment}',
    user_id = #{@user_id},
    merchant_id = #{@merchant_id},
    tag_id = #{@tag_id},
    times_paid = #{@times_paid}
    WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

end