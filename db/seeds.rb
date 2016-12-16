require_relative('../models/merchant.rb')
require_relative('../models/user.rb')
require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require('pry')

user1 = User.new({
  "username" => "nina",
  "funds" => 300
  })
user1.save()

user2 = User.new({
  "username" => "ollie",
  "funds" => 23000
  })
user2.save()

merchant1 = Merchant.new({
  "name" => "Footlights"
  })
merchant1.save()

merchant2 = Merchant.new({
  "name" => "Taquito"
  })
merchant2.save()

merchant3 = Merchant.new({
  "name" => "Tesco"
  })
merchant3.save()

merchant4 = Merchant.new({
  "name" => "Jeelie Piece"
  })
merchant4.save()

tag1 = Tag.new({
  "label" => "Food"
  })
tag1.save()

tag2 = Tag.new({
  "label" => "Booze"
  })
tag2.save()

tag3 = Tag.new({
  "label" => "Coffee"
  })
tag3.save()

today = Time.new.to_s.split(" ").first

transaction1 = Transaction.new({
  "merchant_id" => merchant1.id, 
  "user_id" => user1.id, 
  "time" => today,
  "amount" => 30,
  "tag_id" => tag2.id()
  })
transaction1.save()

transaction2 = Transaction.new({
  "merchant_id" => merchant3.id, 
  "user_id" => user1.id, 
  "time" => today,
  "amount" => 10,
  "tag_id" => tag1.id()
  })
transaction2.save()

transaction3 = Transaction.new({
  "merchant_id" => merchant4.id, 
  "user_id" => user1.id, 
  "time" => today,
  "amount" => 5,
  "tag_id" => tag3.id()
  })
transaction3.save()

transaction4 = Transaction.new({
  "merchant_id" => merchant1.id, 
  "user_id" => user2.id, 
  "time" => today,
  "amount" => 15,
  "tag_id" => tag1.id()
  })
transaction4.save()

transaction4 = Transaction.new({
  "merchant_id" => merchant2.id, 
  "time" => today,
  "user_id" => user2.id, 
  "amount" => 8, 
  "tag_id" => tag1.id()
  })
transaction4.save()





binding.pry
nil