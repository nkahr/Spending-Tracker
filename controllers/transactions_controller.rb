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
  @user= User.find_by_id(@user_id)
  @transactions = @user.transactions()
  case params["sort_by"]
    when "date"
      @transactions = Calc.sort_by_date(@transactions)
    when "amount_asc"
      @transactions = Calc.sort_by_amount_asc(@transactions)
    when "amount_desc"
      @transactions = Calc.sort_by_amount_desc(@transactions)
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

#sort
get '/users/:id/transactions/sort' do
  @sort_by = params["sort_by"]
  @user_id = params["id"].to_i
  @total = Calc.total(@transactions)
  @month_groups = Calc.group_by_month(@transactions)
  @user = User.find_by_id(params["id"])
  @transactions = @user.transactions()
  case @sort_by
  when "date"
    @transactions = Calc.sort_by_date(@transactions)
  when "amount_asc"
    @transactions = Calc.sort_by_amount_asc(@transactions)
  when "amount_desc"
    @transactions = Calc.sort_by_amount_desc(@transactions)
  end
  erb(:"transactions/transactions_index")
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
  params["user_id"] = params["id"]
  params["id"] = nil
  @transaction = Transaction.new(params)
  @transaction.save()
  erb(:"transactions/transactions_create")
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
