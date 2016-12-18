require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/merchant.rb' )
require_relative( '../models/user.rb' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/tag.rb' )
require_relative( '../models/calc.rb' )


#index (all transactions for a single user)
get '/users/:id/transactions' do 
  @user= User.find_by_id(params["id"])
  @transactions = @user.transactions()
  @total = Calc.total(@transactions)
  erb(:"transactions/transactions_index")
end

#new - need to use merchant class to get drop-down menu
get '/users/:id/transactions/new' do 
  @user= User.find_by_id(params["id"])
  @tags = Tag.all()
  @merchants = Merchant.all()
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
# get '/users/:id/transaction/:t_id' do 
#   @transaction = Transaction.find_by_id(params["t_id"]) #havent made this method yet 
#   erb(:"transactions/transactions_show")
# end

# #destroy
# post '/users/:id/transactions/:t_id/delete' do 
#   @id = params["t_id"] #transaction id 
#   Transaction.delete(@id) #havent made this method yet either
#   redirect to("/users/:id/transactions")
# end

# #edit 
# get '/users/:id/transactions/:t_id/edit' do 
  
# end

# #update 
# post '/users/:id/transactions/:t_id' do 

# end
