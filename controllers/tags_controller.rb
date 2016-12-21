require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/tag.rb' )

#index
get '/users/:id/tags' do 
  @user= User.find_by_id(params["id"])
  @tags = Tag.all()
  erb(:"tags/tags_index")
end

#new
get '/users/:id/tags/new' do 
  @user= User.find_by_id(params["id"])
  @tags = Tag.all()
  erb(:"tags/tags_new")
end

#create
post '/users/:id/tags' do 
  @id = params["id"]
  params["id"] = nil
  @tag = Tag.new(params)
  @tag.save()
  erb(:"tags/tags_create")
  redirect to("/users/#{@id}/transactions/new")
 end