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

#create
post '/users' do 
  @user = User.new(params)
  @user.save()
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
  
end

#update 
post '/users/:id' do 

end


