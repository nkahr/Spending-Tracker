require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/user.rb' )
require_relative( '../models/merchant.rb' )

#index
get '/users' do 
  @users = User.all()
  erb(:"users/users_index")
end

#new
get '/users/new' do 
  erb(:"users/users_new")
end

#add funds 
get '/users/:id/add_funds' do 
  @user_id = params["id"].to_i
  @user = User.find_by_id(@user_id)
  erb(:"users/users_add_funds")
end

post '/users/:id/funds_added' do 
  @user_id = params["id"].to_i
  @user = User.find_by_id(@user_id)
  @user.add_funds(params["funds_added"].to_f)
  redirect to("/users/#{@user_id}")
end

#create
post '/users' do 
  @user = User.new(params)
  @result = @user.save()
  erb(:"users/users_create")
end

#show
get '/users/:id' do 
  @user = User.find_by_id(params["id"])
  erb(:"users/users_show")
end

#destroy
post '/users/:id/delete' do 
  @id = params["id"].to_i
  User.delete(@id)
  redirect to("/users")
end

#edit 
get '/users/:id/edit' do 
  @user = User.find_by_id(params["id"])
  erb(:"users/users_edit")
end

#update 
post '/users/:id' do 
  User.update(params)
  redirect to("/users/#{params[:id]}")
end