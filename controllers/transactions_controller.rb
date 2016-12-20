require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/merchant.rb' )
require_relative( '../models/user.rb' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/tag.rb' )
require_relative( '../models/calc.rb' )
require_relative( '../models/chart.rb' )

#index (all transactions for a single user)
get '/users/:id/transactions' do 
  @user_id = params["id"].to_i
  @tags = Tag.all()
  @user = User.find_by_id(@user_id)
  Calc.pay_standing_orders(@user, Time.new)
  @transactions = @user.transactions()


  unless params["tag_id"].to_i == 0
    @transactions = @user.find_by_tag_id(params["tag_id"]) 
    @text1 = "Total spent on #{Tag.find_by_id(params["tag_id"]).label}: #{Calc.total(@transactions)}"
  end

  @month = params['month'].to_i
  @year = params['year'].to_i

  unless @month == 0 && @year == 0
    @transactions = Calc.find_by_month(@transactions, @month, @year)
  end

  unless params["sort_by"].to_s == ""
    @transactions = Calc.sort_by(params["sort_by"], @transactions) 
    @text2 = "All transactions sorted by #{params["sort_by"]}"
  end


  @total = Calc.total(@transactions)
  @month_groups = Calc.group_by_month(@transactions)
  erb(:"transactions/transactions_index")
end

# by month - make a new method to search for transactions by month 
get '/users/:id/transactions/by_month' do
  @user = User.find_by_id(params["id"].to_i)
  @month = params['month']
  @year = params['year']
  @transactions = @user.transactions()
  @selected = Calc.find_by_month(@transactions, @month, @year)
  erb(:"transactions/transactions_by_month")
end

#new - need to use merchant class to get drop-down menu
get '/users/:id/transactions/new' do 
  @user= User.find_by_id(params["id"])
#  @tags = Tag.all()
  @tags = Tag.sort()
  @merchants = Merchant.sort()
  erb(:"transactions/transactions_new")
end


#create
post '/users/:id/transactions' do 
  @user_id = params["id"]
  @user = User.find_by_id(@user_id)
  params["user_id"] = params["id"]
  params["id"] = nil
  @transaction = @user.new_transaction(params) # saves transaction to database and decreases funds
  redirect to("/users/#{params["user_id"]}/transactions")
end

#new standing order
get '/users/:id/transactions/new_standing_order' do 
  @user= User.find_by_id(params["id"])
  @tags = Tag.sort()
  @merchants = Merchant.sort()
  erb(:"transactions/new_standing_order")
end

#create standing order
post '/users/:id/transactions/new_standing_order' do 
  @user_id = params["id"]
  @user = User.find_by_id(@user_id)
  params["user_id"] = params["id"]
  params["id"] = nil
  @standing_order = @user.new_standing_order(params) # saves transaction to database and decreases funds
  redirect to("/users/#{params["user_id"]}/transactions")
end


#show (when you click on a single transaction)
get '/users/:id/transactions/:t_id' do 
  @user_id = params["id"].to_i
  @transaction = Transaction.find_by_id(params["t_id"])
  @id = params["t_id"].to_i
  erb(:"transactions/transactions_show")
end

#destroy
post '/users/:id/transactions/:t_id/delete' do 
  @id = params["t_id"].to_i #transaction id 
  @user_id = params["id"].to_i
  Transaction.delete(@id) 
  redirect to("/users/#{@user_id}/transactions")
end

# #edit 
get '/users/:id/transactions/:t_id/edit' do 
  @user = User.find_by_id(params["id"])
  @transaction = Transaction.find_by_id(params["t_id"])
  @merchant = Merchant.find_by_id(@transaction.merchant_id)
  @merchants = Merchant.all
  @merchant_name = Merchant.find_by_id(@transaction.merchant_id).name
  @tag_label = Tag.find_by_id(@transaction.tag_id).label
  @tags = Tag.all
  @tag = Tag.find_by_id(@transaction.tag_id)
  erb(:"transactions/transactions_edit")
end

#update 
post '/users/:id/transactions/:t_id' do 
  params["user_id"] = params["id"]
  params["id"] = params["t_id"]
  params["t_id"] = nil
  Transaction.update(params)
end
