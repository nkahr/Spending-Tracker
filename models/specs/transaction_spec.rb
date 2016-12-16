require('minitest/autorun')
require('minitest/rg')
require_relative('../transaction.rb')
require_relative('../merchant.rb')
require_relative('../user.rb')

class TransactionSpec < MiniTest::Test

  def test_get_transaction_attributes()
    merchant = Merchant.new({"id" => 2, "name" => "Tesco"})
    user = User.new({"id" => 4, "username" => "neens", "funds" => 300})
    transaction = Transaction.new({"merchant_id" => merchant.id(), "user_id" => user.id(), "amount" => 20})
    assert_equal(2, transaction.merchant_id())
    assert_equal(4, transaction.user_id())

  end

end