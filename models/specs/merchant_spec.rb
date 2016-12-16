require('minitest/autorun')
require('minitest/rg')
require_relative('../merchant.rb')

class MerchantSpec < MiniTest::Test

  def test_get_merchant_attributes()
    merchant = Merchant.new({"name" => "Tesco"})
    assert_equal("Tesco", merchant.name())
  end

end