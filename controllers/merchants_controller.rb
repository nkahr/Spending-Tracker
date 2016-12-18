require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/merchant.rb' )

#index
get '/users/:id/merchants' do 
  @merchants = Merchant.all()
  erb(:"merchants/merchants_index")
end

#new
get '/users/:id/merchants/new' do 
  @user= User.find_by_id(params["id"])
  @merchants = Merchant.all()
  erb(:"merchants/merchants_new")
end

#create
post '/users/:id/merchants' do 
  @id = params["id"]
  params["id"] = nil
  @merchant = Merchant.new(params)
  @merchant.save()
  erb(:"merchants/merchants_create")
  redirect to("/users/#{@id}/transactions/new")
 end