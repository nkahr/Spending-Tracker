require('minitest/autorun')
require('minitest/rg')
require_relative('../user.rb')

class UserSpec < MiniTest::Test

  def test_get_user_attributes()
    user = User.new({"username" => "neens", "funds" => 300})
    assert_equal("neens", user.username())
    assert_equal(300, user.funds())
  end

end