require('minitest/autorun')
require('minitest/rg')
require_relative('../merchant.rb')
require_relative('../user.rb')
require_relative('../tag.rb')
require_relative('../calc.rb')

class CalcSpec < MiniTest::Test

  def setup
    @user = User.new({
      "username" => "nina",
      "funds" => 700.0, 
      "monthly_limit" => 300.0,
      "monthly_income" => 1000.0
      })

    @merchant = Merchant.new({"name" => "Starbucks"})

    @tag1 = Tag.new({"label" => "Coffee"})
    @tag2 = Tag.new({"label" => "Food"})

    today = Time.new.to_s.split(" ").first

    @transaction1 = Transaction.new({
      "merchant_id" => 1, 
      "user_id" => 1, 
      "time" => today,
      "amount" => 7,
      "tag_id" => 2
      })

    @transaction2 = Transaction.new({
      "merchant_id" => 1, 
      "user_id" => 1, 
      "time" => "2016-12-12",
      "amount" => 4.99,
      "tag_id" => 1
      })

    @transaction3 = Transaction.new({
      "merchant_id" => 1, 
      "user_id" => 1, 
      "time" => "2016-12-17",
      "amount" => 5,
      "tag_id" => 1
      })

    @transactions = [@transaction1, @transaction2, @transaction3]
  end

  def test_total()
    total = Calc.total(@transactions)
    assert_equal(16.99, total)
  end

  def test_total_by_id()
    total = Calc.total_by_id(@transactions, 1)
    assert_equal(9.99, total)
  end

  def test_sort_by_amount_asc()
    sorted = Calc.sort_by("amount_asc", @transactions)
    expected = [@transaction2, @transaction3, @transaction1]
    assert_equal(expected, sorted)
  end

  def test_sort_by_amount_desc()
    sorted = Calc.sort_by("amount_desc", @transactions)
    expected = [@transaction1, @transaction3, @transaction2]
    assert_equal(expected, sorted)
  end

  def test_sort_by_date()
    sorted = Calc.sort_by("date", @transactions)
    expected = [@transaction1, @transaction3, @transaction2]
    assert_equal(expected, sorted)
  end

  def test_group_by_month()
    expected = {2016 => {12 => [Date.parse(@transaction1.time), Date.parse(@transaction2.time), Date.parse(@transaction3.time)]}}
    assert_equal(expected, Calc.group_by_month(@transactions))
  end

  def test_find_by_month()
    result = Calc.find_by_month(@transactions, 12, 2016)
    assert_equal(@transactions, result)
  end

  def test_ordinalise()
    assert_equal("3rd", Calc.ordinalise(3))
    assert_equal("22nd", Calc.ordinalise(22))
    assert_equal("31st", Calc.ordinalise(31))
    assert_equal("17th", Calc.ordinalise(17))
  end

end