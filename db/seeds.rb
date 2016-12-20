require_relative('../models/merchant.rb')
require_relative('../models/user.rb')
require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/calc.rb')
require_relative('../models/chart.rb')

require('pry')

User.delete_all()

user1 = User.new({
  "username" => "nina",
  "funds" => 700.0, 
  "monthly_limit" => 300.0,
  "monthly_income" => 1000.0
  })
user1.save()

user2 = User.new({
  "username" => "ollie",
  "funds" => 23000.0,
  "monthly_limit" => 500.0,
  "monthly_income" => 3000.0
  })
user2.save()

merchant1 = Merchant.new({"name" => "Chanter"})
merchant1.save()
merchant2 = Merchant.new({"name" => "Taquito"})
merchant2.save()
merchant3 = Merchant.new({"name" => "Tesco"})
merchant3.save()
merchant4 = Merchant.new({"name" => "Trainline"})
merchant4.save()
merchant5 = Merchant.new({"name" => "IKEA"})
merchant5.save()
merchant6 = Merchant.new({"name" => "EasyJet"})
merchant6.save()
merchant7 = Merchant.new({"name" => "Cameo Cinema"})
merchant7.save()
merchant8 = Merchant.new({"name" => "Lidl"})
merchant8.save()
merchant9 = Merchant.new({"name" => "Starbucks"})
merchant9.save()

tag1 = Tag.new({"label" => "Food"})
tag1.save()
tag2 = Tag.new({"label" => "Drink"})
tag2.save()
tag3 = Tag.new({"label" => "Coffee"})
tag3.save()
tag4 = Tag.new({"label" => "Travel"})
tag4.save()
tag5 = Tag.new({"label" => "Entertainment"})
tag5.save()
tag6 = Tag.new({"label" => "Home"})
tag6.save()

today = Time.new.to_s.split(" ").first

# transaction1 = Transaction.new({
#   "merchant_id" => merchant1.id, 
#   "user_id" => user1.id, 
#   "time" => today,
#   "amount" => 19.99,
#   "tag_id" => tag2.id()
#   })
# transaction1.save()

# transaction2 = Transaction.new({
#   "merchant_id" => merchant3.id, 
#   "user_id" => user1.id, 
#   "time" => today,
#   "amount" => 10.0,
#   "tag_id" => tag1.id()
#   })
# transaction2.save()

# transaction3 = Transaction.new({
#   "merchant_id" => merchant4.id, 
#   "user_id" => user1.id, 
#   "time" => today,
#   "amount" => 5.50,
#   "tag_id" => tag3.id()
#   })
# transaction3.save()

# transaction4 = Transaction.new({
#   "merchant_id" => merchant1.id, 
#   "user_id" => user2.id, 
#   "time" => today,
#   "amount" => 15.29,
#   "tag_id" => tag1.id()
#   })
# transaction4.save()

# transaction4 = Transaction.new({
#   "merchant_id" => merchant2.id, 
#   "time" => today,
#   "user_id" => user2.id, 
#   "amount" => 8, 
#   "tag_id" => tag1.id()
#   })
# transaction4.save()

#StandingOrder.new({"first_payment" => "2016-9-11", "times_paid" => 1, "user_id" => 3, "merchant_id" => 1, "tag_id" => 1, "amount" => 33, "note" => "standing order test" })



binding.pry
nil